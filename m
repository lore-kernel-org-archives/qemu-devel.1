Received: from eggs.gnu.org ([2001:4830:134:3::10]:39682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7NtC-0001CA-P9
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e7NtB-0005yt-PP
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:35314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e7NtB-0005vb-Il
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:46:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e7Nt9-000142-Ja
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:46:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 931902E8086
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 15:46:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Oct 2017 15:31:36 -0000
From: Thomas Huth <1308542@bugs.launchpad.net>
Reply-To: Bug 1308542 <1308542@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140416132514.17124.6406.malonedeb@chaenomeles.canonical.com>
Message-Id: <150894549620.27435.413366308889620057.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1308542] Re: hang in qemu_gluster_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing according to comment #7.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1308542

Title:
  hang in qemu_gluster_init

Status in QEMU:
  Fix Released

Bug description:
  In qemu_gluster_init, if the call to either glfs_set_volfile_server or
  glfs_set_logging fails into the "out" case, glfs_fini is called
  without having first calling glfs_init.  This causes glfs_lock to spin
  forever on this bit:

  	while (!fs->init)
  		pthread_cond_wait (&fs->cond, &fs->mutex);

  And here's the bottom part of the backtrace when hung:

  #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/=
x86_64/pthread_cond_wait.S:183
  #1  0x00007feceebf58c3 in glfs_lock (fs=3D0x7fecf15660b0) at glfs-interna=
l.h:156
  #2  glfs_active_subvol (fs=3D0x7fecf15660b0) at glfs-resolve.c:799
  #3  0x00007feceebeb5b4 in glfs_fini (fs=3D0x7fecf15660b0) at glfs.c:652
  #4  0x00007fecf0043c73 in qemu_gluster_init (gconf=3D<value optimized out=
>, filename=3D<value optimized out>) at /usr/src/debug/qemu-kvm-0.12.1.2/bl=
ock/gluster.c:229

  I believe this can be fixed by simply moving the call to glfs_init
  after the call to glfs_new but before the calls to
  glfs_set_volfile_server or glfs_set_logging.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1308542/+subscriptions
