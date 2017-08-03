Received: from eggs.gnu.org ([2001:4830:134:3::10]:44620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddHAC-0003Ll-0B
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddHA8-0008CV-VK
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:31:48 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:48525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ddHA8-00085J-M4
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:31:44 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id A0BAE671A1
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 16:31:39 +0200 (CEST)
Date: Thu, 3 Aug 2017 16:31:34 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170803163134.109fd57b@bahia.lan>
In-Reply-To: <dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/9kOt28IByW.8+Yd8d/M+y+n";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

--Sig_/9kOt28IByW.8+Yd8d/M+y+n
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 10:34:45 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Greg,
>=20
> On 08/02/2017 11:47 AM, Greg Kurz wrote:
> > Building QEMU on fedora26 with the latest gcc package fails:
> >=20
> >    CC      ppc64-softmmu/target/ppc/kvm.o
> > In file included from include/sysemu/hw_accel.h:16:0,
> >                   from target/ppc/kvm.c:31:
> > target/ppc/kvm.c: In function =E2=80=98kvmppc_booke_watchdog_enable=E2=
=80=99:
> > include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may b=
e used uninitialized
> >   in this function [-Werror=3Dmaybe-uninitialized]
> >               cap.args[i] =3D args_tmp[i];                             =
  \
> >                                     ^
> > target/ppc/kvm.c: In function =E2=80=98kvmppc_set_papr=E2=80=99:
> > include/sysemu/kvm.h:449:35: error: =E2=80=98args_tmp[i]=E2=80=99 may b=
e used uninitialized
> >   in this function [-Werror=3Dmaybe-uninitialized]
> > cc1: all warnings being treated as errors
> >=20
> > $ rpm -q gcc
> > gcc-7.1.1-3.fc26.ppc64le
> >=20
> > Testing the size of args_tmp seems to be enough to prevent the warning
> > to pop up. =20
>=20
> This sizeof() use looks unnatural to me. I wonder why not use size_t,=20
> since this is about sizeof()/ARRAY_SIZE(). The problem seems to come=20
> from the commit this cast was introduced (61c7bbd236):
>=20
> target-ppc/kvm.c:1302:21: error: comparison of unsigned expression < 0=20
> is always false [-Werror=3Dtype-limits]
>=20

Switching from int to size_t causes this error ^^ to show up again.

> So I'd rather suggest this code, which looks more natural to read to me:
>=20
>      if (ARRAY_SIZE(args_tmp)) {

Yeah, it's maybe more in phase with the context but anyway, the truly
unnatural thing is to be forced to do:

    if (foo) {
        for (i =3D 0; i < foo; ...


>          for (i =3D 0; i < ARRAY_SIZE(args_tmp) && ...
>=20
> I Cc'ed Eric :)
>=20
> Regards,
>=20
> Phil.
>=20
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   include/sysemu/kvm.h |   12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 91fc07ee9afe..41fc1005a9ea 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -429,9 +429,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned i=
nt extension);
> >           };                                                           \
> >           uint64_t args_tmp[] =3D { __VA_ARGS__ };                     =
  \
> >           int i;                                                       \
> > -        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                =
 \
> > +        if (sizeof(args_tmp)) {                                      \
> > +            for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&            =
 \
> >                        i < ARRAY_SIZE(cap.args); i++) {                \
> > -            cap.args[i] =3D args_tmp[i];                              =
 \
> > +                cap.args[i] =3D args_tmp[i];                          =
 \
> > +            }                                                        \
> >           }                                                            \
> >           kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);                       \
> >       })
> > @@ -444,9 +446,11 @@ int kvm_vm_check_extension(KVMState *s, unsigned i=
nt extension);
> >           };                                                           \
> >           uint64_t args_tmp[] =3D { __VA_ARGS__ };                     =
  \
> >           int i;                                                       \
> > -        for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&                =
 \
> > +        if (sizeof(args_tmp)) {                                      \
> > +            for (i =3D 0; i < (int)ARRAY_SIZE(args_tmp) &&            =
 \
> >                        i < ARRAY_SIZE(cap.args); i++) {                \
> > -            cap.args[i] =3D args_tmp[i];                              =
 \
> > +                cap.args[i] =3D args_tmp[i];                          =
 \
> > +            }                                                        \
> >           }                                                            \
> >           kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);                   \
> >       })
> >=20
> >  =20


--Sig_/9kOt28IByW.8+Yd8d/M+y+n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmDM8YACgkQAvw66wEB28IFEgCbBMMQKTWqwOpirFoDAAK9R4g1
id0AnRIDE9EVXMsFpPSUhrkaQelAhlOs
=PpSp
-----END PGP SIGNATURE-----

--Sig_/9kOt28IByW.8+Yd8d/M+y+n--
