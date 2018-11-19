Received: from eggs.gnu.org ([2001:4830:134:3::10]:50768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgmR-0005Ak-5q
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOgmQ-0005dk-1z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:27:47 -0500
Date: Mon, 19 Nov 2018 10:27:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119102732.GF19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-6-berrange@redhat.com>
	<5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5acd44f8-69c7-a791-0ce0-49cad6e48423@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: add iotests helpers for dealing
 with TLS certificates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 16, 2018 at 10:39:03AM -0600, Eric Blake wrote:
> On 11/16/18 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > Add helpers to common.tls for creating TLS certificates for a CA,
> > server and client.
>=20
> MUCH appreciated!  We NEED this coverage, easily automated.
>=20
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   tests/qemu-iotests/common.tls | 139 +++++++++++++++++++++++++++++++=
+++
> >   1 file changed, 139 insertions(+)
> >   create mode 100644 tests/qemu-iotests/common.tls
> >=20
> > diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/commo=
n.tls
> > new file mode 100644
>=20
> I was a bit surprised that this wasn't 100755, but this matches the fac=
t
> that none of the other common.* are executable. And after thinking more=
, it
> makes sense - they aren't standalone scripts, but designed to be source=
d,
> and 'source' doesn't care about execute bits.
>=20
> > +tls_dir=3D"${TEST_DIR}/tls"
> > +
> > +function tls_x509_cleanup()
> > +{
> > +    rm -f ${tls_dir}/*.pem
> > +    rm -f ${tls_dir}/*/*.pem
> > +    rmdir ${tls_dir}/*
> > +    rmdir ${tls_dir}
>=20
> Why not just:
> rm -rf $tls_dir

Yeah, I guess we could do that for simplicity

> Also, the quoting is a bit inconsistent. if ${TEST_DIR} can contain spa=
ces,
> then all uses of ${tls_dir} need to be in "".

Hmm, yes.

> > +}
> > +
> > +
> > +function tls_x509_init()
> > +{
> > +    mkdir "${tls_dir}"
>=20
> And this just highlights the quoting inconsistency.  Should this use mk=
dir
> -p?

I assume $TEST_DIR would already exist, so wouldn't need -p.

> > +
> > +function tls_x509_create_root_ca()
> > +{
> > +    name=3D$1
> > +
> > +    test -z "$name" && name=3Dca-cert
>=20
> Could also be shortened as:
>=20
> name=3D${1:-ca-cert}

ok

> > +
> > +    cat > ${tls_dir}/ca.info <<EOF
> > +cn =3D Cthulu Dark Lord Enterprises $name
>=20
> s/Cthulu/Cthulhu/ - after all, we don't want him coming after us just
> because we botched the spelling of his name :)
>=20
> > +ca
> > +cert_signing_key
> > +EOF
> > +
> > +    certtool --generate-self-signed \
> > +             --load-privkey ${tls_dir}/key.pem \
> > +             --template ${tls_dir}/ca.info \
> > +             --outfile ${tls_dir}/$name-cert.pem 2>&1 | head -1
>=20
> More missing ""
>=20
> > +
> > +    rm -f ${tls_dir}/ca.info
> > +}
> > +
> > +
> > +function tls_x509_create_server()
> > +{
> > +    caname=3D$1
> > +    name=3D$2
> > +
> > +    mkdir ${tls_dir}/$name
> > +    cat > ${tls_dir}/cert.info <<EOF
> > +organization =3D Cthulu Dark Lord Enterprises $name
>=20
> Matched spelling
>=20
> > +function tls_x509_create_client()
> > +{
> > +    caname=3D$1
> > +    name=3D$2
> > +
> > +    mkdir ${tls_dir}/$name
> > +    cat > ${tls_dir}/cert.info <<EOF
> > +country =3D South Pacific
> > +locality =3D  R'lyeh
> > +organization =3D Cthulu Dark Lord Enterprises $name
>=20
> And again
>=20
> Needs several touch-ups, but the idea itself is sound.

Yes will fix

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
