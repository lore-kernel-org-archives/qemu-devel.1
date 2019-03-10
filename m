Received: from eggs.gnu.org ([209.51.188.92]:35700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2z0W-0000x9-EE
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2z0U-0003NC-OI
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:00:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:39348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2z0U-0003Ka-Hx
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2z0S-0007WF-0c
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 14:00:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 01B582E80C7
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 14:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Mar 2019 13:50:45 -0000
From: YunQiang Su <wzssyqa@gmail.com>
Reply-To: Bug 1818483 <1818483@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155168800961.29550.2360664198558693792.malonedeb@chaenomeles.canonical.com>
Message-Id: <155222584537.27918.371851496126472096.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818483] Re: qemu user mode does not support
 binfmt_misc config with flags include "P"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

@Peter Luyou and me are working on try to pass the info about whether P
flag is enabled or not by enviroment var or auxval. While we have not
found the right method to do it from binfmt_misc.

In fact, currently qemu trys to process the O flag, and it cannot work at a=
ll.
When you install qemu-user-static package from Debian/Ubuntu, the O flag is=
 enabled,
while =

   execfd =3D qemu_getauxval(AT_EXECFD);
always return 0.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818483

Title:
  qemu user mode does not support binfmt_misc config with flags include
  "P"

Status in QEMU:
  New

Bug description:
  Hi Sir:
  During our test in chroot environment with qemu-user-static, we got some =
test cases failed because of program output warning with unexpected full pa=
th name.
  For example in test module "Devscripts"
  the test item for broken tarball expected the warning info:
  <tar: This does not look like a tar archive
  tar: ******* >
  but the output was:
  </bin/tar: This does not look like a tar archive
  /bin/tar: ******>
  the cause is the config file of binfmt_misc was set not to send argv0, fo=
r example:
  type command "tar" after chroot:
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
  lpeng@lpeng-VirtualBox:~/projects_lpeng/qemu/mips_2/sid$ sudo chroot .
  [sudo] password for lpeng: =

  root@lpeng-VirtualBox:/# tar
  /bin/tar: You must specify one of the '-Acdtrux', '--delete' or '--test-l=
abel' options
  Try '/bin/tar --help' or '/bin/tar --usage' for more information.
  root@lpeng-VirtualBox:/# =

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

  by adding output log in main()@qemu/Linux-user/main.c
  we found the original input command was changed, and qemu do not know tha=
t, we got the input args:
  argv_0----/usr/bin/qemu-mips64el-static---
  argv_1----/bin/tar---
  argv_2----NULL---

  Next step we modified the flags=3DP in the corresponding config under fol=
der /proc/sys/fs/binfmt_misc, then binfmt_misc sent argv[0] to qemu.
  But chroot could not start bash because in current qemu dose not consider=
 about this unexpected one more"argv[0]"

  =

  After modified qemu code temporary to handle the new argv list we got the=
 input args, and from argv[2] is the original input command
  argv_0----/usr/bin/qemu-mips64el-static---
  argv_1----/bin/tar---
  argv_2----tar---

  We need the original input from command line, so is it possible that let =
binfmt_misc to pass one more additional args or env to qemu as a token of t=
he binfmt_misc flag, then qemu can judge how to parse the input args by it?
  looking forward your suggestions.

  Thanks
  luyou

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818483/+subscriptions
