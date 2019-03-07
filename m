Received: from eggs.gnu.org ([209.51.188.92]:60821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h20uc-0002cJ-Pj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h20uU-0005C3-TC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:50:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:46098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h20uS-00055A-Gh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h20uQ-0007vo-Kg
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 21:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9B7D02E80CD
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 21:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2019 21:43:27 -0000
From: "Heitor R. Alves de Siqueira" <1818880@bugs.launchpad.net>
Reply-To: Bug 1818880 <1818880@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155189278546.17656.7588906080638087853.malonedeb@gac.canonical.com>
Message-Id: <155199500734.8973.8754190342273361963.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1818880] Re: Deadlock when detaching network
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Patch removed: "Debdiff for xenial v2"
   https://bugs.launchpad.net/cloud-archive/+bug/1818880/+attachment/524456=
7/+files/xenial_v2.debdiff

** Patch added: "Correct debdiff for xenial v2"
   https://bugs.launchpad.net/cloud-archive/+bug/1818880/+attachment/524456=
8/+files/lp1818880-v2.debdiff

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818880

Title:
  Deadlock when detaching network interface

Status in Ubuntu Cloud Archive:
  Confirmed
Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released
Status in qemu source package in Xenial:
  Confirmed
Status in qemu source package in Bionic:
  Fix Released
Status in qemu source package in Cosmic:
  Fix Released
Status in qemu source package in Disco:
  Fix Released

Bug description:
  [Impact]
  Qemu guests hang indefinitely

  [Description]
  When running a Qemu guest with VirtIO network interfaces, detaching an in=
terface that's currently being used can result in a deadlock. The guest ins=
tance will hang and become unresponsive to commands, and the only option is=
 to kill -9 the instance.
  The reason for this is a dealock between a monitor and an RCU thread, whi=
ch will fight over the BQL (qemu_global_mutex) and the critical RCU section=
 locks. The monitor thread will acquire the BQL for detaching the network i=
nterface, and fire up a helper thread to deal with detaching the network ad=
apter. That new thread needs to wait on the RCU thread to complete the dele=
tion, but the RCU thread wants the BQL to commit its transactions.
  This bug is already fixed upstream (73c6e4013b4c rcu: completely disable =
pthread_atfork callbacks as soon as possible) and included for other series=
 (see below), so we don't need to backport it to Bionic onwards.

  Upstream commit:
  https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D73c6e4013b4c

  $ git describe --contains 73c6e4013b4c
  v2.10.0-rc2~1^2~8

  $ rmadison qemu
  =3D=3D=3D> qemu | 1:2.5+dfsg-5ubuntu10.34 | xenial-updates/universe   | a=
md64, ...
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu | 1:2.11+dfsg-1ubuntu7    | bionic/uni=
verse           | amd64, ...
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu | 1:2.12+dfsg-3ubuntu8    | cosmic/uni=
verse           | amd64, ...
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu | 1:3.1+dfsg-2ubuntu2     | disco/univ=
erse            | amd64, ...

  [Test Case]
  Being a racing condition, this is a tricky bug to reproduce consistently.=
 We've had reports of users running into this with OpenStack deployments an=
d Windows Server guests, and the scenario is usually like this:
  1) Deploy a 16vCPU Windows Server 2012 R2 guest with a virtio network int=
erface
  2) Stress the network interface with e.g. Windows HLK test suite or simil=
ar
  3) Repeatedly attach/detach the network adapter that's in use
  It usually takes more than ~4000 attach/detach cycles to trigger the bug.

  [Regression Potential]
  Regressions for this might arise from the fact that the fix changes RCU l=
ock code. Since this patch has been upstream and in other series for a whil=
e, it's unlikely that it would regressions in RCU code specifically. Other =
code that makes use of the RCU locks (MMIO and some monitor events) will be=
 thoroughly tested for any regressions with use-case scenarios and scripted=
 runs.

To manage notifications about this bug go to:
https://bugs.launchpad.net/cloud-archive/+bug/1818880/+subscriptions
