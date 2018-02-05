Received: from eggs.gnu.org ([2001:4830:134:3::10]:35670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eicCh-0003cI-Mj
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eicCe-0003UR-G2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:32:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55486
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eicCe-0003U7-AK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 03:32:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w158T3WD007525
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 03:32:39 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fxj3w470n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 03:32:39 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Feb 2018 08:32:37 -0000
References: <20180202094241.59537-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Feb 2018 09:32:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180202094241.59537-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ca3cab37-05be-1d1a-19d1-0a9c247389e5@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: fix event mask handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, qemu-stable@nongnu.org



On 02/02/2018 10:42 AM, Christian Borntraeger wrote:
> commit 67915de9f038 ("s390x/event-facility: variable-length event
> masks") switches the sclp receive/send mask. This broke the sclp
	  switched

> lm console.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length event masks")
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/s390x/event-facility.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index b0f71f4554..155a69467b 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>      ef->receive_mask = be32_to_cpu(tmp_mask);
> 
>      /* return the SCLP's capability masks to the guest */
> -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
>      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>                mask_length, sizeof(tmp_mask));
> -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
>      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
>                mask_length, sizeof(tmp_mask));
> 
