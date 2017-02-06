Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cai2w-00069m-1w
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cai2r-00089K-RD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:05:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cai2r-000895-Jp
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:05:21 -0500
Date: Mon, 6 Feb 2017 12:05:15 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206120515.GJ3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170206112953.16993-1-berrange@redhat.com>
	<CAFEAcA_UVfxkRa7ESxXJGLLhT_K-=pnB_NJ53mW687ibxmhSmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_UVfxkRa7ESxXJGLLhT_K-=pnB_NJ53mW687ibxmhSmg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] rules: don't try to create missing include
 dirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Feb 06, 2017 at 11:50:09AM +0000, Peter Maydell wrote:
> On 6 February 2017 at 11:29, Daniel P. Berrange <berrange@redhat.com> wrote:
> > In
> >
> >   commit ba78db44f6532d66a1e704bd44613e841baa2fc5
> >   Author: Daniel P. Berrange <berrange@redhat.com>
> >   Date:   Wed Jan 25 16:14:10 2017 +0000
> >
> >   make: move top level dir to end of include search path
> >
> > The dir $(BUILD_DIR)/$(@D) was added to the include
> > path. This would sometimes point to a non-existant
> > directory, if the sub-dir in question did not contain
> > any target-independant files (eg tcg/). To deal with
> > this the rules.mak attempted to create the directory.
> >
> > While this was succesful, it also caused accidental
> > creation of files in the parent of the build dir.
> > e.g. when building common source files into target
> > specific output files.
> 
> Aha, that's where those directories came from!
> 
> > Rather than trying to workaround this, just revert
> > the code that attempted to mkdir the missing include
> > directories. Instead just turn off the compiler warning
> > in question as the missing dir is expected & harmless
> > in general.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  configure | 2 +-
> >  rules.mak | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 86fd833..6325339 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1474,7 +1474,7 @@ fi
> >
> >  gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
> >  gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
> > -gcc_flags="-Wmissing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
> > +gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
> >  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
> >  gcc_flags="-Wno-initializer-overrides $gcc_flags"
> >  gcc_flags="-Wno-string-plus-int $gcc_flags"
> > diff --git a/rules.mak b/rules.mak
> > index 575a3af..83d6dd1 100644
> > --- a/rules.mak
> > +++ b/rules.mak
> > @@ -374,7 +374,6 @@ define unnest-vars
> >                  $(eval $(o:%.mo=%$(DSOSUF)): module-common.o $($o-objs)),
> >                  $(error $o added in $v but $o-objs is not set)))
> >          $(shell mkdir -p ./ $(sort $(dir $($v))))
> > -        $(shell cd $(BUILD_DIR) && mkdir -p ./ $(sort $(dir $($v))))
> 
> I know this is the same syntax as the existing line above
> and we're deleting it anyway, but what does it actually do?
> When does telling mkdir to create "./" make sense?

No idea why the ./ was there originally - it appears to serve no
purpose. The useful bit is the stuff afterwards - the $($v) bit.
It gets populated based on the variable being unnested. For example

   block-obj-y = block.o blockjob.o block/ nbd/

will make $v contain  "block nbd", hence cause creation of those
dirs in the the build dir.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
