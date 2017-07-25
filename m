Received: from eggs.gnu.org ([2001:4830:134:3::10]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1da4SK-0003J1-3m
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1da4SG-0000Ae-TY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:21:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:55887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1da4SG-0000AN-Ku
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:21:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1da4SE-00085O-K0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:21:10 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A0AFF2E81A3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:21:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jul 2017 18:09:44 -0000
From: Eduardo Habkost <ehabkost@redhat.com>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <150100618457.6362.13816590532929024969.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1703506] Re: SMT not supported by QEMU on AMD
 Ryzen CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am looking at the diff between the host and guest CPUID, and we have a
few candidates: CPUID[4] is all zeroes on the host, and the host has
CPUID leaves up to 0x8000001f available, including CPUID[0x8000001d]
(which contains cache topology information).  Probably we need to
implement CPUID[0x8000001d], I will take a look at Linux code to find
out if that's all we need.

Full CPUID diff below:

--- /tmp/host-x86info.txt       2017-07-25 15:01:26.753304233 -0300
+++ /tmp/guest-x86info.txt      2017-07-25 15:01:33.563335744 -0300
@@ -1,29 +1,29 @@
 eax in: 0x00000000, eax =3D 0000000d ebx =3D 68747541 ecx =3D 444d4163 edx=
 =3D 69746e65
-eax in: 0x00000001, eax =3D 00800f11 ebx =3D 00100800 ecx =3D 7ed8320b edx=
 =3D 178bfbff
-eax in: 0x00000002, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
+eax in: 0x00000001, eax =3D 00800f11 ebx =3D 00080800 ecx =3D ffd83203 edx=
 =3D 178bfbff
+eax in: 0x00000002, eax =3D 00000001 ebx =3D 00000000 ecx =3D 0000004d edx=
 =3D 002c307d
 eax in: 0x00000003, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x00000004, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x00000005, eax =3D 00000040 ebx =3D 00000040 ecx =3D 00000003 edx=
 =3D 00000000
-eax in: 0x00000006, eax =3D 00000004 ebx =3D 00000000 ecx =3D 00000001 edx=
 =3D 00000000
-eax in: 0x00000007, eax =3D 00000000 ebx =3D 209c01a9 ecx =3D 00000000 edx=
 =3D 00000000
+eax in: 0x00000004, eax =3D 0c000121 ebx =3D 01c0003f ecx =3D 0000003f edx=
 =3D 00000001
+eax in: 0x00000005, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000003 edx=
 =3D 00000000
+eax in: 0x00000006, eax =3D 00000004 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
+eax in: 0x00000007, eax =3D 00000000 ebx =3D 209c01ab ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x00000008, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x00000009, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x0000000a, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x0000000b, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
+eax in: 0x0000000b, eax =3D 00000001 ebx =3D 00000002 ecx =3D 00000100 edx=
 =3D 00000000
 eax in: 0x0000000c, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x0000000d, eax =3D 00000007 ebx =3D 00000340 ecx =3D 00000340 edx=
 =3D 00000000
 =

-eax in: 0x80000000, eax =3D 8000001f ebx =3D 68747541 ecx =3D 444d4163 edx=
 =3D 69746e65
-eax in: 0x80000001, eax =3D 00800f11 ebx =3D 20000000 ecx =3D 35c233ff edx=
 =3D 2fd3fbff
+eax in: 0x80000000, eax =3D 8000001a ebx =3D 68747541 ecx =3D 444d4163 edx=
 =3D 69746e65
+eax in: 0x80000001, eax =3D 00800f11 ebx =3D 00000000 ecx =3D 000003f3 edx=
 =3D 2fd3fbff
 eax in: 0x80000002, eax =3D 20444d41 ebx =3D 657a7952 ecx =3D 2037206e edx=
 =3D 30303731
 eax in: 0x80000003, eax =3D 67694520 ebx =3D 432d7468 ecx =3D 2065726f edx=
 =3D 636f7250
 eax in: 0x80000004, eax =3D 6f737365 ebx =3D 20202072 ecx =3D 20202020 edx=
 =3D 00202020
-eax in: 0x80000005, eax =3D ff40ff40 ebx =3D ff40ff40 ecx =3D 20080140 edx=
 =3D 40040140
-eax in: 0x80000006, eax =3D 26006400 ebx =3D 66006400 ecx =3D 02006140 edx=
 =3D 00808140
-eax in: 0x80000007, eax =3D 00000000 ebx =3D 0000001b ecx =3D 00000000 edx=
 =3D 00006599
-eax in: 0x80000008, eax =3D 00003030 ebx =3D 00000007 ecx =3D 0000400f edx=
 =3D 00000000
+eax in: 0x80000005, eax =3D 01ff01ff ebx =3D 01ff01ff ecx =3D 40020140 edx=
 =3D 40020140
+eax in: 0x80000006, eax =3D 00000000 ebx =3D 42004200 ecx =3D 02008140 edx=
 =3D 00808140
+eax in: 0x80000007, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
+eax in: 0x80000008, eax =3D 00003028 ebx =3D 00000000 ecx =3D 00000007 edx=
 =3D 00000000
 eax in: 0x80000009, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x8000000a, eax =3D 00000001 ebx =3D 00008000 ecx =3D 00000000 edx=
 =3D 0001bcff
+eax in: 0x8000000a, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x8000000b, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x8000000c, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x8000000d, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
@@ -38,10 +38,5 @@
 eax in: 0x80000016, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x80000017, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
 eax in: 0x80000018, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x80000019, eax =3D f040f040 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x8000001a, eax =3D 00000003 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x8000001b, eax =3D 000003ff ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x8000001c, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x8000001d, eax =3D 00004121 ebx =3D 01c0003f ecx =3D 0000003f edx=
 =3D 00000000
-eax in: 0x8000001e, eax =3D 00000000 ebx =3D 00000100 ecx =3D 00000000 edx=
 =3D 00000000
-eax in: 0x8000001f, eax =3D 00000007 ebx =3D 0000016f ecx =3D 0000000f edx=
 =3D 00000000
+eax in: 0x80000019, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000
+eax in: 0x8000001a, eax =3D 00000000 ebx =3D 00000000 ecx =3D 00000000 edx=
 =3D 00000000

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1703506

Title:
  SMT not supported by QEMU on AMD Ryzen CPU

Status in QEMU:
  New

Bug description:
  HyperThreading/SMT is supported by AMD Ryzen CPUs but results in this
  message when setting the topology to threads=3D2:

  qemu-system-x86_64: AMD CPU doesn't support hyperthreading. Please
  configure -smp options properly.

  Checking in a Windows 10 guest reveals that SMT is not enabled, and
  from what I understand, QEMU converts the topology from threads to
  cores internally on AMD CPUs. This appears to cause performance
  problems in the guest perhaps because programs are assuming that these
  threads are actual cores.

  Software: Linux 4.12, qemu 2.9.0 host with KVM enabled, Windows 10 pro
  guest

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1703506/+subscriptions
