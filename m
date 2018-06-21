Received: from eggs.gnu.org ([2001:4830:134:3::10]:34764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVoF5-0006FX-0i
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVoF1-0000CQ-PW
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:18:31 -0400
Date: Thu, 21 Jun 2018 11:18:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621011809.GD32328@umbus.fritz.box>
References: <152949925592.606785.4717120428688653960.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <152949925592.606785.4717120428688653960.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 02:54:15PM +0200, Greg Kurz wrote:
> The spapr capability framework was introduced in QEMU 2.12. It allows
> to have an explicit control on how host features are exposed to the
> guest. This is especially needed to handle migration between hetero-
> geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> workarounds against speculative execution vulnerabilities to guests.
> The framework was hence backported to QEMU 2.11.1, especially these
> commits:
>=20
> 0fac4aa93074 spapr: Add pseries-2.12 machine type
> 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
>  optional capability
>=20
> 0fac4aa93074 has the confusing effect of making pseries-2.12 the default
> machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
> patch changes the default machine back to pseries-2.11.
>=20
> Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11
> to be enabled by default, ie, when not passing cap-htm on the command
> line. This breaks several 'make check' testcases that run qemu-system-ppc=
64
> with TCG.
>=20
> The only sane way to fix this is to adapt the impacted testcases so that
> they all pass cap-htm=3Doff in this case. This patch does that as well.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - have the testcases to pass cap-htm=3Doff instead of violating the
>       capabilities logic.
>=20
> Upstream doesn't need anything like that since newer pseries machine types
> start with HTM disabled by default. This is really a oneshot fix for 2.11=
=2E2,
> and I've tried to make it as small as possible.
>=20
> This is a full replacement of the previous version. It is based on Mike's
> staging tree for 2.11:

Thanks for fixing this up

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Btw, 2.11.z should probably have the 2.12 machine type removed
entirely, as well as (obviously) not being the default.  Not within
scope for this patch, though.

>=20
> https://github.com/mdroth/qemu/commits/stable-2.11-staging 72cc467aabd1a2
> ---
>  hw/ppc/spapr.c           |    4 ++--
>  tests/boot-serial-test.c |    8 ++++++--
>  tests/migration-test.c   |    4 ++--
>  tests/prom-env-test.c    |    6 ++++--
>  tests/pxe-test.c         |   10 +++++++---
>  5 files changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1a2dd1f597d9..6499a867520f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
>      /* Defaults for the latest behaviour inherited from the base class */
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> +DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> =20
>  /*
>   * pseries-2.11
> @@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> =20
>  /*
>   * pseries-2.10
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index c935d69824bd..98c5462377f8 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -73,18 +73,22 @@ static void test_machine(const void *data)
>      const testdef_t *test =3D data;
>      char tmpname[] =3D "/tmp/qtest-boot-serial-XXXXXX";
>      int fd;
> +    const char *machine_props;
> =20
>      fd =3D mkstemp(tmpname);
>      g_assert(fd !=3D -1);
> =20
> +    machine_props =3D strcmp(test->machine, "pseries") =3D=3D 0 ? ",cap-=
htm=3Doff" : "";
> +
>      /*
>       * Make sure that this test uses tcg if available: It is used as a
>       * fast-enough smoketest for that.
>       */
> -    global_qtest =3D qtest_startf("-M %s,accel=3Dtcg:kvm "
> +    global_qtest =3D qtest_startf("-M %s%s,accel=3Dtcg:kvm "
>                                  "-chardev file,id=3Dserial0,path=3D%s "
>                                  "-no-shutdown -serial chardev:serial0 %s=
",
> -                                test->machine, tmpname, test->extra);
> +                                test->machine, machine_props, tmpname,
> +                                test->extra);
>      unlink(tmpname);
> =20
>      check_guest_output(test, fd);
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index be598d3257ba..906d29b38241 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -460,12 +460,12 @@ static void test_migrate_start(QTestState **from, Q=
TestState **to,
>          /* On ppc64, the test only works with kvm-hv, but not with kvm-p=
r */
>          accel =3D access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";
>          init_bootfile_ppc(bootpath);
> -        cmd_src =3D g_strdup_printf("-machine accel=3D%s -m 256M"
> +        cmd_src =3D g_strdup_printf("-machine accel=3D%s,cap-htm=3Doff -=
m 256M"
>                                    " -name pcsource,debug-threads=3Don"
>                                    " -serial file:%s/src_serial"
>                                    " -drive file=3D%s,if=3Dpflash,format=
=3Draw",
>                                    accel, tmpfs, bootpath);
> -        cmd_dst =3D g_strdup_printf("-machine accel=3D%s -m 256M"
> +        cmd_dst =3D g_strdup_printf("-machine accel=3D%s,cap-htm=3Doff -=
m 256M"
>                                    " -name pcdest,debug-threads=3Don"
>                                    " -serial file:%s/dest_serial"
>                                    " -incoming %s",
> diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
> index 8c867e631ab6..f6946090d183 100644
> --- a/tests/prom-env-test.c
> +++ b/tests/prom-env-test.c
> @@ -45,14 +45,16 @@ static void check_guest_memory(void)
>  static void test_machine(const void *machine)
>  {
>      const char *extra_args;
> +    const char *extra_props;
> =20
>      /* The pseries firmware boots much faster without the default device=
s */
>      extra_args =3D strcmp(machine, "pseries") =3D=3D 0 ? "-nodefaults" :=
 "";
> +    extra_props =3D strcmp(machine, "pseries") =3D=3D 0 ? ",cap-htm=3Dof=
f" : "";
> =20
> -    global_qtest =3D qtest_startf("-M %s,accel=3Dtcg %s "
> +    global_qtest =3D qtest_startf("-M %s%s,accel=3Dtcg %s "
>                                  "-prom-env 'use-nvramrc?=3Dtrue' "
>                                  "-prom-env 'nvramrc=3D%x %x l!' ",
> -                                (const char *)machine, extra_args,
> +                                (const char *)machine, extra_props, extr=
a_args,
>                                  MAGIC, ADDRESS);
>      check_guest_memory();
>      qtest_quit(global_qtest);
> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> index 937f29e63193..f3a65bd80cb1 100644
> --- a/tests/pxe-test.c
> +++ b/tests/pxe-test.c
> @@ -25,11 +25,15 @@ static char disk[] =3D "tests/pxe-test-disk-XXXXXX";
>  static void test_pxe_one(const char *params, bool ipv6)
>  {
>      char *args;
> +    const char *machine_props;
> =20
> -    args =3D g_strdup_printf("-machine accel=3Dkvm:tcg -nodefaults -boot=
 order=3Dn "
> +    machine_props =3D
> +        strcmp(qtest_get_arch(), "ppc64") =3D=3D 0 ? ",cap-htm=3Doff" : =
"";
> +
> +    args =3D g_strdup_printf("-machine accel=3Dkvm:tcg%s -nodefaults -bo=
ot order=3Dn "
>                             "-netdev user,id=3D" NETNAME ",tftp=3D./,boot=
file=3D%s,"
> -                           "ipv4=3D%s,ipv6=3D%s %s", disk, ipv6 ? "off" =
: "on",
> -                           ipv6 ? "on" : "off", params);
> +                           "ipv4=3D%s,ipv6=3D%s %s", machine_props, disk,
> +                           ipv6 ? "off" : "on", ipv6 ? "on" : "off", par=
ams);
> =20
>      qtest_start(args);
>      boot_sector_test();
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsq/NEACgkQbDjKyiDZ
s5J1NA/+Ol1bDL7uNz6Uy/2H5OxlFebD5EhBHwxVLfWFvOKIpS/LgmboYf4TyrPK
ecOXFMmJFI2PGavKb74Z0ftblYiEpRtiNGN9YPsoCuZwsscbCB6Bn6wW98YM8oZz
zD/JkZQrc++ptzqHli3Tzh0fbxl5+W1Fi53NfC7nrgTq0OqVWCiZ3kCS8EihjsUJ
wHtvyf2PAhXwsZxTt7tC1leSIcQSF/5sLERQ99pyMKFTLqPJvEMiKxmiRAjpAoEq
Po9LyfIMy4OkGMkpfFLc+zqVz7tReDGkVeDwoSyJ8pPioKAf8zfNfgYZ9B7lUeOC
Mkx87VcNDUTiAo6Xa5YgarIRedtysdD+BfA/jTkRU3Evvw6J/BuKnMoTurYvbDPH
6Ak14YrfK4i+Vi85AzLlRdnmfv1aVvws3DCJ3lPuYyIYwU+Vv28Sc3dA6JzPaoQT
ryLQEWjkCaRSHL0w7B8N28B6aweCwVJ6m6FWGujpxJLoUTISj4hta5XPtewnZKrX
XWB6BMtiRjMVv1CWZZ9qmM7TRMLNQLUeIeDWFYHz9GuS7IjLvTKBYwE+MhXYT1XV
I4sy4xqnTT9ARiddy55ik7d07L83jUO4mKkH7lCejQcLMydHhuL34XgPxqylfiRJ
z+KHBER5BfIhcRbSpitCTN4Ti7IjWXDtSLh8pJDqZNiV7QobaBM=
=gy6B
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
