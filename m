Received: from eggs.gnu.org ([2001:4830:134:3::10]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1exweN-0003ek-4U
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1exweL-0002Ei-LW
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:24:38 -0400
Date: Mon, 19 Mar 2018 11:24:27 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180319152426.GB24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-15-git-send-email-alindsay@codeaurora.org>
	<9af89876-bf5d-4696-a430-664fcd5a02fa@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9af89876-bf5d-4696-a430-664fcd5a02fa@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/22] target/arm: Make PMOVSCLR 64 bits
 wide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

Phil,

On Mar 19 00:14, Philippe Mathieu-Daud=E9 wrote:
> Hi Aaron,
>=20
> On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> > This is a bug fix to ensure 64-bit reads of this register don't read
> > adjacent data.
> >=20
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > ---
> >  target/arm/cpu.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 9c3b5ef..fb2f983 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -367,7 +367,7 @@ typedef struct CPUARMState {
> >          uint32_t c9_data;
> >          uint64_t c9_pmcr; /* performance monitor control register */
> >          uint64_t c9_pmcnten; /* perf monitor counter enables */
> > -        uint32_t c9_pmovsr; /* perf monitor overflow status */
> > +        uint64_t c9_pmovsr; /* perf monitor overflow status */
>=20
> This doesn't look correct, since this reg is 32b.
>=20
> I *think* the correct fix is in ARMCPRegInfo v7_cp_reginfo[]:
>=20
>     { .name =3D "PMOVSR", ...
> -     ..., .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmovsr),
> +     ..., .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmovsr),
>       .accessfn =3D pmreg_access,
>       .writefn =3D pmovsr_write,
>       .raw_writefn =3D raw_write },

Nearly all of these PMU registers are 32 bits wide, but most of them are
implemented as 64-bit registers (PMCR, PMCNTEN*, PMSELR, PMINTEN* are a
few examples I see in this patch's context). My understanding is that
AArch64 register accesses are handled as 64 bits, even if the register
itself isn't that wide (though I haven't personally verified this). See
an earlier email from Peter from v2 of this patchset:

https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03983.html

Does this still look wrong to you? If so, I'll take a more thorough look
into how these accesses work.

> >          uint32_t c9_pmuserenr; /* perf monitor user enable */

Whatever we decide should likely be done to PMUSERENR too - I think I
overlooked this one before.

> >          uint64_t c9_pmselr; /* perf monitor counter selection regist=
er */
> >          uint64_t c9_pminten; /* perf monitor interrupt enables */
> >=20
>=20
> Regards,
>=20
> Phil.

-Aaron

--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies=
, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
