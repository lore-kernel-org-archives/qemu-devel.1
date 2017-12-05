Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMEog-0003bh-O3
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMEod-0003OS-H2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMEod-0003OI-AY
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:07:23 -0500
References: <CAFEAcA_ffAw2jz9Sp-hxi_ZvdVjCYynk_0Lk2zFOSCMqCpHgxA@mail.gmail.com>
	<ed43c37b-712a-ea16-85d8-3baee67c560c@redhat.com>
	<CAFEAcA9mzeVNxn0HfQOnx4_K2mnb+1JaY9ryY5Ju3oieHMnyCw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <595f05b7-a61d-fc05-6621-b4f55fff28a7@redhat.com>
Date: Tue, 5 Dec 2017 16:07:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9mzeVNxn0HfQOnx4_K2mnb+1JaY9ryY5Ju3oieHMnyCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] deadlock in rcu_init_lock() in usermode emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05/12/2017 16:01, Peter Maydell wrote:
> On 5 December 2017 at 13:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Probably the best solution is to add start_exclusive/end_exclusive
>> respectively at the beginning and the end of fork_start and fork_end.
>> This is safer in general, as it ensures that the disappeared child
>> threads were quiescent.
>>
>> In fact, I wonder if fork_start/fork_end still need to "take all
>> mutexes" (in pthread_atfork style) if we do
>> start_exclusive/end_exclusive in fork_start and fork_end(0).  You don't
>> even need to reinitialize the mutexes, meaning that mmap_fork_start and
>> mmap_fork_end should go as well.
>>
>> The list of locks that are "assured not taken" within
>> start_exclusive/end_exclusive (currently: rcu_read_lock, tb_lock,
>> mmap_lock) should probably be documented in fork_start/fork_end.
> 
> How does start_exclusive() assure that mmap_lock and tb_lock
> aren't taken? It ensures that no other thread is between
> cpu_exec_start and cpu_exec_end, but we don't (can't) do the work of
> do_syscall() inside an exec-start/end section, and do_syscall()
> codepaths can take the mmap lock and the tb lock (eg target_mmap()
> will take the mmap lock and then call tb_invalidate_phys_range()
> which takes the tb lock).

You're right of course---I'm not very well versed in user-mode
emulation.  But it should still fix the bug.

Paolo
