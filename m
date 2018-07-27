Received: from eggs.gnu.org ([2001:4830:134:3::10]:43122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fivNf-00053O-Ak
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fivNb-0003Ng-8d
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:33:35 -0400
Received: from ozlabs.org ([203.11.71.1]:43289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fivNa-0003Kp-AZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 01:33:31 -0400
Date: Fri, 27 Jul 2018 15:27:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727052724.GJ3694@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Content-Disposition: inline
In-Reply-To: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-3.1] tests/cpu-plug-test: check CPU
 hotplug on ppc64 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote:
> Commit b585395b655 fixed a regression introduced by some recent changes
> in the XICS code, that was causing QEMU to crash instantly during CPU
> hotplug with KVM. This is typically the kind of bug we'd like our
> test suite to detect before it gets merged. Unfortunately, the current
> tests run with '-machine accel=3Dqtest' and don't exercise KVM specific
> paths in QEMU.
>=20
> This patch hence changes add_pseries_test_case() to launch QEMU with
> '-machine accel=3Dkvm' if KVM is available.
>=20
> A notable consequence is that the guest will execute SLOF, but for some
> reasons SLOF sometimes hits a program exception. This causes the guest
> to loop forever and the test to be stuck.  Since we don't need the guest
> to be truely running, let's pass -S to QEMU to avoid that.
>=20
> Also disable machine capabilities that could be unavailable in KVM, eg,
> when using PR KVM.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I'm pretty sure trying to change the accelerator on a qtest test just
doesn't make sense.  We'd need a different approach for testing cpu
hotplug against kvm & tcg backends.

> ---
>  tests/cpu-plug-test.c |   20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> index 5f39ba0df394..2107557809b7 100644
> --- a/tests/cpu-plug-test.c
> +++ b/tests/cpu-plug-test.c
> @@ -21,6 +21,7 @@ struct PlugTestData {
>      unsigned cores;
>      unsigned threads;
>      unsigned maxcpus;
> +    const char *extra_args;
>  };
>  typedef struct PlugTestData PlugTestData;
> =20
> @@ -106,9 +107,10 @@ static void test_plug_with_device_add_coreid(gconstp=
ointer data)
>      char *args;
>      unsigned int c;
> =20
> -    args =3D g_strdup_printf("-machine %s -cpu %s "
> +    args =3D g_strdup_printf("-machine %s -cpu %s %s "
>                             "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%u,=
maxcpus=3D%u",
>                             td->machine, td->cpu_model,
> +                           td->extra_args ? td->extra_args : "",
>                             td->sockets, td->cores, td->threads, td->maxc=
pus);
>      qtest_start(args);
> =20
> @@ -195,10 +197,20 @@ static void add_pseries_test_case(const char *mname)
>          (g_str_has_prefix(mname, "pseries-2.") && atoi(&mname[10]) < 7))=
 {
>          return;
>      }
> -    data =3D g_new(PlugTestData, 1);
> +    data =3D g_new0(PlugTestData, 1);
>      data->machine =3D g_strdup(mname);
>      data->cpu_model =3D "power8_v2.0";
> -    data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
> +    if (!access("/sys/module/kvm_hv", F_OK) ||
> +        !access("/sys/module/kvm_pr", F_OK)) {
> +        data->cpu_model =3D "host";
> +        data->extra_args =3D
> +            "-machine accel=3Dkvm "
> +            "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbrok=
en "
> +            "-machine cap-htm=3Doff "
> +            "-machine cap-hpt-max-page-size=3D64k "
> +            "-S";
> +    }
> +    data->device_model =3D g_strdup_printf("%s-spapr-cpu-core", data->cp=
u_model);
>      data->sockets =3D 2;
>      data->cores =3D 3;
>      data->threads =3D 1;
> @@ -221,7 +233,7 @@ static void add_s390x_test_case(const char *mname)
>          return;
>      }
> =20
> -    data =3D g_new(PlugTestData, 1);
> +    data =3D g_new0(PlugTestData, 1);
>      data->machine =3D g_strdup(mname);
>      data->cpu_model =3D "qemu";
>      data->device_model =3D g_strdup("qemu-s390x-cpu");
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltarTkACgkQbDjKyiDZ
s5LlQRAAzPptunMtdOVf01mLyMfoINEJmfDsTnAjPU6E5B+YucKHzZbD9C3ifNvo
XTT0jMdXF4ty3bteGeXx+EobF18YLIxAsySLHHukT74mrzMk8yCRGTxlXI8uHM1z
kxtkxi9loOG8wxsB65kmbbJDxcg2ofDezsAc/8IPouo9M0kNhTcmi9gAAEDrzuQi
F9CcNTn/4L/du29siSDVoStWShA+uCniu1avL+8U38IHyGBW4dduFffQGWgpGTYx
jYv9Kgcu/89EjOO4xNbFNuTsILBe53h7cGcEtP+MwFK0w6wtiMpDmgWk0qUCQajk
QYvlXaIvgmcWFD7sODTSFxNmEgcvTMr0HqYiweqrVNdzNF+fywlZkiIwMT+S+lZn
mo3eUZfSLdTH+ulH9OUd/DddoBN9fGHiYaUZquy3w+kpkFciFmyte0WnJyPy5Pks
fPsjbIo4oW41ZCdGoqkDCQJesvrsc0dNTTIRf4IVxzU+i60+RsUgBa3znEnvc0x/
tabTWqQsEQIfTHMzxle5CzQw4bvEh+Aez/hOSnurhnfgHg2j+O+doawBgS9+QBt8
cMj3GDwqKNzmxQxuT79IsiCGoaPHWujUrcjoaZyAtM5aao7m+KnWwo5v01gF3cGj
KjweTcnZC0KJaqcscfwC3IiQOoZTntJc8ngSgxFzdgmNo9ptCH0=
=+dmx
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--
