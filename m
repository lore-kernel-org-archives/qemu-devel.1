Received: from eggs.gnu.org ([2001:4830:134:3::10]:59209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZx47-0000ZB-Gu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZx43-0001L9-JL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:00:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:55216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZx43-0001KM-7b
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:59:59 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZx42-0000M7-6S
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:59:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0E4B12E80D2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:59:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2018 10:50:07 -0000
From: Thomas Huth <939027@bugs.launchpad.net>
Reply-To: Bug 939027 <939027@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120222214959.20738.46143.malonedeb@soybean.canonical.com>
Message-Id: <151575420823.25347.2143462359440586196.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 939027] Re: Combining direct_io and non-direct_io
 leads to hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/939027

Title:
  Combining direct_io and non-direct_io leads to hang

Status in QEMU:
  Won't Fix

Bug description:
  Version 0.12.2 - I know this isn't the latest but I looked through the
  changelogs and couldn't find any references to this being fixed.

  This is related to issues that many apps have, and is described in more d=
etail here:
      http://oss.sgi.com/archives/xfs/2010-07/msg00163.html
  and:
      https://bugs.launchpad.net/percona-xtrabackup/+bug/606981

  When using both direct io and buffered io on the same file, you can cause=
 corruption on the filesystem and other issues.
  XFS out right hangs, but the problem exists on ext3 and other filesystems=
 which silently carry on.

  **this is a data corruption issue**.

  This is the full stack trace we got from a recent hang:

  Feb 22 19:55:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 19:55:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 19:55:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 19:55:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 19:55:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 19:55:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 19:55:14 virt11 kernel: Call Trace:
  Feb 22 19:55:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 19:55:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 19:55:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 19:55:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 19:55:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 19:55:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 19:55:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 19:55:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 19:55:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 19:55:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 19:55:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 19:57:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 19:57:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 19:57:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 19:57:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 19:57:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 19:57:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 19:57:14 virt11 kernel: Call Trace:
  Feb 22 19:57:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 19:57:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 19:57:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 19:57:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 19:57:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 19:57:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 19:57:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 19:57:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 19:57:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 19:57:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 19:57:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 19:59:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 19:59:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 19:59:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 19:59:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 19:59:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 19:59:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 19:59:14 virt11 kernel: Call Trace:
  Feb 22 19:59:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 19:59:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 19:59:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 19:59:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 19:59:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 19:59:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 19:59:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 19:59:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 19:59:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 19:59:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 19:59:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:01:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:01:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:01:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:01:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:01:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:01:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:01:14 virt11 kernel: Call Trace:
  Feb 22 20:01:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:01:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:01:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:01:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:01:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:01:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:01:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:01:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:01:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:01:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:01:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:03:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:03:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:03:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:03:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:03:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:03:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:03:14 virt11 kernel: Call Trace:
  Feb 22 20:03:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:03:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:03:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:03:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:03:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:03:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:03:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:03:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:03:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:03:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:03:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:05:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:05:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:05:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:05:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:05:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:05:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:05:14 virt11 kernel: Call Trace:
  Feb 22 20:05:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:05:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:05:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:05:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:05:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:05:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:05:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:05:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:05:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:05:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:05:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:07:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:07:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:07:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:07:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:07:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:07:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:07:14 virt11 kernel: Call Trace:
  Feb 22 20:07:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:07:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:07:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:07:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:07:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:07:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:07:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:07:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:07:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:07:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:07:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:09:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:09:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:09:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:09:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:09:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:09:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:09:14 virt11 kernel: Call Trace:
  Feb 22 20:09:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:09:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:09:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:09:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:09:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:09:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:09:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:09:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:09:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:09:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:09:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:11:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:11:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:11:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:11:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:11:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:11:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:11:14 virt11 kernel: Call Trace:
  Feb 22 20:11:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:11:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:11:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:11:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:11:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:11:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:11:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:11:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:11:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:11:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:11:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b
  Feb 22 20:13:14 virt11 kernel: INFO: task qemu-kvm:18360 blocked for more=
 than 120 seconds.
  Feb 22 20:13:14 virt11 kernel: "echo 0 > /proc/sys/kernel/hung_task_timeo=
ut_secs" disables this message.
  Feb 22 20:13:14 virt11 kernel: qemu-kvm      D 0000000000000002     0 183=
60      1 0x00000080
  Feb 22 20:13:14 virt11 kernel: ffff8808614457e8 0000000000000086 ffff8800=
282d5f80 ffff8800282d5f80
  Feb 22 20:13:14 virt11 kernel: ffff880861445768 ffffffff810573ce ffff8808=
61445768 0000000000000086
  Feb 22 20:13:14 virt11 kernel: ffff8808f15bba78 ffff880861445fd8 00000000=
0000f598 ffff8808f15bba78
  Feb 22 20:13:14 virt11 kernel: Call Trace:
  Feb 22 20:13:14 virt11 kernel: [<ffffffff810573ce>] ? activate_task+0x2e/=
0x40
  Feb 22 20:13:14 virt11 kernel: [<ffffffff814dd755>] rwsem_down_failed_com=
mon+0x95/0x1d0
  Feb 22 20:13:14 virt11 kernel: [<ffffffff814dd8b3>] rwsem_down_write_fail=
ed+0x23/0x30
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8126e573>] call_rwsem_down_write=
_failed+0x13/0x20
  Feb 22 20:13:14 virt11 kernel: [<ffffffff814dcdb2>] ? down_write+0x32/0x40
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa0332d6e>] xfs_ilock+0x7e/0xd0 [=
xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa033ab02>] xfs_iomap+0x2e2/0x440=
 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa0354116>] __xfs_get_blocks+0x86=
/0x200 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa03542aa>] xfs_get_blocks_direct=
+0x1a/0x20 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffff811ac132>] __blockdev_direct_IO+=
0x872/0xc40
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa0353f50>] xfs_vm_direct_IO+0xb0=
/0xf0 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa0354290>] ? xfs_get_blocks_dire=
ct+0x0/0x20 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa0353cc0>] ? xfs_end_io_direct+0=
x0/0xe0 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8106dd57>] ? current_fs_time+0x2=
7/0x30
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8110df22>] generic_file_direct_w=
rite+0xc2/0x190
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa034bfcf>] ? xfs_trans_unlocked_=
item+0x4f/0x60 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa035dd1d>] xfs_write+0x4fd/0xb70=
 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8105dc72>] ? default_wake_functi=
on+0x12/0x20
  Feb 22 20:13:14 virt11 kernel: [<ffffffffa03599a1>] xfs_file_aio_write+0x=
61/0x70 [xfs]
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8117241a>] do_sync_write+0xfa/0x=
140
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8107fbc2>] ? send_signal+0x42/0x=
80
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8108e160>] ? autoremove_wake_fun=
ction+0x0/0x40
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8107ff96>] ? group_send_sig_info=
+0x56/0x70
  Feb 22 20:13:14 virt11 kernel: [<ffffffff81211d3b>] ? selinux_file_permis=
sion+0xfb/0x150
  Feb 22 20:13:14 virt11 kernel: [<ffffffff812051a6>] ? security_file_permi=
ssion+0x16/0x20
  Feb 22 20:13:14 virt11 kernel: [<ffffffff81172718>] vfs_write+0xb8/0x1a0
  Feb 22 20:13:14 virt11 kernel: [<ffffffff810d1b62>] ? audit_syscall_entry=
+0x272/0x2a0
  Feb 22 20:13:14 virt11 kernel: [<ffffffff81173212>] sys_pwrite64+0x82/0xa0
  Feb 22 20:13:14 virt11 kernel: [<ffffffff8100b172>] system_call_fastpath+=
0x16/0x1b

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/939027/+subscriptions
