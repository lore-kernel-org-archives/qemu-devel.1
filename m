Received: from eggs.gnu.org ([2001:4830:134:3::10]:57667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxvx3-00051R-LD
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxvwx-0007Yy-IP
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:35:21 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1cxvwx-0007Ym-Dh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:35:15 -0400
Received: by mail-yb0-x244.google.com with SMTP id 206so5768128ybe.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 06:35:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411082140.1520.57032.malone@chaenomeles.canonical.com>
References: <20170411080154.12474.20009.malonedeb@gac.canonical.com>
	<20170411082140.1520.57032.malone@chaenomeles.canonical.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 11 Apr 2017 21:35:14 +0800
Message-ID: <CAOGPPbctB_RKy1G9+MuKwVN7T7hn6dwKuQ27hVpoVWX8CVyhYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1681688] Re: qemu live migration failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1681688 <1681688@bugs.launchpad.net>, kwolf@redhat.com
Cc: qemu-devel@nongnu.org

Hi Kevin:
   Can you provide some information about the original bug which you want fix?

   the original comment:
   Usually guest devices don't like other writers to the same image, so
   they use blk_set_perm() to prevent this from happening.

   i don't find where the dest qemu will use blk_set_perm during migration.
   but after apply this patch, blkconf_apply_backend_options don't update the
   blk->root->perm.

    Thanks.

On Tue, Apr 11, 2017 at 4:21 PM, Lidong Chen <jemmy858585@gmail.com> wrote:
> blk->root->perm is 1 when blk_new_open.
>
> the blk->root->perm is update to 3 during virtio_blk_device_realize.
>
> but after this commit, the blk->root->perm is still 1. and cause
> bdrv_aligned_pwritev failed.
>
> Breakpoint 1, blk_set_perm (blk=0x14c32b0, perm=3, shared_perm=29, errp=0x7fffffffd380) at block/block-backend.c:579
> 579     {
> (gdb) bt
> #0  blk_set_perm (blk=0x14c32b0, perm=3, shared_perm=29, errp=0x7fffffffd380) at block/block-backend.c:579
> #1  0x000000000063484b in blkconf_apply_backend_options (conf=0x2de7fd0, readonly=false, resizable=true, errp=0x7fffffffd380) at hw/block/block.c:77
> #2  0x00000000004a57bd in virtio_blk_device_realize (dev=0x2de7e30, errp=0x7fffffffd3e0) at /data/qemu/hw/block/virtio-blk.c:931
> #3  0x00000000004f688e in virtio_device_realize (dev=0x2de7e30, errp=0x7fffffffd468) at /data/qemu/hw/virtio/virtio.c:2485
> #4  0x000000000065806f in device_set_realized (obj=0x2de7e30, value=true, errp=0x7fffffffd6d8) at hw/core/qdev.c:939
> #5  0x000000000083aaf5 in property_set_bool (obj=0x2de7e30, v=0x2e67a90, name=0xaf4b53 "realized", opaque=0x2de9660, errp=0x7fffffffd6d8) at qom/object.c:1860
> #6  0x0000000000838c46 in object_property_set (obj=0x2de7e30, v=0x2e67a90, name=0xaf4b53 "realized", errp=0x7fffffffd6d8) at qom/object.c:1094
> #7  0x000000000083c23f in object_property_set_qobject (obj=0x2de7e30, value=0x2e679e0, name=0xaf4b53 "realized", errp=0x7fffffffd6d8) at qom/qom-qobject.c:27
> #8  0x0000000000838f9a in object_property_set_bool (obj=0x2de7e30, value=true, name=0xaf4b53 "realized", errp=0x7fffffffd6d8) at qom/object.c:1163
> #9  0x00000000007bafac in virtio_blk_pci_realize (vpci_dev=0x2ddf920, errp=0x7fffffffd6d8) at hw/virtio/virtio-pci.c:1975
> #10 0x00000000007ba966 in virtio_pci_realize (pci_dev=0x2ddf920, errp=0x7fffffffd6d8) at hw/virtio/virtio-pci.c:1853
> #11 0x000000000071e439 in pci_qdev_realize (qdev=0x2ddf920, errp=0x7fffffffd7b8) at hw/pci/pci.c:2001
> #12 0x00000000007badaa in virtio_pci_dc_realize (qdev=0x2ddf920, errp=0x7fffffffd7b8) at hw/virtio/virtio-pci.c:1930
> #13 0x000000000065806f in device_set_realized (obj=0x2ddf920, value=true, errp=0x7fffffffd9a8) at hw/core/qdev.c:939
> #14 0x000000000083aaf5 in property_set_bool (obj=0x2ddf920, v=0x2decfd0, name=0x9b2c0e "realized", opaque=0x2ddf5d0, errp=0x7fffffffd9a8) at qom/object.c:1860
> #15 0x0000000000838c46 in object_property_set (obj=0x2ddf920, v=0x2decfd0, name=0x9b2c0e "realized", errp=0x7fffffffd9a8) at qom/object.c:1094
> #16 0x000000000083c23f in object_property_set_qobject (obj=0x2ddf920, value=0x2dece90, name=0x9b2c0e "realized", errp=0x7fffffffd9a8) at qom/qom-qobject.c:27
> #17 0x0000000000838f9a in object_property_set_bool (obj=0x2ddf920, value=true, name=0x9b2c0e "realized", errp=0x7fffffffd9a8) at qom/object.c:1163
> #18 0x00000000005bfcea in qdev_device_add (opts=0x1451320, errp=0x7fffffffda30) at qdev-monitor.c:624
> #19 0x00000000005c9662 in device_init_func (opaque=0x0, opts=0x1451320, errp=0x0) at vl.c:2305
> #20 0x000000000095f491 in qemu_opts_foreach (list=0xe5bd80, func=0x5c9624 <device_init_func>, opaque=0x0, errp=0x0) at util/qemu-option.c:1114
> #21 0x00000000005ce9be in main (argc=46, argv=0x7fffffffdeb8, envp=0x7fffffffe030) at vl.c:4583
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1681688
>
> Title:
>   qemu live migration failed
>
> Status in QEMU:
>   New
>
> Bug description:
>   qemu live migration failed
>
>   the dest qemu report this error.
>
>   Receiving block device images
>   Completed 0 %^Mqemu-system-x86_64: block/io.c:1348: bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed.
>
>   this bug is caused by this patch:
>   http://git.qemu-project.org/?p=qemu.git;a=commit;h=d35ff5e6b3aa3a706b0aa3bcf11400fac945b67a
>
>   rollback this commit, the problem solved.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1681688/+subscriptions
>
