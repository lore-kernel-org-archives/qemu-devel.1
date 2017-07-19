Received: from eggs.gnu.org ([2001:4830:134:3::10]:43560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXlKr-0005Pc-6k
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXlKn-0001H0-8d
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:32:01 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXlKn-0001Gg-0N
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:31:57 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 12so56339102wrb.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 02:31:56 -0700 (PDT)
References: <201707190822419393994@zte.com.cn>
	<d53318a2-1297-0592-b755-7c7fda3cc4ce@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d53318a2-1297-0592-b755-7c7fda3cc4ce@twiddle.net>
Date: Wed, 19 Jul 2017 10:31:54 +0100
Message-ID: <877ez493hx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/45] tcg: support for multiple TCG
 contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: jiang.biao2@zte.com.cn, cota@braap.org, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 07/18/2017 02:22 PM, jiang.biao2@zte.com.cn wrote:
>> Seeing your work on multiple TCG, it seems that it has some kind of
>> connection with the  MTTCG feature,
>>
>> but I do not figure out how they are connected in detail.
>>
>> Could you pls help to confirm the following questions:
>>
>>  1.
>>
>>     what is the relationship between your patches and the MTTCG feature
>>     mentioned by https://lwn.net/Articles/697265/?
>
>
> The current MTTCG feature is in QEMU mainline.  It allows parallel
> execution of translated code in both system mode.  It does *not* allow
> parallel translation -- all translation is done with tb_lock held.
>
> Note that we *always* have parallel execution in user mode.  However,
> this can and does lead to problems.  See below.
>
> This patch set allows parallel translation in system mode.  This is
> shown to improve the overall throughput.  It does *not* allow parallel
> translation in user mode.  Firstly because user mode already shares
> more translations between threads (because it is running a single
> executable), and so the translation routines are not high in the
> profile.  Secondly because there are additional locking problems due
> to the fact that we have no bound on the number of user threads.
>
>
>>  2.
>>
>>     What is the current status of the development of the MTTCG feature?
>
> MTTCG has only been enabled on a few targets: alpha, arm, ppc64.
> Look for "mttcg=yes" in configure.
>
> In order for MTTCG to be enabled, the target must be adjusted so that
> (1) all atomic instructions are implemented with atomic tcg operations,
> (2) define TCG_GUEST_DEFAULT_MO to indicate any barriers implied by
>     normal memory operations by the target architecture.
>
> For target/mips, neither of these things are complete.
>
> MTTCG has only been enabled on one host: i386.
> Look for TCG_TARGET_DEFAULT_MO in tcg/*/tcg-target.h.
>
> In order for MTTCG to be enabled, the target memory order must not be
> stronger than the host memory order.  Since i386 has a very strong
> host memory order, it is easy for it to emulate any guest.  When the
> host has a weak memory order, we need to add the additional barriers
> that are implied by the target.  This is work that has not been done.
>
> I am not sure why we have not already added this definition to all of
> the other tcg hosts.  I think this is just oversight, since almost
> everyone uses x86_64 linux as the host for testing tcg.  However,
> since all of the supported targets have weak memory orders we ought to
> be able to support them with any host.

Yeah the MO definitions can be added to the other guests/backends. I was
hoping it would be done by those who have a better understanding of each
guests micro-architecture so as to avoid any silly mistakes. As you say
I think they will all mostly be 0 anyway ;-)

>>  3.
>>
>>     Is there any problem with the multithread programme running with linux-user
>>     qemu mode? would the situation be improved with  the MTTCG feature?
>>
>>     We need to use linux-user mode qemu to run multithread app, but there seems
>>     to be many problem.
>
> For user mode, we should still follow the rules for MTTCG, but we do
> not. Instead we take it on faith that they have been and execute the
> code in parallel anyway.  This faith is often misplaced and it does
> mean that unsupported targets execute user mode code incorrectly.

Certainly for user-mode once the appropriate changes are made to atomic
and barrier support instructions user-mode stability should improve
(modulo unsupported/buggy syscall translation).

System mode emulation usually requires a bit more work and system-wide
instructions, usually ones which trigger interrupts and TLB flushes, to
make sure they are done in a safe way.

--
Alex Bennée
