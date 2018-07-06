Received: from eggs.gnu.org ([2001:4830:134:3::10]:50223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQC4-0001vd-OT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbQC0-0003WG-8G
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:50:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:60820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbQBz-0003Us-UL
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:50:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbQBy-00009D-QD
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 12:50:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 960E42E819C
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:50:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 12:40:49 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1777226 <1777226@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152914430206.1773.1773906291047084265.malonedeb@chaenomeles.canonical.com>
Message-Id: <153088084960.29798.12397489008872355828.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777226] Re: qemu-user warnings confuse userland
 applications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Yes, we should probably move these "unimplemented syscall" warnings to
the LOG_UNIMP logging level (which you can then turn on if you want
them).


** Tags added: linux-user

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777226

Title:
  qemu-user warnings confuse userland applications

Status in QEMU:
  Confirmed

Bug description:
  I recently observed that warning messages emitted by qemu-user can
  confuse applications when reading from stdout/stderr. This was
  observed with the configure script of OpenJDK-11 on qemu-sh4:

  configure: Found potential Boot JDK using configure arguments
  configure: Potential Boot JDK found at /usr/lib/jvm/java-10-openjdk-sh4 i=
s incorrect JDK version (qemu: Unsupported syscall: 318); ignoring
  configure: (Your Boot JDK version must be one of: 10 11)
  configure: error: The path given by --with-boot-jdk does not contain a va=
lid Boot JDK
  configure exiting with result code 1

  See:
  https://buildd.debian.org/status/fetch.php?pkg=3Dopenjdk-11&arch=3Dsh4&ve=
r=3D11%7E18-1&stamp=3D1529119043&raw=3D0

  Commenting out the line of code which emits the warning fixes the
  problem for me and the configure script finishes without problems.

  Thus, qemu should be modified to avoid cluttering stdout or stderr
  with its own messages and rather send those warnings to a log file or
  similar.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777226/+subscriptions
