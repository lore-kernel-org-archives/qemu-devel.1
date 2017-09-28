Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxVUe-0000lG-9g
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxVUb-0001nS-3L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxVUa-0001n2-QE
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:52:29 -0400
Date: Thu, 28 Sep 2017 10:52:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170928095216.GF12919@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170928084430.17059-1-berrange@redhat.com>
	<20170928084430.17059-3-berrange@redhat.com>
	<20170928094453.GD26066@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170928094453.GD26066@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v6 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Thu, Sep 28, 2017 at 05:44:53PM +0800, Fam Zheng wrote:
> On Thu, 09/28 09:44, Daniel P. Berrange wrote:
> > When building the tarball to pass into the docker/vm test image,
> > the code relies on the git submodules being checked out in the
> > main checkout.
> > 
> > ie if the developer has not run 'git submodule update --init dtc'
> > most (all?) of the docker tests will fail due to the missing dtc
> > package in the test images.
> 
> Not all, fail only in envs/configs where libfdt devel doesn't exist.

I didn't test all of them but of the ~5 I did test all failed, so I
just assumed none contain libftd-devel, since you have patchew
manually check it out.

> > Patchew manually checks out the dtc
> > submodule in the main git checkout, but this is a bad idea. The
> > docker tests should never mess around with the developer's main
> > GIT checkout.
> 
> Or in general, scripts should not mess around with developer's GIT checkouts,
> which is the reason ./configure doesn't do it?
> 
> How about we clone/checkout dtc into a temporary dir from ./configure
> automatically instead?
> 
> > 
> > When running tests we want to have a predictable set of submodules
> > included in the source that's tested. The build environment is
> > completely independant of the developers host OS, so the submodules
> > the developer has checked out should not be considered relevant for
> > the tests.
> > 
> > This changes the archive-source.sh script so that it clones the
> > current git checkout into a temporary directory, checks out a
> > fixed set of submodules, builds the tarball and finally removes
> > the temporary git clone.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  scripts/archive-source.sh | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> > index c4e7d98f4d..0d2046a80e 100755
> > --- a/scripts/archive-source.sh
> > +++ b/scripts/archive-source.sh
> > @@ -18,9 +18,15 @@ if test $# -lt 1; then
> >      error "Usage: $0 <output tarball>"
> >  fi
> >  
> > -tar_file="$1"
> > -list_file="$1.list"
> > -submodules=$(git submodule foreach --recursive --quiet 'echo $name')
> > +tar_file=`realpath "$1"`
> > +list_file="${tar_file}.list"
> > +vroot_dir="${tar_file}.vroot"
> > +
> > +# We want a predictable list of submodules for builds, that is
> > +# independant of what the developer currently has initialized
> > +# in their checkout, because the build environment is completely
> > +# different to the host OS.
> > +submodules="dtc"
> >  
> >  if test $? -ne 0; then
> >      error "git submodule command failed"
> > @@ -28,6 +34,14 @@ fi
> >  
> >  trap "status=$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
> >  
> > +git clone --shared . "$vroot_dir"
> 
> (*) This loses the feature that uncommitted changes are also reflected in the
> tarball. Personally I rarely use it but since day one of docker tests we've
> deliberately supported that.

Oh, I missed that we supported that.  We can still cope with that by
using the 'git stash create' trick the docker script used before. e.g.

   stash=`git stash create`
   git clone --shared . $vroot_dir
   cd $vroot_dir
   git checkout $stash

the cloned repo contains the stash object, because we use --shared to
directly share the .git dir contents.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
