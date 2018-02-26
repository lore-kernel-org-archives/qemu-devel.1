Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqM6A-0004JC-9r
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqM66-00006x-Tm
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 11:57:58 -0500
Date: Mon, 26 Feb 2018 17:57:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180226175751.2d8e5f05.cohuck@redhat.com>
In-Reply-To: <1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] s390x/sclp: extend SCLP event masks
 to 64 bits
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

On Fri, 23 Feb 2018 18:42:58 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Extend the SCLP event masks to 64 bits.
> 
> Notice that using any of the new bits results in a state that cannot be
> migrated to an older version.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/event-facility.c         | 56 ++++++++++++++++++++++++++++++---------
>  include/hw/s390x/event-facility.h |  2 +-
>  2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index e04ed9f..c3e39ee 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -30,7 +30,7 @@ struct SCLPEventFacility {
>      SysBusDevice parent_obj;
>      SCLPEventsBus sbus;
>      /* guest's receive mask */
> -    sccb_mask_t receive_mask;
> +    uint32_t receive_mask_pieces[2];
>      /*
>       * when false, we keep the same broken, backwards compatible behaviour as
>       * before, allowing only masks of size exactly 4; when true, we implement
> @@ -42,6 +42,18 @@ struct SCLPEventFacility {
>      uint16_t mask_length;
>  };
>  
> +static inline sccb_mask_t make_receive_mask(SCLPEventFacility *ef)
> +{
> +    return ((sccb_mask_t)ef->receive_mask_pieces[0]) << 32 |
> +                         ef->receive_mask_pieces[1];
> +}
> +
> +static inline void store_receive_mask(SCLPEventFacility *ef, sccb_mask_t val)
> +{
> +    ef->receive_mask_pieces[1] = val;
> +    ef->receive_mask_pieces[0] = val >> 32;
> +}
> +

Hm... how are all those values actually defined in the architecture?
You pass around some values internally (which are supposedly in host
endian) and then and/or them with the receive mask here. Are they
compared byte-for-byte? 32-bit-for-32-bit?

I'm also not a fan of the _pieces suffix - reminds me of Dwarf pieces :)
