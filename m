Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fM1PV-0004Xj-Ih
	for qemu-devel@nongnu.org; Thu, 24 May 2018 21:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fM1PR-0004Tz-Ib
	for qemu-devel@nongnu.org; Thu, 24 May 2018 21:20:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:56700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fM1PR-0004Tg-Be
	for qemu-devel@nongnu.org; Thu, 24 May 2018 21:20:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fM1PP-0006K9-KE
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 01:20:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 86B892E88D2
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 01:20:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 May 2018 01:08:39 -0000
From: John Snow <1769189@bugs.launchpad.net>
Reply-To: Bug 1769189 <1769189@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152544791493.32626.6219738999075353422.malonedeb@gac.canonical.com>
Message-Id: <152721051931.31371.17334189714928431984.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + SATA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I tried bisecting as well, and I wound up at:

1a423896 -- five out of five boot attempts succeeded.
d759c951 -- five out of five boot attempts failed.


d759c951f3287fad04210a52f2dc93f94cf58c7f is the first bad commit
commit d759c951f3287fad04210a52f2dc93f94cf58c7f
Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Date:   Tue Feb 27 12:52:48 2018 +0300

    replay: push replay_mutex_lock up the call tree



My methodology was to boot QEMU like this:

./x86_64-softmmu/qemu-system-x86_64 -m 4096 -cpu host -M q35 -enable-kvm
-smp 4 -drive id=3Dsda,if=3Dnone,file=3D/home/bos/jhuston/windows_10.qcow
-device ide-hd,drive=3Dsda -qmp tcp::4444,server,nowait

and run it three times with -snapshot and see if it hung during boot; if
it did, I marked the commit bad. If it did not, I booted and attempted
to log in and run CrystalDiskMark. If it froze before I even launched
CDM, I marked it bad.

Interestingly enough, on a subsequent (presumably bad) commit (6dc0f529)
which hangs fairly reliably on bootup (66%) I can occasionally get into
Windows 10 and run CDM -- and that unfortunately does not seem to
trigger the error again, so CDM doesn't look like a reliable way to
trigger the hangs.



Anyway, d759c951 definitely appears to change the odds of AHCI locking up d=
uring boot for me, and I suppose it might have something to do with how it =
is changing the BQL acquisition/release in main-loop.c, but I am not sure w=
hy/what yet.

Before this patch, we only lock the iothread and re-lock it if there was
a timeout, and after this patch we *always* lock and unlock the
iothread. This is probably just exposing some latent bug in the AHCI
emulator that has always existed, but now the odds of seeing it are much
higher.

I'll have to dig as to what the race is -- I'm not sure just yet.


If those of you who are seeing this bug too could confirm for me that d759c=
951 appears to be the guilty party, that probably wouldn't hurt.

Thanks!
--js

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1769189

Title:
  Issue with qemu 2.12.0 + SATA

Status in QEMU:
  New

Bug description:
  [EDIT: I first thought that OVMF was the issue, but it turns out to be
  SATA]

  I had a Windows 10 VM running perfectly fine with a SATA drive, since
  I upgraded to qemu 2.12, the guests hangs for a couple of minutes,
  works for a few seconds, and hangs again, etc. By "hang" I mean it
  doesn't freeze, but it looks like it's waiting on IO or something, I
  can move the mouse but everything needing disk access is unresponsive.

  What doesn't work: qemu 2.12 with SATA
  What works: using VirIO-SCSI with qemu 2.12 or downgrading qemu to 2.11.1=
 and keep using SATA.

  Platform is arch linux 4.16.7 on skylake and Haswell, I have attached
  the vm xml file.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1769189/+subscriptions
