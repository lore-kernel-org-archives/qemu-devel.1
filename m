Received: from eggs.gnu.org ([2001:4830:134:3::10]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXSuq-0001lj-Ly
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXSum-0004j2-Lv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:28:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXSum-0004iO-EE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:28:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so2004187wrt.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 07:28:40 -0800 (PST)
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115745.ronekr5cz67nap4b@lakrids.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181213115745.ronekr5cz67nap4b@lakrids.cambridge.arm.com>
Date: Thu, 13 Dec 2018 15:28:37 +0000
Message-ID: <87lg4t1m56.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Fix kvm guest debugging of AA32
 guests on AA64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Rutland <mark.rutland@arm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, ard.biesheuvel@linaro.org, marc.zyngier@arm.com


Mark Rutland <mark.rutland@arm.com> writes:

> Hi Alex,
>
> On Thu, Dec 13, 2018 at 11:55:01AM +0000, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> This is an attempt to fix debugging of AArch32 binaries when running
>> under KVM on AArch64 hardware. There are two parts to this, the first is
>> a handling the possibility of AArch32 software breakpoints with a
>> heuristic based on the current execution mode. The second part is
>> delaying the setup of aarch64 debugging until the shared arm_cpu_realize
>> function is run by which point we have parsed and decoded the actual
>> execution mode of the guest. This doesn't solve the problem of split
>> mode guests which switch between an AA64 EL1 and an AA32 EL0 though.
>>
>> I still ran into a problem with single-step. Even with Mark's
>> single-step fixup series:
>>
>>   To: linux-arm-kernel@lists.infradead.org
>>   Cc: kvmarm@lists.cs.columbia.edu,
>>   Subject: [PATCH 0/2] kvm/arm: make singlestep behaviour consistent
>>   Date: Fri, 9 Nov 2018 15:07:09 +0000
>>   Message-Id: <20181109150711.45864-1-mark.rutland@arm.com>
>>
>> some instructions do single-step but sometimes the single-step doesn't
>> return leading to a runaway until it hits a breakpoint. I'm not sure why
>> this is the case because the SS state machine shouldn't be instruction
>> sensitive.
>
> Could you please give an example sequence where this occurs? I'd be
> happy to take a look.

Here is a trace in gdb:

=3D> 0x0: b       0x1000
   0x4:                 ; <UNDEFINED> instruction: 0xffffffff
   0x8:                 ; <UNDEFINED> instruction: 0xffffffff
   0xc:                 ; <UNDEFINED> instruction: 0xffffffff
   0x10:                        ; <UNDEFINED> instruction: 0xffffffff
   0x1000:      bl      0x372c
   0x1004:      andeq   r12, r0, r1, asr r12
   0x1008:      rors    pc, lr, r0      ; <UNPREDICTABLE>
   0x100c:      andeq   r0, r0, r0
   0x1010:      cfstr32hi       mvfx14, [r12], {120}    ; 0x78
   0x372c:      bl      0x39d4
   0x3730:      bl      0x39cc
   0x3734:      mov     r5, r0
   0x3738:      bl      0x39e8
   0x373c:      movw    r1, #0
   0x39d4:      bx      lr
   0x39d8:      and     r1, r0, #255    ; 0xff
   0x39dc:      and     r0, r0, #65280  ; 0xff00
   0x39e0:      add     r0, r1, r0, lsr #7
   0x39e4:      bx      lr
Hardware assisted breakpoint 1 at 0x39d4
0x00001000 in ?? ()
=3D> 0x1000:      bl      0x372c
   0x1004:      andeq   r12, r0, r1, asr r12
   0x1008:      rors    pc, lr, r0      ; <UNPREDICTABLE>

Thread 1 hit Breakpoint 1, 0x000039d4 in ?? ()
=3D> 0x39d4:      bx      lr
   0x39d8:      and     r1, r0, #255    ; 0xff
   0x39dc:      and     r0, r0, #65280  ; 0xff00
0x1000: 0xeb0009c9      0x0000cc51

The second instruction (bl 0x372c) didn't single-step and we eventually
hit the hbreak I set at 0x39d4.

This is from ard's QEMU_EFI.fd build:

 http://snapshots.linaro.org/components/kernel/leg-virt-tianocore-edk2-upst=
ream/3373/QEMU-ARM/DEBUG_GCC5/QEMU_EFI.img.gz

Running with:

 ./aarch64-softmmu/qemu-system-aarch64 -M virt -cpu host,aarch64=3Doff -ena=
ble-kvm -net none -nographic -bios ~/QEMU_EFI_aarch32.img -smp 2 -s -S

And:

 gdb -ex "target remote localhost:1234"

>
> Thanks,
> Mark.


--
Alex Benn=C3=A9e
