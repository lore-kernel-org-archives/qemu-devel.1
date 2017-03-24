Received: from eggs.gnu.org ([2001:4830:134:3::10]:35302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1crUd6-0001Cg-EF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1crUd2-0008DM-Cu
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:12:08 -0400
Received: from mail.kernel.org ([198.145.29.136]:40064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1crUd2-0008Bg-29
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:12:04 -0400
Date: Fri, 24 Mar 2017 12:11:59 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <671b281d-4536-0117-b9a2-b6b72242d3f5@suse.com>
Message-ID: <alpine.DEB.2.10.1703241153340.8001@sstabellini-ThinkPad-X260>
References: <1490376002-1223-1-git-send-email-paul.durrant@citrix.com>
	<671b281d-4536-0117-b9a2-b6b72242d3f5@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH RESEND] xen: limit pkg-config to
 PKG_CONFIG_PATH for xen libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

On Fri, 24 Mar 2017, Juergen Gross wrote:
> On 24/03/17 18:20, Paul Durrant wrote:
> > The Xen tools Makefile has been modified to set PKG_CONFIG_PATH such that
> > use of pkg-config in QEMU configure finds the newly built Xen libraries.
> > However, because older versions of Xen do not set PKG_CONFIG_PATH in the
> > Makefile, the QEMU configure script will pick up any Xen libraries that may
> > be installed in the build system rather than the newly built ones. Thus,
> > if Xen 4.9 is built and installed it becomes impossible to build tools for
> > an older version of Xen on the same system (without manual de-installtion).
> > 
> > This patch modifies configure to set PKG_CONFIG_LIBDIR to empty when
> > looking for Xen libraries to ensure the search is limited only to
> > PKG_CONFIG_PATH. This makes sure that, for versions of Xen prior to 4.9,
> > pkg-config fails to find the Xen libraries an approriately falls back to
> > previous methods of probing.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Paul, thanks for spotting this. I didn't spot it because I don't have
Xen installed in my build environment, but we should not rely on that. 


> NAK. You are breaking normal qemu build with installed Xen pkg-config
> files.
 
The normal QEMU build, done as part of the xen-unstable build, is
actually done without Xen being installed in the system. So, if I am not
mistaken, the current mechanism also breaks the following entirely
legitimate scenario:

- user has 4.9 installed on her system
- user git clones xen 4.10
- user build xen 4.10
  - as part of the xen build, qemu is cloned and built
  - the qemu configure script picks up the pkgconfig file from
    /usr/share and misconfigure the xen version, setting it to 4.9
    instead of 4.10
  - the qemu build fails
- the xen build fails

Am I right?

Regardless, both cases need to work correctly. A lot of people rely on
out of tree builds, including cross-compilations and openembedded. This
is a regression.

I suggest we set PKG_CONFIG_LIBDIR (or PKG_CONFIG_PATH?) to the right
place depending on where the configure script is picking up the Xen
header files:

- If the configure script picks up the Xen header files from /usr/include,
then we want the pkgconfig dir to be /usr/share/pkgconfig.

- If the configure script picks up the Xen header files from
/local/xen-unstable.git/tools/libxc/include, then we want the pkgconfig
dir to be local/xen-unstable.git/tools/pkg-config.

If that's too complex, we can always go back to the good old,
non-pkgconfig days.


> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Juergen Gross <jgross@suse.com>
> > ---
> >  configure | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/configure b/configure
> > index fdf47e4..6ef5980 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1974,6 +1974,10 @@ fi
> >  ##########################################
> >  # xen probe
> >  
> > +xen_query_pkg_config() {
> > +    PKG_CONFIG_LIBDIR= ${pkg_config_exe} "$@"
> > +}
> > +
> >  if test "$xen" != "no" ; then
> >    xen_libs="-lxenstore -lxenctrl -lxenguest"
> >    xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
> > @@ -1997,9 +2001,9 @@ EOF
> >      xen=no
> >  
> >    # Xen version via pkg-config (Xen 4.9.0 and newer)
> > -  elif $pkg_config --exists xencontrol ; then
> > +  elif xen_query_pkg_config --exists xencontrol; then
> >      xen_ctrl_version="$(printf '%d%02d%02d' \
> > -      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> > +      $(xen_query_pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> >      xen=yes
> >  
> >    elif
> > @@ -2216,8 +2220,8 @@ EOF
> >      if test $xen_ctrl_version -ge 40900 ; then
> >        xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab xenevtchn"
> >        xen_pc="$xen_pc xendevicemodel"
> > -      xen_libs="$($pkg_config --libs $xen_pc)"
> > -      QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> > +      xen_libs="$(xen_query_pkg_config --libs $xen_pc)"
> > +      QEMU_CFLAGS="$QEMU_CFLAGS $(xen_query_pkg_config --cflags $xen_pc)"
> >      elif test $xen_ctrl_version -ge 40701 ; then
> >        libs_softmmu="$xen_stable_libs $libs_softmmu"
> >      fi
> > 
> 
