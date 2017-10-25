Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7Qm4-0001gU-1m
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e7Qm3-0000Ut-Ao
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:51:32 -0400
Date: Wed, 25 Oct 2017 11:51:22 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA_M2Y+Qv==YJtuA32ZZO78+nKG+uwr_+sJv++HC9NtmuQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1710251150470.574@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710241055160.574@sstabellini-ThinkPad-X260>
	<CAFEAcA_M2Y+Qv==YJtuA32ZZO78+nKG+uwr_+sJv++HC9NtmuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 25 Oct 2017, Peter Maydell wrote:
> On 24 October 2017 at 18:59, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > WFI/E are often, but not always, 4 bytes long. When they are, we need to
> > set ARM_EL_IL_SHIFT in the syndrome register.
> >
> > Pass the instruction length to HELPER(wfi), use it to decrement pc
> > appropriately and to pass an is_16bit flag to syn_wfx, which sets
> > ARM_EL_IL_SHIFT if needed.
> >
> > Set dc->insn in both arm_tr_translate_insn and thumb_tr_translate_insn.
> >
> > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> > diff --git a/target/arm/translate.c b/target/arm/translate.c
> > index 4da1a4c..0a7b67c 100644
> > --- a/target/arm/translate.c
> > +++ b/target/arm/translate.c
> > @@ -12124,6 +12124,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> >      }
> >
> >      insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
> > +    dc->insn = insn;
> >      dc->pc += 4;
> >      disas_arm_insn(dc, insn);
> >
> > @@ -12191,6 +12192,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> >      }
> >
> >      insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
> > +    dc->insn = insn;
> >      is_16bit = thumb_insn_is_16bit(dc, insn);
> >      dc->pc += 2;
> >      if (!is_16bit) {
> 
> This isn't quite in the right place, because it's before we load the
> second half of a 32 bit Thumb insn, so it won't give dc->insn the
> correct full width insn value in that case.
> 
> I'm going to take this patch into target-arm.next and fix it up locally
> rather than making you spin a v4.

Thank you! :-)
