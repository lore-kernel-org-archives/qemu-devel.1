Received: from eggs.gnu.org ([2001:4830:134:3::10]:41114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoWQP-0008JC-TH
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eoWQJ-0003xT-7O
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 10:35:17 -0500
Date: Wed, 21 Feb 2018 16:34:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180221163459.50829ebf.cohuck@redhat.com>
In-Reply-To: <1519152302-19079-4-git-send-email-imbrenda@linux.vnet.ibm.com>
References: <1519152302-19079-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519152302-19079-4-git-send-email-imbrenda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] s390x/sclp: extend SCLP event masks
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

On Tue, 20 Feb 2018 19:45:02 +0100
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> Extend the SCLP event masks to 64 bits. This will make us future proof
> against future extensions of the architecture.
> 
> Notice that using any of the new bits results in a state that cannot be
> migrated to an older version.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/event-facility.c         | 43 +++++++++++++++++++++++++++++++++------
>  include/hw/s390x/event-facility.h |  2 +-
>  2 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index f6f28fd..e71302a 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -30,7 +30,10 @@ struct SCLPEventFacility {
>      SysBusDevice parent_obj;
>      SCLPEventsBus sbus;
>      /* guest' receive mask */
> -    sccb_mask_t receive_mask;
> +    union {
> +        uint32_t receive_mask_compat32;
> +        sccb_mask_t receive_mask;
> +    };
>      /*
>       * when false, we keep the same broken, backwards compatible behaviour as
>       * before; when true, we implement the architecture correctly. Needed for
> @@ -261,7 +264,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
>      case SCLP_SELECTIVE_READ:
>          copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
>                    sizeof(sclp_active_selection_mask), ef->mask_length);
> -        sclp_active_selection_mask = be32_to_cpu(sclp_active_selection_mask);
> +        sclp_active_selection_mask = be64_to_cpu(sclp_active_selection_mask);

Would it make sense to introduce a wrapper that combines copy_mask()
and the endianness conversion (just in case you want to extend this
again in the future?

>          if (!sclp_cp_receive_mask ||
>              (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
>              sccb->h.response_code =
> @@ -301,13 +304,13 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>      /* keep track of the guest's capability masks */
>      copy_mask((uint8_t *)&tmp_mask, WEM_CP_RECEIVE_MASK(we_mask, mask_length),
>                sizeof(tmp_mask), mask_length);
> -    ef->receive_mask = be32_to_cpu(tmp_mask);
> +    ef->receive_mask = be64_to_cpu(tmp_mask);
>  
>      /* return the SCLP's capability masks to the guest */
> -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> +    tmp_mask = cpu_to_be64(get_host_receive_mask(ef));
>      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>                mask_length, sizeof(tmp_mask));
> -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> +    tmp_mask = cpu_to_be64(get_host_send_mask(ef));
>      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>                mask_length, sizeof(tmp_mask));
>  
> @@ -368,6 +371,21 @@ static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
>      }
>  }
>  
> +static bool vmstate_event_facility_mask64_needed(void *opaque)
> +{
> +    SCLPEventFacility *ef = opaque;
> +
> +    return (ef->receive_mask & 0xFFFFFFFF) != 0;
> +}
> +
> +static int vmstate_event_facility_mask64_pre_load(void *opaque)
> +{
> +    SCLPEventFacility *ef = opaque;
> +
> +    ef->receive_mask &= ~0xFFFFFFFFULL;
> +    return 0;
> +}
> +
>  static bool vmstate_event_facility_mask_length_needed(void *opaque)
>  {
>      SCLPEventFacility *ef = opaque;
> @@ -383,6 +401,18 @@ static int vmstate_event_facility_mask_length_pre_load(void *opaque)
>      return 0;
>  }
>  
> +static const VMStateDescription vmstate_event_facility_mask64 = {
> +    .name = "vmstate-event-facility/mask64",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = vmstate_event_facility_mask64_needed,
> +    .pre_load = vmstate_event_facility_mask64_pre_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(receive_mask, SCLPEventFacility),
> +        VMSTATE_END_OF_LIST()
> +     }
> +};
> +

Are there plans for extending this beyond 64 bits? Would it make sense
to use the maximum possible size for the mask here, so you don't need
to introduce yet another vmstate in the future? (If it's unlikely that
the mask will ever move beyond 64 bit, that might be overkill, of
course.)

>  static const VMStateDescription vmstate_event_facility_mask_length = {
>      .name = "vmstate-event-facility/mask_length",
>      .version_id = 0,
> @@ -401,10 +431,11 @@ static const VMStateDescription vmstate_event_facility = {
>      .version_id = 0,
>      .minimum_version_id = 0,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(receive_mask, SCLPEventFacility),
> +        VMSTATE_UINT32(receive_mask_compat32, SCLPEventFacility),
>          VMSTATE_END_OF_LIST()
>       },
>      .subsections = (const VMStateDescription * []) {
> +        &vmstate_event_facility_mask64,
>          &vmstate_event_facility_mask_length,
>          NULL
>       }

So what happens for compat machines? They can't ever set bits beyond 31
IIUC?
