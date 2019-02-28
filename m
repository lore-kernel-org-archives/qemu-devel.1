Received: from eggs.gnu.org ([209.51.188.92]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gzNBc-000871-LP
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gzNBX-0002In-4D
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:01:24 -0500
Received: from mail-it1-x135.google.com ([2607:f8b0:4864:20::135]:54319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gzNBW-0002Ey-MS
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:01:19 -0500
Received: by mail-it1-x135.google.com with SMTP id w18so15062913itj.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 07:01:09 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
Date: Thu, 28 Feb 2019 10:01:06 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FBF59F3-F256-4680-B2AD-199C197814C9@oberlin.edu>
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
	<CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
	<63A30600-CCE3-4412-A3EB-8D535A8B21B3@oberlin.edu>
	<4F8E4327-9F59-4F50-A22D-20A3F939899F@oberlin.edu>
	<9108923c-076b-034c-9d68-af355861ae0c@linaro.org>
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Apologies. I started writing this response several days ago but got =
busy.

> On Feb 26, 2019, at 11:56, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> I am happy to have proper segmentation support upstream, but having =
read
> through your patch I think I would approach it differently: I would =
incorporate
> segmentation into the softmmu translation process.

That's an interesting idea. Before I try that, I have a few questions.

I'm very new to this part of the code base. I'm not entirely sure how =
the softmmu translation process works. It looks like each target defines =
a number of MMU_MODES and each memory access TCG instruction (I'm not =
sure what these are called) encodes the MMU mode index. Then, I suppose =
the code generation takes a list of TCG instructions and when generating =
loads and stores, it takes the MMU mode index into account to perform =
virtual to physical translation. I'm not entirely sure where the code =
that does this lives, but is that broadly correct?

> Having many softmmu tlbs, even if unused, used to be expensive, and =
managing
> them difficult.  However, some (very) recent work has reduced that =
expense.
>=20
> I would add 6 new MMU_MODES, one for each segment register.  =
Translation for
> these modes would proceed in two stages, just like real =
segmentation+paging.
> So your access checks happen as a part of normal memory accesses.  (We =
have an
> example of two-level translation in target/arm, S1_ptw_translate.)

So to take an example, movs es:[edi], ds:[esi] would generate a load =
using the DS MMU mode and a store using the ES MMU mode. Currently, a =
single mode appears to be used for all memory accesses and this mode is =
set in the initializer for the disassembly context, =
i386_tr_init_disas_context.

> These new tlbs would need to be flushed on any segment register =
change, and
> with any change to the underlying page tables.  They would need to be =
flushed
> on privilege level changes (or we'd need to add another 6 for ring0).

Are you thinking that this should be modeled as independent sets of =
TLBs, one per mode?

It seems easier to have a linear address MMU mode and then for the MMU =
modes corresponding to segment registers, perform an access and limit =
check, adjust the address by the segment base, and then go through the =
linear address MMU mode translation.

In particular, code that uses segments spends a lot of time changing the =
values of segment registers. E.g., in the movs example above, the ds =
segment may be overridden but the es segment cannot be, so to use the =
string move instructions within ds, es needs to be saved, modified, and =
then restored.

> I would extend the check for HF_ADDSEG_MASK to include 4GB segment =
limits.
> With that, "normal" 32-bit operation would ignore these new tlbs and =
continue
> to use the current flat view of the virtual address space.
>=20
> That should all mean no slow down in the common case, not having to =
adjust
> every single memory access in target/i386/translate.c, and fewer =
runtime calls
> to helper functions when segmentation is in effect.

Modifying HF_ADDSEG_MASK to mean not just the base, but also the limit =
makes a lot of sense. I don't know what happens when these hidden flags =
get modified though. If a basic block is translated with ADDSEG not set, =
then a segment register is changed such that ADDSEG becomes set, will =
the previously translated basic block be retranslated in light of this =
change? I hope so, but I'm not sure how/where this happens.

Not having to adjust every single memory access in i386/translate.c =
would be fantastic. But I don't see a lot of great options for =
implementing this that doesn't require changing them all. Each memory =
access needs to know what segment register* (and thus which MMU mode) to =
use. So either every access needs to be adjusted to explicitly use the =
appropriate mode=E2=80=94taking overrides into account=E2=80=94or the =
lea functions need to set the appropriate mode for a subsequent access =
to use. The latter option means that there's an implicit dependency in =
the order of operations.

Returning to the movs example, the order of operations _must_ be
1. lea ds:[esi]
2. load 4 bytes
3. lea es:[edi]
4. store 4 bytes

Swapping the order of 2 and 3 is currently fine (as long as different =
temporaries are used for storing the results of the lea) but if the lea =
code is also setting the mode, then swapping the order would lead to =
loading 4 bytes from the wrong segment.

This approach seems pretty brittle and errors are likely going to be =
difficult to catch.

Do you have an approach in mind that avoids this difficulty and also =
doesn't modify every memory access?

* I believe LGDT and LIDT are the only two x86 instructions that use a =
linear address rather than a segment-relative one.

Finally, I think there's an issue with this approach when trying to =
store more than 4 or 8 bytes of data in a single operation. On a 32-bit =
host, MOVQ (the MMX instruction) is going to store 64-bits of data. If =
this store happens starting 4 bytes before the end of the segment, I =
believe this should either case #GP(0) or #SS(0), depending on the =
segment. But if the 64-bit store is broken into two 32-bit stores, the =
first may succeed and the second fail, leading to an inconsistent state. =
Do you have any thoughts on how this should be handled?

Thank you,

Steve

--=20
Stephen Checkoway
