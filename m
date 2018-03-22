Received: from eggs.gnu.org ([2001:4830:134:3::10]:56020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywFY-0005Rn-0L
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywFU-0006vq-QE
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:11:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eywFU-0006vS-Im
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:11:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id t6so14656434wmt.5
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 02:11:04 -0700 (PDT)
References: <20180322073822.25795-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be2cad56-c486-1123-efa3-9b28eff96772@redhat.com>
Date: Thu, 22 Mar 2018 10:11:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180322073822.25795-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: Don't enlarge min_io_size to
 max_io_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 22/03/2018 08:38, Fam Zheng wrote:
> Some backends report big max_io_sectors. Making min_io_size the same
> value in this case will make it impossible for guest to align memory,
> therefore the disk may not be usable at all.
> 
> Change the default behavior (when min_io_size and opt_io_size are not
> specified in the command line), do not assume max_io_sectors is a good
> value for opt_io_size and min_io_size, use 512 instead.
> 
> Reported-by: David Gibson <dgibson@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 5b7a48f5a5..76e3c9eaa4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -714,10 +714,8 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>  
>                  /* min_io_size and opt_io_size can't be greater than
>                   * max_io_sectors */
> -                min_io_size =
> -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> -                opt_io_size =
> -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> +                min_io_size = MIN(min_io_size ? : 512, max_io_sectors);
> +                opt_io_size = MIN(opt_io_size ? : 512, max_io_sectors);

There are a few easily fixed issues with your chosen defaults, though
the problem obviously makes sense:

1) the values are in sectors - since you chose 512, it's not clear if
you meant it to be 512 bytes or 512 sectors.  :)  512 sectors (256 KiB
or 2 MiB depending on logical block size) is still too much for the
min_io_size.  The min_io_size default (if it is 0) is the physical block
size, so I think we should make the min_io_size either 0 or the physical
block size.

2) For the opt_io_size, 256 KiB on the other hand is probably too
little.  On my laptop (NVMe disk) a transfer size of 8 MiB is twice as
fast compared to a transfer size of 256 KiB, and 16 MiB or 32 MiB is a
little faster too.  I would either leave zero as the default, or pick
something around 16-32 MiB.

Thanks,

Paolo

>              }
>              /* required VPD size with unmap support */
>              buflen = 0x40;
> 
