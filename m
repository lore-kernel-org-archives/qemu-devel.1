Received: from eggs.gnu.org ([2001:4830:134:3::10]:60189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUw3e-0002tz-13
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUw3Z-0000XI-Jv
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:59:21 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUw3Z-0000Tr-Am
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:59:17 -0500
Received: by mail-ot1-x342.google.com with SMTP id n8so852938otl.6
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 07:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
	<20181205134243.4791-9-aaron@os.amperecomputing.com>
	<20181205153242.GE5549@quinoa.localdomain>
In-Reply-To: <20181205153242.GE5549@quinoa.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 15:59:05 +0000
Message-ID: <CAFEAcA8h7xXk7Vs6_pMThZ7bfkmBBfuJUhGRZvnAfGJQR3GVOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 08/14] target/arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Wed, 5 Dec 2018 at 15:32, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> On Dec 05 08:43, Aaron Lindsay wrote:
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > ---
> >  target/arm/cpu.h    |  4 ++--
> >  target/arm/helper.c | 18 ++++++++++++++++--
> >  2 files changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 304e6e47b3..4216fe22db 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -837,8 +837,8 @@ struct ARMCPU {
> >      uint32_t id_pfr0;
> >      uint32_t id_pfr1;
> >      uint32_t id_dfr0;
> > -    uint32_t pmceid0;
> > -    uint32_t pmceid1;
> > +    uint64_t pmceid0;
> > +    uint64_t pmceid1;
> >      uint32_t id_afr0;
> >      uint32_t id_mmfr0;
> >      uint32_t id_mmfr1;
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 71be6fb578..fb6939e99c 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5256,6 +5256,20 @@ void register_cp_regs_for_features(ARMCPU *cpu)
> >      } else {
> >          define_arm_cp_regs(cpu, not_v7_cp_reginfo);
> >      }
> > +    if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4) {
>
> After further discussion on my last version, this should be
>
> if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4 &&
>         FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) != 0xf) {
>
> to guard against defining these registers for implementation-defined
> PMUs.

With that change
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
