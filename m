Received: from eggs.gnu.org ([2001:4830:134:3::10]:57272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQF-0001L7-HD
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQC-00071y-W8
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:52120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqQC-0006zJ-L4
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqQB-0006cd-Vn
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E81192E851B
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:29:03 -0000
From: Thomas Huth <1768295@bugs.launchpad.net>
Reply-To: Bug 1768295 <1768295@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152519164359.6413.12582240325876567028.malonedeb@chaenomeles.canonical.com>
Message-Id: <153431814535.24250.15157935534231234779.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1768295] Re: VLLDM/VLSTM trigger UsageFault in
 the Secure Mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768295

Title:
  VLLDM/VLSTM trigger UsageFault in the Secure Mode

Status in QEMU:
  Fix Released

Bug description:
  The VLLDM/VLSTM instructions trigger UsageFault when they are supposed
  to behave as NOP.

  Version: =

  $ qemu-system-arm --version                                              =
                                 QEMU emulator version 2.11.93

  VLLDM and VLSTM are instructions newly added to ARMv8-M Mainline
  Profile. Although they are FP instructions and the FP support of the M
  profile is not implemented by QEMU, the Armv8-M Architecture Reference
  Manual specifies that they should behave as NOP even in this case:

  C2.4.268 VLLDM:

  > If the Floating-point Extension is not implemented, this instruction
  is available in Secure state, but behaves as a NOP.

  C2.4.269 VLSTM:

  > If the Floating-point Extension is not implemented, this instruction
  is available in Secure state, but behaves as a NOP.

  VLLDM and VLSTM are generated automatically by the compiler to save
  and restore the floating point registers (in a lazy manner) during a
  Non-Secure function call. An example is shown below:

  10000064 <__gnu_cmse_nonsecure_call>:
  10000064:       e92d 4fe0       stmdb   sp!, {r5, r6, r7, r8, r9, sl, fp,=
 lr}
  10000068:       4627            mov     r7, r4
  1000006a:       46a0            mov     r8, r4
  1000006c:       46a1            mov     r9, r4
  1000006e:       46a2            mov     sl, r4
  10000070:       46a3            mov     fp, r4
  10000072:       46a4            mov     ip, r4
  10000074:       b0a2            sub     sp, #136        ; 0x88
  10000076:       ec2d 0a00       vlstm   sp
  1000007a:       f384 8800       msr     CPSR_f, r4
  1000007e:       4625            mov     r5, r4
  10000080:       4626            mov     r6, r4
  10000082:       47a4            blxns   r4
  10000084:       ec3d 0a00       vlldm   sp
  10000088:       b022            add     sp, #136        ; 0x88
  1000008a:       e8bd 8fe0       ldmia.w sp!, {r5, r6, r7, r8, r9, sl, fp,=
 pc}

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1768295/+subscriptions
