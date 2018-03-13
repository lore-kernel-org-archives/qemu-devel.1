Received: from eggs.gnu.org ([2001:4830:134:3::10]:57547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evhJd-0006R3-Hd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evhJa-0007p8-By
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:37:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evhJa-0007oR-5w
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:37:54 -0400
Date: Tue, 13 Mar 2018 10:37:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180313103736.GC16582@stefanha-x1.localdomain>
References: <20180312131806.23209-1-stefanha@redhat.com>
	<43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 02:46:20PM +0100, Thomas Huth wrote:
> On 12.03.2018 14:18, Stefan Hajnoczi wrote:
> > Warn if files are added/renamed/deleted without MAINTAINERS file
> > changes.  This has helped me in Linux and we could benefit from this
> > check in QEMU.
> >=20
> > This patch is a manual cherry-pick of Linux commit
> > 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
> > file add/move/delete") by Joe Perches <joe@perches.com>.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Note the 80-char lines are from upstream code.  Keep them as-is.
> >=20
> >  scripts/checkpatch.pl | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index d1fe79bcc4..d0d8f63d48 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1177,6 +1177,7 @@ sub process {
> >  	our $clean =3D 1;
> >  	my $signoff =3D 0;
> >  	my $is_patch =3D 0;
> > +	my $reported_maintainer_file =3D 0;
> > =20
> >  	our @report =3D ();
> >  	our $cnt_lines =3D 0;
> > @@ -1379,6 +1380,24 @@ sub process {
> >  			}
> >  		}
> > =20
> > +# Check if MAINTAINERS is being updated.  If so, there's probably no n=
eed to
> > +# emit the "does MAINTAINERS need updating?" message on file add/move/=
delete
> > +		if ($line =3D~ /^\s*MAINTAINERS\s*\|/) {
> > +			$reported_maintainer_file =3D 1;
> > +		}
> > +
> > +# Check for added, moved or deleted files
> > +		if (!$reported_maintainer_file &&
> > +		    ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> > +		     $line =3D~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
> > +		     ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\-]*)\s*\}/ =
&&
> > +		      (defined($1) || defined($2))))) {
> > +			$is_patch =3D 1;
> > +			$reported_maintainer_file =3D 1;
> > +			WARN("added, moved or deleted file(s), does MAINTAINERS need updati=
ng?\n" .
> > +				$herecurr);
>=20
> Could you please turn this into a notification instead of a warning? For
> rationale, please see the discussion of this patch last year:
>=20
> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html

It's a warning, not an error, so this already means "don't treat it as
fatal".

Why is a warning a bad user experience but a notification would be fine?

Stefan

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJap6nwAAoJEJykq7OBq3PIwosH/11Oa+BkUyhFf4YgTYolaSF4
UpqNUwlWR5Nb/uC2CKRXdoe08P4CtKYzoHHf57fedr1xTNaaCTbXPuSZIeHfQmAf
xJPON1f9pcRW+547qRElq9Th32OM9OxhrBZyOD1D4YqP7ncWiiRm+EeOC8wUtUXi
gzCa0ELlErY7hzX+j6ptvGpZHoCtVs2qaQiQrt55JdVnYgL5REmhhedAfmin08Ls
vaVeHbE8OKerE34QfFH0Y1L1k9jEs2fNAGlsogQxFcEr0PIdJg4UKGub4SuJGiui
PGA/X1g/9eUnm4BYjNm5rZn8cC521zuPcpMYppPRTj+NPIMLgxszwItEgBd7eJQ=
=RFqK
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
