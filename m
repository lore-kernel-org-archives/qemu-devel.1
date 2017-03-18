Received: from eggs.gnu.org ([2001:4830:134:3::10]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpDfC-00006w-PI
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 08:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cpDf9-0001Nb-MP
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 08:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:48943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cpDf9-0001NQ-FO
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 08:40:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cpDf7-0004hK-BV
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 12:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 528662E80C6
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 12:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Mar 2017 12:35:02 -0000
From: Leo Gaspard <1673957@bugs.launchpad.net>
Reply-To: Bug 1673957 <1673957@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170318123502.30244.36321.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1673957] [NEW] virtfs: mapped-xattr on mount point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

With
  -virtfs local,path=3D"/tmp",security_model=3Dmapped-xattr,mount_tag=3D"sh=
ared2"
in the qemu command line,
  shared2 on /mnt/testbis type 9p (rw,sync,dirsync,relatime,trans=3Dvirtio,=
version=3D9p2000.L,msize=3D262144)
in the guest mount points, and
  tmpfs on /tmp type tmpfs (rw,nosuid,nodev)
in the host mount points (with CONFIG_TMPFS_XATTR=3Dy according to zgrep /p=
roc/config.gz), running qemu as user "vm-test", trying to "touch a" in /mnt=
/testbis on the VM fails with "Operation not supported". In addition, no fi=
le or directory actually present in the host's /tmp can be seen in the gues=
t's /mnt/testbis.

When trying to replace "/tmp" with "/tmp/aaa" on the host, with /tmp/aaa
owned by root:root, still running qemu as vm-test, trying to run "ls" in
the guest's /mnt/testbis fails with the weird "ls: reading directory
'.': Cannot allocate memory", while the directory is empty.

After a "chown vm-test /tmp/aaa", the guest can list the files (despite
the permissions already allowing it to do so before), but still not
write new files: "cannot touch 'b': Operation not supported".

Do you have a pointer as to what is happening?

PS: complete setup is running all this inside a qemu VM that I use for
testing, I guess it shouldn't matter but saying it just in case

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1673957

Title:
  virtfs: mapped-xattr on mount point

Status in QEMU:
  New

Bug description:
  With
    -virtfs local,path=3D"/tmp",security_model=3Dmapped-xattr,mount_tag=3D"=
shared2"
  in the qemu command line,
    shared2 on /mnt/testbis type 9p (rw,sync,dirsync,relatime,trans=3Dvirti=
o,version=3D9p2000.L,msize=3D262144)
  in the guest mount points, and
    tmpfs on /tmp type tmpfs (rw,nosuid,nodev)
  in the host mount points (with CONFIG_TMPFS_XATTR=3Dy according to zgrep =
/proc/config.gz), running qemu as user "vm-test", trying to "touch a" in /m=
nt/testbis on the VM fails with "Operation not supported". In addition, no =
file or directory actually present in the host's /tmp can be seen in the gu=
est's /mnt/testbis.

  When trying to replace "/tmp" with "/tmp/aaa" on the host, with
  /tmp/aaa owned by root:root, still running qemu as vm-test, trying to
  run "ls" in the guest's /mnt/testbis fails with the weird "ls: reading
  directory '.': Cannot allocate memory", while the directory is empty.

  After a "chown vm-test /tmp/aaa", the guest can list the files
  (despite the permissions already allowing it to do so before), but
  still not write new files: "cannot touch 'b': Operation not
  supported".

  Do you have a pointer as to what is happening?

  PS: complete setup is running all this inside a qemu VM that I use for
  testing, I guess it shouldn't matter but saying it just in case

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1673957/+subscriptions
