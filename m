Received: from eggs.gnu.org ([209.51.188.92]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEHv-0002jE-8t
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hMEHr-0001AI-8S
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:10:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hMEHi-000119-6L
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:10:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id t76so3639253wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:10:04 -0700 (PDT)
References: <20190502155516.12415-1-cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40bc015c-710a-c731-74cb-ebf082fb8f57@redhat.com>
Date: Thu, 2 May 2019 18:10:00 +0200
MIME-Version: 1.0
In-Reply-To: <20190502155516.12415-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390/ipl: cast to SCSIDevice directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 5/2/19 5:55 PM, Cornelia Huck wrote:
> Coverity notes that the result of object_dynamic_cast() to
> SCSIDevice is not checked in s390_gen_initial_iplp(); as
> we know that we always have a SCSIDevice in that branch,
> we can instead cast via SCSI_DEVICE directly.
> 
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
