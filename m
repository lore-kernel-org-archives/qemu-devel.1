Received: from eggs.gnu.org ([2001:4830:134:3::10]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dueru-0003Gd-Dl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duerm-0001FB-7h
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:46 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:46681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duerl-0001Ev-Pl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:16:37 -0400
Received: by mail-wr0-x22c.google.com with SMTP id o42so2141035wrb.3
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 06:16:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
References: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Sep 2017 11:21:44 +0100
Message-ID: <CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qmeu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Reiser <jreiser@bitwagon.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 September 2017 at 00:13, John Reiser <jreiser@bitwagon.com> wrote:
> [Moving here from  https://bugzilla.redhat.com/show_bug.cgi?id=1493304 ]
>
> qemu-arm from qemu-user-2.10.0-1.fc27.x86_64 (thus emulating 32-bit ARM on
> x86_64)
> generates SIGSEGV when code modifies a never-previously executed instruction
> that is on a writable page and is 848 bytes ahead of pc.
> A real armv7l processor allows this and executes as desired.
> Why the difference?  How can it be changed?  Where is the documentation?
> The memory region in question is allocated via

> mmap2(0xf7000000,228092,PROT_EXEC|PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0)
> = 0xf7000000
> [and not changed via mprotect()] and written once to contain:
> =====
> 0xf703704c:
>         ldr r2,mflg_here  // pc+856
>         orr r2,r2,r3  @ modify the instruction
> =>      str r2,mflg_here  // pc+848    the faulting instruction
>
>      [[snip about 848 bytes containing instructions only]]
>
> 0xf70373ac:
>   mflg_here:  // The next instruction is re-written once.
>         orr r3,r3,#0  @ flags |= MAP_{PRIVATE|ANON}  [QNX vs Linux]

Is your guest program correctly performing the necessary cache
maintenance operations between writing to the instruction and
executing the modified version? The ARM architecture provides
very wide latitude to an implementation to prefetch and precache
instructions, so it's quite easy to write code that happens
to run by accident in one implementation but not in another.
QEMU's implementation means that for straightline code with
no branches it will tend to prefetch more aggressively than a
hardware implementation, but it's still architecturally valid
to do so.

For 32-bit ARM Linux guest code, this usually means you need to
call the cacheflush syscall -- the lack of any cacheflush
lines in your strace output suggests maybe you've forgotten
to do this.

The gcc __builtin___clear_cache() is usually the simplest
way to achieve the required cache maintenance (portably,
for any CPU architecture).

thanks
-- PMM
