Received: from eggs.gnu.org ([2001:4830:134:3::10]:53857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZvTj-00054B-76
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fZvTf-0007G0-9g
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:50:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:46934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fZvTf-0007Er-3B
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 05:50:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fZvTd-00006m-C4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:50:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5A5B92E8030
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 09:50:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Jul 2018 09:45:07 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1779634 <1779634@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153052346519.30029.15773821079672320069.malonedeb@wampee.canonical.com>
Message-Id: <153052470743.18486.17863358342280760595.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1779634] Re: qemu-x86_64 on aarch64 reports
 "Synchronous External Abort"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu-x86_64 is just a userspace program. If the kernel is getting
Synchronous External Aborts then this is not a QEMU problem. Either
there's a bug in the host kernel, or the guest binary is attempting to
mmap /dev/mem and do wrong things to it because it's expecting it to be
an x86 system. I suspect the latter (it's probably trying to do
userspace writes directly to the network controller handware). This sort
of binary is never going to be runnable via QEMU.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1779634

Title:
  qemu-x86_64 on aarch64 reports "Synchronous External Abort"

Status in QEMU:
  New

Bug description:
  Purpose: to run x86_64 utilities on aarch64 platform (Intel/Dell network =
adapters' firmware upgrade tools)
  System: aarch64 server platform, with ubuntu 16.04 (xenial) Linux 4.13.0-=
45-generic #50~16.04.1-Ubuntu SMP Wed May 30 11:14:25 UTC 2018 aarch64 aarc=
h64 aarch64 GNU/Linux

  Reproduce:
  1) build linux-user qemu-x86_64 static from source (tried both version 2.=
12.0 & 2.11.2)
  =C2=A0=C2=A0=C2=A0./configure --target-list=3Dx86_64-linux-user --disable=
-system --static --enable-linux-user

  2) install the interpreter into binfmt_misc filesystem
  =C2=A0=C2=A0=C2=A0$ cat /proc/sys/fs/binfmt_misc/qemu-x86_64
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enabled
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interpreter /usr/local/bin/qemu-x86_64
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags:
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0offset 0
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0magic 7f454c4602010100000000000000000002003=
e00
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mask fffffffffffefefcfffffffffffffffffeffff=
ff

  3) packaging Intel/Dell upgrade utilities into docker images, I've publis=
hed two on docker hub:
  =C2=A0=C2=A0=C2=A0REPOSITORY          TAG
  =C2=A0=C2=A0=C2=A0heyi/dellupdate     latest
  =C2=A0=C2=A0=C2=A0heyi/nvmupdate64e   latest

  4) run the docker container on aarch64 server platform:
  =C2=A0=C2=A0=C2=A0docker run -it --privileged --network host --volume /us=
r/local/bin/qemu-x86_64:/usr/local/bin/qemu-x86_64 heyi/dellupdate:latest

  5) finally, within docker container run the upgrade tool:
  =C2=A0=C2=A0=C2=A0# ./Network_Firmware_T6VN9_LN_18.5.17_A00.BIN

  Errors: in dmesg it reports excessive 'Synchronous External Abort':

  kernel: [242850.159893] Synchronous External Abort: synchronous external =
abort (0x92000610) at 0x0000000000429958
  kernel: [242850.169199] Unhandled fault: synchronous external abort (0x92=
000610) at 0x0000000000429958

  thanks and best regards, Yi

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1779634/+subscriptions
