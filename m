Received: from eggs.gnu.org ([2001:4830:134:3::10]:39699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gWekJ-00021y-3d
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gWekG-0001PZ-AH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:54:31 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gWekF-0001PK-Vt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:54:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id h25so11547881oig.1
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 01:54:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181210152829.29271-5-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-5-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 11 Dec 2018 10:54:26 +0100
Message-ID: <CAL1e-=j1o_Sc0-xsgTq+0wsE1HC+p1_kEA5Op4Ub0D03J7juMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/13] tests/tcg/mips: enable
 mips32-dsp/mips32-dspr2/mipsr5900 linux-user (WIP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: shorne@gmail.com, amarkovic@wavecomp.com, qemu-devel@nongnu.org, aurelien@aurel32.net, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, michael@walle.cc, Stefan Markovic <smarkovic@wavecomp.com>

On Dec 10, 2018 4:29 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>
> Convert the existing tests to use our common cross build
> infrastructure.
>
> [WIP: mips32r2 disabled to avoid name clash]
> [WIP: mipsr5900 disabled due to clashing build flags]
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/mips/Makefile.target       |  15 ++-
>  tests/tcg/mips/mips32-dsp/Makefile   | 166 +++++----------------------
>  tests/tcg/mips/mips32-dspr2/Makefile |  83 +++-----------
>  tests/tcg/mips/mipsr5900/Makefile    |  40 +++----
>  4 files changed, 75 insertions(+), 229 deletions(-)
>

Thank you Alex for this initiative.

For DSP, following MIPS CPUs in QEMU support DSP:

DSP: 24KEc (MIPS32R2),  34Kf (MIPS32R2), 74Kf (MIPS32R2), mips64dspr2
(MIPS64R2),

DSP R2: mips64dspr2 (MIPS64R2),

(For simplicity, I didn't mention new nanoMIPS architecture, since your gcc
for sure don't support it yet)

In brackets, those are architectures that are usually required to be passed
to gcc as its option, and that explains the switch involving MIPS64R2 for
DSP R2.

Whereas while starting QEMU, CPU name should be specified in -cpu switch.

mips64dspr2 is a virtual cpu (doesn't model any real cpu) made specifically
for DSP R2 testings, hence such odd name.

Hopefully this clarifies some of your dilemmas.

What are name clashes that you mention? Are they just related to filenames?

CHEERS,
Aleksandar

> diff --git a/tests/tcg/mips/Makefile.target
b/tests/tcg/mips/Makefile.target
> index 086625f533..33bb25bf8d 100644
> --- a/tests/tcg/mips/Makefile.target
> +++ b/tests/tcg/mips/Makefile.target
> @@ -15,8 +15,17 @@ TESTS +=3D $(MIPS_TESTS)
>  hello-mips: CFLAGS+=3D-ffreestanding
>  hello-mips: LDFLAGS+=3D-nostdlib
>
> -# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
> -# however they are intended for system tests.
> -
>  run-hello-mips: hello-mips
>         $(call skip-test, $<, "BROKEN")
> +
> +# For MIPS32 and mipsr5900 we have a bunch of extra tests in
sub-directories
> +
> +ifeq ($(TARGET_NAME),mipsel)
> +-include $(MIPS_SRC)/mips32-dsp/Makefile
> +
> +# FIXME: doesn't build - names clash with mips32-dsp
> +#-include $(MIPS_SRC)/mips32-dspr2/Makefile
> +
> +# FIXME: the docker compiler can't build the binaries
> +#-include $(MIPS_SRC)/mipsr5900/Makefile
> +endif
> diff --git a/tests/tcg/mips/mips32-dsp/Makefile
b/tests/tcg/mips/mips32-dsp/Makefile
> index c3a0a00944..df2dddceaa 100644
> --- a/tests/tcg/mips/mips32-dsp/Makefile
> +++ b/tests/tcg/mips/mips32-dsp/Makefile
> @@ -1,136 +1,30 @@
> --include ../../config-host.mak
> -
> -CROSS=3Dmips64el-unknown-linux-gnu-
> -
> -SIM=3Dqemu-mipsel
> -SIM_FLAGS=3D-cpu 74Kf
> -
> -CC      =3D $(CROSS)gcc
> -CFLAGS  =3D -mabi=3D32 -march=3Dmips32r2 -mgp32 -mdsp -static
> -
> -TESTCASES =3D absq_s_ph.tst
> -TESTCASES +=3D absq_s_w.tst
> -TESTCASES +=3D addq_ph.tst
> -TESTCASES +=3D addq_s_ph.tst
> -TESTCASES +=3D addq_s_w.tst
> -TESTCASES +=3D addsc.tst
> -TESTCASES +=3D addu_qb.tst
> -TESTCASES +=3D addu_s_qb.tst
> -TESTCASES +=3D addwc.tst
> -TESTCASES +=3D bitrev.tst
> -TESTCASES +=3D bposge32.tst
> -TESTCASES +=3D cmp_eq_ph.tst
> -TESTCASES +=3D cmpgu_eq_qb.tst
> -TESTCASES +=3D cmpgu_le_qb.tst
> -TESTCASES +=3D cmpgu_lt_qb.tst
> -TESTCASES +=3D cmp_le_ph.tst
> -TESTCASES +=3D cmp_lt_ph.tst
> -TESTCASES +=3D cmpu_eq_qb.tst
> -TESTCASES +=3D cmpu_le_qb.tst
> -TESTCASES +=3D cmpu_lt_qb.tst
> -TESTCASES +=3D dpaq_sa_l_w.tst
> -TESTCASES +=3D dpaq_s_w_ph.tst
> -TESTCASES +=3D dpau_h_qbl.tst
> -TESTCASES +=3D dpau_h_qbr.tst
> -TESTCASES +=3D dpsq_sa_l_w.tst
> -TESTCASES +=3D dpsq_s_w_ph.tst
> -TESTCASES +=3D dpsu_h_qbl.tst
> -TESTCASES +=3D dpsu_h_qbr.tst
> -TESTCASES +=3D extp.tst
> -TESTCASES +=3D extpdp.tst
> -TESTCASES +=3D extpdpv.tst
> -TESTCASES +=3D extpv.tst
> -TESTCASES +=3D extr_rs_w.tst
> -TESTCASES +=3D extr_r_w.tst
> -TESTCASES +=3D extr_s_h.tst
> -TESTCASES +=3D extrv_rs_w.tst
> -TESTCASES +=3D extrv_r_w.tst
> -TESTCASES +=3D extrv_s_h.tst
> -TESTCASES +=3D extrv_w.tst
> -TESTCASES +=3D extr_w.tst
> -TESTCASES +=3D insv.tst
> -TESTCASES +=3D lbux.tst
> -TESTCASES +=3D lhx.tst
> -TESTCASES +=3D lwx.tst
> -TESTCASES +=3D madd.tst
> -TESTCASES +=3D maddu.tst
> -TESTCASES +=3D maq_sa_w_phl.tst
> -TESTCASES +=3D maq_sa_w_phr.tst
> -TESTCASES +=3D maq_s_w_phl.tst
> -TESTCASES +=3D maq_s_w_phr.tst
> -TESTCASES +=3D mfhi.tst
> -TESTCASES +=3D mflo.tst
> -TESTCASES +=3D modsub.tst
> -TESTCASES +=3D msub.tst
> -TESTCASES +=3D msubu.tst
> -TESTCASES +=3D mthi.tst
> -TESTCASES +=3D mthlip.tst
> -TESTCASES +=3D mtlo.tst
> -TESTCASES +=3D muleq_s_w_phl.tst
> -TESTCASES +=3D muleq_s_w_phr.tst
> -TESTCASES +=3D muleu_s_ph_qbl.tst
> -TESTCASES +=3D muleu_s_ph_qbr.tst
> -TESTCASES +=3D mulq_rs_ph.tst
> -TESTCASES +=3D mult.tst
> -TESTCASES +=3D multu.tst
> -TESTCASES +=3D packrl_ph.tst
> -TESTCASES +=3D pick_ph.tst
> -TESTCASES +=3D pick_qb.tst
> -TESTCASES +=3D precequ_ph_qbla.tst
> -TESTCASES +=3D precequ_ph_qbl.tst
> -TESTCASES +=3D precequ_ph_qbra.tst
> -TESTCASES +=3D precequ_ph_qbr.tst
> -TESTCASES +=3D preceq_w_phl.tst
> -TESTCASES +=3D preceq_w_phr.tst
> -TESTCASES +=3D preceu_ph_qbla.tst
> -TESTCASES +=3D preceu_ph_qbl.tst
> -TESTCASES +=3D preceu_ph_qbra.tst
> -TESTCASES +=3D preceu_ph_qbr.tst
> -TESTCASES +=3D precrq_ph_w.tst
> -TESTCASES +=3D precrq_qb_ph.tst
> -TESTCASES +=3D precrq_rs_ph_w.tst
> -TESTCASES +=3D precrqu_s_qb_ph.tst
> -TESTCASES +=3D raddu_w_qb.tst
> -TESTCASES +=3D rddsp.tst
> -TESTCASES +=3D repl_ph.tst
> -TESTCASES +=3D repl_qb.tst
> -TESTCASES +=3D replv_ph.tst
> -TESTCASES +=3D replv_qb.tst
> -TESTCASES +=3D shilo.tst
> -TESTCASES +=3D shilov.tst
> -TESTCASES +=3D shll_ph.tst
> -TESTCASES +=3D shll_qb.tst
> -TESTCASES +=3D shll_s_ph.tst
> -TESTCASES +=3D shll_s_w.tst
> -TESTCASES +=3D shllv_ph.tst
> -TESTCASES +=3D shllv_qb.tst
> -TESTCASES +=3D shllv_s_ph.tst
> -TESTCASES +=3D shllv_s_w.tst
> -TESTCASES +=3D shra_ph.tst
> -TESTCASES +=3D shra_r_ph.tst
> -TESTCASES +=3D shra_r_w.tst
> -TESTCASES +=3D shrav_ph.tst
> -TESTCASES +=3D shrav_r_ph.tst
> -TESTCASES +=3D shrav_r_w.tst
> -TESTCASES +=3D shrl_qb.tst
> -TESTCASES +=3D shrlv_qb.tst
> -TESTCASES +=3D subq_ph.tst
> -TESTCASES +=3D subq_s_ph.tst
> -TESTCASES +=3D subq_s_w.tst
> -TESTCASES +=3D subu_qb.tst
> -TESTCASES +=3D subu_s_qb.tst
> -TESTCASES +=3D wrdsp.tst
> -
> -all: $(TESTCASES)
> -
> -%.tst: %.c
> -       $(CC) $(CFLAGS) $< -o $@
> -
> -check: $(TESTCASES)
> -       @for case in $(TESTCASES); do \
> -        echo $(SIM) $(SIM_FLAGS) ./$$case;\
> -        $(SIM) $(SIM_FLAGS) ./$$case; \
> -       done
> -
> -clean:
> -       $(RM) -rf $(TESTCASES)
> +#
> +# MIPS32-DSP linux-user tests
> +#
> +# We don't set the VPATH for these tests as we re-use the VPATH from
> +# ../Makefile and add explicit paths for the source to avoid name clashe=
s
> +# between the various sub-dirs.
> +#
> +
> +MIPS32DSP_SRC =3D $(SRC_PATH)/tests/tcg/mips/mips32-dsp
> +MIPS32DSP_ALL =3D $(wildcard $(MIPS32DSP_SRC)/*.c)
> +MIPS32DSP_TESTS =3D $(patsubst $(MIPS32DSP_SRC)/%.c, mips32-dsp/%,
$(MIPS32DSP_ALL))
> +MIPS32DSP_RUNS =3D $(patsubst %, run-%, $(MIPS32DSP_TESTS))
> +
> +# add to the list of tests
> +TESTS +=3D $(MIPS32DSP_TESTS)
> +
> +# We need a rule to ensure we create a sub-directory to build in
> +# It is a PHONY target to prevent confusion with MIPS32DSP_SRC
> +.PHONY: mips32-dsp.build
> +mips32-dsp.build:
> +       mkdir -p mips32-dsp
> +
> +$(MIPS32DSP_TESTS): | mips32-dsp.build
> +$(MIPS32DSP_TESTS): CFLAGS+=3D-mabi=3D32 -march=3Dmips32r2 -mgp32 -mdsp
> +
> +$(MIPS32DSP_RUNS): QEMU_OPTS=3D-cpu 74Kf
> +
> +# FIXME: I don't know why the general rule in tests/tcg/Makefile isn't
enough
> +run-mips32-dsp/%: mips32-dsp/%
> +       $(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on
$(TARGET_NAME) $(QEMU_OPTS)")
> diff --git a/tests/tcg/mips/mips32-dspr2/Makefile
b/tests/tcg/mips/mips32-dspr2/Makefile
> index ed19581c7e..6da966abb6 100644
> --- a/tests/tcg/mips/mips32-dspr2/Makefile
> +++ b/tests/tcg/mips/mips32-dspr2/Makefile
> @@ -1,71 +1,24 @@
> --include ../../config-host.mak
> +#
> +# MIPS32-DSPR2 linux-user tests
> +#
>
> -CROSS=3Dmips64el-unknown-linux-gnu-
> +MIPS32_DSPR2_SRC =3D $(SRC_PATH)/tests/tcg/mips/mips32-dsp
> +MIPS32_DSPR2_ALL =3D $(wildcard $(MIPS32_DSPR2_SRC)/*.c)
> +MIPS32_DSPR2_TESTS =3D $(patsubst $(MIPS32_DSPR2_SRC)/%.c, mips32-dspr2/=
%,
$(MIPS32_DSPR2_ALL))
> +MIPS32_DSPR2_RUNS =3D $(patsubst %, run-%, $(MIPS32_DSPR2_TESTS))
>
> -SIM=3Dqemu-mipsel
> -SIM_FLAGS=3D-cpu 74Kf
> +# add to the list of tests
> +TESTS +=3D $(MIPS32_DSPR2_TESTS)
>
> -CC      =3D $(CROSS)gcc
> -CFLAGS  =3D -mabi=3D32 -march=3Dmips32r2 -mgp32 -mdspr2 -static
> +.PHONY: mips32-dspr2.build
> +mips32-dspr2.build:
> +       mkdir -p mips32-dspr2
>
> -TESTCASES =3D absq_s_qb.tst
> -TESTCASES +=3D addqh_ph.tst
> -TESTCASES +=3D addqh_r_ph.tst
> -TESTCASES +=3D addqh_r_w.tst
> -TESTCASES +=3D addqh_w.tst
> -TESTCASES +=3D adduh_qb.tst
> -TESTCASES +=3D adduh_r_qb.tst
> -TESTCASES +=3D addu_ph.tst
> -TESTCASES +=3D addu_s_ph.tst
> -TESTCASES +=3D append.tst
> -TESTCASES +=3D balign.tst
> -TESTCASES +=3D cmpgdu_eq_qb.tst
> -TESTCASES +=3D cmpgdu_le_qb.tst
> -TESTCASES +=3D cmpgdu_lt_qb.tst
> -TESTCASES +=3D dpaqx_sa_w_ph.tst
> -TESTCASES +=3D dpa_w_ph.tst
> -TESTCASES +=3D dpax_w_ph.tst
> -TESTCASES +=3D dpaqx_s_w_ph.tst
> -TESTCASES +=3D dpsqx_sa_w_ph.tst
> -TESTCASES +=3D dpsqx_s_w_ph.tst
> -TESTCASES +=3D dps_w_ph.tst
> -TESTCASES +=3D dpsx_w_ph.tst
> -TESTCASES +=3D mul_ph.tst
> -TESTCASES +=3D mulq_rs_w.tst
> -TESTCASES +=3D mulq_s_ph.tst
> -TESTCASES +=3D mulq_s_w.tst
> -TESTCASES +=3D mulsaq_s_w_ph.tst
> -TESTCASES +=3D mulsa_w_ph.tst
> -TESTCASES +=3D mul_s_ph.tst
> -TESTCASES +=3D precr_qb_ph.tst
> -TESTCASES +=3D precr_sra_ph_w.tst
> -TESTCASES +=3D precr_sra_r_ph_w.tst
> -TESTCASES +=3D prepend.tst
> -TESTCASES +=3D shra_qb.tst
> -TESTCASES +=3D shra_r_qb.tst
> -TESTCASES +=3D shrav_qb.tst
> -TESTCASES +=3D shrav_r_qb.tst
> -TESTCASES +=3D shrl_ph.tst
> -TESTCASES +=3D shrlv_ph.tst
> -TESTCASES +=3D subqh_ph.tst
> -TESTCASES +=3D subqh_r_ph.tst
> -TESTCASES +=3D subqh_r_w.tst
> -TESTCASES +=3D subqh_w.tst
> -TESTCASES +=3D subuh_qb.tst
> -TESTCASES +=3D subuh_r_qb.tst
> -TESTCASES +=3D subu_ph.tst
> -TESTCASES +=3D subu_s_ph.tst
> +$(MIPS32_DSPR2_TESTS): | mips32-dspr2.build
> +$(MIPS32_DSPR2_TESTS): CFLAGS+=3D-mabi=3D32 -march=3Dmips32r2 -mgp32 -md=
spr2
>
> -all: $(TESTCASES)
> +$(MIPS32_DSPR2_RUNS): QEMU_OPTS=3D-cpu 74Kf
>
> -%.tst: %.c
> -       $(CC) $(CFLAGS) $< -o $@
> -
> -check: $(TESTCASES)
> -       @for case in $(TESTCASES); do \
> -        echo $(SIM) $(SIM_FLAGS) ./$$case;\
> -               $(SIM) $(SIM_FLAGS) ./$$case; \
> -       done
> -
> -clean:
> -       $(RM) -rf $(TESTCASES)
> +# FIXME: I don't know why the general rule in tests/tcg/Makefile isn't
enough
> +run-mips32-dspr2/%: mips32-dspr2/%
> +       $(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on
$(TARGET_NAME) $(QEMU_OPTS)")
> diff --git a/tests/tcg/mips/mipsr5900/Makefile
b/tests/tcg/mips/mipsr5900/Makefile
> index a1c388bc3c..7880e76986 100644
> --- a/tests/tcg/mips/mipsr5900/Makefile
> +++ b/tests/tcg/mips/mipsr5900/Makefile
> @@ -1,30 +1,20 @@
> --include ../../config-host.mak
> +#
> +# MIPSR5900 linux-user tests
> +#
>
> -CROSS=3Dmipsr5900el-unknown-linux-gnu-
> +MIPSR5900_SRC =3D $(SRC_PATH)/tests/tcg/mips/mipsr5900
> +MIPSR5900_ALL =3D $(wildcard $(MIPSR5900_SRC)/*.c)
> +MIPSR5900_TESTS =3D $(patsubst $(MIPSR5900_SRC)/%.c, %, $(MIPSR5900_ALL)=
)
> +MIPSR5900_RUNS =3D $(patsubst %, run-%, $(MIPSR5900_TESTS))
>
> -SIM=3Dqemu-mipsel
> -SIM_FLAGS=3D-cpu R5900
> +# add to the list of tests
> +TESTS +=3D $(MIPSR5900_TESTS)
>
> -CC      =3D $(CROSS)gcc
> -CFLAGS  =3D -Wall -mabi=3D32 -march=3Dr5900 -static
> +.PHONY: mipsr5900.build
> +mipsr5900.build:
> +       mkdir -p mipsr5900
>
> -TESTCASES =3D div1.tst
> -TESTCASES +=3D divu1.tst
> -TESTCASES +=3D mflohi1.tst
> -TESTCASES +=3D mtlohi1.tst
> -TESTCASES +=3D mult.tst
> -TESTCASES +=3D multu.tst
> +$(MIPS32DSP_TESTS): | mipsr5900.build
> +$(MIPSR5900_TESTS): CFLAGS+=3D-mabi=3D32 -march=3Dr5900 -msingle-float
>
> -all: $(TESTCASES)
> -
> -%.tst: %.c
> -       $(CC) $(CFLAGS) $< -o $@
> -
> -check: $(TESTCASES)
> -       @for case in $(TESTCASES); do \
> -        echo $(SIM) $(SIM_FLAGS) ./$$case;\
> -        $(SIM) $(SIM_FLAGS) ./$$case; \
> -       done
> -
> -clean:
> -       $(RM) -rf $(TESTCASES)
> +$(MIPSR5900_RUNS): QEMU_OPTS=3D-cpu R5900
> --
> 2.17.1
>
>
