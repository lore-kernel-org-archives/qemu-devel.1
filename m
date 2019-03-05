Received: from eggs.gnu.org ([209.51.188.92]:42224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lpeng@wavecomp.com>) id 1h18Qt-0000vf-VL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lpeng@wavecomp.com>) id 1h18Qs-0005Dk-Rc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:40:27 -0500
Received: from mail-eopbgr740138.outbound.protection.outlook.com
	([40.107.74.138]:6209
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lpeng@wavecomp.com>) id 1h18Qs-0005AZ-Fx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:40:26 -0500
From: Luyou Peng <lpeng@wavecomp.com>
Date: Tue, 5 Mar 2019 11:40:24 +0000
Message-ID: <BN6PR2201MB13474AAB9F74F5C17C72CD8BD1720@BN6PR2201MB1347.namprd22.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu user mode could not support binfmt_misc config
 with flags include "P"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yunqiang Su <ysu@wavecomp.com>

Hi Sir:
During our test in chroot environment with qemu-user-static, we got some te=
st cases failed because of program output warning with unexpected full path=
 name.
For example in test module "Devscripts"
the test item for broken tarball expected the warning info:
< tar: This does not look like a tar archive
tar: ******* >
but the output was:
< /bin/tar: This does not look like a tar archive
/bin/tar: ******>
the cause is the config file of binfmt_misc was set not to send argv0, for =
example:
type command "tar" after chroot:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
lpeng@lpeng-VirtualBox:~/projects_lpeng/qemu/mips_2/sid$ sudo chroot .
[sudo] password for lpeng:
root@lpeng-VirtualBox:/# tar
/bin/tar: You must specify one of the '-Acdtrux', '--delete' or '--test-lab=
el' options
Try '/bin/tar --help' or '/bin/tar --usage' for more information.
root@lpeng-VirtualBox:/#
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

by adding output log in main()@qemu/Linux-user/main.c
we found the original input command was changed, and qemu do not know that,=
 we got the input args:
argv_0----/usr/bin/qemu-mips64el-static---
argv_1----/bin/tar---
argv_2----NULL---

Next step we modified the flags=3DP in the corresponding config under folde=
r /proc/sys/fs/binfmt_misc, then binfmt_misc sent argv[0] to qemu.
But chroot could not start bash because in current qemu dose not consider a=
bout this unexpected one more"argv[0]"

After modified qemu code temporary to handle the new argv list we got the i=
nput args, and from argv[2] is the original input command
argv_0----/usr/bin/qemu-mips64el-static---
argv_1----/bin/tar---
argv_2----tar---

I have submitted a ticket:https://bugs.launchpad.net/qemu/+bug/1818483, and=
 I tried to modified binfmt_misc.c to let it send one more args if the corr=
esponding binfmt_misc flags include "P", also I modified main.c in qemu as =
attached patch_qemu_main.patch to check if the input args include such stri=
ng. Then qemu user could support both scenarios.
Is this modification feasible?
Thanks so much!

Regards
Luyou
