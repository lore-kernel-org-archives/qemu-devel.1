Received: from eggs.gnu.org ([2001:4830:134:3::10]:41292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGlKn-00035S-Bi
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cGlKj-0003LG-BX
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:33:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cGlKj-0003Kn-5k
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:33:21 -0500
References: <94eb2c0bfa1c6a9fec0543057483@google.com>
	<CADPb22R4bTg1en3rL3M=3_nLgC7Xj1P=j-mzwVtco0ar3h4EMQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e83cf3c2-fba2-b093-5e63-a72fe8c0cdd1@redhat.com>
Date: Tue, 13 Dec 2016 12:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <CADPb22R4bTg1en3rL3M=3_nLgC7Xj1P=j-mzwVtco0ar3h4EMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-i386: Fix eflags.TF/#DB handling of
 syscall/sysret insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Evans <dje@google.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 12/12/2016 20:23, Doug Evans wrote:
> On Tue, Dec 6, 2016 at 3:06 PM, Doug Evans <dje@google.com> wrote:
>> Hi.
>>
>> While qemu's behaviour matches what one would expect from reading
>> the docs, it does not match what I'm seeing on h/w.
>> Can anyone else confirm what the correct behaviour is here?
>>
>> ---
>>
>> The syscall and sysret instructions behave a bit differently:
>> TF is checked after the instruction completes.
>> This allows the o/s to disable #DB at a syscall by adding TF to FMASK.
>> And then when the sysret is executed the #DB is taken "as if" the
>> syscall insn just completed.
>>
>> Signed-off-by: Doug Evans <dje@google.com>
> 
> Ping.
> Especially, can anyone confirm the correct behaviour here?

Hi, I haven't look at the patch because QEMU was in freeze.  I'll get
back to it later this week, hopefully.

The best way to provide a testcase would be a patch to kvm-unit-tests
(git://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git); most of the
tests can be used with both QEMU emulation mode and KVM.

Paolo

> I can provide a testcase with Fuchsia if one likes.
> https://fuchsia.googlesource.com/fuchsia/
> It's not that hard to repro - we trip over it because we don't have a #DB IST
> and since SYSCALL doesn't change SP we get a double fault on qemu
> trying to establish the interrupt frame for the #DB (whereas the #DB shouldn't
> happen in the first place - at least when run on the h/w I'm using).
> The Intel/AMD docs are *really* unclear on this AFAICT.
> 
> patchwork reference: http://patchwork.ozlabs.org/patch/703373/
> 
