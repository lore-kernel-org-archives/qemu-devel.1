Received: from eggs.gnu.org ([2001:4830:134:3::10]:55730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxrNw-0004Zk-LI
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxrNs-0003Q7-Mw
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxrNs-0003P1-Dr
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:15:00 -0400
Date: Fri, 29 Sep 2017 10:14:47 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929091447.GG6803@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-3-berrange@redhat.com>
	<723de7c1-e617-923c-6e69-561577f0fe1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <723de7c1-e617-923c-6e69-561577f0fe1a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 01:03:41PM -0500, Eric Blake wrote:
> On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> > When building the tarball to pass into the docker/vm test image,
> > the code relies on the git submodules being checked out in the
> > main checkout.
> > 
> > ie if the developer has not run 'git submodule update --init dtc'
> > many of the docker tests will fail due to the libfdt package not
> 
> 'dtc' vs. 'libfdt' - is one of the acronyms wrong?

For reasons I don't understand we called our submodule 'dtc'
but it builds a libfdt library. So at least my wording here
reflects that mismatch.

> 
> > being present in the test images. Patchew manually checks out the
> > dtc submodule in the main git checkout, but this is a bad idea.
> > 
> > When running tests we want to have a predictable set of submodules
> > included in the source that's tested. The build environment is
> > completely independant of the developers host OS, so the submodules
> 
> s/independant/independent/
> 
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
> >  scripts/archive-source.sh | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> > 
> 
> > +++ b/scripts/archive-source.sh
> 
> > +# We want a predictable list of submodules for builds, that is
> > +# independant of what the developer currently has initialized
> 
> and again
> 
> > +# in their checkout, because the build environment is completely
> > +# different to the host OS.
> > +submodules="dtc"
> >  
> >  if test $? -ne 0; then
> >      error "git submodule command failed"
> > @@ -28,6 +34,21 @@ fi
> >  
> >  trap "status=$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
> >  
> > +if git diff-index --quiet HEAD -- &>/dev/null
> > +then
> > +    HEAD=HEAD
> > +else
> > +    HEAD=`git stash create`
> > +fi
> > +git clone --shared . "$vroot_dir"
> 
> set -e is not in effect; do you need error checking here?

Yes we shouldl

> 
> > +here=`pwd`
> 
> $PWD is cheaper than spawning a subprocess for `pwd`.

I always forget about $PWD :-)

> > +cd "$vroot_dir"
> 
> Definitely need error checking here.

Yep

> 
> > +git checkout $HEAD
> > +
> > +for sm in $submodules; do
> > +    git submodule update --init $sm

And here too

> > +done
> > +
> >  if test -n "$submodules"; then
> >      {
> >          git ls-files || error "git ls-files failed"
> > @@ -48,4 +69,7 @@ fi
> >  
> >  tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
> >  
> > +cd "$here"
> 
> and again here
> 
> > +rm -rf "$vroot_dir"

I can move this into the earlier 'trap' cleanup and remove
this need to cd && rm.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
