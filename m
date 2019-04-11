Received: from eggs.gnu.org ([209.51.188.92]:50681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEgtK-00043R-WB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEgtJ-0000po-HH
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:05:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:51268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hEgtJ-0000mV-8e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 17:05:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hEgtH-00052b-To
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 21:05:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CF10F2E80CC
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 21:05:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Apr 2019 20:52:52 -0000
From: =?utf-8?q?Matthias_L=C3=BCscher?= <1823790@bugs.launchpad.net>
Reply-To: Bug 1823790 <1823790@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155475569461.20468.17957138207618410360.malonedeb@chaenomeles.canonical.com>
Message-Id: <155501597210.13466.17748252574136665465.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1823790] Re: QEMU mishandling of SO_PEERSEC
 forces systemd into tight loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have just studied a bit the systemd code and this brought me to the
following idea/temporary workaround: What about returning -1 (error) and
setting errno when getsockopt(fd, SOL_SOCKET, SO_PEERSEC, ...) gets
called? This would then let systemd know that SO_PEERSEC is not (yet)
implemented.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1823790

Title:
  QEMU mishandling of SO_PEERSEC forces systemd into tight loop

Status in QEMU:
  New

Bug description:
  While building Debian images for embedded ARM target systems I
  detected that QEMU seems to force newer systemd daemons into a tight
  loop.

  My setup is the following:

  Host machine: Ubuntu 18.04, amd64
  LXD container: Debian Buster, arm64, systemd 241
  QEMU: qemu-aarch64-static, 4.0.0-rc2 (custom build) and 3.1.0 (Debian 1:3=
.1+dfsg-7)

  To easily reproduce the issue I have created the following repository:
  https://github.com/lueschem/edi-qemu

  The call where systemd gets looping is the following:
  2837 getsockopt(3,1,31,274891889456,274887218756,274888927920) =3D -1 err=
no=3D34 (Numerical result out of range)

  Furthermore I also verified that the issue is not related to LXD.
  The same behavior can be reproduced using systemd-nspawn.

  This issue reported against systemd seems to be related:
  https://github.com/systemd/systemd/issues/11557

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1823790/+subscriptions
