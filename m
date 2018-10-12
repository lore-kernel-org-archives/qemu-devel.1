Received: from eggs.gnu.org ([2001:4830:134:3::10]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAudX-0004FJ-Ll
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gAudT-0007eB-UZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:25:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57352 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gAudS-0007XB-Rz
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:25:35 -0400
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-4-fli@suse.com>
	<878t344o4l.fsf@dusky.pond.sub.org>
	<dc2502f6-b288-05aa-dfed-7799a283616a@suse.com>
	<87r2gvshbi.fsf@dusky.pond.sub.org>
From: Fei Li <fli@suse.com>
Message-ID: <969d9b54-a1a1-b923-404a-58298ea9ac39@suse.com>
Date: Fri, 12 Oct 2018 18:25:21 +0800
MIME-Version: 1.0
In-Reply-To: <87r2gvshbi.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC v5 3/7] qemu_init_vcpu: add a new Error
 parameter to propagate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com



On 10/12/2018 04:24 PM, Markus Armbruster wrote:
> Fei Li <fli@suse.com> writes:
>
>> On 10/11/2018 09:19 PM, Markus Armbruster wrote:
>>> Fei Li <fli@suse.com> writes:
>>>
>>>> The caller of qemu_init_vcpu() already passed the **errp to handle
>>> Which caller?  There are many.  Or do you mean "The callers"?
>> Oh, sorry, I mean "The callers" :)
>>>> errors. In view of this, add a new Error parameter to the following
>>>> call trace to propagate the error and let the further caller check it.
>>> Which "call trace"?
>> Actually, I want to say all functions called by qemu_init_vcpu()..
>>>> Besides, make qemu_init_vcpu() return a Boolean value to let its
>>>> callers know whether it succeeds.
>>>>
>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>> ---
>>>>    accel/tcg/user-exec-stub.c      |  2 +-
>>>>    cpus.c                          | 34 +++++++++++++++++++++-------------
>>>>    include/qom/cpu.h               |  2 +-
>>>>    target/alpha/cpu.c              |  4 +++-
>>>>    target/arm/cpu.c                |  4 +++-
>>>>    target/cris/cpu.c               |  4 +++-
>>>>    target/hppa/cpu.c               |  4 +++-
>>>>    target/i386/cpu.c               |  4 +++-
>>>>    target/lm32/cpu.c               |  4 +++-
>>>>    target/m68k/cpu.c               |  4 +++-
>>>>    target/microblaze/cpu.c         |  4 +++-
>>>>    target/mips/cpu.c               |  4 +++-
>>>>    target/moxie/cpu.c              |  4 +++-
>>>>    target/nios2/cpu.c              |  4 +++-
>>>>    target/openrisc/cpu.c           |  4 +++-
>>>>    target/ppc/translate_init.inc.c |  4 +++-
>>>>    target/riscv/cpu.c              |  4 +++-
>>>>    target/s390x/cpu.c              |  4 +++-
>>>>    target/sh4/cpu.c                |  4 +++-
>>>>    target/sparc/cpu.c              |  4 +++-
>>>>    target/tilegx/cpu.c             |  4 +++-
>>>>    target/tricore/cpu.c            |  4 +++-
>>>>    target/unicore32/cpu.c          |  4 +++-
>>>>    target/xtensa/cpu.c             |  4 +++-
>>>>    24 files changed, 86 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
>>>> index a32b4496af..38f6b928d4 100644
>>>> --- a/accel/tcg/user-exec-stub.c
>>>> +++ b/accel/tcg/user-exec-stub.c
>>>> @@ -10,7 +10,7 @@ void cpu_resume(CPUState *cpu)
>>>>    {
>>>>    }
>>>>    -void qemu_init_vcpu(CPUState *cpu)
>>>> +bool qemu_init_vcpu(CPUState *cpu, Error **errp)
>>>>    {
>>> You need to return a value here.  Sure you compile-tested this?
>> Oops! I forget the TCG case.. The `return true` should be added.
>> Thanks for pointing this out!
> You're welcome.
>
>>>>    }
>>>>    diff --git a/cpus.c b/cpus.c
> [...]
>>> I see how you changed the code to pass an Error from the
>>> qemu_FOO_start_vcpu() through qemu_init_vcpu() to its callers.  I can't
>>> see how such errors can be created.  Without a way to create any, the
>>> patch is pointless.  What am I missing?
>> This patch is also the pre-patch for the updated qemu_thread_create()
>> in patch 7/7
>> just as I explained in patch 2/7 [Issue1].
> Patches that make little sense on their own, but pave the way for a
> later patch are okay.  But they should explain that purpose in their
> commit message.
Right. Thanks for the advice, will amend the commit message in next version.

Have a nice day
Fei
