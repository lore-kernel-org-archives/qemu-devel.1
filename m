Received: from eggs.gnu.org ([2001:4830:134:3::10]:40574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crUyU-0000W5-OY
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crUyR-0007Jm-IV
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:34:14 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:27148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=249263d75=Paul.Durrant@citrix.com>)
	id 1crUyR-0007J0-7N
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:34:11 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 24 Mar 2017 19:34:08 +0000
Message-ID: <4334f125a9174a2e99e5b6f1228da2cd@AMSPEX02CL03.citrite.net>
References: <1490376002-1223-1-git-send-email-paul.durrant@citrix.com>
	<671b281d-4536-0117-b9a2-b6b72242d3f5@suse.com>
	<alpine.DEB.2.10.1703241153340.8001@sstabellini-ThinkPad-X260>
	<2a218de0a59a4060b00a0f3839323d37@AMSPEX02CL03.citrite.net>
In-Reply-To: <2a218de0a59a4060b00a0f3839323d37@AMSPEX02CL03.citrite.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Stefano Stabellini' <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Paul Durrant
> Sent: 24 March 2017 19:18
> To: 'Stefano Stabellini' <sstabellini@kernel.org>; Juergen Gross
> <jgross@suse.com>
> Cc: Anthony Perard <anthony.perard@citrix.com>; xen-
> devel@lists.xenproject.org; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] [PATCH RESEND] xen: limit pkg-config to
> PKG_CONFIG_PATH for xen libraries
>=20
> > -----Original Message-----
> > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > Sent: 24 March 2017 19:12
> > To: Juergen Gross <jgross@suse.com>
> > Cc: Paul Durrant <Paul.Durrant@citrix.com>; qemu-devel@nongnu.org;
> xen-
> > devel@lists.xenproject.org; Anthony Perard
> <anthony.perard@citrix.com>;
> > Stefano Stabellini <sstabellini@kernel.org>
> > Subject: Re: [PATCH RESEND] xen: limit pkg-config to PKG_CONFIG_PATH
> for
> > xen libraries
> >
> > On Fri, 24 Mar 2017, Juergen Gross wrote:
> > > On 24/03/17 18:20, Paul Durrant wrote:
> > > > The Xen tools Makefile has been modified to set PKG_CONFIG_PATH
> > such that
> > > > use of pkg-config in QEMU configure finds the newly built Xen libra=
ries.
> > > > However, because older versions of Xen do not set
> PKG_CONFIG_PATH
> > in the
> > > > Makefile, the QEMU configure script will pick up any Xen libraries =
that
> > may
> > > > be installed in the build system rather than the newly built ones. =
Thus,
> > > > if Xen 4.9 is built and installed it becomes impossible to build to=
ols for
> > > > an older version of Xen on the same system (without manual de-
> > installtion).
> > > >
> > > > This patch modifies configure to set PKG_CONFIG_LIBDIR to empty
> when
> > > > looking for Xen libraries to ensure the search is limited only to
> > > > PKG_CONFIG_PATH. This makes sure that, for versions of Xen prior to
> > 4.9,
> > > > pkg-config fails to find the Xen libraries an approriately falls ba=
ck to
> > > > previous methods of probing.
> > > >
> > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> >
> > Paul, thanks for spotting this. I didn't spot it because I don't have
> > Xen installed in my build environment, but we should not rely on that.
> >
> >
> > > NAK. You are breaking normal qemu build with installed Xen pkg-config
> > > files.
> >
> > The normal QEMU build, done as part of the xen-unstable build, is
> > actually done without Xen being installed in the system. So, if I am no=
t
> > mistaken, the current mechanism also breaks the following entirely
> > legitimate scenario:
> >
> > - user has 4.9 installed on her system
> > - user git clones xen 4.10
> > - user build xen 4.10
> >   - as part of the xen build, qemu is cloned and built
> >   - the qemu configure script picks up the pkgconfig file from
> >     /usr/share and misconfigure the xen version, setting it to 4.9
> >     instead of 4.10
> >   - the qemu build fails
> > - the xen build fails
> >
> > Am I right?
> >
>=20
> I think the above would actually work because the 4.10 files would be fou=
nd
> before the 4.9 files. What fails is installing 4.9 and then trying to bui=
ld 4.8.

I should qualify that with saying 'trying to build 4.8 with a newer QEMU (i=
.e. one that has a configure which knows about pkg-config).
I still think that's a legitimate use-case though.

  Paul

>=20
> > Regardless, both cases need to work correctly. A lot of people rely on
> > out of tree builds, including cross-compilations and openembedded. This
> > is a regression.
> >
> > I suggest we set PKG_CONFIG_LIBDIR (or PKG_CONFIG_PATH?) to the
> right
> > place depending on where the configure script is picking up the Xen
> > header files:
> >
> > - If the configure script picks up the Xen header files from /usr/inclu=
de,
> > then we want the pkgconfig dir to be /usr/share/pkgconfig.
> >
> > - If the configure script picks up the Xen header files from
> > /local/xen-unstable.git/tools/libxc/include, then we want the pkgconfig
> > dir to be local/xen-unstable.git/tools/pkg-config.
> >
>=20
> Yes, that's what is needed.
>=20
> > If that's too complex, we can always go back to the good old,
> > non-pkgconfig days.
> >
>=20
> Unless this can be speedily resolved I think reverting the pkg-config cha=
nges
> would be best.
>=20
> Another possibility perhaps would be an explicit configure flag for in-tr=
ee and
> out-of-tree builds so we can say exactly where QEMU should be getting its
> environment from?
>=20
>   Paul
>=20
> >
> > > > Cc: Anthony Perard <anthony.perard@citrix.com>
> > > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > > > Cc: Juergen Gross <jgross@suse.com>
> > > > ---
> > > >  configure | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/configure b/configure
> > > > index fdf47e4..6ef5980 100755
> > > > --- a/configure
> > > > +++ b/configure
> > > > @@ -1974,6 +1974,10 @@ fi
> > > >  ##########################################
> > > >  # xen probe
> > > >
> > > > +xen_query_pkg_config() {
> > > > +    PKG_CONFIG_LIBDIR=3D ${pkg_config_exe} "$@"
> > > > +}
> > > > +
> > > >  if test "$xen" !=3D "no" ; then
> > > >    xen_libs=3D"-lxenstore -lxenctrl -lxenguest"
> > > >    xen_stable_libs=3D"-lxenforeignmemory -lxengnttab -lxenevtchn"
> > > > @@ -1997,9 +2001,9 @@ EOF
> > > >      xen=3Dno
> > > >
> > > >    # Xen version via pkg-config (Xen 4.9.0 and newer)
> > > > -  elif $pkg_config --exists xencontrol ; then
> > > > +  elif xen_query_pkg_config --exists xencontrol; then
> > > >      xen_ctrl_version=3D"$(printf '%d%02d%02d' \
> > > > -      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> > > > +      $(xen_query_pkg_config --modversion xencontrol | sed 's/\./ =
/g')
> )"
> > > >      xen=3Dyes
> > > >
> > > >    elif
> > > > @@ -2216,8 +2220,8 @@ EOF
> > > >      if test $xen_ctrl_version -ge 40900 ; then
> > > >        xen_pc=3D"xencontrol xenstore xenguest xenforeignmemory
> > xengnttab xenevtchn"
> > > >        xen_pc=3D"$xen_pc xendevicemodel"
> > > > -      xen_libs=3D"$($pkg_config --libs $xen_pc)"
> > > > -      QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> > > > +      xen_libs=3D"$(xen_query_pkg_config --libs $xen_pc)"
> > > > +      QEMU_CFLAGS=3D"$QEMU_CFLAGS $(xen_query_pkg_config --
> cflags
> > $xen_pc)"
> > > >      elif test $xen_ctrl_version -ge 40701 ; then
> > > >        libs_softmmu=3D"$xen_stable_libs $libs_softmmu"
> > > >      fi
> > > >
> > >
