Received: from eggs.gnu.org ([209.51.188.92]:45408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEgaE-0006OS-39
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hEgaD-0005Bo-1c
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:46:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:46572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hEgaC-0005B4-PX
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 16:46:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hEga9-000238-3N
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 20:46:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F29832E81C9
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 20:45:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Apr 2019 20:36:38 -0000
From: =?utf-8?q?Matthias_L=C3=BCscher?= <1823790@bugs.launchpad.net>
Reply-To: Bug 1823790 <1823790@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155475569461.20468.17957138207618410360.malonedeb@chaenomeles.canonical.com>
Message-Id: <155501499891.7911.12140611810489192279.malone@wampee.canonical.com>
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

This is probably the tight loop that gets triggered:
https://github.com/systemd/systemd/commit/217d89678269334f461e9abeeffed5707=
7b21454

It looks like the previous implementation was just a bit more
"tolerant".

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
