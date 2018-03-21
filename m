Received: from eggs.gnu.org ([2001:4830:134:3::10]:46445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eyfUG-0005rq-4v
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alindsay@codeaurora.org>) id 1eyfUF-0007QO-A7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:17:12 -0400
Date: Wed, 21 Mar 2018 11:17:00 -0400
From: Aaron Lindsay <alindsay@codeaurora.org>
Message-ID: <20180321151700.GF24561@codeaurora.org>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-2-git-send-email-alindsay@codeaurora.org>
	<aeacd6da-0f45-f871-9a0a-2c8a524db510@amsat.org>
	<20180319203509.GD24561@codeaurora.org>
	<3e12e8ef-e5ee-d690-7d01-c074b6145566@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3e12e8ef-e5ee-d690-7d01-c074b6145566@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 01/22] target/arm: A53:
 Initialize PMCEID[01]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On Mar 20 02:03, Philippe Mathieu-Daud=E9 wrote:
> On 03/19/2018 09:35 PM, Aaron Lindsay wrote:
> > On Mar 18 23:35, Philippe Mathieu-Daud=E9 wrote:
> >> Hi Aaron,
> >>
> >> On 03/16/2018 09:30 PM, Aaron Lindsay wrote:
> >>> A53 advertises ARM_FEATURE_PMU, but wasn't initializing pmceid[01].
> >>> pmceid[01] are already being initialized to zero for both A15 and A=
57.
> >>>
> >>> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> >>> ---
> >>>  target/arm/cpu64.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> >>> index 991d764..8c4db31 100644
> >>> --- a/target/arm/cpu64.c
> >>> +++ b/target/arm/cpu64.c
> >>> @@ -201,6 +201,8 @@ static void aarch64_a53_initfn(Object *obj)
> >>>      cpu->id_isar5 =3D 0x00011121;
> >>>      cpu->id_aa64pfr0 =3D 0x00002222;
> >>>      cpu->id_aa64dfr0 =3D 0x10305106;
> >>> +    cpu->pmceid0 =3D 0x00000000;
> >>> +    cpu->pmceid1 =3D 0x00000000;
> >>>      cpu->id_aa64isar0 =3D 0x00011120;
> >>>      cpu->id_aa64mmfr0 =3D 0x00001122; /* 40 bit physical addr */
> >>>      cpu->dbgdidr =3D 0x3516d000;
> >>>
> >>
> >> Maybe we can move this at a single place in arm_cpu_post_init():
> >>
> >>     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> >>         cpu->pmceid0 =3D 0x00000000;
> >>         cpu->pmceid1 =3D 0x00000000;
> >>     }
> >=20
> > I like consolidating the initialization - though I think it can go in
> > arm_cpu_realizefn() with the preexisting PMU-related id_aa64dfr0
> > initialization since it is constant once you've chosen a type of
> > processor. One of the other patches in this set actually already adds
> > some PMCEID initialization there based on PMCR.N.
>=20
> Indeed, arm_cpu_realizefn() is a good place.

I've consolidated the pmceid[01] initialization into arm_cpu_realizefn()
for v4.

-Aaron

--=20
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies=
, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
