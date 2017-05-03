Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d5xyt-0006vw-GD
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d5xyq-0003t1-BE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:22:27 -0400
Received: from mail.kernel.org ([198.145.29.136]:47598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d5xyq-0003sG-37
	for qemu-devel@nongnu.org; Wed, 03 May 2017 13:22:24 -0400
Date: Wed, 3 May 2017 10:20:59 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170503164838.GB1553@perard.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1705031019140.9240@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
	<03cfd81856554ecd91c0c317353e819b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704181038360.31486@sstabellini-ThinkPad-X260>
	<51ac3ff38f464abfb98928e6fb959bf7@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704191552450.31486@sstabellini-ThinkPad-X260>
	<6738c7d96a1c476187f69616f25b28d1@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704201035390.18403@sstabellini-ThinkPad-X260>
	<20170503164838.GB1553@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] QEMU build breakage on ARM against Xen 4.9 caused
 by libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <Paul.Durrant@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Wei Liu <wei.liu2@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Wed, 3 May 2017, Anthony PERARD wrote:
> On Thu, Apr 20, 2017 at 11:05:33AM -0700, Stefano Stabellini wrote:
> > On Thu, 20 Apr 2017, Paul Durrant wrote:
> > > I think xencall should be part of the base xen_stable_libs anyway.
> > 
> > Yes, you are right. However I noticed that -lxencall needs to come after
> > -lxendevicemodel. So, I'll have to move -lxendevicemodel before
> > $xen_stable_libs, see below. I'll merge this patch into "configure:
> > detect presence of libxendevicemodel", if that's OK.
> > 
> > diff --git a/configure b/configure
> > index 99d6cbc..3133ef8 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1992,7 +1992,7 @@ if test "$xen" != "no" ; then
> >    else
> >  
> >      xen_libs="-lxenstore -lxenctrl -lxenguest"
> > -    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
> > +    xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
> >  
> >      # First we test whether Xen headers and libraries are available.
> >      # If no, we are done and there is no Xen support.
> > @@ -2027,9 +2027,9 @@ int main(void) {
> >    return 0;
> >  }
> >  EOF
> > -        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> > +        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
> >        then
> > -      xen_stable_libs="$xen_stable_libs -lxendevicemodel"
> > +      xen_stable_libs="-lxendevicemodel $xen_stable_libs"
> >        xen_ctrl_version=40900
> >        xen=yes
> >      elif
> 
> Hey, now that this patch is merged, xen.git fail to build QEMU. (osstest
> qemu-mainline branch fail.)
> 
> That's because -lxencall is not found because -L$path_to_libxencall is
> missing in xen.git.
> 
> But I've notice something else, libxendevicemodel.so is not linked
> against libxencall, that might be the root of the issues on arm.
> (libxenctrl.so is linked against libxencall.)
> 
> Thought?
> 
> 
> We probably need this patch in xen:

We also need to add -L$path_to_libxencall and -I$path_to_libxencall to
tools/Makefile:subdir-all-qemu-xen-dir.


> diff --git a/tools/libs/devicemodel/Makefile b/tools/libs/devicemodel/Makefile
> index 55626a5049..81fa5a4ac4 100644
> --- a/tools/libs/devicemodel/Makefile
> +++ b/tools/libs/devicemodel/Makefile
> @@ -63,7 +63,7 @@ libxendevicemodel.so.$(MAJOR): libxendevicemodel.so.$(MAJOR).$(MINOR)
>         $(SYMLINK_SHLIB) $< $@
>  
>  libxendevicemodel.so.$(MAJOR).$(MINOR): $(PIC_OBJS) libxendevicemodel.map
> -       $(CC) $(LDFLAGS) $(PTHREAD_LDFLAGS) -Wl,$(SONAME_LDFLAG) -Wl,libxendevicemodel.so.$(MAJOR) $(SHLIB_LDFLAGS) -o $@ $(PIC_OBJS) $(LDLIBS_libxentoollog) $(APPEND_LDFLAGS)
> +       $(CC) $(LDFLAGS) $(PTHREAD_LDFLAGS) -Wl,$(SONAME_LDFLAG) -Wl,libxendevicemodel.so.$(MAJOR) $(SHLIB_LDFLAGS) -o $@ $(PIC_OBJS) $(LDLIBS_libxentoollog) $(LDLIBS_libxencall) $(APPEND_LDFLAGS)
>  
>  .PHONY: install
>  install: build
> 
> -- 
> Anthony PERARD
> 
