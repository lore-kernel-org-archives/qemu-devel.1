Received: from eggs.gnu.org ([2001:4830:134:3::10]:43269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e73Oe-00078C-BP
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e73Od-0002dS-LF
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:53:48 -0400
Date: Tue, 24 Oct 2017 10:53:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1710241046350.574@sstabellini-ThinkPad-X260>
Message-ID: <alpine.DEB.2.10.1710241050310.574@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
	<CAFEAcA_-b5kb=_jDeDbCGugmzvcuUGKvWV0myThVJuTDbg9jNA@mail.gmail.com>
	<CAFEAcA9Zcm4tEbYXJhsp=ZDCoQDZjd53XuM6T+cxfL7fj5QxCw@mail.gmail.com>
	<alpine.DEB.2.10.1710241046350.574@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 24 Oct 2017, Stefano Stabellini wrote:
> On Tue, 24 Oct 2017, Peter Maydell wrote:
> > On 24 October 2017 at 16:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > On 21 October 2017 at 19:09, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > >> diff --git a/target/arm/translate.c b/target/arm/translate.c
> > >> index 4da1a4c..a89518f 100644
> > >> --- a/target/arm/translate.c
> > >> +++ b/target/arm/translate.c
> > >> @@ -12325,12 +12325,15 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
> > >>              /* nothing more to generate */
> > >>              break;
> > >>          case DISAS_WFI:
> > >> -            gen_helper_wfi(cpu_env);
> > >> +        {
> > >> +            TCGv_i32 tmp = tcg_const_i32((dc->insn & (1U << 31)) ? 4 : 2);
> > >
> > > This won't work, because dc->insn is only populated by the translate-a64.c
> > > A64 translator, not by the A32/T32 code. I guess 'principle of least
> > > surprise' suggests we should populate it for Thumb and ARM too.
> > 
> > ...and also, this code path is used for both A32 and Thumb instruction
> > sets, so just looking at the top bit of dc->insn isn't sufficient, because
> > you might have the A32 encoding with a cond field with the top bit clear.
> > You can either look also at dc->thumb, or alternatively have a new
> > field is_16bit in DisasContext which you populate in arm_tr_translate_insn()
> > and thumb_tr_translate_insn().
> 
> Thank you for the explanation. I went for changing this line to:
> 
>   TCGv_i32 tmp = tcg_const_i32((dc->thumb &&
>                                (dc->insn & !(1U << 31))) ? 4 : 2);

Sorry, this should be:

   TCGv_i32 tmp = tcg_const_i32((dc->thumb &&
                                !(dc->insn & (1U << 31))) ? 2 : 4);


> and I have also added a call to tcg_temp_free_i32, and dc->insn = insn
> in arm_tr_translate_insn and thumb_tr_translate_insn.
> 
> I'll send another patch.
> 
