Received: from eggs.gnu.org ([2001:4830:134:3::10]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eRHHe-0002nU-T1
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eRHHc-0007zd-73
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:46:10 -0500
Received: from mail-eopbgr30105.outbound.protection.outlook.com
	([40.107.3.105]:54048
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1eRHHb-0007w8-Fp
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:46:08 -0500
References: <1513350170-20168-1-git-send-email-den@openvz.org>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <ae8923ec-8a04-83a9-ef4c-936fa1ec2ed0@openvz.org>
Date: Tue, 19 Dec 2017 15:45:52 +0300
MIME-Version: 1.0
In-Reply-To: <1513350170-20168-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 0/2] virtio: fix IO request length in
 virtio SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 12/15/2017 06:02 PM, Denis V. Lunev wrote:
> v2->v3
> - added 2.12 machine types
> - added compat properties for 2.11 machine type
>
> v1->v2:
> - added max_segments property for virtblock device
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
>
the patch appears to be problematic.

We observe the following crashes under heavy load

    [    2.348177] kernel BUG at drivers/virtio/virtio_ring.c:160!
    [    2.349382] invalid opcode: 0000 [#1] SMP 
    [    2.350448] Modules linked in: xfs libcrc32c sr_mod cdrom sd_mod crc_t10dif crct10dif_generic virtio_scsi virtio_console virtio_net ata_generic pata_acpi crct10dif_pclmul crct10dif_common crc32c_intel serio_raw bochs_drm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm virtio_pci virtio_ring virtio i2c_core ata_piix libata floppy dm_mirror dm_region_hash dm_log dm_mod
    [    2.357149] CPU: 1 PID: 399 Comm: mount Not tainted 3.10.0-514.26.2.el7.x86_64 #1
    [    2.358569] Hardware name: Virtuozzo KVM, BIOS 1.10.2-3.1.vz7.2 04/01/2014
    [    2.359967] task: ffff8800362f4e70 ti: ffff880035b00000 task.ti: ffff880035b00000
    [    2.361443] RIP: 0010:[<ffffffffa00b4ae0>]  [<ffffffffa00b4ae0>] virtqueue_add_sgs+0x370/0x3c0 [virtio_ring]
    [    2.363171] RSP: 0018:ffff880035b03760  EFLAGS: 00010002
    [    2.364419] RAX: ffff8800359b8800 RBX: 0000000000000082 RCX: 0000000000000003
    [    2.365866] RDX: ffffea0000d9b7c2 RSI: ffff880035b037e0 RDI: ffff8800783dcfe0
    [    2.367325] RBP: ffff880035b037b8 R08: ffff88003679d3c0 R09: 0000000000000020
    [    2.368766] R10: ffff8800359c08c0 R11: ffff8800359c08c0 R12: ffff8800787a4948
    [    2.370232] R13: ffff880035b037f8 R14: ffff880035b037f8 R15: 0000000000000020
    [    2.371681] FS:  00007f38a0887880(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
    [    2.373233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    2.374529] CR2: 00007f2090d276f8 CR3: 0000000036371000 CR4: 00000000000406e0
    [    2.375982] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [    2.377462] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
    [    2.378913] Stack:
    [    2.379846]  ffff88003679d3c0 0000000100000000 ffff88003582d800 ffff880035b037e0
    [    2.381389]  0000000335b03820 ffff8800359b8800 ffff88003679d3c0 ffff8800787a4948
    [    2.382905]  ffff8800359c0998 ffff8800359b8800 000000000000006c ffff880035b03870
    [    2.384449] Call Trace:
    [    2.385420]  [<ffffffffa019a631>] virtscsi_kick_cmd+0x161/0x280 [virtio_scsi]
    [    2.386874]  [<ffffffff81183e49>] ? mempool_alloc+0x69/0x170
    [    2.388189]  [<ffffffffa019a87f>] virtscsi_queuecommand+0x12f/0x230 [virtio_scsi]
    [    2.389702]  [<ffffffffa019aa57>] virtscsi_queuecommand_single+0x37/0x40 [virtio_scsi]
    [    2.391217]  [<ffffffff8145269a>] scsi_dispatch_cmd+0xaa/0x230
    [    2.392537]  [<ffffffff8145b7a1>] scsi_request_fn+0x501/0x770
    [    2.393832]  [<ffffffff812eb9c3>] __blk_run_queue+0x33/0x40
    [    2.395103]  [<ffffffff812eba7a>] queue_unplugged+0x2a/0xa0
    [    2.396380]  [<ffffffff812f08d8>] blk_flush_plug_list+0x1d8/0x230
    [    2.397673]  [<ffffffff812f0ce4>] blk_finish_plug+0x14/0x40
    [    2.398935]  [<ffffffffa0226a84>] _xfs_buf_ioapply+0x334/0x460 [xfs]
    [    2.400286]  [<ffffffffa0250378>] ? xlog_bread_noalign+0xa8/0xe0 [xfs]
    [    2.401631]  [<ffffffffa022872d>] xfs_buf_submit_wait+0x5d/0x1d0 [xfs]
    [    2.402960]  [<ffffffffa0250378>] xlog_bread_noalign+0xa8/0xe0 [xfs]
    [    2.404306]  [<ffffffffa0251023>] xlog_bread+0x23/0x50 [xfs]
    [    2.405537]  [<ffffffffa0255f71>] xlog_find_verify_cycle+0xf1/0x1b0 [xfs]
    [    2.406885]  [<ffffffffa0256541>] xlog_find_head+0x2f1/0x3e0 [xfs]
    [    2.408175]  [<ffffffffa0256673>] xlog_find_tail+0x43/0x2f0 [xfs]
    [    2.409432]  [<ffffffff810c52b4>] ? try_to_wake_up+0x174/0x340
    [    2.410673]  [<ffffffffa025694d>] xlog_recover+0x2d/0x190 [xfs]
    [    2.411927]  [<ffffffffa0257bbb>] ? xfs_trans_ail_init+0xab/0xd0 [xfs]
    [    2.413246]  [<ffffffffa02498da>] xfs_log_mount+0xea/0x2e0 [xfs]
    [    2.414490]  [<ffffffffa0240138>] xfs_mountfs+0x518/0x8b0 [xfs]
    [    2.415714]  [<ffffffffa022e400>] ? xfs_filestream_get_parent+0x80/0x80 [xfs]
    [    2.417100]  [<ffffffffa0241009>] ? xfs_mru_cache_create+0x129/0x190 [xfs]
    [    2.419226]  [<ffffffffa02435e3>] xfs_fs_fill_super+0x3b3/0x4d0 [xfs]
    [    2.420473]  [<ffffffff81202400>] mount_bdev+0x1b0/0x1f0
    [    2.421575]  [<ffffffffa0243230>] ? xfs_parseargs+0xbe0/0xbe0 [xfs]
    [    2.422766]  [<ffffffffa02419a5>] xfs_fs_mount+0x15/0x20 [xfs]
    [    2.423903]  [<ffffffff81202b99>] mount_fs+0x39/0x1b0
    [    2.424955]  [<ffffffff811a5415>] ? __alloc_percpu+0x15/0x20
    [    2.426054]  [<ffffffff8121e91f>] vfs_kern_mount+0x5f/0xf0
    [    2.427147]  [<ffffffff81220e7e>] do_mount+0x24e/0xaa0
    [    2.428170]  [<ffffffff8119f8eb>] ? strndup_user+0x4b/0xa0
    [    2.429226]  [<ffffffff81221766>] SyS_mount+0x96/0xf0
    [    2.430242]  [<ffffffff81697809>] system_call_fastpath+0x16/0x1b
    [    2.431351] Code: 5c e9 69 ff ff ff 31 db e9 17 fd ff ff 89 da 48 c7 c6 98 63 0b a0 48 c7 c7 a0 70 0b a0 31 c0 e8 a7 7f 28 e1 e9 d5 fd ff ff 0f 0b <0f> 0b 8b 55 c8 48 89 d9 48 c7 c6 c0 62 0b a0 48 c7 c7 78 70 0b 

The problem is presumed to be gone in very latest 4.14 kernel.
We believe that the problem is fixed with

commit 44ed8089e991a60d614abe0ee4b9057a28b364e4
Author: Richard W.M. Jones <rjones@redhat.com>
Date:   Thu Aug 10 17:56:51 2017 +0100

    scsi: virtio: Reduce BUG if total_sg > virtqueue size to WARN.
    
    If using indirect descriptors, you can make the total_sg as large as you
    want.  If not, BUG is too serious because the function later returns
    -ENOSPC.
    
    Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Thus I am going to add the property, but with default 126 :(

Den
