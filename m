Received: from eggs.gnu.org ([2001:4830:134:3::10]:33930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dXFTf-0007g1-Lw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dXFTa-00059C-Oi
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:30:59 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com
	([104.47.37.131]:48640
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1dXFTa-00058c-Br
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:30:54 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Mon, 17 Jul 2017 23:30:51 +0000
Message-ID: <DM2PR21MB0060B20A50AEEC8B6816154C9EA00@DM2PR21MB0060.namprd21.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Disable image locking for snapshot drive?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>

Hi all,

I'm running a recent Linux build of qemu on Windows Subsystem for Linux (WS=
L) which doesn't appear to implement file locking:

$ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0 -devic=
e virtio-blk-pci,drive=3Dhd0
qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed to =
unlock byte 100
qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed to =
unlock byte 100
qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed to =
lock byte 100

That's no big deal; I can switch it off:

$ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,file.locking=3D=
off,id=3Dhd0 ...
(all good)

But how can I do the same for a snapshot drive?

$ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,file.locking=3D=
off,id=3Dhd0 -snapshot ...
qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,file.locking=3Doff,i=
d=3Dhd0: Failed to unlock byte 100
qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,file.locking=3Doff,i=
d=3Dhd0: Failed to unlock byte 100
qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,file.locking=3Doff,i=
d=3Dhd0: Could not create temporary overlay '/var/tmp/vl.o83dxn': Failed to=
 lock byte 100

(I also tried the snapshot=3Don drive option with similar results.)

Thanks,
Andrew
