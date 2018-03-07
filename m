Received: from eggs.gnu.org ([2001:4830:134:3::10]:33783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etNxh-0000tC-3F
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1etNxd-0007Mb-Vi
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:33:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1etNxd-0007MT-Q3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 20:33:41 -0500
Date: Wed, 7 Mar 2018 09:33:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180307013332.GE13844@lemon.usersys.redhat.com>
References: <20180306154411.18462-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306154411.18462-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] scsi-disk.c: consider bl->max_transfer
 in INQUIRY emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 03/06 12:44, Daniel Henrique Barboza wrote:
> The calculation of the max_transfer atribute of BlockDriverState
> makes considerations such as max_segments and transfer_length via
> the BLKSECTGET ioctl (if available).
> 
> However, bl->max_transfer isn't considered when emulating the INQUIRY
> 'Block Limit' response to the scsi-hd devices. This leads to situations
> where the declared max_sectors from the INQUIRY response is inconsistent
> with the block limits, which isn't ideal. It can also be misleading to the
> user that sets /sys/block/<dev>/queue/max_sectors_kb to a certain
> value, then finds a different value in the guest OS for the same disk.
> 
> Following the same logic scsi_read_complete from scsi-generic.c does
> when patching the response of the Block Limits VPD back to the guest,
> change the max_io_sectors value of the emulated Block Limits VPD
> response by considering the blk_get_max_transfer of the related
> BlockDriverState. Use MIN_NOT_ZERO to be sure that the minimal
> value is chosen.
> 
> Given that we're changing max_io_sectors, consider that min_io_sectors
> and opt_io_sectors can't be greater than the new calculated value.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/scsi/scsi-disk.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 49d2559d93..c65c1ce56d 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -704,6 +704,21 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
>                          page_code);
>                  return -1;
>              }
> +            if (s->qdev.type == TYPE_DISK) {
> +                int max_transfer_blk = blk_get_max_transfer(s->qdev.conf.blk);
> +                int max_io_sectors_blk =
> +                    max_transfer_blk / s->qdev.blocksize;
> +
> +                max_io_sectors =
> +                    MIN_NON_ZERO(max_io_sectors_blk, max_io_sectors);
> +
> +                /* min_io_size and opt_io_size can't be greater than
> +                 * max_io_sectors */
> +                min_io_size =
> +                    MIN_NON_ZERO(min_io_size, max_io_sectors);
> +                opt_io_size =
> +                    MIN_NON_ZERO(opt_io_size, max_io_sectors);
> +            }
>              /* required VPD size with unmap support */
>              buflen = 0x40;
>              memset(outbuf + 4, 0, buflen - 4);
> -- 
> 2.14.3
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
