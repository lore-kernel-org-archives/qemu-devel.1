Received: from eggs.gnu.org ([2001:4830:134:3::10]:57512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e4Alu-00085L-65
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e4Alr-0007Re-CR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:09:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e4Alr-0007QY-2x
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 15:09:51 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9GJ91Vm000652
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 15:09:47 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dn1u1acg2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 15:09:46 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 16 Oct 2017 20:09:44 +0100
References: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 16 Oct 2017 21:09:37 +0200
MIME-Version: 1.0
In-Reply-To: <1507729193-9747-1-git-send-email-jjherne@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1661309f-f6ee-2535-26fe-f473fa9075f1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/event-facility: variable-length
 event masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org, cohuck@redhat.com



On 10/11/2017 03:39 PM, Jason J. Herne wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> The architecture supports masks of variable length for sclp write
> event mask. We currently only support 4 byte event masks, as that
> is what Linux uses.
> 
> Let's extend this to the maximum mask length supported by the
> architecture and return 0 to the guest for the mask bits we don't
> support in core.
> 
> Initial patch by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  hw/s390x/event-facility.c         | 35 +++++++++++++++++++++++++++++------
>  include/hw/s390x/event-facility.h | 20 ++++++++++++++++----
>  2 files changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 34b2faf..b0f71f4 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -259,23 +259,46 @@ out:
>      return;
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
>  static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>  {
>      WriteEventMask *we_mask = (WriteEventMask *) sccb;
> +    uint16_t mask_length = be16_to_cpu(we_mask->mask_length);
> +    uint32_t tmp_mask;
> 
> -    /* Attention: We assume that Linux uses 4-byte masks, what it actually
> -       does. Architecture allows for masks of variable size, though */
> -    if (be16_to_cpu(we_mask->mask_length) != 4) {
> +    if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX)) {
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
>          goto out;
>      }
> 
> +    /*
> +     * Note: We currently only support masks up to 4 byte length;
> +     *       the remainder is filled up with zeroes. Linux uses
> +     *       a 4 byte mask length.
> +     */
> +
>      /* keep track of the guest's capability masks */
> -    ef->receive_mask = be32_to_cpu(we_mask->cp_receive_mask);
> +    copy_mask((uint8_t *)&tmp_mask, WEM_CP_RECEIVE_MASK(we_mask, mask_length),
> +              sizeof(tmp_mask), mask_length);
> +    ef->receive_mask = be32_to_cpu(tmp_mask);
> 
>      /* return the SCLP's capability masks to the guest */
> -    we_mask->send_mask = cpu_to_be32(get_host_send_mask(ef));
> -    we_mask->receive_mask = cpu_to_be32(get_host_receive_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> +    copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
> +              mask_length, sizeof(tmp_mask));
> +    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> +    copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
> +              mask_length, sizeof(tmp_mask));
> 
>      sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
> 
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index def1bb0..5119b9b 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -49,16 +49,28 @@
>  #define TYPE_SCLP_CPU_HOTPLUG "sclp-cpu-hotplug"
>  #define TYPE_SCLP_QUIESCE "sclpquiesce"
> 
> +#define SCLP_EVENT_MASK_LEN_MAX 1021
> +
>  typedef struct WriteEventMask {
>      SCCBHeader h;
>      uint16_t _reserved;
>      uint16_t mask_length;
> -    uint32_t cp_receive_mask;
> -    uint32_t cp_send_mask;
> -    uint32_t receive_mask;
> -    uint32_t send_mask;
> +    uint8_t masks[];
> +/*
> + * Layout of the masks is
> + *  uint8_t cp_receive_mask[mask_length];
> + *  uint8_t cp_send_mask[mask_length];
> + *  uint8_t receive_mask[mask_length];
> + *  uint8_t send_mask[mask_length];
> + * where 1 <= mask_length <= SCLP_EVENT_MASK_LEN_MAX
> + */
>  } QEMU_PACKED WriteEventMask;
> 
> +#define WEM_CP_RECEIVE_MASK(wem, mask_len) ((wem)->masks)
> +#define WEM_CP_SEND_MASK(wem, mask_len) ((wem)->masks + (mask_len))
> +#define WEM_RECEIVE_MASK(wem, mask_len) ((wem)->masks + 2 * (mask_len))
> +#define WEM_SEND_MASK(wem, mask_len) ((wem)->masks + 3 * (mask_len))
> +
>  typedef struct EventBufferHeader {
>      uint16_t length;
>      uint8_t  type;
> 
