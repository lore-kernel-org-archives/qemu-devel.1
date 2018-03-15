Received: from eggs.gnu.org ([2001:4830:134:3::10]:46830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ewROr-00041S-P4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ewROn-0001nd-E4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:50:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ewROn-0001mB-20
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:50:21 -0400
Date: Thu, 15 Mar 2018 11:50:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180315115018.GA7015@stefanha-x1.localdomain>
References: <20180312131806.23209-1-stefanha@redhat.com>
	<43378184-a291-263f-b8b2-dedc455622e3@redhat.com>
	<20180313103736.GC16582@stefanha-x1.localdomain>
	<98b9bf37-5bca-35f0-7178-dd640ee3fe81@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <98b9bf37-5bca-35f0-7178-dd640ee3fe81@redhat.com>
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


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 11:49:57AM +0100, Thomas Huth wrote:
> On 13.03.2018 11:37, Stefan Hajnoczi wrote:
> > On Mon, Mar 12, 2018 at 02:46:20PM +0100, Thomas Huth wrote:
> >> On 12.03.2018 14:18, Stefan Hajnoczi wrote:
> >>> Warn if files are added/renamed/deleted without MAINTAINERS file
> >>> changes.  This has helped me in Linux and we could benefit from this
> >>> check in QEMU.
> >>>
> >>> This patch is a manual cherry-pick of Linux commit
> >>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning=
 on
> >>> file add/move/delete") by Joe Perches <joe@perches.com>.
> >>>
> >>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> ---
> >>> Note the 80-char lines are from upstream code.  Keep them as-is.
> >>>
> >>>  scripts/checkpatch.pl | 19 +++++++++++++++++++
> >>>  1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> >>> index d1fe79bcc4..d0d8f63d48 100755
> >>> --- a/scripts/checkpatch.pl
> >>> +++ b/scripts/checkpatch.pl
> >>> @@ -1177,6 +1177,7 @@ sub process {
> >>>  	our $clean =3D 1;
> >>>  	my $signoff =3D 0;
> >>>  	my $is_patch =3D 0;
> >>> +	my $reported_maintainer_file =3D 0;
> >>> =20
> >>>  	our @report =3D ();
> >>>  	our $cnt_lines =3D 0;
> >>> @@ -1379,6 +1380,24 @@ sub process {
> >>>  			}
> >>>  		}
> >>> =20
> >>> +# Check if MAINTAINERS is being updated.  If so, there's probably no=
 need to
> >>> +# emit the "does MAINTAINERS need updating?" message on file add/mov=
e/delete
> >>> +		if ($line =3D~ /^\s*MAINTAINERS\s*\|/) {
> >>> +			$reported_maintainer_file =3D 1;
> >>> +		}
> >>> +
> >>> +# Check for added, moved or deleted files
> >>> +		if (!$reported_maintainer_file &&
> >>> +		    ($line =3D~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> >>> +		     $line =3D~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
> >>> +		     ($line =3D~ /\{\s*([\w\/\.\-]*)\s*\=3D\>\s*([\w\/\.\-]*)\s*\}=
/ &&
> >>> +		      (defined($1) || defined($2))))) {
> >>> +			$is_patch =3D 1;
> >>> +			$reported_maintainer_file =3D 1;
> >>> +			WARN("added, moved or deleted file(s), does MAINTAINERS need upda=
ting?\n" .
> >>> +				$herecurr);
> >>
> >> Could you please turn this into a notification instead of a warning? F=
or
> >> rationale, please see the discussion of this patch last year:
> >>
> >> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05753.html
> >=20
> > It's a warning, not an error, so this already means "don't treat it as
> > fatal".
> >=20
> > Why is a warning a bad user experience but a notification would be fine?
>=20
> Since this will likely cause a lot of false positives. I think people
> will then rather be annoyed if checkpatch.pl nags them with a warning in
> these cases.

This approach works fine for Linux, I don't think it will be a problem
for QEMU.

The idea of zero false positives is nice though.  Do you have time to
implement a real MAINTAINERS checker that avoids false positives (i.e.
it applies the MAINTAINERS hunk in the patch, if present, onto the
current MAINTAINERS file and then looks up every new file or rename)?

Stefan

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaql36AAoJEJykq7OBq3PIHFUH/iY4AdpGUGpFIFyxTa6bDZLv
DLZlhictZioH9dAb1MDrF4J5pv5sA52OUh5U4y+on6jLMEn+RTThp48fCr+Uoa3d
Md4NoS1cgc9B72qUApSD/aF5Hj6N1YdNBU8kwrwGxZRxvhfoUEiM5rFG9kLXkw4b
hixALFBZmN1I0XqegMMjeebZcriDD667z3SVw1ses8YrUwSuKC2znfijLPiIi1pe
P2YSGZ2DghatgFQDIKxgg7SastoUo3FjztI1XH8pX881RZtNbVvTQgOLetnrwHs+
TjWzhMXTwYZJ7zXcBfkv+rl/152+q44L8zygW7tUWvekTIRWMQ1jeC4Vqn6OMsI=
=GZLn
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
