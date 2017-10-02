Received: from eggs.gnu.org ([2001:4830:134:3::10]:47347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dz0MC-00024R-IC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dz0M8-0005KV-EV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dz0M8-0005K1-6F
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:01:56 -0400
Date: Mon, 2 Oct 2017 14:01:28 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171002130128.GK27086@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170929101201.21039-1-berrange@redhat.com>
	<20170929101201.21039-3-berrange@redhat.com>
	<8737711zla.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8737711zla.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Mon, Oct 02, 2017 at 01:52:33PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrange <berrange@redhat.com> writes:
>=20
> > When building the tarball to pass into the docker/vm test image,
> > the code relies on the git submodules being checked out in the
> > main checkout.
> >
> > ie if the developer has not run 'git submodule update --init dtc'
> > many of the docker tests will fail due to the libfdt package not
> > being present in the test images. Patchew manually checks out the
> > dtc submodule in the main git checkout, but this is a bad idea.
> >
> > When running tests we want to have a predictable set of submodules
> > included in the source that's tested. The build environment is
> > completely independent of the developers host OS, so the submodules
> > the developer has checked out should not be considered relevant for
> > the tests.
> >
> > This changes the archive-source.sh script so that it clones the
> > current git checkout into a temporary directory, checks out a
> > fixed set of submodules, builds the tarball and finally removes
> > the temporary git clone.
>=20
> I feel like we've just gone around in one big circle here. The whole
> point of passing the tarball into the docker build in the first place
> was to avoid messing around with checkouts and the like. Is it not
> possible to get what we want direct from git?

What I've implemented here gets what we want straight from git, with
minimal performance overhead because entire .git is shared with hard
links.

> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  scripts/archive-source.sh | 34 ++++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > index c4e7d98f4d..4029de7b20 100755
> > --- a/scripts/archive-source.sh
> > +++ b/scripts/archive-source.sh
> > @@ -18,15 +18,37 @@ if test $# -lt 1; then
> >      error "Usage: $0 <output tarball>"
> >  fi
> >
> > -tar_file=3D"$1"
> > -list_file=3D"$1.list"
> > -submodules=3D$(git submodule foreach --recursive --quiet 'echo $name=
')
> > +tar_file=3D`realpath "$1"`
> > +list_file=3D"${tar_file}.list"
> > +vroot_dir=3D"${tar_file}.vroot"
> >
> > -if test $? -ne 0; then
> > -    error "git submodule command failed"
> > +# We want a predictable list of submodules for builds, that is
> > +# independent of what the developer currently has initialized
> > +# in their checkout, because the build environment is completely
> > +# different to the host OS.
> > +submodules=3D"dtc"
> > +
> > +trap "status=3D$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$stat=
us" 0 1 2 3 15
> > +
> > +if git diff-index --quiet HEAD -- &>/dev/null
> > +then
> > +    HEAD=3DHEAD
> > +else
> > +    HEAD=3D`git stash create`
> >  fi
> > +git clone --shared . "$vroot_dir"
> > +test $? -ne 0 && error "failed to clone into '$vroot_dir'"
> > +
> > +cd "$vroot_dir"
> > +test $? -ne 0 && error "failed to change into '$vroot_dir'"
> > +
> > +git checkout $HEAD
> > +test $? -ne 0 && error "failed to checkout $HEAD revision"
> >
> > -trap "status=3D$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
> > +for sm in $submodules; do
> > +    git submodule update --init $sm
> > +    test $? -ne 0 && error "failed to init submodule $sm"
> > +done
> >
> >  if test -n "$submodules"; then
> >      {
>=20
>=20
> --
> Alex Benn=C3=A9e

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
