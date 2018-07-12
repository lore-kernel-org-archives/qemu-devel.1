Received: from eggs.gnu.org ([2001:4830:134:3::10]:51034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdXw0-000091-Pa
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fdXvw-0007Cq-Nx
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:44030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fdXvw-0007Bn-HN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fdXvv-0001pF-8p
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 09:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3EE0A2E80C7
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 09:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jul 2018 09:23:49 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1774677 <1774677@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152787131775.31828.3557775502793493947.malonedeb@soybean.canonical.com>
Message-Id: <153138742931.21860.12095317805066591122.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774677] Re: -icount increases boot time by >10x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I tested Pavel's patch, applying it to master
(c447afd5783b9237fa51b7a85777007d8d568bfc), but I'm afraid it only made
things worse - qemu has now been booting the test kernel for 30 minutes
but the boot has still not completed.  The last console messages printed
were:

piix 0000:00:01.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xc100-0xc107
    ide1: BM-DMA at 0xc108-0xc10f

Running strace -p on the qemu process shows it calling ppoll once per
second:

ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], 5, {t=
v_sec=3D1, tv_nsec=3D0}, NULL, 8) =3D 0 (Timeout)
ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], 5, {t=
v_sec=3D1, tv_nsec=3D0}, NULL, 8) =3D 0 (Timeout)
ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], 5, {t=
v_sec=3D1, tv_nsec=3D0}, NULL, 8) =3D 0 (Timeout)
ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], 5, {t=
v_sec=3D1, tv_nsec=3D0}, NULL, 8) =3D 0 (Timeout)
ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], 5, {t=
v_sec=3D1, tv_nsec=3D0}, NULL, 8) =3D 0 (Timeout)
ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, {fd=3D8, event=
s=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}, {fd=3D11, events=3DPOLLIN}], 5, {t=
v_sec=3D1, tv_nsec=3D0}, NULL, 8) =3D 0 (Timeout)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774677

Title:
  -icount increases boot time by >10x

Status in QEMU:
  Confirmed

Bug description:
  When I specify the -icount option, some guest operations such as
  booting a Linux kernel take more than 10 times longer than otherwise.
  For example, the following will boot Aboriginal Linux to the login
  prompt about 6 seconds on my system (using TCG, not KVM):

  wget http://landley.net/aboriginal/downloads/old/binaries/1.4.5/system-im=
age-i686.tar.gz
  gunzip <system-image-i686.tar.gz | tar xfv -
  cd system-image-i686
  sh run-emulator.sh

  If I replace the last line with

  QEMU_EXTRA=3D"-icount shift=3Dauto" sh run-emulator.sh

  booting to the login prompt takes about 1 minute 20 seconds.

  I have tried different values for "shift" other than the "auto" used
  above, but have not been able to find one that gives reasonable
  performance.  Specifying "sleep=3Doff" also did not help.

  During the slow boots, qemu appears to spend most of its time
  sleeping, not using the host CPU.

  I see this with multiple versions of qemu, including current git
  sources (c181ddaa176856b3cd2dfd12bbcf25fa9c884a97), and on multiple
  host OSes, including Debian 9 on x86_64.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774677/+subscriptions
