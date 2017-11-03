Received: from eggs.gnu.org ([2001:4830:134:3::10]:56843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAa5s-0006k2-CV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eAa5p-0007FF-8a
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:25:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eAa5p-0007DX-22
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:24:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eAa5n-000829-7z
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 11:24:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 31DAB2E80CC
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 11:24:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Nov 2017 11:11:03 -0000
From: Thomas Huth <1086782@bugs.launchpad.net>
Reply-To: Bug 1086782 <1086782@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20121205125603.6348.62070.malonedeb@gac.canonical.com>
Message-Id: <150970746321.4047.11021785829317668336.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1086782] Re: HPET time drift windows 7 64bits
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1086782

Title:
  HPET time drift windows 7 64bits guest

Status in QEMU:
  Incomplete

Bug description:
  Using latest qemu-kvm (1.2.0), time drift (clock slow in guest) in Window=
s 7 64 bits guest when HPET is enabled (default).
  Disabling HPET (-no-hpet) solves the time drift.

  UsePlatformClock enable/disable doesn't make a difference in the guest.
  bcdedit /set useplatformclock true

  Using driftfix slew doesn't make a difference too.

  =

  # qemu-system-x86_64 --version
  QEMU emulator version 1.2.0 (qemu-kvm-1.2.0), Copyright (c) 2003-2008 Fab=
rice Bellard

  Kernel is 3.6.8:
  # uname -a
  Linux pulsar 3.6.8 #1 SMP Sat Dec 1 16:26:10 CET 2012 x86_64 x86_64 x86_6=
4 GNU/Linux

  TSC is stable in the host:
  =3D=3D=3D
  # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
  tsc

  Dmesg:
  [    0.000000] hpet clockevent registered
  [    0.000000] tsc: Fast TSC calibration using PIT
  [    0.000000] tsc: Detected 2660.096 MHz processor
  [    0.001002] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 5320.19 BogoMIPS (lpj=3D2660096)
  [    0.001138] pid_max: default: 32768 minimum: 301
  ...
  [    1.492019] tsc: Refined TSC clocksource calibration: 2659.973 MHz
  [    1.492093] Switching to clocksource tsc

  =

  CPUinfo, constant_tsc:
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 23
  model name      : Intel(R) Core(TM)2 Quad CPU    Q8400  @ 2.66GHz
  stepping        : 10
  microcode       : 0xa0b
  cpu MHz         : 2667.000
  cache size      : 2048 KB
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx=
 lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 =
monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave lahf_lm dtherm=
 tpr_shadow vnmi flexpriority
  bogomips        : 5320.19

  # grep -i hpet .config
  CONFIG_HPET_TIMER=3Dy
  CONFIG_HPET_EMULATE_RTC=3Dy
  CONFIG_HPET=3Dy
  # CONFIG_HPET_MMAP is not set
  =3D=3D=3D

  Qemu command line:
  /usr/bin/qemu-system-x86_64 -drive file=3D/dev/vol0/KVMORION01,cache=3Dno=
ne,aio=3Dnative,if=3Dvirtio \
    -drive file=3D/dev/vol0/KVMORION02,cache=3Dnone,aio=3Dnative,if=3Dvirti=
o \
    -cpu host \
    -m 2048 \
    -smp 4,maxcpus=3D4,cores=3D4,threads=3D1,sockets=3D1 \
    -rtc base=3Dlocaltime,driftfix=3Dslew \
    -vnc 10.124.241.211:0,password -k es \
    -monitor telnet:localhost:37200,server,nowait \
    -netdev tap,id=3Dkvmorion,ifname=3Dkvmorion,script=3D/etc/qemu-ifup-br0=
,downscript=3D/etc/qemu-ifdown-br0 \
    -device virtio-net-pci,netdev=3Dkvmorion,id=3Dvirtio-nic0,mac=3D02:85:6=
4:02:c2:aa \
    -device virtio-balloon-pci,id=3Dballoon0 \
    -boot menu=3Don \
    -pidfile /var/run/kvmorion.pid \
    -daemonize

  Using 1 CPU doesn't make a difference.
  Only workaround is disabling hpet (-no-hpet)

  Sample time drift in guest:
  >ntpdate -q 10.124.241.211
   5 Dec 13:36:06 ntpdate[3464]: Raised to realtime priority class
  server 10.124.241.211, stratum 2, offset 3.694184, delay 0.02551
   5 Dec 13:36:12 ntpdate[3464]: step time server 10.124.241.211 offset 3.6=
94184 s
  ec

  >ntpdate -q 10.124.241.211
   5 Dec 13:52:02 ntpdate[1964]: Raised to realtime priority class
  server 10.124.241.211, stratum 2, offset 4.719968, delay 0.02554
   5 Dec 13:52:08 ntpdate[1964]: step time server 10.124.241.211 offset 4.7=
19968 s
  ec

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1086782/+subscriptions
