Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fixdc-0000VS-Ec
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fixdZ-0002XS-4J
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:58:12 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:55828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fixdY-0002LJ-Pf
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 03:58:09 -0400
Received: from player786.ha.ovh.net (unknown [10.109.146.1])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9C8C119200C
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 09:57:59 +0200 (CEST)
Date: Fri, 27 Jul 2018 09:54:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180727095452.45edee8b@bahia>
In-Reply-To: <20180727052724.GJ3694@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/HB0RlW/aeLnSkBhQ/WBs+B_";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/HB0RlW/aeLnSkBhQ/WBs+B_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jul 2018 15:27:24 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jul 25, 2018 at 04:45:26PM +0200, Greg Kurz wrote:
> > Commit b585395b655 fixed a regression introduced by some recent changes
> > in the XICS code, that was causing QEMU to crash instantly during CPU
> > hotplug with KVM. This is typically the kind of bug we'd like our
> > test suite to detect before it gets merged. Unfortunately, the current
> > tests run with '-machine accel=3Dqtest' and don't exercise KVM specific
> > paths in QEMU.
> >=20
> > This patch hence changes add_pseries_test_case() to launch QEMU with
> > '-machine accel=3Dkvm' if KVM is available.
> >=20
> > A notable consequence is that the guest will execute SLOF, but for some
> > reasons SLOF sometimes hits a program exception. This causes the guest
> > to loop forever and the test to be stuck.  Since we don't need the guest
> > to be truely running, let's pass -S to QEMU to avoid that.
> >=20
> > Also disable machine capabilities that could be unavailable in KVM, eg,
> > when using PR KVM.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I'm pretty sure trying to change the accelerator on a qtest test just
> doesn't make sense.  We'd need a different approach for testing cpu
> hotplug against kvm & tcg backends.
>=20

The test starts QEMU, triggers the CPU hotplug code with a QMP command
and checks the command didn't fail (or QEMU didn't crash, as it would
have before commit b585395b655a)... I really don't understand what
is wrong with that... Please elaborate.

> > ---
> >  tests/cpu-plug-test.c |   20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
> > index 5f39ba0df394..2107557809b7 100644
> > --- a/tests/cpu-plug-test.c
> > +++ b/tests/cpu-plug-test.c
> > @@ -21,6 +21,7 @@ struct PlugTestData {
> >      unsigned cores;
> >      unsigned threads;
> >      unsigned maxcpus;
> > +    const char *extra_args;
> >  };
> >  typedef struct PlugTestData PlugTestData;
> > =20
> > @@ -106,9 +107,10 @@ static void test_plug_with_device_add_coreid(gcons=
tpointer data)
> >      char *args;
> >      unsigned int c;
> > =20
> > -    args =3D g_strdup_printf("-machine %s -cpu %s "
> > +    args =3D g_strdup_printf("-machine %s -cpu %s %s "
> >                             "-smp 1,sockets=3D%u,cores=3D%u,threads=3D%=
u,maxcpus=3D%u",
> >                             td->machine, td->cpu_model,
> > +                           td->extra_args ? td->extra_args : "",
> >                             td->sockets, td->cores, td->threads, td->ma=
xcpus);
> >      qtest_start(args);
> > =20
> > @@ -195,10 +197,20 @@ static void add_pseries_test_case(const char *mna=
me)
> >          (g_str_has_prefix(mname, "pseries-2.") && atoi(&mname[10]) < 7=
)) {
> >          return;
> >      }
> > -    data =3D g_new(PlugTestData, 1);
> > +    data =3D g_new0(PlugTestData, 1);
> >      data->machine =3D g_strdup(mname);
> >      data->cpu_model =3D "power8_v2.0";
> > -    data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
> > +    if (!access("/sys/module/kvm_hv", F_OK) ||
> > +        !access("/sys/module/kvm_pr", F_OK)) {
> > +        data->cpu_model =3D "host";
> > +        data->extra_args =3D
> > +            "-machine accel=3Dkvm "
> > +            "-machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbr=
oken "
> > +            "-machine cap-htm=3Doff "
> > +            "-machine cap-hpt-max-page-size=3D64k "
> > +            "-S";
> > +    }
> > +    data->device_model =3D g_strdup_printf("%s-spapr-cpu-core", data->=
cpu_model);
> >      data->sockets =3D 2;
> >      data->cores =3D 3;
> >      data->threads =3D 1;
> > @@ -221,7 +233,7 @@ static void add_s390x_test_case(const char *mname)
> >          return;
> >      }
> > =20
> > -    data =3D g_new(PlugTestData, 1);
> > +    data =3D g_new0(PlugTestData, 1);
> >      data->machine =3D g_strdup(mname);
> >      data->cpu_model =3D "qemu";
> >      data->device_model =3D g_strdup("qemu-s390x-cpu");
> >  =20
>=20


--Sig_/HB0RlW/aeLnSkBhQ/WBs+B_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAltaz8wACgkQcdTV5YIv
c9Zakg//YlBHpAe2cy8USDheschocF4TRKKRZVCON6nxR226StcV6zICUdFLHgAO
SA+gkT224Zrk3uliQWLUyg6nkzfxmOeqzYvI52PvGeHlcM3eXxvGzHhADpKktisk
g8hnpcqRfRkk/bAzKYxq2ZI2Di6Q/p98DpYJ9EpS6HA9O5NH+T9kNMEX3V5mH703
h3g8BzHiUVJDGf/KVuWRsv7JfAa4YoWL6co3tpt75MUi9oQtJ+KMtJ+p4TkE8lIx
QiYkgNVf2VYuyrDhS9KMXzpNFdIKndS8JTbLjXf2Dzu2SbBhr3DGW6ewLo+bF8vQ
HWGXO5mmiljj5WLFCxyfL2XJHqHpr6rNiNhCFZKpLPbcGdfLSbmhdQ+y3WqimMxv
4859Aw9YfxvBXml7EPmmWUTC7gn+F3dIfkSOZa0E1Ix8n5Oygiw5Xcg5XfAvFsag
czFM5dzZa+9gSKsLjV+xoCNnGUFXBYdrj59/pT8PqFd4ZsNSyia0U/GfDCtgbZ9E
ifeBAwqsG8E1WgusQ4GCizI6p/9pIh4l4isKFP0DQmvV5fj4TkeQktmgjxCTHHWk
uRvs14+KrK1uSX/13WTXeVVe5KA1ELdUCxe6/NarG4OAy/9/1QoaYxe3kRR4qjn4
VsOBxV0XhvMxcZ4rLWICdgyQYfZj2ouY34iPWrw+FHGSupWkx8I=
=9Qxf
-----END PGP SIGNATURE-----

--Sig_/HB0RlW/aeLnSkBhQ/WBs+B_--
