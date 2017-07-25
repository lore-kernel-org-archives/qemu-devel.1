Received: from eggs.gnu.org ([2001:4830:134:3::10]:41494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1da4vM-0006xq-B5
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1da4vJ-0003DN-4R
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:51:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:58983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1da4vI-0003CO-UT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 14:51:13 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1da4vG-0000fe-TO
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:51:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 36E512E80D7
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 18:51:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Jul 2017 18:38:53 -0000
From: Eduardo Habkost <ehabkost@redhat.com>
Reply-To: Bug 1703506 <1703506@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149974876377.6612.10329067332937096720.malonedeb@gac.canonical.com>
Message-Id: <150100793322.24380.3169902382542114871.malone@soybean.canonical.com>
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

The core topology info used by Linux (see
linux/arch/x86/kernel/cpu/amd.c:amd_get_topology()) is actually at
CPUID[0x8000001e].

AMD's documentation is a bit confusing, as the Architecture Programmer's
Manual still refers to CPUID[0x8000001e].EBX[bits 7:0] as "compute unit
ID", but the Processor Programming Reference for AMD Family 17h
documents the same bits as "Core ID".  We can implement
CPUID[0x8000001e] and print the existing warning only if CPU vendor is
AMD and cpuid_family !=3D 0x17.

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
