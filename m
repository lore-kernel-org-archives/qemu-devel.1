Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzl8l-0001dY-AY
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzl8h-0001CL-AW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dzl8h-0001Bi-1x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 10:59:11 -0400
Date: Wed, 4 Oct 2017 08:59:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171004085906.751eb29b@t450s.home>
In-Reply-To: <56527e57-ee99-4d9a-9048-9a9b9900a86b@virtuozzo.com>
References: <20171003220038.16762.20147.stgit@gimli.home>
	<56527e57-ee99-4d9a-9048-9a9b9900a86b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 4 Oct 2017 12:59:04 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 04.10.2017 01:00, Alex Williamson wrote:
> > Commit c3e5875afc0f ("checkpatch: check trace-events code style")
> > introduces a regression as reported:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05820.html
> >
> > Bareword found where operator expected at ./scripts/checkpatch.pl line =
1350, near "s/($hex[.:\/ ])+$hex//gr"
> > syntax error at ./scripts/checkpatch.pl line 1350, near "s/($hex[.:\/ ]=
)+$hex//gr"
> > Execution of ./scripts/checkpatch.pl aborted due to compilation errors.
> >
> > $ perl -v
> >
> > This is perl, v5.10.1 (*) built for x86_64-linux-thread-multi =20
>=20
> v5.10.1 is 8 years old.
> most possibly the error relates to=C2=A0 /r modifier, which was added int=
=20
> perl 5.14, so, possible solution would be
>=20
> @@ -1432,7 +1432,8 @@ sub process {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qr/%[-+=20
> *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # don't consider groups splitted by [.:/ ], like=20
> 2A.20:12ab
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 my $tmpline =3D $rawline =3D~ s/($hex[.:\/ ])+$hex//gr;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 my $tmpline =3D $rawline;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 my $tmpline =3D~ s/($hex[.:\/ ])+$hex//g;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if ($tmpline =3D~ /(?<!0x)$hex/) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR("Hex numbers must be=
 prefixed with '0x'\n" .

Yes, that fixes it.

> >
> > As no fix or discussion has resulted, revert the original patch. =20
>=20
> Sorry for no answer on your report

No worries, this seems to have gotten the job done.  Please post the
patch above and I withdraw my revert.  Thanks,

Alex

> >
> > Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Fixes: c3e5875afc0f ("checkpatch: check trace-events code style")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >   scripts/checkpatch.pl |   19 -------------------
> >   1 file changed, 19 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 3c0a28e644aa..f7e785d12a49 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1422,25 +1422,6 @@ sub process {
> >   			$rpt_cleaners =3D 1;
> >   		}
> >  =20
> > -# checks for trace-events files
> > -		if ($realfile =3D~ /trace-events$/ && $line =3D~ /^\+/) {
> > -			if ($rawline =3D~ /%[-+ 0]*#/) {
> > -				ERROR("Don't use '#' flag of printf format ('%#') in " .
> > -				      "trace-events, use '0x' prefix instead\n" . $herecurr);
> > -			} else {
> > -				my $hex =3D
> > -					qr/%[-+ *.0-9]*([hljztL]|ll|hh)?(x|X|"\s*PRI[xX][^"]*"?)/;
> > -
> > -				# don't consider groups splitted by [.:/ ], like 2A.20:12ab
> > -				my $tmpline =3D $rawline =3D~ s/($hex[.:\/ ])+$hex//gr;
> > -
> > -				if ($tmpline =3D~ /(?<!0x)$hex/) {
> > -					ERROR("Hex numbers must be prefixed with '0x'\n" .
> > -					      $herecurr);
> > -				}
> > -			}
> > -		}
> > -
> >   # check we are in a valid source file if not then ignore this hunk
> >   		next if ($realfile !~ /\.(h|c|cpp|s|S|pl|py|sh)$/);
> >  =20
> > =20
>=20
>=20
