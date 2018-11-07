Received: from eggs.gnu.org ([2001:4830:134:3::10]:46815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKRfM-0001Fh-Ic
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gKRfJ-0004wl-1Y
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:30:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:33386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gKRfI-0004vM-O5
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:30:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gKRfH-0007WY-5n
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 17:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E9DE52E80CC
	for <qemu-devel@nongnu.org>; Wed,  7 Nov 2018 17:30:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Nov 2018 17:15:40 -0000
From: Nathan Wallace <1758819@bugs.launchpad.net>
Reply-To: Bug 1758819 <1758819@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152204272199.688.3778854075369133494.malonedeb@wampee.canonical.com>
Message-Id: <154161094050.29232.7509981504999944905.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1758819] Re: HVF Illegal instruction: 4,
 High Sierra, v2.12-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am also able to reproduce this bug. The problem is that when hvf is
enabled, qemu will attempt to execute the xgetbv instruction, which
isn't supported on my processor (Intel Xeon X5670).

Here is a stack trace from lldb; the behavior is 100% reproducible for
me.

nathan@Nathans-Mac-Pro:~/src/qemu/qemu-3.0.0/x86_64-softmmu
$ lldb -- qemu-system-x86_64 --accel hvf
(lldb) target create "qemu-system-x86_64"
runCurrent executable set to 'qemu-system-x86_64' (x86_64).
(lldb) settings set -- target.run-args  "--accel" "hvf"
(lldb) run
Process 27479 launched: '/Users/nathan/src/qemu/qemu-3.0.0/x86_64-softmmu/q=
emu-system-x86_64' (x86_64)
Process 27479 stopped
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D EXC_BAD_INS=
TRUCTION (code=3DEXC_I386_INVOP, subcode=3D0x0)
    frame #0: 0x00000001001bca3a qemu-system-x86_64`xgetbv(xcr=3D0) at x86_=
cpuid.c:34
   31  	{
   32  	    uint32_t eax, edx;
   33
-> 34  	    __asm__ volatile ("xgetbv"
   35  	                      : "=3Da" (eax), "=3Dd" (edx)
   36  	                      : "c" (xcr));
   37
Target 0: (qemu-system-x86_64) stopped.
(lldb) bt
* thread #1, queue =3D 'com.apple.main-thread', stop reason =3D EXC_BAD_INS=
TRUCTION (code=3DEXC_I386_INVOP, subcode=3D0x0)
  * frame #0: 0x00000001001bca3a qemu-system-x86_64`xgetbv(xcr=3D0) at x86_=
cpuid.c:34
    frame #1: 0x00000001001bc8a6 qemu-system-x86_64`hvf_get_supported_cpuid=
(func=3D13, idx=3D0, reg=3D0) at x86_cpuid.c:116
    frame #2: 0x0000000100143a21 qemu-system-x86_64`x86_cpu_get_supported_f=
eature_word(w=3DFEAT_XSAVE_COMP_LO, migratable_only=3Dfalse) at cpu.c:3498
    frame #3: 0x000000010014367d qemu-system-x86_64`x86_cpu_filter_features=
(cpu=3D0x00000001040a2c00) at cpu.c:4749
    frame #4: 0x0000000100146c65 qemu-system-x86_64`x86_cpu_realizefn(dev=
=3D0x00000001040a2c00, errp=3D0x00007ffeefbfd620) at cpu.c:4834
    frame #5: 0x000000010028a84b qemu-system-x86_64`device_set_realized(obj=
=3D0x00000001040a2c00, value=3Dtrue, errp=3D0x00007ffeefbfd7d0) at qdev.c:8=
26
    frame #6: 0x00000001004b6d4d qemu-system-x86_64`property_set_bool(obj=
=3D0x00000001040a2c00, v=3D0x0000000101c49a20, name=3D"realized", opaque=3D=
0x0000000101a996d0, errp=3D0x00007ffeefbfd7d0) at object.c:1984
    frame #7: 0x00000001004b4ae8 qemu-system-x86_64`object_property_set(obj=
=3D0x00000001040a2c00, v=3D0x0000000101c49a20, name=3D"realized", errp=3D0x=
00007ffeefbfd7d0) at object.c:1176
    frame #8: 0x00000001004b8e8a qemu-system-x86_64`object_property_set_qob=
ject(obj=3D0x00000001040a2c00, value=3D0x0000000101c49a00, name=3D"realized=
", errp=3D0x00007ffeefbfd7d0) at qom-qobject.c:27
    frame #9: 0x00000001004b5092 qemu-system-x86_64`object_property_set_boo=
l(obj=3D0x00000001040a2c00, value=3Dtrue, name=3D"realized", errp=3D0x00007=
ffeefbfd7d0) at object.c:1242
    frame #10: 0x000000010010ae20 qemu-system-x86_64`pc_new_cpu(typename=3D=
"qemu64-x86_64-cpu", apic_id=3D0, errp=3D0x0000000100c44de0) at pc.c:1107
    frame #11: 0x000000010010af4c qemu-system-x86_64`pc_cpus_init(pcms=3D0x=
0000000101d630b0) at pc.c:1155
    frame #12: 0x000000010011294e qemu-system-x86_64`pc_init1(machine=3D0x0=
000000101d630b0, host_type=3D"i440FX-pcihost", pci_type=3D"i440FX") at pc_p=
iix.c:153
    frame #13: 0x0000000100112640 qemu-system-x86_64`pc_init_v3_0(machine=
=3D0x0000000101d630b0) at pc_piix.c:438
    frame #14: 0x0000000100291f25 qemu-system-x86_64`machine_run_board_init=
(machine=3D0x0000000101d630b0) at machine.c:830
    frame #15: 0x00000001001e583f qemu-system-x86_64`qemu_main(argc=3D3, ar=
gv=3D0x00007ffeefbff818, envp=3D0x00007ffeefbff838) at vl.c:4516
    frame #16: 0x0000000100486459 qemu-system-x86_64`-[QemuCocoaAppControll=
er startEmulationWithArgc:argv:](self=3D0x0000000101c16510, _cmd=3D"startEm=
ulationWithArgc:argv:", argc=3D3, argv=3D0x00007ffeefbff818) at cocoa.m:1093
    frame #17: 0x00000001004862f7 qemu-system-x86_64`-[QemuCocoaAppControll=
er applicationDidFinishLaunching:](self=3D0x0000000101c16510, _cmd=3D"appli=
cationDidFinishLaunching:", note=3D@"NSApplicationDidFinishLaunchingNotific=
ation") at cocoa.m:1045
    frame #18: 0x00007fff4c99447c CoreFoundation`__CFNOTIFICATIONCENTER_IS_=
CALLING_OUT_TO_AN_OBSERVER__ + 12
    frame #19: 0x00007fff4c99434a CoreFoundation`_CFXRegistrationPost + 458
    frame #20: 0x00007fff4c994081 CoreFoundation`___CFXNotificationPost_blo=
ck_invoke + 225
    frame #21: 0x00007fff4c952c12 CoreFoundation`-[_CFXNotificationRegistra=
r find:object:observer:enumerator:] + 1826
    frame #22: 0x00007fff4c951ca3 CoreFoundation`_CFXNotificationPost + 659
    frame #23: 0x00007fff4ea7c817 Foundation`-[NSNotificationCenter postNot=
ificationName:object:userInfo:] + 66
    frame #24: 0x00007fff4a041206 AppKit`-[NSApplication _postDidFinishNoti=
fication] + 313
    frame #25: 0x00007fff4a040e4f AppKit`-[NSApplication _sendFinishLaunchi=
ngNotification] + 220
    frame #26: 0x00007fff49f13ab3 AppKit`-[NSApplication(NSAppleEventHandli=
ng) _handleAEOpenEvent:] + 562
    frame #27: 0x00007fff49f136e9 AppKit`-[NSApplication(NSAppleEventHandli=
ng) _handleCoreEvent:withReplyEvent:] + 690
    frame #28: 0x00007fff4eabf664 Foundation`-[NSAppleEventManager dispatch=
RawAppleEvent:withRawReply:handlerRefCon:] + 287
    frame #29: 0x00007fff4eabf4e2 Foundation`_NSAppleEventManagerGenericHan=
dler + 102
    frame #30: 0x00007fff4da97dd0 AE`aeDispatchAppleEvent(AEDesc const*, AE=
Desc*, unsigned int, unsigned char*) + 1788
    frame #31: 0x00007fff4da97677 AE`dispatchEventAndSendReply(AEDesc const=
*, AEDesc*) + 41
    frame #32: 0x00007fff4da97565 AE`aeProcessAppleEvent + 383
    frame #33: 0x00007fff4bc6e4a0 HIToolbox`AEProcessAppleEvent + 55
    frame #34: 0x00007fff49f0ed32 AppKit`_DPSNextEvent + 2788
    frame #35: 0x00007fff4a6a4e34 AppKit`-[NSApplication(NSEvent) _nextEven=
tMatchingEventMask:untilDate:inMode:dequeue:] + 3044
    frame #36: 0x00007fff49f03885 AppKit`-[NSApplication run] + 764
    frame #37: 0x0000000100489161 qemu-system-x86_64`main(argc=3D3, argv=3D=
0x00007ffeefbff818) at cocoa.m:1537
    frame #38: 0x00007fff7493e015 libdyld.dylib`start + 1
    frame #39: 0x00007fff7493e015 libdyld.dylib`start + 1
(lldb) p xcr
(uint32_t) $0 =3D 0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1758819

Title:
  HVF Illegal instruction: 4, High Sierra, v2.12-rc0

Status in QEMU:
  New

Bug description:
  I've built v2.12.0-rc0 on MacOS using homebrew. I'm running 10.13.3 on
  a 5,1 Mac Pro with a X5690 processor.

  When I run 'qemu-system-x86_64 -M accel=3Dhvf', I get a crash "Illegal
  instruction: 4".

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1758819/+subscriptions
