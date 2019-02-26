Received: from eggs.gnu.org ([209.51.188.92]:34675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyg21-0004I8-6C
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyg1z-0007Su-VE
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:56:37 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:45728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyg1z-0007Rn-NE
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:56:35 -0500
Received: by mail-pg1-x531.google.com with SMTP id y4so6459216pgc.12
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:56:35 -0800 (PST)
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
	<4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
Date: Tue, 26 Feb 2019 08:56:30 -0800
MIME-Version: 1.0
In-Reply-To: <4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/25/19 4:32 PM, Stephen Checkoway wrote:
> FWIW, I figured out an approach to this. Essentially, I'm reusing the function which computes linear addresses to enforce not only segment limits (in everything but long mode), but also read/write access (in protected mode).
> 
> Unfortunately, that meant every call to the linear address computation has to be augmented with an access size and whether it's a store or not. The patch is pretty large so I won't include it here, but you can view it at <https://github.com/stevecheckoway/qemu/commit/ac58652efacedc53f3831301ea0326ac8f882b18>.
> 
> If this is something that qemu would like, then I think two additional things are definitely required:
> 1. Tests. make check passes and the firmware I have which necessitated the checks appears to work, but that change touches the almost every guest-memory-accessing x86 instruction.
> 2. This is going to slow down the common case—where segments have a 0 base address and a limit of 0xFFFFFFFF—and there's no real need to do that. It seems like something akin to addseg could be used to decide when to insert the checks. I don't really understand how that works and in my case, segments with nonzero bases and non-0xFFFFFFFF limits are the norm so I didn't investigate that. Something similar could probably be done to omit the writable segment checks.
> 
> Finally, there are some limitations. The amount of memory touched by xsave (and the related instructions) depends on edx:eax. I didn't bother checking that at all. Similarly, there are some MPX instructions that don't do any access checks when they really should. And finally, there's one place that checks for an access size of 8 bytes when, in some cases, it should be 16.
> 
> I'm happy to work to upstream this, if the approach is broadly acceptable and the functionality is desired.

I am happy to have proper segmentation support upstream, but having read
through your patch I think I would approach it differently: I would incorporate
segmentation into the softmmu translation process.

Having many softmmu tlbs, even if unused, used to be expensive, and managing
them difficult.  However, some (very) recent work has reduced that expense.

I would add 6 new MMU_MODES, one for each segment register.  Translation for
these modes would proceed in two stages, just like real segmentation+paging.
So your access checks happen as a part of normal memory accesses.  (We have an
example of two-level translation in target/arm, S1_ptw_translate.)

These new tlbs would need to be flushed on any segment register change, and
with any change to the underlying page tables.  They would need to be flushed
on privilege level changes (or we'd need to add another 6 for ring0).

I would extend the check for HF_ADDSEG_MASK to include 4GB segment limits.
With that, "normal" 32-bit operation would ignore these new tlbs and continue
to use the current flat view of the virtual address space.

That should all mean no slow down in the common case, not having to adjust
every single memory access in target/i386/translate.c, and fewer runtime calls
to helper functions when segmentation is in effect.


r~
