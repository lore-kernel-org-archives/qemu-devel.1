Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2yJ1-0005xD-LE
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2yIx-0007qK-NC
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:39:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2yIx-0007oT-Dx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:39:03 -0400
Date: Fri, 13 Oct 2017 12:38:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171013113859.GG20515@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171013102812.29648-1-berrange@redhat.com>
	<1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
	<a591ebd3-ae7f-cde6-1cd2-d4859c17494f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a591ebd3-ae7f-cde6-1cd2-d4859c17494f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Oct 13, 2017 at 12:55:40PM +0200, Thomas Huth wrote:
> On 13.10.2017 12:52, Thomas Huth wrote:
> > On 13.10.2017 12:28, Daniel P. Berrange wrote:
> >> The system compiler in OpenBSD is gcc 4.2.1 which is too
> >> old for our needs. If doing 'pkg_add gcc' you can get a
> >> much newer version (4.9.4 in OpenBSD 6.1) which works with
> >> QEMU. This installs binaries with two naming schemes:
> >>
> >>   $ pkg_info  -L gcc | grep bin
> >>   /usr/local/bin/ecpp
> >>   /usr/local/bin/egcc
> >>   /usr/local/bin/egcc-ar
> >>   /usr/local/bin/egcc-nm
> >>   /usr/local/bin/egcc-ranlib
> >>   /usr/local/bin/egcov
> >>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc
> >>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ar
> >>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-nm
> >>   /usr/local/bin/x86_64-unknown-openbsd6.0-egcc-ranlib
> >>   /usr/local/bin/x86_64-unknown-openbsd6.0-gcc-4.9.3
> >>
> >> We pick the short name this it won't change across OpenBSD
> >> releases.
> >>
> >> This means users don't need to manually pass custom --cc
> >> and --cxx args to configure to avoid immediate failure.
> >>
> >> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >> ---
> >>  configure | 18 ++++++++++++++++--
> >>  1 file changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/configure b/configure
> >> index 06f18ea9af..fcb7523933 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -255,7 +255,21 @@ cross_prefix=""
> >>  audio_drv_list=""
> >>  block_drv_rw_whitelist=""
> >>  block_drv_ro_whitelist=""
> >> -host_cc="cc"
> >> +
> >> +case `uname -s` in
> >> +    OpenBSD)
> >> +    # Default system cc in OpenBSD is unsufficient
> > 
> > s/unsufficient/insufficient/
> > 
> >> +    # we need the 'gcc' pkg added, whch provides
> > 
> > s/whch/which/
> > 
> >> +    # these modified binary names
> >> +    host_cc="egcc"
> >> +    host_cxx="eg++"
> >> +    ;;
> >> +         *)
> >> +    host_cc="cc"
> >> +    host_cxx="c++"
> >> +    ;;
> >> +esac
> > 
> > Do we really need such work-arounds in our configure script? GCC 4.2 is
> > really veeeery old nowadays, so if the OpenBSD folks refuse to update
> > the default in their distro, IMHO they should be punished by having to
> > select the C compiler manually everywhere.
> 
> By the way, looks like OpenBSD is also switching to clang by default soon:
> 
> https://www.phoronix.com/scan.php?page=news_item&px=OpenBSD-Default-Clang

In a few years time we could potentially revert this patch, but in the
meantime it is clearly beneficial for anyone using OpenBSD and has no
significant maint burden for us to carry it while there are widely
supported OpenBSD releases which need it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
