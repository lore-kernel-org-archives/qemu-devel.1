Received: from eggs.gnu.org ([2001:4830:134:3::10]:35326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ciczy-000077-GV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ciczx-00081V-Hh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:19:06 -0500
Date: Tue, 28 Feb 2017 16:18:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170228081855.GA29328@lemon.lan>
References: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
	<1488226184-9044-5-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488226184-9044-5-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/43] block: Involve block drivers in
 permission granting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On Mon, 02/27 21:09, Kevin Wolf wrote:
> +    /**
> +     * Called to inform the driver that the set of cumulative set of used
> +     * permissions for @bs has changed to @perm, and the set of sharable
> +     * permission to @shared. The driver can use this to propagate changes to
> +     * its children (i.e. request permissions only if a parent actually needs
> +     * them).
> +     *
> +     * This function is only invoked after bdrv_check_perm(), 

Trying to rebase the image locking series and found this contract doesn't seem
to hold as in:

(gdb) bt
#0  0x00007ffff1ad291f in raise () at /lib64/libc.so.6
#1  0x00007ffff1ad451a in abort () at /lib64/libc.so.6
#2  0x00007ffff1acada7 in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007ffff1acae52 in  () at /lib64/libc.so.6
#4  0x0000555555b9e73e in raw_set_perm (bs=0x5555567ee7a0, perm=0, shared=31) at /stor/work/qemu/block/file-posix.c:2541
#5  0x0000555555b43437 in bdrv_set_perm (bs=0x5555567ee7a0, cumulative_perms=0, cumulative_shared_perms=31) at /stor/work/qemu/block.c:1484
#6  0x0000555555b4357a in bdrv_update_perm (bs=0x5555567ee7a0) at /stor/work/qemu/block.c:1514
#7  0x0000555555b43cb9 in bdrv_replace_child (child=0x5555567f2cb0, new_bs=0x0) at /stor/work/qemu/block.c:1721
#8  0x0000555555b4402e in bdrv_detach_child (child=0x5555567f2cb0) at /stor/work/qemu/block.c:1798
#9  0x0000555555b44070 in bdrv_root_unref_child (child=0x5555567f2cb0) at /stor/work/qemu/block.c:1809
#10 0x0000555555b941f1 in blk_remove_bs (blk=0x5555567f3e60) at /stor/work/qemu/block/block-backend.c:541
#11 0x0000555555b9397a in blk_delete (blk=0x5555567f3e60) at /stor/work/qemu/block/block-backend.c:227
#12 0x0000555555b93b3e in blk_unref (blk=0x5555567f3e60) at /stor/work/qemu/block/block-backend.c:271
#13 0x0000555555b45215 in bdrv_open_inherit (filename=0x5555567de020 "/stor/vm/arch.img", reference=0x0, options=0x5555567ec5e0, flags=8194, parent=0x0, child_role=0x0, errp=0x7fffffffdcc8)
    at /stor/work/qemu/block.c:2312
#14 0x0000555555b45613 in bdrv_open (filename=0x5555567de020 "/stor/vm/arch.img", reference=0x0, options=0x5555567e60b0, flags=0, errp=0x7fffffffdcc8) at /stor/work/qemu/block.c:2400
#15 0x0000555555b93864 in blk_new_open (filename=0x5555567de020 "/stor/vm/arch.img", reference=0x0, options=0x5555567e60b0, flags=0, errp=0x7fffffffdcc8)
    at /stor/work/qemu/block/block-backend.c:209
#16 0x00005555558d7db0 in blockdev_init (file=0x5555567de020 "/stor/vm/arch.img", bs_opts=0x5555567e60b0, errp=0x7fffffffdcc8) at /stor/work/qemu/blockdev.c:585
#17 0x00005555558d8e92 in drive_new (all_opts=0x55555674ff50, block_default_type=IF_IDE) at /stor/work/qemu/blockdev.c:1083
#18 0x00005555558e883a in drive_init_func (opaque=0x5555567a5760, opts=0x55555674ff50, errp=0x0) at /stor/work/qemu/vl.c:1129
#19 0x0000555555c4c5d8 in qemu_opts_foreach (list=0x555556143c60 <qemu_drive_opts>, func=0x5555558e880a <drive_init_func>, opaque=0x5555567a5760, errp=0x0)
    at /stor/work/qemu/util/qemu-option.c:1135
#20 0x00005555558f1020 in main (argc=2, argv=0x7fffffffe1a8, envp=0x7fffffffe1c0) at /stor/work/qemu/vl.c:4410

Maybe bdrv_update_perm should call bdrv_check_perm too?

Fam
