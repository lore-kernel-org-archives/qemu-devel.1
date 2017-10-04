Received: from eggs.gnu.org ([2001:4830:134:3::10]:45470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dziDY-0007OX-0j
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dziDU-00084x-Bc
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dziDU-00084k-5p
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 07:51:56 -0400
Date: Wed, 4 Oct 2017 12:51:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171004115148.GH17517@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171003220038.16762.20147.stgit@gimli.home>
	<56527e57-ee99-4d9a-9048-9a9b9900a86b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56527e57-ee99-4d9a-9048-9a9b9900a86b@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert: checkpatch: check trace-events
 code style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Oct 04, 2017 at 12:59:04PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> 04.10.2017 01:00, Alex Williamson wrote:
> > Commit c3e5875afc0f ("checkpatch: check trace-events code style")
> > introduces a regression as reported:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05820.html
> >=20
> > Bareword found where operator expected at ./scripts/checkpatch.pl lin=
e 1350, near "s/($hex[.:\/ ])+$hex//gr"
> > syntax error at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/=
 ])+$hex//gr"
> > Execution of ./scripts/checkpatch.pl aborted due to compilation error=
s.
> >=20
> > $ perl -v
> >=20
> > This is perl, v5.10.1 (*) built for x86_64-linux-thread-multi
>=20
> v5.10.1 is 8 years old.
> most possibly the error relates to=C2=A0 /r modifier, which was added i=
nt perl
> 5.14, so, possible solution would be
>=20
> @@ -1432,7 +1432,8 @@ sub process {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qr/%[-+
> *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # don't consider groups splitted by [.:/ ], like=
 2A.20:12ab
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 my $tmpline =3D $rawline =3D~ s/($hex[.:\/ ])+$hex//gr=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 my $tmpline =3D $rawline;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 my $tmpline =3D~ s/($hex[.:\/ ])+$hex//g;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if ($tmpline =3D~ /(?<!0x)$hex/) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR("Hex numbers must =
be prefixed with '0x'\n" .

Yes, that fixes the error when run on a rhel6 vintage Perl.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
