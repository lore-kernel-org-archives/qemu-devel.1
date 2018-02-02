Received: from eggs.gnu.org ([2001:4830:134:3::10]:53014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1ehde5-0001zh-SH
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1ehdd1-0001Li-SF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:52:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1ehdd1-0001KN-6d
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:51:51 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12E9qfa081049
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:10:14 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvqccxaw9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:10:13 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 14:10:11 -0000
Date: Fri, 2 Feb 2018 15:10:07 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <20180202094241.59537-1-borntraeger@de.ibm.com>
References: <20180202094241.59537-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180202151007.6b834412@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/sclp: fix event mask handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "Jason J.
	Herne" <jjherne@linux.vnet.ibm.com>, qemu-stable@nongnu.org

On Fri,  2 Feb 2018 09:42:41 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> commit 67915de9f038 ("s390x/event-facility: variable-length event
> masks") switches the sclp receive/send mask. This broke the sclp
> lm console.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length
> event masks") Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
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
> @@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility
> *ef, SCCB *sccb) ef->receive_mask = be32_to_cpu(tmp_mask);
> 
>      /* return the SCLP's capability masks to the guest */
> -    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
>      copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t
> *)&tmp_mask, mask_length, sizeof(tmp_mask));
> -    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
> +    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
>      copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t
> *)&tmp_mask, mask_length, sizeof(tmp_mask));
> 
