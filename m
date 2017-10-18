Received: from eggs.gnu.org ([2001:4830:134:3::10]:37909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4l2k-0000X6-Kj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4l2i-0006Kx-RJ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4l2i-0006KD-JQ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:53:40 -0400
References: <1508185024-5840-1-git-send-email-mark.kanda@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19391da4-ccbb-0ef0-cd69-6e4ecad3edde@redhat.com>
Date: Wed, 18 Oct 2017 11:53:36 +0200
MIME-Version: 1.0
In-Reply-To: <1508185024-5840-1-git-send-email-mark.kanda@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Reject virtio-scsi configurations with
 logical block size > physical block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
Cc: konrad.wilk@oracle.com, martin.petersen@oracle.com

On 16/10/2017 22:17, Mark Kanda wrote:
> With virtio-scsi, logical block size should never be larger than
> physical block size. From an ATA/SCSI perspective, it makes no sense
> to have the logical block size greater than the physical block size,
> and it cannot even be effectively expressed in the command set. The
> whole point of adding the physical block size to the ATA/SCSI command
> set was to communicate a desire for a larger block size (than logical),
> while maintaining backwards compatibility with legacy 512 byte block
> size.
> 
> This was found by setting logical_block_size > physical_block_size in
> the QEMU command line, and discovering that it confuses Windows VMs -
> fsutil reports both physical and logical block sizes are equal to the
> logical size.

It doesn't confuse Windows VMs; physical block size is expressed as a
number n such that physical_block_size = 2^n * logical_block_size.  So
if you specify an invalid configuration (which as you say "cannot be
expressed" in SBC) all QEMU can do is set n=0.

fsutil therefore prints exactly what QEMU says in READ CAPACITY. :)

I've adjusted a little bit the commit message and queued the patch, thanks!

Paolo

> Example QEMU option:
> 
>   -device scsi-hd,drive=drive-scsi0,id=disk1,bus=scsi.0,
>           physical_block_size=512,logical_block_size=4096
> 
> Windows Server 2012 R2 VM:
> 
>   C:\Users\Administrator>fsutil fsinfo ntfsinfo F:
>   ...
>   Bytes Per Sector  :               4096
>   Bytes Per Physical Sector :       4096
>   Bytes Per Cluster :               4096
>   Bytes Per FileRecord Segment    : 4096
>   ...
> 
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  hw/scsi/scsi-disk.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 6e841fb..2a4f8c5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2329,6 +2329,14 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>  
>      blkconf_serial(&s->qdev.conf, &s->serial);
>      blkconf_blocksizes(&s->qdev.conf);
> +
> +    if (s->qdev.conf.logical_block_size >
> +        s->qdev.conf.physical_block_size) {
> +        error_setg(errp,
> +                   "logical_block_size > physical_block_size not supported");
> +        return;
> +    }
> +
>      if (dev->type == TYPE_DISK) {
>          blkconf_geometry(&dev->conf, NULL, 65535, 255, 255, &err);
>          if (err) {
> 
