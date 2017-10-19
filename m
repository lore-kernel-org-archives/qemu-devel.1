Received: from eggs.gnu.org ([2001:4830:134:3::10]:50927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bc2-0005lv-L1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bbw-0006Za-KK
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Bbw-0006ZD-B3
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:15:48 -0400
Date: Thu, 19 Oct 2017 15:15:41 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171019141541.GS8408@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171016131644.9565-1-kraxel@redhat.com>
	<20171016131644.9565-2-kraxel@redhat.com>
	<20171019140545.GA30324@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019140545.GA30324@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [PULL 01/11] build: automatically handle GIT
 submodule checkout for dtc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Oct 19, 2017 at 03:05:45PM +0100, Anthony PERARD wrote:
> On Mon, Oct 16, 2017 at 03:16:34PM +0200, Gerd Hoffmann wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> > 
> > Currently if DTC is required by configure and not available in the host
> > OS install, we exit with an error message telling the user to checkout a
> > git submodule or install the library.
> > 
> > This introduces automatic handling of the git submodule checkout process
> > and enables it for dtc. This only runs if building from GIT, so users of
> > release tarballs still need the system library install. The current state
> > of the git checkout is stashed in .git-submodule-status, and a helper
> > program is used to determine if this state matches the desired submodule
> > state. A dependency against 'Makefile' ensures that the submodule state
> > is refreshed at the start of the build process
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > Message-id: 20170929101201.21039-2-berrange@redhat.com
> > 
> > [ kraxel: use /bin/sh not bash for scripts/git-submodule.sh ]
> > [ kraxel: fix Makefile dependencies ]
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > [fixup] Makefile dep
> > ---
> 
> > diff --git a/Makefile b/Makefile
> > index 97b4508d7d..9866909e08 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -14,6 +14,27 @@ ifneq ($(wildcard config-host.mak),)
> >  all:
> >  include config-host.mak
> >  
> > +git-submodule-update:
> > +
> > +.PHONY: git-submodule-update
> > +
> > +ifeq (0,$(MAKELEVEL))
> 
> Hi,
> 
> this new patch, and especialy the use MAKELEVEL here does not work when
> we build Xen, since we build QEMU when building Xen.
> 
> When Xen is built, a clone of qemu.git is made, and then configure/make
> is called. At this point, MAKELEVEL would already be set so
> the makefile rule git-submodule-update would be empty.
> 
> Is it possible to do things differently in the QEMU makefiles? (Or do we
> have to simply unset MAKELEVEL in xen makefiles before building qemu.)

If it is practical from the Xen side, I think it would be preferrable
to unset MAKELEVEL when jumping in to build QEMU, that way any part of
QEMU makefiles can rely on MAKELEVEL being set normally.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
