Received: from eggs.gnu.org ([2001:4830:134:3::10]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoW5B-0000Fc-0N
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoW51-0005Nj-BD
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:13:20 -0500
Date: Wed, 21 Feb 2018 16:12:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180221161215.766900c5.cohuck@redhat.com>
In-Reply-To: <1519152302-19079-2-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519152302-19079-2-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/3] s390x/sclp: proper support of
 larger send and receive masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Tue, 20 Feb 2018 19:45:00 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> The architecture allows the guests to ask for masks up to 1021 bytes in
> length. Part was fixed in 67915de9f0383ccf4ab8c42dd02aa18dcd79b411
> ("s390x/event-facility: variable-length event masks"), but some issues
> were still remaining, in particular regarding the handling of selective
> reads.
> 
> This patch fixes the handling of selective reads, whose size will now
> match the length of the event mask, as per architecture.
> 
> The default behaviour is to be compliant with the architecture, but when
> using older machine models the old behaviour is selected, in order to
> be able to migrate toward older versions.

I remember trying to do this back when I still had access to the
architecture, but somehow never finished this (don't remember why).

> 
> Fixes: 67915de9f0383ccf4a ("s390x/event-facility: variable-length event masks")

Doesn't that rather fix the initial implementation? What am I missing?

> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/event-facility.c  | 90 +++++++++++++++++++++++++++++++++++++++-------
>  hw/s390x/s390-virtio-ccw.c |  8 ++++-
>  2 files changed, 84 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 155a694..2414614 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -31,6 +31,14 @@ struct SCLPEventFacility {
>      SCLPEventsBus sbus;
>      /* guest' receive mask */
>      unsigned int receive_mask;
> +    /*
> +     * when false, we keep the same broken, backwards compatible behaviour as
> +     * before; when true, we implement the architecture correctly. Needed for
> +     * migration toward older versions.
> +     */
> +    bool allow_all_mask_sizes;

The comment does not really tell us what the old behaviour is ;)

So, if this is about extending the mask size, call this
"allow_large_masks" or so?

> +    /* length of the receive mask */
> +    uint16_t mask_length;
>  };
>  
>  /* return true if any child has event pending set */
> @@ -220,6 +228,17 @@ static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
>      return rc;
>  }
>  
> +/* copy up to dst_len bytes and fill the rest of dst with zeroes */
> +static void copy_mask(uint8_t *dst, uint8_t *src, uint16_t dst_len,
> +                      uint16_t src_len)
> +{
> +    int i;
> +
> +    for (i = 0; i < dst_len; i++) {
> +        dst[i] = i < src_len ? src[i] : 0;
> +    }
> +}
> +
>  static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
>  {
>      unsigned int sclp_active_selection_mask;
> @@ -240,7 +259,9 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
>          sclp_active_selection_mask = sclp_cp_receive_mask;
>          break;
>      case SCLP_SELECTIVE_READ:
> -        sclp_active_selection_mask = be32_to_cpu(red->mask);
> +        copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
> +                  sizeof(sclp_active_selection_mask), ef->mask_length);
> +        sclp_active_selection_mask = be32_to_cpu(sclp_active_selection_mask);

Hm, this looks like a real bug fix for the commit referenced above.
Split this out? We don't need compat support for that; maybe even
cc:stable?

(Not sure what the consequences are here, other than unwanted bits at
the end; can't say without doc.)

>          if (!sclp_cp_receive_mask ||
>              (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
>              sccb->h.response_code =
> @@ -259,24 +280,14 @@ out:
>      return;
>  }
>  
> -/* copy up to dst_len bytes and fill the rest of dst with zeroes */
> -static void copy_mask(uint8_t *dst, uint8_t *src, uint16_t dst_len,
> -                      uint16_t src_len)
> -{
> -    int i;
> -
> -    for (i = 0; i < dst_len; i++) {
> -        dst[i] = i < src_len ? src[i] : 0;
> -    }
> -}
> -
>  static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>  {
>      WriteEventMask *we_mask = (WriteEventMask *) sccb;
>      uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
>      uint32_t tmp_mask;
>  
> -    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX)) {
> +    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
> +        ((mask_length != 4) && !ef->allow_all_mask_sizes)) {

This is a behaviour change, isn't it? Previously, we allowed up to 4
bytes, now we allow exactly 4 bytes?

>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
>          goto out;
>      }
