Received: from eggs.gnu.org ([2001:4830:134:3::10]:58756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl4Q4-0008Fp-7d
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl4Py-0001Am-Bm
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 22:32:24 -0400
Date: Fri, 25 Aug 2017 11:38:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825013819.GQ5379@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s33OSBZCP+C8M/FY"
Content-Disposition: inline
In-Reply-To: <1503562911-2776-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 2/6] ppc: make cpu_model
 translation to type consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--s33OSBZCP+C8M/FY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 10:21:47AM +0200, Igor Mammedov wrote:
> PPC handles -cpu FOO rather incosistently,
> i.e. it does case-insensitive matching of FOO to
> a CPU type (see: ppc_cpu_compare_class_name) but
> handles alias names as case-sensitive, as result:
>=20
>  # qemu-system-ppc64 -M mac99 -cpu g3
>  qemu-system-ppc64: unable to find CPU model ' kN=EF=BF=BDU'
>=20
>  # qemu-system-ppc64 -cpu 970MP_V1.1
>  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
>=20
> while
>=20
>  # qemu-system-ppc64 -M mac99 -cpu G3
>  # qemu-system-ppc64 -cpu 970MP_v1.1
>=20
> start up just fine.
>=20
> Considering we can't take case-insensitive matching away,
> make it case-insensitive for  all alias/type/core_type
> lookups.
>=20
> As side effect it allows to remove duplicate core types
> which are the same but use lower-case letters in name.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Hmm.  So, I'm certainly good with making the matching more consistent,
and removing extra entries differing only in case.

However, I don't like capitalizing everything in the model table.  The
"canonical" capitalization - as in how it appears in manuals and
marketing info - is quite frequently mixed case.  So I think making
everything caps in the table will make it harder to read in the
context of looking at the corresponding documentation.

Can we instead retain mixed case in the table, and capitalize both
sides at the comparison time?

> ---
> PS:
>  consistent naming will be used by follow up patch to
>  simplify cpu_model translation code and drop ~50LOC.
> ---
>  hw/ppc/spapr_cpu_core.c     |  30 +-
>  target/ppc/cpu-models.c     | 866 ++++++++++++++++++++++----------------=
------
>  target/ppc/kvm.c            |   2 +-
>  target/ppc/translate_init.c |   2 +-
>  4 files changed, 450 insertions(+), 450 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ea278ce..40936b4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -130,8 +130,10 @@ char *spapr_get_cpu_core_type(const char *model)
>  {
>      char *core_type;
>      gchar **model_pieces =3D g_strsplit(model, ",", 2);
> +    gchar *cpu_model =3D g_ascii_strup(model_pieces[0], -1);
> +    g_strfreev(model_pieces);
> =20
> -    core_type =3D g_strdup_printf("%s-%s", model_pieces[0], TYPE_SPAPR_C=
PU_CORE);
> +    core_type =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE, cpu_model);
> =20
>      /* Check whether it exists or whether we have to look up an alias na=
me */
>      if (!object_class_by_name(core_type)) {
> @@ -139,13 +141,13 @@ char *spapr_get_cpu_core_type(const char *model)
> =20
>          g_free(core_type);
>          core_type =3D NULL;
> -        realmodel =3D ppc_cpu_lookup_alias(model_pieces[0]);
> +        realmodel =3D ppc_cpu_lookup_alias(cpu_model);
>          if (realmodel) {
>              core_type =3D spapr_get_cpu_core_type(realmodel);
>          }
>      }
> +    g_free(cpu_model);
> =20
> -    g_strfreev(model_pieces);
>      return core_type;
>  }
> =20
> @@ -265,34 +267,32 @@ err:
> =20
>  static const char *spapr_core_models[] =3D {
>      /* 970 */
> -    "970_v2.2",
> +    "970_V2.2",
> =20
>      /* 970MP variants */
> -    "970MP_v1.0",
> -    "970mp_v1.0",
> -    "970MP_v1.1",
> -    "970mp_v1.1",
> +    "970MP_V1.0",
> +    "970MP_V1.1",
> =20
>      /* POWER5+ */
> -    "POWER5+_v2.1",
> +    "POWER5+_V2.1",
> =20
>      /* POWER7 */
> -    "POWER7_v2.3",
> +    "POWER7_V2.3",
> =20
>      /* POWER7+ */
> -    "POWER7+_v2.1",
> +    "POWER7+_V2.1",
> =20
>      /* POWER8 */
> -    "POWER8_v2.0",
> +    "POWER8_V2.0",
> =20
>      /* POWER8E */
> -    "POWER8E_v2.1",
> +    "POWER8E_V2.1",
> =20
>      /* POWER8NVL */
> -    "POWER8NVL_v1.0",
> +    "POWER8NVL_V1.0",
> =20
>      /* POWER9 */
> -    "POWER9_v1.0",
> +    "POWER9_V1.0",
>  };
> =20
>  static Property spapr_cpu_core_properties[] =3D {
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 8b27962..346b6b1 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -101,10 +101,10 @@
>  #endif
>      POWERPC_DEF("IOP480",        CPU_POWERPC_IOP480,                 IOP=
480,
>                  "IOP480 (401 microcontroller)")
> -    POWERPC_DEF("Cobra",         CPU_POWERPC_COBRA,                  401,
> +    POWERPC_DEF("COBRA",         CPU_POWERPC_COBRA,                  401,
>                  "IBM Processor for Network Resources")
>  #if defined(TODO)
> -    POWERPC_DEF("Xipchip",       CPU_POWERPC_XIPCHIP,                401,
> +    POWERPC_DEF("XIPCHIP",       CPU_POWERPC_XIPCHIP,                401,
>                  NULL)
>  #endif
>      /* PowerPC 403 family                                               =
     */
> @@ -176,16 +176,16 @@
>                  "PowerPC 405 F6")
>  #endif
>      /* PowerPC 405 microcontrollers                                     =
     */
> -    POWERPC_DEF("405CRa",        CPU_POWERPC_405CRa,                 405,
> +    POWERPC_DEF("405CRA",        CPU_POWERPC_405CRa,                 405,
>                  "PowerPC 405 CRa")
> -    POWERPC_DEF("405CRb",        CPU_POWERPC_405CRb,                 405,
> +    POWERPC_DEF("405CRB",        CPU_POWERPC_405CRb,                 405,
>                  "PowerPC 405 CRb")
> -    POWERPC_DEF("405CRc",        CPU_POWERPC_405CRc,                 405,
> +    POWERPC_DEF("405CRC",        CPU_POWERPC_405CRc,                 405,
>                  "PowerPC 405 CRc")
>      POWERPC_DEF("405EP",         CPU_POWERPC_405EP,                  405,
>                  "PowerPC 405 EP")
>  #if defined(TODO)
> -    POWERPC_DEF("405EXr",        CPU_POWERPC_405EXr,                 405,
> +    POWERPC_DEF("405EXR",        CPU_POWERPC_405EXr,                 405,
>                  "PowerPC 405 EXr")
>  #endif
>      POWERPC_DEF("405EZ",         CPU_POWERPC_405EZ,                  405,
> @@ -194,13 +194,13 @@
>      POWERPC_DEF("405FX",         CPU_POWERPC_405FX,                  405,
>                  "PowerPC 405 FX")
>  #endif
> -    POWERPC_DEF("405GPa",        CPU_POWERPC_405GPa,                 405,
> +    POWERPC_DEF("405GPA",        CPU_POWERPC_405GPa,                 405,
>                  "PowerPC 405 GPa")
> -    POWERPC_DEF("405GPb",        CPU_POWERPC_405GPb,                 405,
> +    POWERPC_DEF("405GPB",        CPU_POWERPC_405GPb,                 405,
>                  "PowerPC 405 GPb")
> -    POWERPC_DEF("405GPc",        CPU_POWERPC_405GPc,                 405,
> +    POWERPC_DEF("405GPC",        CPU_POWERPC_405GPc,                 405,
>                  "PowerPC 405 GPc")
> -    POWERPC_DEF("405GPd",        CPU_POWERPC_405GPd,                 405,
> +    POWERPC_DEF("405GPD",        CPU_POWERPC_405GPd,                 405,
>                  "PowerPC 405 GPd")
>      POWERPC_DEF("405GPR",        CPU_POWERPC_405GPR,                 405,
>                  "PowerPC 405 GPR")
> @@ -226,20 +226,20 @@
>      POWERPC_DEF("405S",          CPU_POWERPC_405S,                   405,
>                  "PowerPC 405 S")
>  #endif
> -    POWERPC_DEF("Npe405H",       CPU_POWERPC_NPE405H,                405,
> +    POWERPC_DEF("NPE405H",       CPU_POWERPC_NPE405H,                405,
>                  "Npe405 H")
> -    POWERPC_DEF("Npe405H2",      CPU_POWERPC_NPE405H2,               405,
> +    POWERPC_DEF("NPE405H2",      CPU_POWERPC_NPE405H2,               405,
>                  "Npe405 H2")
> -    POWERPC_DEF("Npe405L",       CPU_POWERPC_NPE405L,                405,
> +    POWERPC_DEF("NPE405L",       CPU_POWERPC_NPE405L,                405,
>                  "Npe405 L")
> -    POWERPC_DEF("Npe4GS3",       CPU_POWERPC_NPE4GS3,                405,
> +    POWERPC_DEF("NPE4GS3",       CPU_POWERPC_NPE4GS3,                405,
>                  "Npe4GS3")
>  #if defined(TODO)
> -    POWERPC_DEF("Npcxx1",        CPU_POWERPC_NPCxx1,                 405,
> +    POWERPC_DEF("NPCXX1",        CPU_POWERPC_NPCxx1,                 405,
>                  NULL)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("Npr161",        CPU_POWERPC_NPR161,                 405,
> +    POWERPC_DEF("NPR161",        CPU_POWERPC_NPR161,                 405,
>                  NULL)
>  #endif
>  #if defined(TODO)
> @@ -278,24 +278,24 @@
>                  "STB130")
>  #endif
>      /* Xilinx PowerPC 405 cores                                         =
     */
> -    POWERPC_DEF("x2vp4",         CPU_POWERPC_X2VP4,                  405,
> +    POWERPC_DEF("X2VP4",         CPU_POWERPC_X2VP4,                  405,
>                  NULL)
> -    POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
> +    POWERPC_DEF("X2VP20",        CPU_POWERPC_X2VP20,                 405,
>                  NULL)
>  #if defined(TODO)
> -    POWERPC_DEF("zl10310",       CPU_POWERPC_ZL10310,                405,
> +    POWERPC_DEF("ZL10310",       CPU_POWERPC_ZL10310,                405,
>                  "Zarlink ZL10310")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("zl10311",       CPU_POWERPC_ZL10311,                405,
> +    POWERPC_DEF("ZL10311",       CPU_POWERPC_ZL10311,                405,
>                  "Zarlink ZL10311")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("zl10320",       CPU_POWERPC_ZL10320,                405,
> +    POWERPC_DEF("ZL10320",       CPU_POWERPC_ZL10320,                405,
>                  "Zarlink ZL10320")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("zl10321",       CPU_POWERPC_ZL10321,                405,
> +    POWERPC_DEF("ZL10321",       CPU_POWERPC_ZL10321,                405,
>                  "Zarlink ZL10321")
>  #endif
>      /* PowerPC 440 family                                               =
     */
> @@ -308,10 +308,10 @@
>      POWERPC_DEF("440A4",         CPU_POWERPC_440A4,                  440=
x4,
>                  "PowerPC 440 A4")
>  #endif
> -    POWERPC_DEF("440-Xilinx",    CPU_POWERPC_440_XILINX,             440=
x5,
> +    POWERPC_DEF("440-XILINX",    CPU_POWERPC_440_XILINX,             440=
x5,
>                  "PowerPC 440 Xilinx 5")
> =20
> -    POWERPC_DEF("440-Xilinx-w-dfpu",    CPU_POWERPC_440_XILINX, 440x5wDF=
PU,
> +    POWERPC_DEF("440-XILINX-W-DFPU",    CPU_POWERPC_440_XILINX, 440x5wDF=
PU,
>                  "PowerPC 440 Xilinx 5 With a Double Prec. FPU")
>  #if defined(TODO)
>      POWERPC_DEF("440A5",         CPU_POWERPC_440A5,                  440=
x5,
> @@ -342,22 +342,22 @@
>                  "PowerPC 440H6")
>  #endif
>      /* PowerPC 440 microcontrollers                                     =
     */
> -    POWERPC_DEF("440EPa",        CPU_POWERPC_440EPa,                 440=
EP,
> +    POWERPC_DEF("440EPA",        CPU_POWERPC_440EPa,                 440=
EP,
>                  "PowerPC 440 EPa")
> -    POWERPC_DEF("440EPb",        CPU_POWERPC_440EPb,                 440=
EP,
> +    POWERPC_DEF("440EPB",        CPU_POWERPC_440EPb,                 440=
EP,
>                  "PowerPC 440 EPb")
>      POWERPC_DEF("440EPX",        CPU_POWERPC_440EPX,                 440=
EP,
>                  "PowerPC 440 EPX")
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GPb",        CPU_POWERPC_440GPb,                 440=
GP,
> +    POWERPC_DEF("440GPB",        CPU_POWERPC_440GPb,                 440=
GP,
>                  "PowerPC 440 GPb")
>  #endif
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GPc",        CPU_POWERPC_440GPc,                 440=
GP,
> +    POWERPC_DEF("440GPC",        CPU_POWERPC_440GPc,                 440=
GP,
>                  "PowerPC 440 GPc")
>  #endif
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GRa",        CPU_POWERPC_440GRa,                 440=
x5,
> +    POWERPC_DEF("440GRA",        CPU_POWERPC_440GRa,                 440=
x5,
>                  "PowerPC 440 GRa")
>  #endif
>  #if defined(TODO_USER_ONLY)
> @@ -365,19 +365,19 @@
>                  "PowerPC 440 GRX")
>  #endif
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GXa",        CPU_POWERPC_440GXa,                 440=
EP,
> +    POWERPC_DEF("440GXA",        CPU_POWERPC_440GXa,                 440=
EP,
>                  "PowerPC 440 GXa")
>  #endif
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GXb",        CPU_POWERPC_440GXb,                 440=
EP,
> +    POWERPC_DEF("440GXB",        CPU_POWERPC_440GXb,                 440=
EP,
>                  "PowerPC 440 GXb")
>  #endif
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GXc",        CPU_POWERPC_440GXc,                 440=
EP,
> +    POWERPC_DEF("440GXC",        CPU_POWERPC_440GXc,                 440=
EP,
>                  "PowerPC 440 GXc")
>  #endif
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("440GXf",        CPU_POWERPC_440GXf,                 440=
EP,
> +    POWERPC_DEF("440GXF",        CPU_POWERPC_440GXf,                 440=
EP,
>                  "PowerPC 440 GXf")
>  #endif
>  #if defined(TODO)
> @@ -413,12 +413,12 @@
>      /* Freescale embedded PowerPC cores                                 =
     */
>      /* MPC5xx family (aka RCPU)                                         =
     */
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("MPC5xx",        CPU_POWERPC_MPC5xx,                 MPC=
5xx,
> +    POWERPC_DEF("MPC5XX",        CPU_POWERPC_MPC5xx,                 MPC=
5xx,
>                  "Generic MPC5xx core")
>  #endif
>      /* MPC8xx family (aka PowerQUICC)                                   =
     */
>  #if defined(TODO_USER_ONLY)
> -    POWERPC_DEF("MPC8xx",        CPU_POWERPC_MPC8xx,                 MPC=
8xx,
> +    POWERPC_DEF("MPC8XX",        CPU_POWERPC_MPC8xx,                 MPC=
8xx,
>                  "Generic MPC8xx core")
>  #endif
>      /* MPC82xx family (aka PowerQUICC-II)                               =
     */
> @@ -430,57 +430,57 @@
>                  "PowerPC G2 GP core")
>      POWERPC_DEF("G2LS",          CPU_POWERPC_G2ls,                   G2,
>                  "PowerPC G2 LS core")
> -    POWERPC_DEF("G2HiP3",        CPU_POWERPC_G2_HIP3,                G2,
> +    POWERPC_DEF("G2HIP3",        CPU_POWERPC_G2_HIP3,                G2,
>                  "PowerPC G2 HiP3 core")
> -    POWERPC_DEF("G2HiP4",        CPU_POWERPC_G2_HIP4,                G2,
> +    POWERPC_DEF("G2HIP4",        CPU_POWERPC_G2_HIP4,                G2,
>                  "PowerPC G2 HiP4 core")
>      POWERPC_DEF("MPC603",        CPU_POWERPC_MPC603,                 603=
E,
>                  "PowerPC MPC603 core")
> -    POWERPC_DEF("G2le",          CPU_POWERPC_G2LE,                   G2L=
E,
> +    POWERPC_DEF("G2LE",          CPU_POWERPC_G2LE,                   G2L=
E,
>          "PowerPC G2le core (same as G2 plus little-endian mode support)")
> -    POWERPC_DEF("G2leGP",        CPU_POWERPC_G2LEgp,                 G2L=
E,
> +    POWERPC_DEF("G2LEGP",        CPU_POWERPC_G2LEgp,                 G2L=
E,
>                  "PowerPC G2LE GP core")
> -    POWERPC_DEF("G2leLS",        CPU_POWERPC_G2LEls,                 G2L=
E,
> +    POWERPC_DEF("G2LELS",        CPU_POWERPC_G2LEls,                 G2L=
E,
>                  "PowerPC G2LE LS core")
> -    POWERPC_DEF("G2leGP1",       CPU_POWERPC_G2LEgp1,                G2L=
E,
> +    POWERPC_DEF("G2LEGP1",       CPU_POWERPC_G2LEgp1,                G2L=
E,
>                  "PowerPC G2LE GP1 core")
> -    POWERPC_DEF("G2leGP3",       CPU_POWERPC_G2LEgp3,                G2L=
E,
> +    POWERPC_DEF("G2LEGP3",       CPU_POWERPC_G2LEgp3,                G2L=
E,
>                  "PowerPC G2LE GP3 core")
>      /* PowerPC G2 microcontrollers                                      =
     */
>  #if defined(TODO)
>      POWERPC_DEF_SVR("MPC5121", "MPC5121",
>                      CPU_POWERPC_MPC5121,      POWERPC_SVR_5121,      G2L=
E)
>  #endif
> -    POWERPC_DEF_SVR("MPC5200_v10", "MPC5200 v1.0",
> +    POWERPC_DEF_SVR("MPC5200_V10", "MPC5200 v1.0",
>                      CPU_POWERPC_MPC5200_v10,  POWERPC_SVR_5200_v10,  G2L=
E)
> -    POWERPC_DEF_SVR("MPC5200_v11", "MPC5200 v1.1",
> +    POWERPC_DEF_SVR("MPC5200_V11", "MPC5200 v1.1",
>                      CPU_POWERPC_MPC5200_v11,  POWERPC_SVR_5200_v11,  G2L=
E)
> -    POWERPC_DEF_SVR("MPC5200_v12", "MPC5200 v1.2",
> +    POWERPC_DEF_SVR("MPC5200_V12", "MPC5200 v1.2",
>                      CPU_POWERPC_MPC5200_v12,  POWERPC_SVR_5200_v12,  G2L=
E)
> -    POWERPC_DEF_SVR("MPC5200B_v20", "MPC5200B v2.0",
> +    POWERPC_DEF_SVR("MPC5200B_V20", "MPC5200B v2.0",
>                      CPU_POWERPC_MPC5200B_v20, POWERPC_SVR_5200B_v20, G2L=
E)
> -    POWERPC_DEF_SVR("MPC5200B_v21", "MPC5200B v2.1",
> +    POWERPC_DEF_SVR("MPC5200B_V21", "MPC5200B v2.1",
>                      CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2L=
E)
>      /* e200 family                                                      =
     */
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC55xx", "Generic MPC55xx core",
> +    POWERPC_DEF_SVR("MPC55XX", "Generic MPC55xx core",
>                      CPU_POWERPC_MPC55xx,      POWERPC_SVR_55xx,      e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("e200z0",        CPU_POWERPC_e200z0,                 e20=
0,
> +    POWERPC_DEF("E200Z0",        CPU_POWERPC_e200z0,                 e20=
0,
>                  "PowerPC e200z0 core")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("e200z1",        CPU_POWERPC_e200z1,                 e20=
0,
> +    POWERPC_DEF("E200Z1",        CPU_POWERPC_e200z1,                 e20=
0,
>                  "PowerPC e200z1 core")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("e200z3",        CPU_POWERPC_e200z3,                 e20=
0,
> +    POWERPC_DEF("E200Z3",        CPU_POWERPC_e200z3,                 e20=
0,
>                  "PowerPC e200z3 core")
>  #endif
> -    POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e20=
0,
> +    POWERPC_DEF("E200Z5",        CPU_POWERPC_e200z5,                 e20=
0,
>                  "PowerPC e200z5 core")
> -    POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e20=
0,
> +    POWERPC_DEF("E200Z6",        CPU_POWERPC_e200z6,                 e20=
0,
>                  "PowerPC e200z6 core")
>      /* PowerPC e200 microcontrollers                                    =
     */
>  #if defined(TODO)
> @@ -488,11 +488,11 @@
>                      CPU_POWERPC_MPC5514E,     POWERPC_SVR_5514E,     e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5514E_v0", "MPC5514E v0",
> +    POWERPC_DEF_SVR("MPC5514E_V0", "MPC5514E v0",
>                      CPU_POWERPC_MPC5514E_v0,  POWERPC_SVR_5514E_v0,  e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5514E_v1", "MPC5514E v1",
> +    POWERPC_DEF_SVR("MPC5514E_V1", "MPC5514E v1",
>                      CPU_POWERPC_MPC5514E_v1,  POWERPC_SVR_5514E_v1,  e20=
0)
>  #endif
>  #if defined(TODO)
> @@ -500,11 +500,11 @@
>                      CPU_POWERPC_MPC5514G,     POWERPC_SVR_5514G,     e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5514G_v0", "MPC5514G v0",
> +    POWERPC_DEF_SVR("MPC5514G_V0", "MPC5514G v0",
>                      CPU_POWERPC_MPC5514G_v0,  POWERPC_SVR_5514G_v0,  e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5514G_v1", "MPC5514G v1",
> +    POWERPC_DEF_SVR("MPC5514G_V1", "MPC5514G v1",
>                      CPU_POWERPC_MPC5514G_v1,  POWERPC_SVR_5514G_v1,  e20=
0)
>  #endif
>  #if defined(TODO)
> @@ -516,11 +516,11 @@
>                      CPU_POWERPC_MPC5516E,     POWERPC_SVR_5516E,     e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5516E_v0", "MPC5516E v0",
> +    POWERPC_DEF_SVR("MPC5516E_V0", "MPC5516E v0",
>                      CPU_POWERPC_MPC5516E_v0,  POWERPC_SVR_5516E_v0,  e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5516E_v1", "MPC5516E v1",
> +    POWERPC_DEF_SVR("MPC5516E_V1", "MPC5516E v1",
>                      CPU_POWERPC_MPC5516E_v1,  POWERPC_SVR_5516E_v1,  e20=
0)
>  #endif
>  #if defined(TODO)
> @@ -528,11 +528,11 @@
>                      CPU_POWERPC_MPC5516G,     POWERPC_SVR_5516G,     e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5516G_v0", "MPC5516G v0",
> +    POWERPC_DEF_SVR("MPC5516G_V0", "MPC5516G v0",
>                      CPU_POWERPC_MPC5516G_v0,  POWERPC_SVR_5516G_v0,  e20=
0)
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF_SVR("MPC5516G_v1", "MPC5516G v1",
> +    POWERPC_DEF_SVR("MPC5516G_V1", "MPC5516G v1",
>                      CPU_POWERPC_MPC5516G_v1,  POWERPC_SVR_5516G_v1,  e20=
0)
>  #endif
>  #if defined(TODO)
> @@ -572,13 +572,13 @@
>                      CPU_POWERPC_MPC5567,      POWERPC_SVR_5567,      e20=
0)
>  #endif
>      /* e300 family                                                      =
     */
> -    POWERPC_DEF("e300c1",        CPU_POWERPC_e300c1,                 e30=
0,
> +    POWERPC_DEF("E300C1",        CPU_POWERPC_e300c1,                 e30=
0,
>                  "PowerPC e300c1 core")
> -    POWERPC_DEF("e300c2",        CPU_POWERPC_e300c2,                 e30=
0,
> +    POWERPC_DEF("E300C2",        CPU_POWERPC_e300c2,                 e30=
0,
>                  "PowerPC e300c2 core")
> -    POWERPC_DEF("e300c3",        CPU_POWERPC_e300c3,                 e30=
0,
> +    POWERPC_DEF("E300C3",        CPU_POWERPC_e300c3,                 e30=
0,
>                  "PowerPC e300c3 core")
> -    POWERPC_DEF("e300c4",        CPU_POWERPC_e300c4,                 e30=
0,
> +    POWERPC_DEF("E300C4",        CPU_POWERPC_e300c4,                 e30=
0,
>                  "PowerPC e300c4 core")
>      /* PowerPC e300 microcontrollers                                    =
     */
>  #if defined(TODO)
> @@ -674,114 +674,114 @@
>      POWERPC_DEF_SVR("MPC8379E", "MPC8379E",
>                      CPU_POWERPC_MPC837x,      POWERPC_SVR_8379E,     e30=
0)
>      /* e500 family                                                      =
     */
> -    POWERPC_DEF_SVR("e500_v10", "PowerPC e500 v1.0 core",
> +    POWERPC_DEF_SVR("E500_V10", "PowerPC e500 v1.0 core",
>                      CPU_POWERPC_e500v1_v10,   POWERPC_SVR_E500,      e50=
0v1);
> -    POWERPC_DEF_SVR("e500_v20", "PowerPC e500 v2.0 core",
> +    POWERPC_DEF_SVR("E500_V20", "PowerPC e500 v2.0 core",
>                      CPU_POWERPC_e500v1_v20,   POWERPC_SVR_E500,      e50=
0v1);
> -    POWERPC_DEF_SVR("e500v2_v10", "PowerPC e500v2 v1.0 core",
> +    POWERPC_DEF_SVR("E500V2_V10", "PowerPC e500v2 v1.0 core",
>                      CPU_POWERPC_e500v2_v10,   POWERPC_SVR_E500,      e50=
0v2);
> -    POWERPC_DEF_SVR("e500v2_v20", "PowerPC e500v2 v2.0 core",
> +    POWERPC_DEF_SVR("E500V2_V20", "PowerPC e500v2 v2.0 core",
>                      CPU_POWERPC_e500v2_v20,   POWERPC_SVR_E500,      e50=
0v2);
> -    POWERPC_DEF_SVR("e500v2_v21", "PowerPC e500v2 v2.1 core",
> +    POWERPC_DEF_SVR("E500V2_V21", "PowerPC e500v2 v2.1 core",
>                      CPU_POWERPC_e500v2_v21,   POWERPC_SVR_E500,      e50=
0v2);
> -    POWERPC_DEF_SVR("e500v2_v22", "PowerPC e500v2 v2.2 core",
> +    POWERPC_DEF_SVR("E500V2_V22", "PowerPC e500v2 v2.2 core",
>                      CPU_POWERPC_e500v2_v22,   POWERPC_SVR_E500,      e50=
0v2);
> -    POWERPC_DEF_SVR("e500v2_v30", "PowerPC e500v2 v3.0 core",
> +    POWERPC_DEF_SVR("E500V2_V30", "PowerPC e500v2 v3.0 core",
>                      CPU_POWERPC_e500v2_v30,   POWERPC_SVR_E500,      e50=
0v2);
> -    POWERPC_DEF_SVR("e500mc", "e500mc",
> +    POWERPC_DEF_SVR("E500MC", "e500mc",
>                      CPU_POWERPC_e500mc,       POWERPC_SVR_E500,      e50=
0mc)
>  #ifdef TARGET_PPC64
> -    POWERPC_DEF_SVR("e5500", "e5500",
> +    POWERPC_DEF_SVR("E5500", "e5500",
>                      CPU_POWERPC_e5500,        POWERPC_SVR_E500,      e55=
00)
>  #endif
>      /* PowerPC e500 microcontrollers                                    =
     */
> -    POWERPC_DEF_SVR("MPC8533_v10", "MPC8533 v1.0",
> +    POWERPC_DEF_SVR("MPC8533_V10", "MPC8533 v1.0",
>                      CPU_POWERPC_MPC8533_v10,  POWERPC_SVR_8533_v10,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8533_v11", "MPC8533 v1.1",
> +    POWERPC_DEF_SVR("MPC8533_V11", "MPC8533 v1.1",
>                      CPU_POWERPC_MPC8533_v11,  POWERPC_SVR_8533_v11,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8533E_v10", "MPC8533E v1.0",
> +    POWERPC_DEF_SVR("MPC8533E_V10", "MPC8533E v1.0",
>                      CPU_POWERPC_MPC8533E_v10, POWERPC_SVR_8533E_v10, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8533E_v11", "MPC8533E v1.1",
> +    POWERPC_DEF_SVR("MPC8533E_V11", "MPC8533E v1.1",
>                      CPU_POWERPC_MPC8533E_v11, POWERPC_SVR_8533E_v11, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8540_v10", "MPC8540 v1.0",
> +    POWERPC_DEF_SVR("MPC8540_V10", "MPC8540 v1.0",
>                      CPU_POWERPC_MPC8540_v10,  POWERPC_SVR_8540_v10,  e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8540_v20", "MPC8540 v2.0",
> +    POWERPC_DEF_SVR("MPC8540_V20", "MPC8540 v2.0",
>                      CPU_POWERPC_MPC8540_v20,  POWERPC_SVR_8540_v20,  e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8540_v21", "MPC8540 v2.1",
> +    POWERPC_DEF_SVR("MPC8540_V21", "MPC8540 v2.1",
>                      CPU_POWERPC_MPC8540_v21,  POWERPC_SVR_8540_v21,  e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8541_v10", "MPC8541 v1.0",
> +    POWERPC_DEF_SVR("MPC8541_V10", "MPC8541 v1.0",
>                      CPU_POWERPC_MPC8541_v10,  POWERPC_SVR_8541_v10,  e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8541_v11", "MPC8541 v1.1",
> +    POWERPC_DEF_SVR("MPC8541_V11", "MPC8541 v1.1",
>                      CPU_POWERPC_MPC8541_v11,  POWERPC_SVR_8541_v11,  e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8541E_v10", "MPC8541E v1.0",
> +    POWERPC_DEF_SVR("MPC8541E_V10", "MPC8541E v1.0",
>                      CPU_POWERPC_MPC8541E_v10, POWERPC_SVR_8541E_v10, e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8541E_v11", "MPC8541E v1.1",
> +    POWERPC_DEF_SVR("MPC8541E_V11", "MPC8541E v1.1",
>                      CPU_POWERPC_MPC8541E_v11, POWERPC_SVR_8541E_v11, e50=
0v1)
> -    POWERPC_DEF_SVR("MPC8543_v10", "MPC8543 v1.0",
> +    POWERPC_DEF_SVR("MPC8543_V10", "MPC8543 v1.0",
>                      CPU_POWERPC_MPC8543_v10,  POWERPC_SVR_8543_v10,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543_v11", "MPC8543 v1.1",
> +    POWERPC_DEF_SVR("MPC8543_V11", "MPC8543 v1.1",
>                      CPU_POWERPC_MPC8543_v11,  POWERPC_SVR_8543_v11,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543_v20", "MPC8543 v2.0",
> +    POWERPC_DEF_SVR("MPC8543_V20", "MPC8543 v2.0",
>                      CPU_POWERPC_MPC8543_v20,  POWERPC_SVR_8543_v20,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543_v21", "MPC8543 v2.1",
> +    POWERPC_DEF_SVR("MPC8543_V21", "MPC8543 v2.1",
>                      CPU_POWERPC_MPC8543_v21,  POWERPC_SVR_8543_v21,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543E_v10", "MPC8543E v1.0",
> +    POWERPC_DEF_SVR("MPC8543E_V10", "MPC8543E v1.0",
>                      CPU_POWERPC_MPC8543E_v10, POWERPC_SVR_8543E_v10, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543E_v11", "MPC8543E v1.1",
> +    POWERPC_DEF_SVR("MPC8543E_V11", "MPC8543E v1.1",
>                      CPU_POWERPC_MPC8543E_v11, POWERPC_SVR_8543E_v11, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543E_v20", "MPC8543E v2.0",
> +    POWERPC_DEF_SVR("MPC8543E_V20", "MPC8543E v2.0",
>                      CPU_POWERPC_MPC8543E_v20, POWERPC_SVR_8543E_v20, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8543E_v21", "MPC8543E v2.1",
> +    POWERPC_DEF_SVR("MPC8543E_V21", "MPC8543E v2.1",
>                      CPU_POWERPC_MPC8543E_v21, POWERPC_SVR_8543E_v21, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8544_v10", "MPC8544 v1.0",
> +    POWERPC_DEF_SVR("MPC8544_V10", "MPC8544 v1.0",
>                      CPU_POWERPC_MPC8544_v10,  POWERPC_SVR_8544_v10,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8544_v11", "MPC8544 v1.1",
> +    POWERPC_DEF_SVR("MPC8544_V11", "MPC8544 v1.1",
>                      CPU_POWERPC_MPC8544_v11,  POWERPC_SVR_8544_v11,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8544E_v10", "MPC8544E v1.0",
> +    POWERPC_DEF_SVR("MPC8544E_V10", "MPC8544E v1.0",
>                      CPU_POWERPC_MPC8544E_v10, POWERPC_SVR_8544E_v10, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8544E_v11", "MPC8544E v1.1",
> +    POWERPC_DEF_SVR("MPC8544E_V11", "MPC8544E v1.1",
>                      CPU_POWERPC_MPC8544E_v11, POWERPC_SVR_8544E_v11, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8545_v20", "MPC8545 v2.0",
> +    POWERPC_DEF_SVR("MPC8545_V20", "MPC8545 v2.0",
>                      CPU_POWERPC_MPC8545_v20,  POWERPC_SVR_8545_v20,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8545_v21", "MPC8545 v2.1",
> +    POWERPC_DEF_SVR("MPC8545_V21", "MPC8545 v2.1",
>                      CPU_POWERPC_MPC8545_v21,  POWERPC_SVR_8545_v21,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8545E_v20", "MPC8545E v2.0",
> +    POWERPC_DEF_SVR("MPC8545E_V20", "MPC8545E v2.0",
>                      CPU_POWERPC_MPC8545E_v20, POWERPC_SVR_8545E_v20, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8545E_v21", "MPC8545E v2.1",
> +    POWERPC_DEF_SVR("MPC8545E_V21", "MPC8545E v2.1",
>                      CPU_POWERPC_MPC8545E_v21, POWERPC_SVR_8545E_v21, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8547E_v20", "MPC8547E v2.0",
> +    POWERPC_DEF_SVR("MPC8547E_V20", "MPC8547E v2.0",
>                      CPU_POWERPC_MPC8547E_v20, POWERPC_SVR_8547E_v20, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8547E_v21", "MPC8547E v2.1",
> +    POWERPC_DEF_SVR("MPC8547E_V21", "MPC8547E v2.1",
>                      CPU_POWERPC_MPC8547E_v21, POWERPC_SVR_8547E_v21, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548_v10", "MPC8548 v1.0",
> +    POWERPC_DEF_SVR("MPC8548_V10", "MPC8548 v1.0",
>                      CPU_POWERPC_MPC8548_v10,  POWERPC_SVR_8548_v10,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548_v11", "MPC8548 v1.1",
> +    POWERPC_DEF_SVR("MPC8548_V11", "MPC8548 v1.1",
>                      CPU_POWERPC_MPC8548_v11,  POWERPC_SVR_8548_v11,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548_v20", "MPC8548 v2.0",
> +    POWERPC_DEF_SVR("MPC8548_V20", "MPC8548 v2.0",
>                      CPU_POWERPC_MPC8548_v20,  POWERPC_SVR_8548_v20,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548_v21", "MPC8548 v2.1",
> +    POWERPC_DEF_SVR("MPC8548_V21", "MPC8548 v2.1",
>                      CPU_POWERPC_MPC8548_v21,  POWERPC_SVR_8548_v21,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548E_v10", "MPC8548E v1.0",
> +    POWERPC_DEF_SVR("MPC8548E_V10", "MPC8548E v1.0",
>                      CPU_POWERPC_MPC8548E_v10, POWERPC_SVR_8548E_v10, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548E_v11", "MPC8548E v1.1",
> +    POWERPC_DEF_SVR("MPC8548E_V11", "MPC8548E v1.1",
>                      CPU_POWERPC_MPC8548E_v11, POWERPC_SVR_8548E_v11, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548E_v20", "MPC8548E v2.0",
> +    POWERPC_DEF_SVR("MPC8548E_V20", "MPC8548E v2.0",
>                      CPU_POWERPC_MPC8548E_v20, POWERPC_SVR_8548E_v20, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8548E_v21", "MPC8548E v2.1",
> +    POWERPC_DEF_SVR("MPC8548E_V21", "MPC8548E v2.1",
>                      CPU_POWERPC_MPC8548E_v21, POWERPC_SVR_8548E_v21, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8555_v10", "MPC8555 v1.0",
> +    POWERPC_DEF_SVR("MPC8555_V10", "MPC8555 v1.0",
>                      CPU_POWERPC_MPC8555_v10,  POWERPC_SVR_8555_v10,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8555_v11", "MPC8555 v1.1",
> +    POWERPC_DEF_SVR("MPC8555_V11", "MPC8555 v1.1",
>                      CPU_POWERPC_MPC8555_v11,  POWERPC_SVR_8555_v11,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8555E_v10", "MPC8555E v1.0",
> +    POWERPC_DEF_SVR("MPC8555E_V10", "MPC8555E v1.0",
>                      CPU_POWERPC_MPC8555E_v10, POWERPC_SVR_8555E_v10, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8555E_v11", "MPC8555E v1.1",
> +    POWERPC_DEF_SVR("MPC8555E_V11", "MPC8555E v1.1",
>                      CPU_POWERPC_MPC8555E_v11, POWERPC_SVR_8555E_v11, e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8560_v10", "MPC8560 v1.0",
> +    POWERPC_DEF_SVR("MPC8560_V10", "MPC8560 v1.0",
>                      CPU_POWERPC_MPC8560_v10,  POWERPC_SVR_8560_v10,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8560_v20", "MPC8560 v2.0",
> +    POWERPC_DEF_SVR("MPC8560_V20", "MPC8560 v2.0",
>                      CPU_POWERPC_MPC8560_v20,  POWERPC_SVR_8560_v20,  e50=
0v2)
> -    POWERPC_DEF_SVR("MPC8560_v21", "MPC8560 v2.1",
> +    POWERPC_DEF_SVR("MPC8560_V21", "MPC8560 v2.1",
>                      CPU_POWERPC_MPC8560_v21,  POWERPC_SVR_8560_v21,  e50=
0v2)
>      POWERPC_DEF_SVR("MPC8567", "MPC8567",
>                      CPU_POWERPC_MPC8567,      POWERPC_SVR_8567,      e50=
0v2)
> @@ -796,7 +796,7 @@
>      POWERPC_DEF_SVR("MPC8572E", "MPC8572E",
>                      CPU_POWERPC_MPC8572E,     POWERPC_SVR_8572E,     e50=
0v2)
>      /* e600 family                                                      =
     */
> -    POWERPC_DEF("e600",          CPU_POWERPC_e600,                   e60=
0,
> +    POWERPC_DEF("E600",          CPU_POWERPC_e600,                   e60=
0,
>                  "PowerPC e600 core")
>      /* PowerPC e600 microcontrollers                                    =
     */
>      POWERPC_DEF_SVR("MPC8610", "MPC8610",
> @@ -807,299 +807,299 @@
>                      CPU_POWERPC_MPC8641D,     POWERPC_SVR_8641D,     e60=
0)
>      /* 32 bits "classic" PowerPC                                        =
     */
>      /* PowerPC 6xx family                                               =
     */
> -    POWERPC_DEF("601_v0",        CPU_POWERPC_601_v0,                 601,
> +    POWERPC_DEF("601_V0",        CPU_POWERPC_601_v0,                 601,
>                  "PowerPC 601v0")
> -    POWERPC_DEF("601_v1",        CPU_POWERPC_601_v1,                 601,
> +    POWERPC_DEF("601_V1",        CPU_POWERPC_601_v1,                 601,
>                  "PowerPC 601v1")
> -    POWERPC_DEF("601_v2",        CPU_POWERPC_601_v2,                 601=
v,
> +    POWERPC_DEF("601_V2",        CPU_POWERPC_601_v2,                 601=
v,
>                  "PowerPC 601v2")
>      POWERPC_DEF("602",           CPU_POWERPC_602,                    602,
>                  "PowerPC 602")
>      POWERPC_DEF("603",           CPU_POWERPC_603,                    603,
>                  "PowerPC 603")
> -    POWERPC_DEF("603e_v1.1",     CPU_POWERPC_603E_v11,               603=
E,
> +    POWERPC_DEF("603E_V1.1",     CPU_POWERPC_603E_v11,               603=
E,
>                  "PowerPC 603e v1.1")
> -    POWERPC_DEF("603e_v1.2",     CPU_POWERPC_603E_v12,               603=
E,
> +    POWERPC_DEF("603E_V1.2",     CPU_POWERPC_603E_v12,               603=
E,
>                  "PowerPC 603e v1.2")
> -    POWERPC_DEF("603e_v1.3",     CPU_POWERPC_603E_v13,               603=
E,
> +    POWERPC_DEF("603E_V1.3",     CPU_POWERPC_603E_v13,               603=
E,
>                  "PowerPC 603e v1.3")
> -    POWERPC_DEF("603e_v1.4",     CPU_POWERPC_603E_v14,               603=
E,
> +    POWERPC_DEF("603E_V1.4",     CPU_POWERPC_603E_v14,               603=
E,
>                  "PowerPC 603e v1.4")
> -    POWERPC_DEF("603e_v2.2",     CPU_POWERPC_603E_v22,               603=
E,
> +    POWERPC_DEF("603E_V2.2",     CPU_POWERPC_603E_v22,               603=
E,
>                  "PowerPC 603e v2.2")
> -    POWERPC_DEF("603e_v3",       CPU_POWERPC_603E_v3,                603=
E,
> +    POWERPC_DEF("603E_V3",       CPU_POWERPC_603E_v3,                603=
E,
>                  "PowerPC 603e v3")
> -    POWERPC_DEF("603e_v4",       CPU_POWERPC_603E_v4,                603=
E,
> +    POWERPC_DEF("603E_V4",       CPU_POWERPC_603E_v4,                603=
E,
>                  "PowerPC 603e v4")
> -    POWERPC_DEF("603e_v4.1",     CPU_POWERPC_603E_v41,               603=
E,
> +    POWERPC_DEF("603E_V4.1",     CPU_POWERPC_603E_v41,               603=
E,
>                  "PowerPC 603e v4.1")
> -    POWERPC_DEF("603e7",         CPU_POWERPC_603E7,                  603=
E,
> +    POWERPC_DEF("603E7",         CPU_POWERPC_603E7,                  603=
E,
>                  "PowerPC 603e (aka PID7)")
> -    POWERPC_DEF("603e7t",        CPU_POWERPC_603E7t,                 603=
E,
> +    POWERPC_DEF("603E7T",        CPU_POWERPC_603E7t,                 603=
E,
>                  "PowerPC 603e7t")
> -    POWERPC_DEF("603e7v",        CPU_POWERPC_603E7v,                 603=
E,
> +    POWERPC_DEF("603E7V",        CPU_POWERPC_603E7v,                 603=
E,
>                  "PowerPC 603e7v")
> -    POWERPC_DEF("603e7v1",       CPU_POWERPC_603E7v1,                603=
E,
> +    POWERPC_DEF("603E7V1",       CPU_POWERPC_603E7v1,                603=
E,
>                  "PowerPC 603e7v1")
> -    POWERPC_DEF("603e7v2",       CPU_POWERPC_603E7v2,                603=
E,
> +    POWERPC_DEF("603E7V2",       CPU_POWERPC_603E7v2,                603=
E,
>                  "PowerPC 603e7v2")
> -    POWERPC_DEF("603p",          CPU_POWERPC_603P,                   603=
E,
> +    POWERPC_DEF("603P",          CPU_POWERPC_603P,                   603=
E,
>                  "PowerPC 603p (aka PID7v)")
>      POWERPC_DEF("604",           CPU_POWERPC_604,                    604,
>                  "PowerPC 604")
> -    POWERPC_DEF("604e_v1.0",     CPU_POWERPC_604E_v10,               604=
E,
> +    POWERPC_DEF("604E_V1.0",     CPU_POWERPC_604E_v10,               604=
E,
>                  "PowerPC 604e v1.0")
> -    POWERPC_DEF("604e_v2.2",     CPU_POWERPC_604E_v22,               604=
E,
> +    POWERPC_DEF("604E_V2.2",     CPU_POWERPC_604E_v22,               604=
E,
>                  "PowerPC 604e v2.2")
> -    POWERPC_DEF("604e_v2.4",     CPU_POWERPC_604E_v24,               604=
E,
> +    POWERPC_DEF("604E_V2.4",     CPU_POWERPC_604E_v24,               604=
E,
>                  "PowerPC 604e v2.4")
> -    POWERPC_DEF("604r",          CPU_POWERPC_604R,                   604=
E,
> +    POWERPC_DEF("604R",          CPU_POWERPC_604R,                   604=
E,
>                  "PowerPC 604r (aka PIDA)")
>  #if defined(TODO)
> -    POWERPC_DEF("604ev",         CPU_POWERPC_604EV,                  604=
E,
> +    POWERPC_DEF("604EV",         CPU_POWERPC_604EV,                  604=
E,
>                  "PowerPC 604ev")
>  #endif
>      /* PowerPC 7xx family                                               =
     */
> -    POWERPC_DEF("740_v1.0",      CPU_POWERPC_7x0_v10,                740,
> +    POWERPC_DEF("740_V1.0",      CPU_POWERPC_7x0_v10,                740,
>                  "PowerPC 740 v1.0 (G3)")
> -    POWERPC_DEF("750_v1.0",      CPU_POWERPC_7x0_v10,                750,
> +    POWERPC_DEF("750_V1.0",      CPU_POWERPC_7x0_v10,                750,
>                  "PowerPC 750 v1.0 (G3)")
> -    POWERPC_DEF("740_v2.0",      CPU_POWERPC_7x0_v20,                740,
> +    POWERPC_DEF("740_V2.0",      CPU_POWERPC_7x0_v20,                740,
>                  "PowerPC 740 v2.0 (G3)")
> -    POWERPC_DEF("750_v2.0",      CPU_POWERPC_7x0_v20,                750,
> +    POWERPC_DEF("750_V2.0",      CPU_POWERPC_7x0_v20,                750,
>                  "PowerPC 750 v2.0 (G3)")
> -    POWERPC_DEF("740_v2.1",      CPU_POWERPC_7x0_v21,                740,
> +    POWERPC_DEF("740_V2.1",      CPU_POWERPC_7x0_v21,                740,
>                  "PowerPC 740 v2.1 (G3)")
> -    POWERPC_DEF("750_v2.1",      CPU_POWERPC_7x0_v21,                750,
> +    POWERPC_DEF("750_V2.1",      CPU_POWERPC_7x0_v21,                750,
>                  "PowerPC 750 v2.1 (G3)")
> -    POWERPC_DEF("740_v2.2",      CPU_POWERPC_7x0_v22,                740,
> +    POWERPC_DEF("740_V2.2",      CPU_POWERPC_7x0_v22,                740,
>                  "PowerPC 740 v2.2 (G3)")
> -    POWERPC_DEF("750_v2.2",      CPU_POWERPC_7x0_v22,                750,
> +    POWERPC_DEF("750_V2.2",      CPU_POWERPC_7x0_v22,                750,
>                  "PowerPC 750 v2.2 (G3)")
> -    POWERPC_DEF("740_v3.0",      CPU_POWERPC_7x0_v30,                740,
> +    POWERPC_DEF("740_V3.0",      CPU_POWERPC_7x0_v30,                740,
>                  "PowerPC 740 v3.0 (G3)")
> -    POWERPC_DEF("750_v3.0",      CPU_POWERPC_7x0_v30,                750,
> +    POWERPC_DEF("750_V3.0",      CPU_POWERPC_7x0_v30,                750,
>                  "PowerPC 750 v3.0 (G3)")
> -    POWERPC_DEF("740_v3.1",      CPU_POWERPC_7x0_v31,                740,
> +    POWERPC_DEF("740_V3.1",      CPU_POWERPC_7x0_v31,                740,
>                  "PowerPC 740 v3.1 (G3)")
> -    POWERPC_DEF("750_v3.1",      CPU_POWERPC_7x0_v31,                750,
> +    POWERPC_DEF("750_V3.1",      CPU_POWERPC_7x0_v31,                750,
>                  "PowerPC 750 v3.1 (G3)")
> -    POWERPC_DEF("740e",          CPU_POWERPC_740E,                   740,
> +    POWERPC_DEF("740E",          CPU_POWERPC_740E,                   740,
>                  "PowerPC 740E (G3)")
> -    POWERPC_DEF("750e",          CPU_POWERPC_750E,                   750,
> +    POWERPC_DEF("750E",          CPU_POWERPC_750E,                   750,
>                  "PowerPC 750E (G3)")
> -    POWERPC_DEF("740p",          CPU_POWERPC_7x0P,                   740,
> +    POWERPC_DEF("740P",          CPU_POWERPC_7x0P,                   740,
>                  "PowerPC 740P (G3)")
> -    POWERPC_DEF("750p",          CPU_POWERPC_7x0P,                   750,
> +    POWERPC_DEF("750P",          CPU_POWERPC_7x0P,                   750,
>                  "PowerPC 750P (G3)")
> -    POWERPC_DEF("750cl_v1.0",    CPU_POWERPC_750CL_v10,              750=
cl,
> +    POWERPC_DEF("750CL_V1.0",    CPU_POWERPC_750CL_v10,              750=
cl,
>                  "PowerPC 750CL v1.0")
> -    POWERPC_DEF("750cl_v2.0",    CPU_POWERPC_750CL_v20,              750=
cl,
> +    POWERPC_DEF("750CL_V2.0",    CPU_POWERPC_750CL_v20,              750=
cl,
>                  "PowerPC 750CL v2.0")
> -    POWERPC_DEF("750cx_v1.0",    CPU_POWERPC_750CX_v10,              750=
cx,
> +    POWERPC_DEF("750CX_V1.0",    CPU_POWERPC_750CX_v10,              750=
cx,
>                  "PowerPC 750CX v1.0 (G3 embedded)")
> -    POWERPC_DEF("750cx_v2.0",    CPU_POWERPC_750CX_v20,              750=
cx,
> +    POWERPC_DEF("750CX_V2.0",    CPU_POWERPC_750CX_v20,              750=
cx,
>                  "PowerPC 750CX v2.1 (G3 embedded)")
> -    POWERPC_DEF("750cx_v2.1",    CPU_POWERPC_750CX_v21,              750=
cx,
> +    POWERPC_DEF("750CX_V2.1",    CPU_POWERPC_750CX_v21,              750=
cx,
>                  "PowerPC 750CX v2.1 (G3 embedded)")
> -    POWERPC_DEF("750cx_v2.2",    CPU_POWERPC_750CX_v22,              750=
cx,
> +    POWERPC_DEF("750CX_V2.2",    CPU_POWERPC_750CX_v22,              750=
cx,
>                  "PowerPC 750CX v2.2 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v2.1",   CPU_POWERPC_750CXE_v21,             750=
cx,
> +    POWERPC_DEF("750CXE_V2.1",   CPU_POWERPC_750CXE_v21,             750=
cx,
>                  "PowerPC 750CXe v2.1 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v2.2",   CPU_POWERPC_750CXE_v22,             750=
cx,
> +    POWERPC_DEF("750CXE_V2.2",   CPU_POWERPC_750CXE_v22,             750=
cx,
>                  "PowerPC 750CXe v2.2 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v2.3",   CPU_POWERPC_750CXE_v23,             750=
cx,
> +    POWERPC_DEF("750CXE_V2.3",   CPU_POWERPC_750CXE_v23,             750=
cx,
>                  "PowerPC 750CXe v2.3 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v2.4",   CPU_POWERPC_750CXE_v24,             750=
cx,
> +    POWERPC_DEF("750CXE_V2.4",   CPU_POWERPC_750CXE_v24,             750=
cx,
>                  "PowerPC 750CXe v2.4 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v2.4b",  CPU_POWERPC_750CXE_v24b,            750=
cx,
> +    POWERPC_DEF("750CXE_V2.4B",  CPU_POWERPC_750CXE_v24b,            750=
cx,
>                  "PowerPC 750CXe v2.4b (G3 embedded)")
> -    POWERPC_DEF("750cxe_v3.0",   CPU_POWERPC_750CXE_v30,             750=
cx,
> +    POWERPC_DEF("750CXE_V3.0",   CPU_POWERPC_750CXE_v30,             750=
cx,
>                  "PowerPC 750CXe v3.0 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v3.1",   CPU_POWERPC_750CXE_v31,             750=
cx,
> +    POWERPC_DEF("750CXE_V3.1",   CPU_POWERPC_750CXE_v31,             750=
cx,
>                  "PowerPC 750CXe v3.1 (G3 embedded)")
> -    POWERPC_DEF("750cxe_v3.1b",  CPU_POWERPC_750CXE_v31b,            750=
cx,
> +    POWERPC_DEF("750CXE_V3.1B",  CPU_POWERPC_750CXE_v31b,            750=
cx,
>                  "PowerPC 750CXe v3.1b (G3 embedded)")
> -    POWERPC_DEF("750cxr",        CPU_POWERPC_750CXR,                 750=
cx,
> +    POWERPC_DEF("750CXR",        CPU_POWERPC_750CXR,                 750=
cx,
>                  "PowerPC 750CXr (G3 embedded)")
> -    POWERPC_DEF("750fl",         CPU_POWERPC_750FL,                  750=
fx,
> +    POWERPC_DEF("750FL",         CPU_POWERPC_750FL,                  750=
fx,
>                  "PowerPC 750FL (G3 embedded)")
> -    POWERPC_DEF("750fx_v1.0",    CPU_POWERPC_750FX_v10,              750=
fx,
> +    POWERPC_DEF("750FX_V1.0",    CPU_POWERPC_750FX_v10,              750=
fx,
>                  "PowerPC 750FX v1.0 (G3 embedded)")
> -    POWERPC_DEF("750fx_v2.0",    CPU_POWERPC_750FX_v20,              750=
fx,
> +    POWERPC_DEF("750FX_V2.0",    CPU_POWERPC_750FX_v20,              750=
fx,
>                  "PowerPC 750FX v2.0 (G3 embedded)")
> -    POWERPC_DEF("750fx_v2.1",    CPU_POWERPC_750FX_v21,              750=
fx,
> +    POWERPC_DEF("750FX_V2.1",    CPU_POWERPC_750FX_v21,              750=
fx,
>                  "PowerPC 750FX v2.1 (G3 embedded)")
> -    POWERPC_DEF("750fx_v2.2",    CPU_POWERPC_750FX_v22,              750=
fx,
> +    POWERPC_DEF("750FX_V2.2",    CPU_POWERPC_750FX_v22,              750=
fx,
>                  "PowerPC 750FX v2.2 (G3 embedded)")
> -    POWERPC_DEF("750fx_v2.3",    CPU_POWERPC_750FX_v23,              750=
fx,
> +    POWERPC_DEF("750FX_V2.3",    CPU_POWERPC_750FX_v23,              750=
fx,
>                  "PowerPC 750FX v2.3 (G3 embedded)")
> -    POWERPC_DEF("750gl",         CPU_POWERPC_750GL,                  750=
gx,
> +    POWERPC_DEF("750GL",         CPU_POWERPC_750GL,                  750=
gx,
>                  "PowerPC 750GL (G3 embedded)")
> -    POWERPC_DEF("750gx_v1.0",    CPU_POWERPC_750GX_v10,              750=
gx,
> +    POWERPC_DEF("750GX_V1.0",    CPU_POWERPC_750GX_v10,              750=
gx,
>                  "PowerPC 750GX v1.0 (G3 embedded)")
> -    POWERPC_DEF("750gx_v1.1",    CPU_POWERPC_750GX_v11,              750=
gx,
> +    POWERPC_DEF("750GX_V1.1",    CPU_POWERPC_750GX_v11,              750=
gx,
>                  "PowerPC 750GX v1.1 (G3 embedded)")
> -    POWERPC_DEF("750gx_v1.2",    CPU_POWERPC_750GX_v12,              750=
gx,
> +    POWERPC_DEF("750GX_V1.2",    CPU_POWERPC_750GX_v12,              750=
gx,
>                  "PowerPC 750GX v1.2 (G3 embedded)")
> -    POWERPC_DEF("750l_v2.0",     CPU_POWERPC_750L_v20,               750,
> +    POWERPC_DEF("750L_V2.0",     CPU_POWERPC_750L_v20,               750,
>                  "PowerPC 750L v2.0 (G3 embedded)")
> -    POWERPC_DEF("750l_v2.1",     CPU_POWERPC_750L_v21,               750,
> +    POWERPC_DEF("750L_V2.1",     CPU_POWERPC_750L_v21,               750,
>                  "PowerPC 750L v2.1 (G3 embedded)")
> -    POWERPC_DEF("750l_v2.2",     CPU_POWERPC_750L_v22,               750,
> +    POWERPC_DEF("750L_V2.2",     CPU_POWERPC_750L_v22,               750,
>                  "PowerPC 750L v2.2 (G3 embedded)")
> -    POWERPC_DEF("750l_v3.0",     CPU_POWERPC_750L_v30,               750,
> +    POWERPC_DEF("750L_V3.0",     CPU_POWERPC_750L_v30,               750,
>                  "PowerPC 750L v3.0 (G3 embedded)")
> -    POWERPC_DEF("750l_v3.2",     CPU_POWERPC_750L_v32,               750,
> +    POWERPC_DEF("750L_V3.2",     CPU_POWERPC_750L_v32,               750,
>                  "PowerPC 750L v3.2 (G3 embedded)")
> -    POWERPC_DEF("745_v1.0",      CPU_POWERPC_7x5_v10,                745,
> +    POWERPC_DEF("745_V1.0",      CPU_POWERPC_7x5_v10,                745,
>                  "PowerPC 745 v1.0")
> -    POWERPC_DEF("755_v1.0",      CPU_POWERPC_7x5_v10,                755,
> +    POWERPC_DEF("755_V1.0",      CPU_POWERPC_7x5_v10,                755,
>                  "PowerPC 755 v1.0")
> -    POWERPC_DEF("745_v1.1",      CPU_POWERPC_7x5_v11,                745,
> +    POWERPC_DEF("745_V1.1",      CPU_POWERPC_7x5_v11,                745,
>                  "PowerPC 745 v1.1")
> -    POWERPC_DEF("755_v1.1",      CPU_POWERPC_7x5_v11,                755,
> +    POWERPC_DEF("755_V1.1",      CPU_POWERPC_7x5_v11,                755,
>                  "PowerPC 755 v1.1")
> -    POWERPC_DEF("745_v2.0",      CPU_POWERPC_7x5_v20,                745,
> +    POWERPC_DEF("745_V2.0",      CPU_POWERPC_7x5_v20,                745,
>                  "PowerPC 745 v2.0")
> -    POWERPC_DEF("755_v2.0",      CPU_POWERPC_7x5_v20,                755,
> +    POWERPC_DEF("755_V2.0",      CPU_POWERPC_7x5_v20,                755,
>                  "PowerPC 755 v2.0")
> -    POWERPC_DEF("745_v2.1",      CPU_POWERPC_7x5_v21,                745,
> +    POWERPC_DEF("745_V2.1",      CPU_POWERPC_7x5_v21,                745,
>                  "PowerPC 745 v2.1")
> -    POWERPC_DEF("755_v2.1",      CPU_POWERPC_7x5_v21,                755,
> +    POWERPC_DEF("755_V2.1",      CPU_POWERPC_7x5_v21,                755,
>                  "PowerPC 755 v2.1")
> -    POWERPC_DEF("745_v2.2",      CPU_POWERPC_7x5_v22,                745,
> +    POWERPC_DEF("745_V2.2",      CPU_POWERPC_7x5_v22,                745,
>                  "PowerPC 745 v2.2")
> -    POWERPC_DEF("755_v2.2",      CPU_POWERPC_7x5_v22,                755,
> +    POWERPC_DEF("755_V2.2",      CPU_POWERPC_7x5_v22,                755,
>                  "PowerPC 755 v2.2")
> -    POWERPC_DEF("745_v2.3",      CPU_POWERPC_7x5_v23,                745,
> +    POWERPC_DEF("745_V2.3",      CPU_POWERPC_7x5_v23,                745,
>                  "PowerPC 745 v2.3")
> -    POWERPC_DEF("755_v2.3",      CPU_POWERPC_7x5_v23,                755,
> +    POWERPC_DEF("755_V2.3",      CPU_POWERPC_7x5_v23,                755,
>                  "PowerPC 755 v2.3")
> -    POWERPC_DEF("745_v2.4",      CPU_POWERPC_7x5_v24,                745,
> +    POWERPC_DEF("745_V2.4",      CPU_POWERPC_7x5_v24,                745,
>                  "PowerPC 745 v2.4")
> -    POWERPC_DEF("755_v2.4",      CPU_POWERPC_7x5_v24,                755,
> +    POWERPC_DEF("755_V2.4",      CPU_POWERPC_7x5_v24,                755,
>                  "PowerPC 755 v2.4")
> -    POWERPC_DEF("745_v2.5",      CPU_POWERPC_7x5_v25,                745,
> +    POWERPC_DEF("745_V2.5",      CPU_POWERPC_7x5_v25,                745,
>                  "PowerPC 745 v2.5")
> -    POWERPC_DEF("755_v2.5",      CPU_POWERPC_7x5_v25,                755,
> +    POWERPC_DEF("755_V2.5",      CPU_POWERPC_7x5_v25,                755,
>                  "PowerPC 755 v2.5")
> -    POWERPC_DEF("745_v2.6",      CPU_POWERPC_7x5_v26,                745,
> +    POWERPC_DEF("745_V2.6",      CPU_POWERPC_7x5_v26,                745,
>                  "PowerPC 745 v2.6")
> -    POWERPC_DEF("755_v2.6",      CPU_POWERPC_7x5_v26,                755,
> +    POWERPC_DEF("755_V2.6",      CPU_POWERPC_7x5_v26,                755,
>                  "PowerPC 755 v2.6")
> -    POWERPC_DEF("745_v2.7",      CPU_POWERPC_7x5_v27,                745,
> +    POWERPC_DEF("745_V2.7",      CPU_POWERPC_7x5_v27,                745,
>                  "PowerPC 745 v2.7")
> -    POWERPC_DEF("755_v2.7",      CPU_POWERPC_7x5_v27,                755,
> +    POWERPC_DEF("755_V2.7",      CPU_POWERPC_7x5_v27,                755,
>                  "PowerPC 755 v2.7")
> -    POWERPC_DEF("745_v2.8",      CPU_POWERPC_7x5_v28,                745,
> +    POWERPC_DEF("745_V2.8",      CPU_POWERPC_7x5_v28,                745,
>                  "PowerPC 745 v2.8")
> -    POWERPC_DEF("755_v2.8",      CPU_POWERPC_7x5_v28,                755,
> +    POWERPC_DEF("755_V2.8",      CPU_POWERPC_7x5_v28,                755,
>                  "PowerPC 755 v2.8")
>  #if defined(TODO)
> -    POWERPC_DEF("745p",          CPU_POWERPC_7x5P,                   745,
> +    POWERPC_DEF("745P",          CPU_POWERPC_7x5P,                   745,
>                  "PowerPC 745P (G3)")
> -    POWERPC_DEF("755p",          CPU_POWERPC_7x5P,                   755,
> +    POWERPC_DEF("755P",          CPU_POWERPC_7x5P,                   755,
>                  "PowerPC 755P (G3)")
>  #endif
>      /* PowerPC 74xx family                                              =
     */
> -    POWERPC_DEF("7400_v1.0",     CPU_POWERPC_7400_v10,               740=
0,
> +    POWERPC_DEF("7400_V1.0",     CPU_POWERPC_7400_v10,               740=
0,
>                  "PowerPC 7400 v1.0 (G4)")
> -    POWERPC_DEF("7400_v1.1",     CPU_POWERPC_7400_v11,               740=
0,
> +    POWERPC_DEF("7400_V1.1",     CPU_POWERPC_7400_v11,               740=
0,
>                  "PowerPC 7400 v1.1 (G4)")
> -    POWERPC_DEF("7400_v2.0",     CPU_POWERPC_7400_v20,               740=
0,
> +    POWERPC_DEF("7400_V2.0",     CPU_POWERPC_7400_v20,               740=
0,
>                  "PowerPC 7400 v2.0 (G4)")
> -    POWERPC_DEF("7400_v2.1",     CPU_POWERPC_7400_v21,               740=
0,
> +    POWERPC_DEF("7400_V2.1",     CPU_POWERPC_7400_v21,               740=
0,
>                  "PowerPC 7400 v2.1 (G4)")
> -    POWERPC_DEF("7400_v2.2",     CPU_POWERPC_7400_v22,               740=
0,
> +    POWERPC_DEF("7400_V2.2",     CPU_POWERPC_7400_v22,               740=
0,
>                  "PowerPC 7400 v2.2 (G4)")
> -    POWERPC_DEF("7400_v2.6",     CPU_POWERPC_7400_v26,               740=
0,
> +    POWERPC_DEF("7400_V2.6",     CPU_POWERPC_7400_v26,               740=
0,
>                  "PowerPC 7400 v2.6 (G4)")
> -    POWERPC_DEF("7400_v2.7",     CPU_POWERPC_7400_v27,               740=
0,
> +    POWERPC_DEF("7400_V2.7",     CPU_POWERPC_7400_v27,               740=
0,
>                  "PowerPC 7400 v2.7 (G4)")
> -    POWERPC_DEF("7400_v2.8",     CPU_POWERPC_7400_v28,               740=
0,
> +    POWERPC_DEF("7400_V2.8",     CPU_POWERPC_7400_v28,               740=
0,
>                  "PowerPC 7400 v2.8 (G4)")
> -    POWERPC_DEF("7400_v2.9",     CPU_POWERPC_7400_v29,               740=
0,
> +    POWERPC_DEF("7400_V2.9",     CPU_POWERPC_7400_v29,               740=
0,
>                  "PowerPC 7400 v2.9 (G4)")
> -    POWERPC_DEF("7410_v1.0",     CPU_POWERPC_7410_v10,               741=
0,
> +    POWERPC_DEF("7410_V1.0",     CPU_POWERPC_7410_v10,               741=
0,
>                  "PowerPC 7410 v1.0 (G4)")
> -    POWERPC_DEF("7410_v1.1",     CPU_POWERPC_7410_v11,               741=
0,
> +    POWERPC_DEF("7410_V1.1",     CPU_POWERPC_7410_v11,               741=
0,
>                  "PowerPC 7410 v1.1 (G4)")
> -    POWERPC_DEF("7410_v1.2",     CPU_POWERPC_7410_v12,               741=
0,
> +    POWERPC_DEF("7410_V1.2",     CPU_POWERPC_7410_v12,               741=
0,
>                  "PowerPC 7410 v1.2 (G4)")
> -    POWERPC_DEF("7410_v1.3",     CPU_POWERPC_7410_v13,               741=
0,
> +    POWERPC_DEF("7410_V1.3",     CPU_POWERPC_7410_v13,               741=
0,
>                  "PowerPC 7410 v1.3 (G4)")
> -    POWERPC_DEF("7410_v1.4",     CPU_POWERPC_7410_v14,               741=
0,
> +    POWERPC_DEF("7410_V1.4",     CPU_POWERPC_7410_v14,               741=
0,
>                  "PowerPC 7410 v1.4 (G4)")
> -    POWERPC_DEF("7448_v1.0",     CPU_POWERPC_7448_v10,               740=
0,
> +    POWERPC_DEF("7448_V1.0",     CPU_POWERPC_7448_v10,               740=
0,
>                  "PowerPC 7448 v1.0 (G4)")
> -    POWERPC_DEF("7448_v1.1",     CPU_POWERPC_7448_v11,               740=
0,
> +    POWERPC_DEF("7448_V1.1",     CPU_POWERPC_7448_v11,               740=
0,
>                  "PowerPC 7448 v1.1 (G4)")
> -    POWERPC_DEF("7448_v2.0",     CPU_POWERPC_7448_v20,               740=
0,
> +    POWERPC_DEF("7448_V2.0",     CPU_POWERPC_7448_v20,               740=
0,
>                  "PowerPC 7448 v2.0 (G4)")
> -    POWERPC_DEF("7448_v2.1",     CPU_POWERPC_7448_v21,               740=
0,
> +    POWERPC_DEF("7448_V2.1",     CPU_POWERPC_7448_v21,               740=
0,
>                  "PowerPC 7448 v2.1 (G4)")
> -    POWERPC_DEF("7450_v1.0",     CPU_POWERPC_7450_v10,               745=
0,
> +    POWERPC_DEF("7450_V1.0",     CPU_POWERPC_7450_v10,               745=
0,
>                  "PowerPC 7450 v1.0 (G4)")
> -    POWERPC_DEF("7450_v1.1",     CPU_POWERPC_7450_v11,               745=
0,
> +    POWERPC_DEF("7450_V1.1",     CPU_POWERPC_7450_v11,               745=
0,
>                  "PowerPC 7450 v1.1 (G4)")
> -    POWERPC_DEF("7450_v1.2",     CPU_POWERPC_7450_v12,               745=
0,
> +    POWERPC_DEF("7450_V1.2",     CPU_POWERPC_7450_v12,               745=
0,
>                  "PowerPC 7450 v1.2 (G4)")
> -    POWERPC_DEF("7450_v2.0",     CPU_POWERPC_7450_v20,               745=
0,
> +    POWERPC_DEF("7450_V2.0",     CPU_POWERPC_7450_v20,               745=
0,
>                  "PowerPC 7450 v2.0 (G4)")
> -    POWERPC_DEF("7450_v2.1",     CPU_POWERPC_7450_v21,               745=
0,
> +    POWERPC_DEF("7450_V2.1",     CPU_POWERPC_7450_v21,               745=
0,
>                  "PowerPC 7450 v2.1 (G4)")
> -    POWERPC_DEF("7441_v2.1",     CPU_POWERPC_7450_v21,               744=
0,
> +    POWERPC_DEF("7441_V2.1",     CPU_POWERPC_7450_v21,               744=
0,
>                  "PowerPC 7441 v2.1 (G4)")
> -    POWERPC_DEF("7441_v2.3",     CPU_POWERPC_74x1_v23,               744=
0,
> +    POWERPC_DEF("7441_V2.3",     CPU_POWERPC_74x1_v23,               744=
0,
>                  "PowerPC 7441 v2.3 (G4)")
> -    POWERPC_DEF("7451_v2.3",     CPU_POWERPC_74x1_v23,               745=
0,
> +    POWERPC_DEF("7451_V2.3",     CPU_POWERPC_74x1_v23,               745=
0,
>                  "PowerPC 7451 v2.3 (G4)")
> -    POWERPC_DEF("7441_v2.10",    CPU_POWERPC_74x1_v210,              744=
0,
> +    POWERPC_DEF("7441_V2.10",    CPU_POWERPC_74x1_v210,              744=
0,
>                  "PowerPC 7441 v2.10 (G4)")
> -    POWERPC_DEF("7451_v2.10",    CPU_POWERPC_74x1_v210,              745=
0,
> +    POWERPC_DEF("7451_V2.10",    CPU_POWERPC_74x1_v210,              745=
0,
>                  "PowerPC 7451 v2.10 (G4)")
> -    POWERPC_DEF("7445_v1.0",     CPU_POWERPC_74x5_v10,               744=
5,
> +    POWERPC_DEF("7445_V1.0",     CPU_POWERPC_74x5_v10,               744=
5,
>                  "PowerPC 7445 v1.0 (G4)")
> -    POWERPC_DEF("7455_v1.0",     CPU_POWERPC_74x5_v10,               745=
5,
> +    POWERPC_DEF("7455_V1.0",     CPU_POWERPC_74x5_v10,               745=
5,
>                  "PowerPC 7455 v1.0 (G4)")
> -    POWERPC_DEF("7445_v2.1",     CPU_POWERPC_74x5_v21,               744=
5,
> +    POWERPC_DEF("7445_V2.1",     CPU_POWERPC_74x5_v21,               744=
5,
>                  "PowerPC 7445 v2.1 (G4)")
> -    POWERPC_DEF("7455_v2.1",     CPU_POWERPC_74x5_v21,               745=
5,
> +    POWERPC_DEF("7455_V2.1",     CPU_POWERPC_74x5_v21,               745=
5,
>                  "PowerPC 7455 v2.1 (G4)")
> -    POWERPC_DEF("7445_v3.2",     CPU_POWERPC_74x5_v32,               744=
5,
> +    POWERPC_DEF("7445_V3.2",     CPU_POWERPC_74x5_v32,               744=
5,
>                  "PowerPC 7445 v3.2 (G4)")
> -    POWERPC_DEF("7455_v3.2",     CPU_POWERPC_74x5_v32,               745=
5,
> +    POWERPC_DEF("7455_V3.2",     CPU_POWERPC_74x5_v32,               745=
5,
>                  "PowerPC 7455 v3.2 (G4)")
> -    POWERPC_DEF("7445_v3.3",     CPU_POWERPC_74x5_v33,               744=
5,
> +    POWERPC_DEF("7445_V3.3",     CPU_POWERPC_74x5_v33,               744=
5,
>                  "PowerPC 7445 v3.3 (G4)")
> -    POWERPC_DEF("7455_v3.3",     CPU_POWERPC_74x5_v33,               745=
5,
> +    POWERPC_DEF("7455_V3.3",     CPU_POWERPC_74x5_v33,               745=
5,
>                  "PowerPC 7455 v3.3 (G4)")
> -    POWERPC_DEF("7445_v3.4",     CPU_POWERPC_74x5_v34,               744=
5,
> +    POWERPC_DEF("7445_V3.4",     CPU_POWERPC_74x5_v34,               744=
5,
>                  "PowerPC 7445 v3.4 (G4)")
> -    POWERPC_DEF("7455_v3.4",     CPU_POWERPC_74x5_v34,               745=
5,
> +    POWERPC_DEF("7455_V3.4",     CPU_POWERPC_74x5_v34,               745=
5,
>                  "PowerPC 7455 v3.4 (G4)")
> -    POWERPC_DEF("7447_v1.0",     CPU_POWERPC_74x7_v10,               744=
5,
> +    POWERPC_DEF("7447_V1.0",     CPU_POWERPC_74x7_v10,               744=
5,
>                  "PowerPC 7447 v1.0 (G4)")
> -    POWERPC_DEF("7457_v1.0",     CPU_POWERPC_74x7_v10,               745=
5,
> +    POWERPC_DEF("7457_V1.0",     CPU_POWERPC_74x7_v10,               745=
5,
>                  "PowerPC 7457 v1.0 (G4)")
> -    POWERPC_DEF("7447_v1.1",     CPU_POWERPC_74x7_v11,               744=
5,
> +    POWERPC_DEF("7447_V1.1",     CPU_POWERPC_74x7_v11,               744=
5,
>                  "PowerPC 7447 v1.1 (G4)")
> -    POWERPC_DEF("7457_v1.1",     CPU_POWERPC_74x7_v11,               745=
5,
> +    POWERPC_DEF("7457_V1.1",     CPU_POWERPC_74x7_v11,               745=
5,
>                  "PowerPC 7457 v1.1 (G4)")
> -    POWERPC_DEF("7457_v1.2",     CPU_POWERPC_74x7_v12,               745=
5,
> +    POWERPC_DEF("7457_V1.2",     CPU_POWERPC_74x7_v12,               745=
5,
>                  "PowerPC 7457 v1.2 (G4)")
> -    POWERPC_DEF("7447A_v1.0",    CPU_POWERPC_74x7A_v10,              744=
5,
> +    POWERPC_DEF("7447A_V1.0",    CPU_POWERPC_74x7A_v10,              744=
5,
>                  "PowerPC 7447A v1.0 (G4)")
> -    POWERPC_DEF("7457A_v1.0",    CPU_POWERPC_74x7A_v10,              745=
5,
> +    POWERPC_DEF("7457A_V1.0",    CPU_POWERPC_74x7A_v10,              745=
5,
>                  "PowerPC 7457A v1.0 (G4)")
> -    POWERPC_DEF("7447A_v1.1",    CPU_POWERPC_74x7A_v11,              744=
5,
> +    POWERPC_DEF("7447A_V1.1",    CPU_POWERPC_74x7A_v11,              744=
5,
>                  "PowerPC 7447A v1.1 (G4)")
> -    POWERPC_DEF("7457A_v1.1",    CPU_POWERPC_74x7A_v11,              745=
5,
> +    POWERPC_DEF("7457A_V1.1",    CPU_POWERPC_74x7A_v11,              745=
5,
>                  "PowerPC 7457A v1.1 (G4)")
> -    POWERPC_DEF("7447A_v1.2",    CPU_POWERPC_74x7A_v12,              744=
5,
> +    POWERPC_DEF("7447A_V1.2",    CPU_POWERPC_74x7A_v12,              744=
5,
>                  "PowerPC 7447A v1.2 (G4)")
> -    POWERPC_DEF("7457A_v1.2",    CPU_POWERPC_74x7A_v12,              745=
5,
> +    POWERPC_DEF("7457A_V1.2",    CPU_POWERPC_74x7A_v12,              745=
5,
>                  "PowerPC 7457A v1.2 (G4)")
>      /* 64 bits PowerPC                                                  =
     */
>  #if defined (TARGET_PPC64)
> @@ -1125,64 +1125,64 @@
>      POWERPC_DEF("POWER5",        CPU_POWERPC_POWER5,                 POW=
ER5,
>                  "POWER5")
>  #endif
> -    POWERPC_DEF("POWER5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POW=
ER5P,
> +    POWERPC_DEF("POWER5+_V2.1",  CPU_POWERPC_POWER5P_v21,            POW=
ER5P,
>                  "POWER5+ v2.1")
>  #if defined(TODO)
>      POWERPC_DEF("POWER6",        CPU_POWERPC_POWER6,                 POW=
ER6,
>                  "POWER6")
>  #endif
> -    POWERPC_DEF("POWER7_v2.3",   CPU_POWERPC_POWER7_v23,             POW=
ER7,
> +    POWERPC_DEF("POWER7_V2.3",   CPU_POWERPC_POWER7_v23,             POW=
ER7,
>                  "POWER7 v2.3")
> -    POWERPC_DEF("POWER7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POW=
ER7,
> +    POWERPC_DEF("POWER7+_V2.1",  CPU_POWERPC_POWER7P_v21,            POW=
ER7,
>                  "POWER7+ v2.1")
> -    POWERPC_DEF("POWER8E_v2.1",  CPU_POWERPC_POWER8E_v21,            POW=
ER8,
> +    POWERPC_DEF("POWER8E_V2.1",  CPU_POWERPC_POWER8E_v21,            POW=
ER8,
>                  "POWER8E v2.1")
> -    POWERPC_DEF("POWER8_v2.0",   CPU_POWERPC_POWER8_v20,             POW=
ER8,
> +    POWERPC_DEF("POWER8_V2.0",   CPU_POWERPC_POWER8_v20,             POW=
ER8,
>                  "POWER8 v2.0")
> -    POWERPC_DEF("POWER8NVL_v1.0",CPU_POWERPC_POWER8NVL_v10,          POW=
ER8,
> +    POWERPC_DEF("POWER8NVL_V1.0", CPU_POWERPC_POWER8NVL_v10,         POW=
ER8,
>                  "POWER8NVL v1.0")
> -    POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970,
> +    POWERPC_DEF("970_V2.2",      CPU_POWERPC_970_v22,                970,
>                  "PowerPC 970 v2.2")
> =20
> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,            POW=
ER9,
> +    POWERPC_DEF("POWER9_V1.0",   CPU_POWERPC_POWER9_BASE,            POW=
ER9,
>                  "POWER9 v1.0")
> =20
> -    POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970,
> +    POWERPC_DEF("970FX_V1.0",    CPU_POWERPC_970FX_v10,              970,
>                  "PowerPC 970FX v1.0 (G5)")
> -    POWERPC_DEF("970fx_v2.0",    CPU_POWERPC_970FX_v20,              970,
> +    POWERPC_DEF("970FX_V2.0",    CPU_POWERPC_970FX_v20,              970,
>                  "PowerPC 970FX v2.0 (G5)")
> -    POWERPC_DEF("970fx_v2.1",    CPU_POWERPC_970FX_v21,              970,
> +    POWERPC_DEF("970FX_V2.1",    CPU_POWERPC_970FX_v21,              970,
>                  "PowerPC 970FX v2.1 (G5)")
> -    POWERPC_DEF("970fx_v3.0",    CPU_POWERPC_970FX_v30,              970,
> +    POWERPC_DEF("970FX_V3.0",    CPU_POWERPC_970FX_v30,              970,
>                  "PowerPC 970FX v3.0 (G5)")
> -    POWERPC_DEF("970fx_v3.1",    CPU_POWERPC_970FX_v31,              970,
> +    POWERPC_DEF("970FX_V3.1",    CPU_POWERPC_970FX_v31,              970,
>                  "PowerPC 970FX v3.1 (G5)")
> -    POWERPC_DEF("970mp_v1.0",    CPU_POWERPC_970MP_v10,              970,
> +    POWERPC_DEF("970MP_V1.0",    CPU_POWERPC_970MP_v10,              970,
>                  "PowerPC 970MP v1.0")
> -    POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
> +    POWERPC_DEF("970MP_V1.1",    CPU_POWERPC_970MP_v11,              970,
>                  "PowerPC 970MP v1.1")
>  #if defined(TODO)
> -    POWERPC_DEF("Cell",          CPU_POWERPC_CELL,                   970,
> +    POWERPC_DEF("CELL",          CPU_POWERPC_CELL,                   970,
>                  "PowerPC Cell")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("Cell_v1.0",     CPU_POWERPC_CELL_v10,               970,
> +    POWERPC_DEF("CELL_V1.0",     CPU_POWERPC_CELL_v10,               970,
>                  "PowerPC Cell v1.0")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("Cell_v2.0",     CPU_POWERPC_CELL_v20,               970,
> +    POWERPC_DEF("CELL_V2.0",     CPU_POWERPC_CELL_v20,               970,
>                  "PowerPC Cell v2.0")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("Cell_v3.0",     CPU_POWERPC_CELL_v30,               970,
> +    POWERPC_DEF("CELL_V3.0",     CPU_POWERPC_CELL_v30,               970,
>                  "PowerPC Cell v3.0")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("Cell_v3.1",     CPU_POWERPC_CELL_v31,               970,
> +    POWERPC_DEF("CELL_V3.1",     CPU_POWERPC_CELL_v31,               970,
>                  "PowerPC Cell v3.1")
>  #endif
>  #if defined(TODO)
> -    POWERPC_DEF("Cell_v3.2",     CPU_POWERPC_CELL_v32,               970,
> +    POWERPC_DEF("CELL_V3.2",     CPU_POWERPC_CELL_v32,               970,
>                  "PowerPC Cell v3.2")
>  #endif
>  #if defined(TODO)
> @@ -1228,181 +1228,181 @@
>  PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "403", "403GC" },
>      { "405", "405D4" },
> -    { "405CR", "405CRc" },
> -    { "405GP", "405GPd" },
> -    { "405GPe", "405CRc" },
> -    { "x2vp7", "x2vp4" },
> -    { "x2vp50", "x2vp20" },
> +    { "405CR", "405CRC" },
> +    { "405GP", "405GPD" },
> +    { "405GPE", "405CRC" },
> +    { "X2VP7", "X2VP4" },
> +    { "X2VP50", "X2VP20" },
> =20
> -    { "440EP", "440EPb" },
> -    { "440GP", "440GPc" },
> -    { "440GR", "440GRa" },
> -    { "440GX", "440GXf" },
> +    { "440EP", "440EPB" },
> +    { "440GP", "440GPC" },
> +    { "440GR", "440GRA" },
> +    { "440GX", "440GXF" },
> =20
> -    { "RCPU", "MPC5xx" },
> +    { "RCPU", "MPC5XX" },
>      /* MPC5xx microcontrollers */
> -    { "MGT560", "MPC5xx" },
> -    { "MPC509", "MPC5xx" },
> -    { "MPC533", "MPC5xx" },
> -    { "MPC534", "MPC5xx" },
> -    { "MPC555", "MPC5xx" },
> -    { "MPC556", "MPC5xx" },
> -    { "MPC560", "MPC5xx" },
> -    { "MPC561", "MPC5xx" },
> -    { "MPC562", "MPC5xx" },
> -    { "MPC563", "MPC5xx" },
> -    { "MPC564", "MPC5xx" },
> -    { "MPC565", "MPC5xx" },
> -    { "MPC566", "MPC5xx" },
> +    { "MGT560", "MPC5XX" },
> +    { "MPC509", "MPC5XX" },
> +    { "MPC533", "MPC5XX" },
> +    { "MPC534", "MPC5XX" },
> +    { "MPC555", "MPC5XX" },
> +    { "MPC556", "MPC5XX" },
> +    { "MPC560", "MPC5XX" },
> +    { "MPC561", "MPC5XX" },
> +    { "MPC562", "MPC5XX" },
> +    { "MPC563", "MPC5XX" },
> +    { "MPC564", "MPC5XX" },
> +    { "MPC565", "MPC5XX" },
> +    { "MPC566", "MPC5XX" },
> =20
> -    { "PowerQUICC", "MPC8xx" },
> +    { "POWERQUICC", "MPC8XX" },
>      /* MPC8xx microcontrollers */
> -    { "MGT823", "MPC8xx" },
> -    { "MPC821", "MPC8xx" },
> -    { "MPC823", "MPC8xx" },
> -    { "MPC850", "MPC8xx" },
> -    { "MPC852T", "MPC8xx" },
> -    { "MPC855T", "MPC8xx" },
> -    { "MPC857", "MPC8xx" },
> -    { "MPC859", "MPC8xx" },
> -    { "MPC860", "MPC8xx" },
> -    { "MPC862", "MPC8xx" },
> -    { "MPC866", "MPC8xx" },
> -    { "MPC870", "MPC8xx" },
> -    { "MPC875", "MPC8xx" },
> -    { "MPC880", "MPC8xx" },
> -    { "MPC885", "MPC8xx" },
> +    { "MGT823", "MPC8XX" },
> +    { "MPC821", "MPC8XX" },
> +    { "MPC823", "MPC8XX" },
> +    { "MPC850", "MPC8XX" },
> +    { "MPC852T", "MPC8XX" },
> +    { "MPC855T", "MPC8XX" },
> +    { "MPC857", "MPC8XX" },
> +    { "MPC859", "MPC8XX" },
> +    { "MPC860", "MPC8XX" },
> +    { "MPC862", "MPC8XX" },
> +    { "MPC866", "MPC8XX" },
> +    { "MPC870", "MPC8XX" },
> +    { "MPC875", "MPC8XX" },
> +    { "MPC880", "MPC8XX" },
> +    { "MPC885", "MPC8XX" },
> =20
>      /* PowerPC MPC603 microcontrollers */
>      { "MPC8240", "603" },
> =20
> -    { "MPC52xx", "MPC5200" },
> -    { "MPC5200", "MPC5200_v12" },
> -    { "MPC5200B", "MPC5200B_v21" },
> +    { "MPC52XX", "MPC5200" },
> +    { "MPC5200", "MPC5200_V12" },
> +    { "MPC5200B", "MPC5200B_V21" },
> =20
> -    { "MPC82xx", "MPC8280" },
> -    { "PowerQUICC-II", "MPC82xx" },
> -    { "MPC8241", "G2HiP4" },
> -    { "MPC8245", "G2HiP4" },
> -    { "MPC8247", "G2leGP3" },
> -    { "MPC8248", "G2leGP3" },
> -    { "MPC8250", "MPC8250_HiP4" },
> -    { "MPC8250_HiP3", "G2HiP3" },
> -    { "MPC8250_HiP4", "G2HiP4" },
> -    { "MPC8255", "MPC8255_HiP4" },
> -    { "MPC8255_HiP3", "G2HiP3" },
> -    { "MPC8255_HiP4", "G2HiP4" },
> -    { "MPC8260", "MPC8260_HiP4" },
> -    { "MPC8260_HiP3", "G2HiP3" },
> -    { "MPC8260_HiP4", "G2HiP4" },
> -    { "MPC8264", "MPC8264_HiP4" },
> -    { "MPC8264_HiP3", "G2HiP3" },
> -    { "MPC8264_HiP4", "G2HiP4" },
> -    { "MPC8265", "MPC8265_HiP4" },
> -    { "MPC8265_HiP3", "G2HiP3" },
> -    { "MPC8265_HiP4", "G2HiP4" },
> -    { "MPC8266", "MPC8266_HiP4" },
> -    { "MPC8266_HiP3", "G2HiP3" },
> -    { "MPC8266_HiP4", "G2HiP4" },
> -    { "MPC8270", "G2leGP3" },
> -    { "MPC8271", "G2leGP3" },
> -    { "MPC8272", "G2leGP3" },
> -    { "MPC8275", "G2leGP3" },
> -    { "MPC8280", "G2leGP3" },
> -    { "e200", "e200z6" },
> -    { "e300", "e300c3" },
> +    { "MPC82XX", "MPC8280" },
> +    { "POWERQUICC-II", "MPC82XX" },
> +    { "MPC8241", "G2HIP4" },
> +    { "MPC8245", "G2HIP4" },
> +    { "MPC8247", "G2LEGP3" },
> +    { "MPC8248", "G2LEGP3" },
> +    { "MPC8250", "MPC8250_HIP4" },
> +    { "MPC8250_HIP3", "G2HIP3" },
> +    { "MPC8250_HIP4", "G2HIP4" },
> +    { "MPC8255", "MPC8255_HIP4" },
> +    { "MPC8255_HIP3", "G2HIP3" },
> +    { "MPC8255_HIP4", "G2HIP4" },
> +    { "MPC8260", "MPC8260_HIP4" },
> +    { "MPC8260_HIP3", "G2HIP3" },
> +    { "MPC8260_HIP4", "G2HIP4" },
> +    { "MPC8264", "MPC8264_HIP4" },
> +    { "MPC8264_HIP3", "G2HIP3" },
> +    { "MPC8264_HIP4", "G2HIP4" },
> +    { "MPC8265", "MPC8265_HIP4" },
> +    { "MPC8265_HIP3", "G2HIP3" },
> +    { "MPC8265_HIP4", "G2HIP4" },
> +    { "MPC8266", "MPC8266_HIP4" },
> +    { "MPC8266_HIP3", "G2HIP3" },
> +    { "MPC8266_HIP4", "G2HIP4" },
> +    { "MPC8270", "G2LEGP3" },
> +    { "MPC8271", "G2LEGP3" },
> +    { "MPC8272", "G2LEGP3" },
> +    { "MPC8275", "G2LEGP3" },
> +    { "MPC8280", "G2LEGP3" },
> +    { "E200", "E200Z6" },
> +    { "E300", "E300C3" },
>      { "MPC8347", "MPC8347T" },
>      { "MPC8347A", "MPC8347AT" },
>      { "MPC8347E", "MPC8347ET" },
>      { "MPC8347EA", "MPC8347EAT" },
> -    { "e500", "e500v2_v22" },
> -    { "e500v1", "e500_v20" },
> -    { "e500v2", "e500v2_v22" },
> -    { "MPC8533", "MPC8533_v11" },
> -    { "MPC8533E", "MPC8533E_v11" },
> -    { "MPC8540", "MPC8540_v21" },
> -    { "MPC8541", "MPC8541_v11" },
> -    { "MPC8541E", "MPC8541E_v11" },
> -    { "MPC8543", "MPC8543_v21" },
> -    { "MPC8543E", "MPC8543E_v21" },
> -    { "MPC8544", "MPC8544_v11" },
> -    { "MPC8544E", "MPC8544E_v11" },
> -    { "MPC8545", "MPC8545_v21" },
> -    { "MPC8545E", "MPC8545E_v21" },
> -    { "MPC8547E", "MPC8547E_v21" },
> -    { "MPC8548", "MPC8548_v21" },
> -    { "MPC8548E", "MPC8548E_v21" },
> -    { "MPC8555", "MPC8555_v11" },
> -    { "MPC8555E", "MPC8555E_v11" },
> -    { "MPC8560", "MPC8560_v21" },
> -    { "601",  "601_v2" },
> -    { "601v", "601_v2" },
> -    { "Vanilla", "603" },
> -    { "603e", "603e_v4.1" },
> -    { "Stretch", "603e" },
> -    { "Vaillant", "603e7v" },
> -    { "603r", "603e7t" },
> -    { "Goldeneye", "603r" },
> -    { "604e", "604e_v2.4" },
> -    { "Sirocco", "604e" },
> -    { "Mach5", "604r" },
> -    { "740", "740_v3.1" },
> -    { "Arthur", "740" },
> -    { "750", "750_v3.1" },
> -    { "Typhoon", "750" },
> +    { "E500", "E500V2_V22" },
> +    { "E500V1", "E500_V20" },
> +    { "E500V2", "E500V2_V22" },
> +    { "MPC8533", "MPC8533_V11" },
> +    { "MPC8533E", "MPC8533E_V11" },
> +    { "MPC8540", "MPC8540_V21" },
> +    { "MPC8541", "MPC8541_V11" },
> +    { "MPC8541E", "MPC8541E_V11" },
> +    { "MPC8543", "MPC8543_V21" },
> +    { "MPC8543E", "MPC8543E_V21" },
> +    { "MPC8544", "MPC8544_V11" },
> +    { "MPC8544E", "MPC8544E_V11" },
> +    { "MPC8545", "MPC8545_V21" },
> +    { "MPC8545E", "MPC8545E_V21" },
> +    { "MPC8547E", "MPC8547E_V21" },
> +    { "MPC8548", "MPC8548_V21" },
> +    { "MPC8548E", "MPC8548E_V21" },
> +    { "MPC8555", "MPC8555_V11" },
> +    { "MPC8555E", "MPC8555E_V11" },
> +    { "MPC8560", "MPC8560_V21" },
> +    { "601",  "601_V2" },
> +    { "601V", "601_V2" },
> +    { "VANILLA", "603" },
> +    { "603E", "603E_V4.1" },
> +    { "STRETCH", "603E" },
> +    { "VAILLANT", "603E7V" },
> +    { "603R", "603E7T" },
> +    { "GOLDENEYE", "603R" },
> +    { "604E", "604E_V2.4" },
> +    { "SIROCCO", "604E" },
> +    { "MACH5", "604R" },
> +    { "740", "740_V3.1" },
> +    { "ARTHUR", "740" },
> +    { "750", "750_V3.1" },
> +    { "TYPHOON", "750" },
>      { "G3",      "750" },
> -    { "Conan/Doyle", "750p" },
> -    { "750cl", "750cl_v2.0" },
> -    { "750cx", "750cx_v2.2" },
> -    { "750cxe", "750cxe_v3.1b" },
> -    { "750fx", "750fx_v2.3" },
> -    { "750gx", "750gx_v1.2" },
> -    { "750l", "750l_v3.2" },
> -    { "LoneStar", "750l" },
> -    { "745", "745_v2.8" },
> -    { "755", "755_v2.8" },
> -    { "Goldfinger", "755" },
> -    { "7400", "7400_v2.9" },
> -    { "Max", "7400" },
> +    { "CONAN/DOYLE", "750P" },
> +    { "750CL", "750CL_V2.0" },
> +    { "750CX", "750CX_V2.2" },
> +    { "750CXE", "750CXE_V3.1B" },
> +    { "750FX", "750FX_V2.3" },
> +    { "750GX", "750GX_V1.2" },
> +    { "750L", "750L_V3.2" },
> +    { "LONESTAR", "750L" },
> +    { "745", "745_V2.8" },
> +    { "755", "755_V2.8" },
> +    { "GOLDFINGER", "755" },
> +    { "7400", "7400_V2.9" },
> +    { "MAX", "7400" },
>      { "G4",  "7400" },
> -    { "7410", "7410_v1.4" },
> -    { "Nitro", "7410" },
> -    { "7448", "7448_v2.1" },
> -    { "7450", "7450_v2.1" },
> -    { "Vger", "7450" },
> -    { "7441", "7441_v2.3" },
> -    { "7451", "7451_v2.3" },
> -    { "7445", "7445_v3.2" },
> -    { "7455", "7455_v3.2" },
> -    { "Apollo6", "7455" },
> -    { "7447", "7447_v1.1" },
> -    { "7457", "7457_v1.2" },
> -    { "Apollo7", "7457" },
> -    { "7447A", "7447A_v1.2" },
> -    { "7457A", "7457A_v1.2" },
> -    { "Apollo7PM", "7457A_v1.0" },
> +    { "7410", "7410_V1.4" },
> +    { "NITRO", "7410" },
> +    { "7448", "7448_V2.1" },
> +    { "7450", "7450_V2.1" },
> +    { "VGER", "7450" },
> +    { "7441", "7441_V2.3" },
> +    { "7451", "7451_V2.3" },
> +    { "7445", "7445_V3.2" },
> +    { "7455", "7455_V3.2" },
> +    { "APOLLO6", "7455" },
> +    { "7447", "7447_V1.1" },
> +    { "7457", "7457_V1.2" },
> +    { "APOLLO7", "7457" },
> +    { "7447A", "7447A_V1.2" },
> +    { "7457A", "7457A_V1.2" },
> +    { "APOLLO7PM", "7457A_V1.0" },
>  #if defined(TARGET_PPC64)
>      { "POWER3", "630" },
>      { "POWER3+", "631" },
> -    { "POWER5+", "POWER5+_v2.1" },
> -    { "POWER5gs", "POWER5+_v2.1" },
> -    { "POWER7", "POWER7_v2.3" },
> -    { "POWER7+", "POWER7+_v2.1" },
> -    { "POWER8E", "POWER8E_v2.1" },
> -    { "POWER8", "POWER8_v2.0" },
> -    { "POWER8NVL", "POWER8NVL_v1.0" },
> -    { "POWER9", "POWER9_v1.0" },
> -    { "970", "970_v2.2" },
> -    { "970fx", "970fx_v3.1" },
> -    { "970mp", "970mp_v1.1" },
> +    { "POWER5+", "POWER5+_V2.1" },
> +    { "POWER5GS", "POWER5+_V2.1" },
> +    { "POWER7", "POWER7_V2.3" },
> +    { "POWER7+", "POWER7+_V2.1" },
> +    { "POWER8E", "POWER8E_V2.1" },
> +    { "POWER8", "POWER8_V2.0" },
> +    { "POWER8NVL", "POWER8NVL_V1.0" },
> +    { "POWER9", "POWER9_V1.0" },
> +    { "970", "970_V2.2" },
> +    { "970FX", "970FX_V3.1" },
> +    { "970MP", "970MP_V1.1" },
>  #endif
> =20
>      /* Generic PowerPCs */
>  #if defined(TARGET_PPC64)
> -    { "ppc64", "970fx" },
> +    { "PPC64", "970FX" },
>  #endif
> -    { "ppc32", "604" },
> -    { "ppc", "ppc32" },
> -    { "default", "ppc" },
> +    { "PPC32", "604" },
> +    { "PPC", "PPC32" },
> +    { "DEFAULT", "PPC" },
>      { NULL, NULL }
>  };
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8590809..3f21190 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2480,7 +2480,7 @@ static int kvm_ppc_register_host_cpu_type(void)
>       */
>      dc =3D DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>      for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> -        if (strcmp(ppc_cpu_aliases[i].alias, dc->desc) =3D=3D 0) {
> +        if (strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) =3D=3D 0) {
>              char *suffix;
> =20
>              ppc_cpu_aliases[i].model =3D g_strdup(object_class_get_name(=
oc));
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index f377cf2..0325226 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10250,7 +10250,7 @@ static ObjectClass *ppc_cpu_class_by_name(const c=
har *name)
>      }
> =20
>      for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> -        if (strcmp(ppc_cpu_aliases[i].alias, name) =3D=3D 0) {
> +        if (strcasecmp(ppc_cpu_aliases[i].alias, name) =3D=3D 0) {
>              return ppc_cpu_class_by_alias(&ppc_cpu_aliases[i]);
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s33OSBZCP+C8M/FY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmff4oACgkQbDjKyiDZ
s5KC7xAA0FLMOgfTmJ0xAobWD+/sfBmBN702mxSJDFcNBMXxfNbQc8CTSfAvS4H6
4eEhTGCRPfwcvTF4p+flaDvaBCkRW2pskjFTICJdufzZCYNqM/czAg2xWHVrcMut
R1GoYwZX/QYuLmBim94EcNtIwsv46QCJ9M38knAKKGVOArlpHIrUdWRaU0X9/XT8
IjiMJQPqTzdP2NDuvg8ZmYRgWIIrJjGIpPPVFlAzXtFE54lvg3507zAhypzCLXZf
1l78dMhG20RnMDhBA03jzEALtcKl8IwMb4LAmdKnC+h/kN0XsAAzRmRbqnmmjF+X
ReNYqZ/bjyWWNPVyVJTwAUZbP6BAJi7RdY64ES1OOj6N0Hq3XZu7VZGA4e+KGB6J
n61Hu9HrxAd+9CVfnmGSFmQ1YnHIx+/fovgn2xu2IdLzTqOoR2/LBTE3GB4VFCdz
QYn2/dRUSUNHORKVdA11J/sKXnZNU+F2n9ubJ9+DputpLji/mAFqR3oGTgoSd4s4
MwOPRuqJ8zTxPluQNJ9t/6tWIav+V20UbNrND1CW+H2b1CLgaEH0Y7J7dKEnScev
XAV1sHDWaJLPMLQfdZ6W6QOEWkQeNI1V60f0Z+/T1c7EMXKt8JPC+tlN84da8icf
SVdwu5RQfj68gfQWk7FpP2/oqJMhyxfbXblLUMkEOjwD2gKLPCY=
=Mosz
-----END PGP SIGNATURE-----

--s33OSBZCP+C8M/FY--
