Received: from eggs.gnu.org ([2001:4830:134:3::10]:55701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dByqP-0003tK-6z
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dByqL-00036d-8C
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:30:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:47119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dByqK-00036R-Vw
	for qemu-devel@nongnu.org; Sat, 20 May 2017 03:30:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dByqI-00008Q-8p
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 07:30:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 418222E8041
	for <qemu-devel@nongnu.org>; Sat, 20 May 2017 07:30:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 May 2017 07:15:26 -0000
From: PetaMem <rj@petamem.com>
Reply-To: Bug 950692 <950692@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120309101320.24066.98151.malonedeb@gac.canonical.com>
Message-Id: <149526452595.6531.1959017073744767217.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 950692] Re: High CPU usage in Host (revisited)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From our point of view, this ticket can be closed. KVM is running
without issues on all our servers for more than 5 years now.

The problem described above, was due to a weird combination of "timer"
kernel parameters in the early 3.x kernels. IIRC, enabling a high-
frequency timer and/or "tickless system" solved the issues we had.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/950692

Title:
  High CPU usage in Host (revisited)

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  last time QEMU(KVM) was working for us flawlessly was 2.6.35 kernel.

  Actually it still works flawlessly on that one single machine, that
  still has this kernel. Qemu version is meanwhile 1.0-r3, so the
  problem seems to be dependent on kernel version and not qemu version.

  We have several other machines, where the "high CPU usage in host"
  problem is present in various degrees of annoyingness.

  Both host and guest are Gentoo linux, at least that's what we test
  with. Several tested systems with other linux distributions and
  FreeBSD show similar - if not worse - behaviour. I will talk about 3
  hosts, machine A, machine B and machine C

  A:

  2.6.35-gentoo-r9 #2 SMP Sat Nov 6 22:32:28 CET 2010 x86_64 Intel(R) Xeon(=
R) CPU L5410 @ 2.33GHz
  32GB, runs about 15 KVM guests (all Gentoo, some 32bit, some 64bit, all S=
MP)
  no problems whatsoever, host CPU usage corresponds to Guest CPU usage + 1=
-2%, that's how we like it
  qemu 1.0-r3

  B:

  3.0.6-gentoo #1 SMP Sun Oct 16 18:57:31 CEST 2011 x86_64 Intel(R) Xeon(R)=
 CPU L5630 @ 2.13GHz
  144GB, runs 1(!) KVM guest (Debian 6.x)
  /usr/bin/qemu-system-x86_64 --enable-kvm -daemonize -cpu host -k de -net =
tap -tdf -hda /data/vm/disk.raw -m 768 -smp 1 -vnc :5 -net nic,model=3De100=
0,macaddr=3D...
  100% host CPU load always, therefore it got only "smp 1", if we gave it s=
mp 2, it would have 200%, smp 4 400% and so on.
  qemu 1.0-r3

  C:

  3.1.6-gentoo #5 SMP Tue Mar 6 20:34:44 CET 2012 x86_64 Intel(R) Xeon(R) C=
PU 5148 @ 2.33GHz
  16GB, runs 1-4 KVM guests (mostly Gentoo machines from A, plus some SuSE,=
 RedHat etc.)
  X00% CPU usage, where x corresponds to the smp X parameter, at startup as=
 well as if someone "touches" the VM, like logging in, doing a "ls". If the=
 machine is ABSOLUTELY IDLE, the process also exhibits 1-2% CPU load in hos=
t, but as soon as you do a simple ls, usage goes to - say - 400%, where it =
remains for some seconds, then slowly falls 280%, 120%, 60%, ... back to 1-=
2%
  qemu 1.0-r3

  =

  B is no go, C tries to well-behave but ultimatively fails, A is golden.

  There seems to be REAL high CPU usage and not only an error in
  displaying it. Other processes get less CPU power and exhibit
  definitely a slower runtime. On B, definitely one CPU core is hogged
  all the time

  =

  Some years ago we experienced something similar with ~2.6.26 and after a =
long and woeful period, we found out that compiling the host kernel as a ti=
ckless system caused the problem. Enabling high resolution timers made the =
problem go away and that is the situation on machine A until today. Since t=
hen no one dared to touch this production server. Unfortunately, this recip=
e didn't help with the other machines.

  I have scanned the net for similar problems and there are people
  complaining about high CPU usage. Unfortunately very often the devs or
  maintainers cannot reproduce it and the issue is dropped. Well - we
  cannot reproduce a "good behaviour"(tm) on any but one machine with
  any recent (read: post-2.6.35) linux kernel.

  Summary what we tried so far:

  * different linux kernels @ host, and @ guest

  -> no difference, especially there are guests @ A, that run newer
  kernels and there are Guests at B and C that run older kernels than is
  the host kernel

  * smp and non-smp, 32bit and 64bit guests

  -> 32/64bit in the guest makes no difference whatsoever. The smp just
  limits how much of the host CPU the guest hogs on non-well behaving
  systems (smp X -> X * 100%)

  * various linux guest OS, as well as FreeBSD

  -> no difference whatsoever

  * various options parameters in the host kernel (other schedulers,
  HRT, tickless,...)

  -> no difference whatsoever

  * various versions of qemu/kvm since 0.13

  -> no difference whatsoever

  * various qemu/kvm options, virtio and non-virtio configurations (most
  of the VMs @ A run blk-virtio but emulate an e1000)

  -> no difference whatsoever

  =

  You could say, we've reached wits' end. We could try 2.6.35 @ machine C w=
ith the same configuration from A (they are identical except CPU and RAM si=
ze, but same RAID, mainboard, etc. plus A once had also the 5148 Xeons and =
an upgrade luckily made no difference in good behaviour, so I would exclude=
 the CPU factor) but honestly that is not the way I'd like to go. The goal =
is to update A to something recent and not to loose it's VM-hosting well be=
haviour. Ideally to propagate this well beaviour to the other machines.

  =

  Arjan Minski
    PetaMem IT

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/950692/+subscriptions
