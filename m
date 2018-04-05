Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47DD-0008Ti-Th
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f47DA-0004YS-Sg
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:54:08 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:56132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f47DA-0004YG-IT
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:54:04 -0400
Received: by mail-wm0-x241.google.com with SMTP id b127so7044146wmf.5
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 08:54:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180327164141.19075-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b00ba0ab-538f-a6f1-3b99-1a0d9adb6eab@redhat.com>
Date: Thu, 5 Apr 2018 17:54:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180327164141.19075-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] scsi-disk: Don't enlarge min_io_size to
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
Cc: danielhb@linux.vnet.ibm.com, eblake@redhat.com, dgibson@redhat.com

On 27/03/2018 18:41, Fam Zheng wrote:
> Some backends report big max_io_sectors. Making min_io_size the same
> value in this case will make it impossible for guest to align memory,
> therefore the disk may not be usable at all.
> 
> Do not enlarge them when they are zero.
> 
> Reported-by: David Gibson <dgibson@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> ---
> 
> v2: Leave the values alone if zero. [Paolo]
>     At least we can consult block layer for a slightly more sensible
>     opt_io_size, but that's for another patch.
> ---
>  hw/scsi/scsi-disk.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index f5ab767ab5..f8ed8cf2b4 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -714,10 +714,12 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>  
>                  /* min_io_size and opt_io_size can't be greater than
>                   * max_io_sectors */
> -                min_io_size =
> -                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> -                opt_io_size =
> -                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> +                if (min_io_size) {
> +                    min_io_size = MIN(min_io_size, max_io_sectors);
> +                }
> +                if (opt_io_size) {
> +                    opt_io_size = MIN(opt_io_size, max_io_sectors);
> +                }
>              }
>              /* required VPD size with unmap support */
>              buflen = 0x40;
> 

Queued, thanks.

Paolo
