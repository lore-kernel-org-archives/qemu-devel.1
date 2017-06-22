Received: from eggs.gnu.org ([2001:4830:134:3::10]:56262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNqBE-0000NJ-OM
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 20:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dNqBB-0002WZ-La
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 20:41:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:52028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dNqBB-0002WL-G0
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 20:41:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dNqB9-0007m4-Is
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 00:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 81FA12E8033
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 00:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2017 00:32:08 -0000
From: Chris Stevens <1699628@bugs.launchpad.net>
Reply-To: Bug 1699628 <1699628@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149809152821.28527.1538400923657139906.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1699628] [NEW] Direct Sound Audio does not stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The Bug:
DirectSound Audio does not stop because dsound_ctl_out does not end up call=
ing IDirectSoundBuffer_Stop. This is due to a bug in dsound_get_status_out =
where the status flags returned from IDirectSoundBuffer_GetStatus are compa=
red with DSERR_BUFFERLOST (an error code) rather than DSBSTATUS_BUFFERLOST =
(a status flag). The status is actually (DSBSTATUS_LOOPING | DSBSTATUS_PLAY=
ING) and one of those flags happens to be set in the DSERR_BUFFERLOST value=
. As a result, dsound_get_status_out returns -1 and dsound_ctl_out exits be=
fore calling IDirectSoundBuffer_Stop.

The Fix:
A simple replacement of DSERR_BUFFERLOST with DSBSTATUS_BUFFERLOST in dsoun=
d_get_status_out. =

Should be: "if (*statusp & DSBSTATUS_BUFFERLOST) {"

Version Information:
I was able to produce this bug in Qemu 2.9.0 and with the latest source pul=
led from git://git.qemu-project.org/qemu.git (commit 8dfaf23ae1). I was abl=
e to verify my suggested fix with the latest source.

Guest OS:
Discovered running Minoca OS v0.4 (www.github.com/minoca/os). Images at htt=
ps://www.minocacorp.com/download/nightlies/latest-x86. The Qemu test images=
 I tried (http://wiki.qemu.org/Testing/System_Images) didn't have an easy s=
ound setup (was looking for 'aplay' or similar).

Qemu Command Line:
./qemu-system-x86_64.exe -m 512 -hda pc.img -smp 4 -usbdevice keyboard -dev=
ice intel-hda -device hda-duplex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699628

Title:
  Direct Sound Audio does not stop

Status in QEMU:
  New

Bug description:
  The Bug:
  DirectSound Audio does not stop because dsound_ctl_out does not end up ca=
lling IDirectSoundBuffer_Stop. This is due to a bug in dsound_get_status_ou=
t where the status flags returned from IDirectSoundBuffer_GetStatus are com=
pared with DSERR_BUFFERLOST (an error code) rather than DSBSTATUS_BUFFERLOS=
T (a status flag). The status is actually (DSBSTATUS_LOOPING | DSBSTATUS_PL=
AYING) and one of those flags happens to be set in the DSERR_BUFFERLOST val=
ue. As a result, dsound_get_status_out returns -1 and dsound_ctl_out exits =
before calling IDirectSoundBuffer_Stop.

  The Fix:
  A simple replacement of DSERR_BUFFERLOST with DSBSTATUS_BUFFERLOST in dso=
und_get_status_out. =

  Should be: "if (*statusp & DSBSTATUS_BUFFERLOST) {"

  Version Information:
  I was able to produce this bug in Qemu 2.9.0 and with the latest source p=
ulled from git://git.qemu-project.org/qemu.git (commit 8dfaf23ae1). I was a=
ble to verify my suggested fix with the latest source.

  Guest OS:
  Discovered running Minoca OS v0.4 (www.github.com/minoca/os). Images at h=
ttps://www.minocacorp.com/download/nightlies/latest-x86. The Qemu test imag=
es I tried (http://wiki.qemu.org/Testing/System_Images) didn't have an easy=
 sound setup (was looking for 'aplay' or similar).

  Qemu Command Line:
  ./qemu-system-x86_64.exe -m 512 -hda pc.img -smp 4 -usbdevice keyboard -d=
evice intel-hda -device hda-duplex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1699628/+subscriptions
