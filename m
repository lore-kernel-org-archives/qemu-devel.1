Received: from eggs.gnu.org ([209.51.188.92]:48883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hMFqE-0001JZ-KD
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hMFqD-0007st-KO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:49:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58040
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hMFqD-0007rJ-G6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:49:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x42Hflif095780
	for <qemu-devel@nongnu.org>; Thu, 2 May 2019 13:49:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s84ma1j1r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 13:49:46 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 2 May 2019 18:49:44 +0100
References: <20190502155516.12415-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 2 May 2019 19:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190502155516.12415-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ec7ac4a9-b818-9869-7f56-dbc0e9d6d558@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390/ipl: cast to SCSIDevice directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.ibm.com>



On 02.05.19 17:55, Cornelia Huck wrote:
> Coverity notes that the result of object_dynamic_cast() to
> SCSIDevice is not checked in s390_gen_initial_iplp(); as
> we know that we always have a SCSIDevice in that branch,
> we can instead cast via SCSI_DEVICE directly.
> 

And it even does look nicer. 

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> Coverity: CID 1401098
> Fixes: 44445d8668f4 ("s390 vfio-ccw: Add bootindex property and IPLB data")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/ipl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d0cc06a05fd0..b93750c14eac 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -374,8 +374,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>      if (ccw_dev) {
>          switch (devtype) {
>          case CCW_DEVTYPE_SCSI:
> -            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> -                                                           TYPE_SCSI_DEVICE);
> +            sd = SCSI_DEVICE(dev_st);
>              ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>              ipl->iplb.blk0_len =
>                  cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> 
