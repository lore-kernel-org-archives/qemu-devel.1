Received: from eggs.gnu.org ([2001:4830:134:3::10]:57829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1etqBb-0001ZS-Bi
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1etqBW-0005ER-OY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:41:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1etqBW-0005E6-G8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:41:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w287euTY110621
	for <qemu-devel@nongnu.org>; Thu, 8 Mar 2018 02:41:52 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gk0qpgn15-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 02:41:52 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Mar 2018 07:41:50 -0000
References: <1520435434-24471-1-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Mar 2018 08:41:47 +0100
MIME-Version: 1.0
In-Reply-To: <1520435434-24471-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5fc4c07c-0f64-06b2-9310-8f6c09147c06@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] s390x/sclp: extend SCLP event masks
 to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, cohuck@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 03/07/2018 04:10 PM, Claudio Imbrenda wrote:
> Extend the SCLP event masks to 64 bits.
> 
> Notice that using any of the new bits results in a state that cannot be
> migrated to an older version.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> ---
>  hw/s390x/event-facility.c         | 49 ++++++++++++++++++++++++++++++++-------
>  include/hw/s390x/event-facility.h |  2 +-
>  2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index e04ed9f..c166e0a 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -30,7 +30,10 @@ struct SCLPEventFacility {
>      SysBusDevice parent_obj;
>      SCLPEventsBus sbus;
>      /* guest's receive mask */
> -    sccb_mask_t receive_mask;
> +    union {
> +        uint32_t receive_mask_pieces[2];
> +        sccb_mask_t receive_mask;
> +    };

Would it work to make sccb_mask_t a union instead?
