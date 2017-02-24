Received: from eggs.gnu.org ([2001:4830:134:3::10]:34667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chGL7-0007MJ-Qf
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1chGL2-0005mt-Td
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:55:17 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1chGL2-0005mZ-JP
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:55:12 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so15123749wmd.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 05:55:12 -0800 (PST)
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-MMw0_ombzTD+kQYpeNKywtcKY2UczcpR-hFDwGZhZJw@mail.gmail.com>
Date: Fri, 24 Feb 2017 13:55:08 +0000
Message-ID: <87wpcflmmb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/13] Rewrite NVIC to not
 depend on the GIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 16 February 2017 at 16:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This patchset is the revamp of the NVIC code from Michael
>> Davidsaver's patchset of a year ago.
>>
>> Despite some superficial similarities of register layout, the
>> M-profile NVIC is really very different from the A-profile GIC.  Our
>> current attempt to reuse the GIC code means that we have significant
>> bugs in our NVIC.  The series pulls the NVIC apart from the GIC code
>> (fixing a few accidental bugs in the process), and then once it has a
>> place to stand, implements a few minor cleanups, a key bugfix
>> (getting priority calculations and masking right) and a missing
>> feature (escalation to HardFault).
>>
>> For testing, I have used the Stellaris image I have to hand:
>> http://people.linaro.org/~peter.maydell/stellaris.tgz
>> and also a set of bare-metal test programs also written by
>> Michael. You can find my slightly tweaked and cleand up
>> version of those here (a README explains how to run them):
>> https://git.linaro.org/people/peter.maydell/m-profile-tests.git
>
> PS: git branch of this v2 patchset at
> https://git.linaro.org/people/peter.maydell/qemu-arm.git nvic-rewrite
> (includes squashed-in fix to patch 3).

Even this branch is failing the tests for me:

QEMU emulator version 2.8.50 (v2.8.0-1289-g63d3eb3ef5-dirty)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers
make: Nothing to be done for 'all'.
=============== Testing test1-kern.bin ===============
1..2
# Starting
# 12345678
# 23456789
# 6789
# 600789
ok 1 - 00000000 == 00000000 var1
ok 2 - 87654321 == 87654321 var2
Ran    2/2
Passed 2/2
Fail   0/2
=============== Testing test9-kern.bin ===============
NVIC: Bad read offset 0xd90
NVIC: Bad read offset 0xd94
1..19
ok 1 - deadbeaf == deadbeaf marker
ok 2 - ffffffff == ffffffff LR
# XPSR 40000000
ok 3 - 00000000 == 00000000 PRIMASK
ok 4 - 00000000 == 00000000 FAULTMASK
ok 5 - 00000000 == 00000000 BASEPRI
ok 6 - 00000000 == 00000000 CONTROL
ok 7 - 20000460 == 20000460 MSP
ok 8 - 00000000 == 00000000 PSP
# cpuid 410fc231
not ok 9 - 00000000 == 00000800 icsr
ok 10 - 00000000 == 00000000 vtor
ok 11 - fa050000 == fa050000 aircr
ok 12 - 00000000 == 00000000 scr
ok 13 - 00000200 == 00000200 ccr
ok 14 - 00000000 == 00000000 shpr[0]
ok 15 - 00000000 == 00000000 shpr[1]
ok 16 - 00000000 == 00000000 shpr[2]
ok 17 - 00000000 == 00000000 shcsr
ok 18 - 00000000 == 00000000 syst_csr
# ictr 00000001
# mpu_type 00000000
ok 19 - 00000000 == 00000000 mpu_ctrl
Ran    19/19
Passed 18/19
Fail   1/19
=============== Testing test10-kern.bin ===============
1..10
# BASEPRI mask 000000ff
# DEBUG prio 000000ff
not ok 1 - 00000000 == 00000800 ICSR
ok 2 - 00000000 == 00000000 SHCSR
# Call SVC
# In SVC
ok 3 - 0000080b == 0000080b ICSR
ok 4 - 00000080 == 00000080 SHCSR
# In PendSV
ok 5 - 0000000e == 0000000e ICSR
ok 6 - 00000480 == 00000480 SHCSR
# Back in SVC
ok 7 - 00000003 == 00000003 Back in SVC
# Back in main
ok 8 - 00000004 == 00000004 Back in SVC
not ok 9 - 00000000 == 00000800 ICSR
ok 10 - 00000000 == 00000000 SHCSR
# Done
Ran    10/10
Passed 8/10
Fail   2/10
=============== Testing test4-kern.bin ===============
1..33
ok 1 - 00000005 == 00000005 PRIGROUP
# Enable IRQ0/1
ok 2 - 00000003 == 00000003 ENA
ok 3 - 00000000 == 00000000 PEND
ok 4 - 00000000 == 00000000 ACT
not ok 5 - 00000000 == 00000800 ICSR
# Pend IRQ0 (shouldn't run)
ok 6 - 00000003 == 00000003 ENA
ok 7 - 00000001 == 00000001 PEND
ok 8 - 00000000 == 00000000 ACT
not ok 9 - 00410000 == 00410800 ICSR
ok 10 - 00000001 == 00000001 SEQ 1
# Unmask (should run now)
# in IRQ0 SEQ 2
ok 11 - 00000003 == 00000003 ENA
ok 12 - 00000000 == 00000000 PEND
ok 13 - 00000001 == 00000001 ACT
ok 14 - 00000810 == 00000810 ICSR
# Back in main
ok 15 - 00000003 == 00000003 ENA
ok 16 - 00000000 == 00000000 PEND
ok 17 - 00000000 == 00000000 ACT
ok 18 - 00000003 == 00000003 SEQ 3
# Give IRQ1 priority over IRQ0
# Pend IRQ0 and IRQ1 (should run now)
# in IRQ1 SEQ 4
ok 19 - 00000003 == 00000003 ENA
ok 20 - 00000001 == 00000001 PEND
ok 21 - 00000002 == 00000002 ACT
ok 22 - 00410811 == 00410811 ICSR
# in IRQ0 SEQ 5
ok 23 - 00000003 == 00000003 ENA
ok 24 - 00000000 == 00000000 PEND
ok 25 - 00000001 == 00000001 ACT
ok 26 - 00000810 == 00000810 ICSR
# Back in main
ok 27 - 00000006 == 00000006 SEQ 6
# Pend IRQ0 (should run now)
# in IRQ0 SEQ 7
# pend IRQ1
# in IRQ1 SEQ 8
# back in IRQ0
ok 28 - 00000009 == 00000009 SEQ 9
# Back in main
ok 29 - 0000000a == 0000000a SEQ 10
# Pend IRQ1 (should run now)
# in IRQ1 SEQ 11
# pend IRQ0
# still in IRQ1
ok 30 - 0000000c == 0000000c SEQ 12
# in IRQ0 SEQ 13
# Back in main
ok 31 - 0000000e == 0000000e SEQ 14
# equal prio, IRQ1 has lower sub-group
# Pend IRQ0 and IRQ1 (should run now)
# in IRQ1 SEQ 15
# in IRQ0 SEQ 16
# Back in main
ok 32 - 00000011 == 00000011 SEQ 17
# Pend IRQ0 (should run now) and IRQ1
# in IRQ0 SEQ 18
# in IRQ1 SEQ 19
# Back in main
ok 33 - 00000014 == 00000014 SEQ 20
# Done
Ran    33/33
Passed 31/33
Fail   2/33
=============== Testing test5-kern.bin ===============
1..45
# MSP=20000440 PSP=20000840
# SP 20000400
ok 1 - 00000000 == 00000000 CONTROL
ok 2 - 00000000 == 00000000 IPSR
ok 3 - stack0, avect=00000000 instack=00000000 actrl=00000000
# Start, trigger SVC
# in SVC SEQ 1
# SP 200003e0
ok 4 - 00000000 == 00000000 CONTROL
ok 5 - 0000000b == 0000000b IPSR
ok 6 - stack0, avect=0000000b instack=00000000 actrl=00000000
# Back in main
ok 7 - 00000002 == 00000002 SEQ 2
# SP 20000400
ok 8 - 00000000 == 00000000 CONTROL
ok 9 - 00000000 == 00000000 IPSR
ok 10 - stack0, avect=00000000 instack=00000000 actrl=00000000
# Priv w/ proc stack
# SP 20000818
ok 11 - 00000002 == 00000002 CONTROL
ok 12 - 00000000 == 00000000 IPSR
ok 13 - stack2, avect=00000000 instack=00000002 actrl=00000002
# trigger SVC
# in SVC SEQ 3
# SP 20000400
ok 14 - 00000000 == 00000000 CONTROL
ok 15 - 0000000b == 0000000b IPSR
ok 16 - stack0, avect=0000000b instack=00000000 actrl=00000000
# Back in main
ok 17 - 00000004 == 00000004 SEQ 4
# SP 20000818
ok 18 - 00000002 == 00000002 CONTROL
ok 19 - 00000000 == 00000000 IPSR
ok 20 - stack2, avect=00000000 instack=00000002 actrl=00000002
# Drop privlage
# SP 20000818
ok 21 - 00000003 == 00000003 CONTROL
ok 22 - 00000000 == 00000000 IPSR
ok 23 - stack2, avect=00000000 instack=00000002 actrl=00000003
# trigger SVC
# in SVC SEQ 5
# SP 20000400
ok 24 - 00000001 == 00000001 CONTROL
ok 25 - 0000000b == 0000000b IPSR
ok 26 - stack0, avect=0000000b instack=00000000 actrl=00000001
# Back in main
ok 27 - 00000006 == 00000006 SEQ 6
# SP 20000818
ok 28 - 00000003 == 00000003 CONTROL
ok 29 - 00000000 == 00000000 IPSR
ok 30 - stack2, avect=00000000 instack=00000002 actrl=00000003
# Try to restore privlage and switch stack (should be noop)
# SP 20000818
ok 31 - 00000003 == 00000003 CONTROL
ok 32 - 00000000 == 00000000 IPSR
ok 33 - stack2, avect=00000000 instack=00000002 actrl=00000003
# Try to set masks
ok 34 - 00000000 == 00000000 masks
# trigger SVC
# in SVC SEQ 7
ok 35 - 00000000 == 00000000 masks
ok 36 - 00000001 == 00000001 masks
# Back in main
ok 37 - 00000008 == 00000008 SEQ 8
ok 38 - 00000000 == 00000000 masks
# trigger HardFault (restores priv)
# HARDFAULT 9
# Set CONTROL=0
# Back in main
ok 39 - 0000000a == 0000000a SEQ 10
# SP 20000818
ok 40 - 00000002 == 00000002 CONTROL
ok 41 - 00000000 == 00000000 IPSR
ok 42 - stack2, avect=00000000 instack=00000002 actrl=00000002
# restore MSP
# SP 20000400
ok 43 - 00000000 == 00000000 CONTROL
ok 44 - 00000000 == 00000000 IPSR
ok 45 - stack0, avect=00000000 instack=00000000 actrl=00000000
# Done.
Ran    45/45
Passed 45/45
Fail   0/45
=============== Testing test13-kern.bin ===============
1..4
# Tests of USAGEFAULTs

# 1 USAGEFAULT for a random undefined insn should be UNDEFINSTR
# Fault: 00000003 (Usage) FSR: 00010000 (UNDEFINSTR)
ok 1 - 00000003 == 00000003 fault type
ok 2 - 00010000 == 00010000 FSR
# 2 USAGEFAULT for a cp insn should be NOCP
# Fault: 00000003 (Usage) FSR: 00080000 (NOCP)
ok 3 - 00000003 == 00000003 fault type
ok 4 - 00080000 == 00080000 FSR
# Done.
Ran    4/4
Passed 4/4
Fail   0/4


--
Alex Bennée
