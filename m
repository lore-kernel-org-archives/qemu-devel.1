Received: from eggs.gnu.org ([208.118.235.92]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1genxo-0002ci-5C
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 16:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1genxk-0003lE-23
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 16:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1genxi-0003Un-0z
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 16:22:03 -0500
Date: Wed, 2 Jan 2019 13:21:53 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA9RvgJ=6Eje1O6VEOX5S1qLnu5R_Pwbe4QAvPB4y-Zy4Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1901021321240.800@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704251134220.2875@sstabellini-ThinkPad-X260>
	<1493145313-31311-1-git-send-email-sstabellini@kernel.org>
	<1493145313-31311-9-git-send-email-sstabellini@kernel.org>
	<CAFEAcA9RvgJ=6Eje1O6VEOX5S1qLnu5R_Pwbe4QAvPB4y-Zy4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 09/21] configure: use pkg-config for
 obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, QEMU Developers <qemu-devel@nongnu.org>, Juergen Gross <jgross@suse.com>, Michael Tokarev <mjt@tls.msk.ru>

On Tue, 11 Dec 2018, Daniel wrote:
> On Tue, Dec 11, 2018 at 10:34:52AM +0000, Peter Maydell wrote:
> > On Tue, 25 Apr 2017 at 19:35, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > >
> > > From: Juergen Gross <jgross@suse.com>
> > >
> > > Instead of trying to guess the Xen version to use by compiling various
> > > test programs first just ask the system via pkg-config. Only if it
> > > can't return the version fall back to the test program scheme.
> > >
> > > If configure is being called with dedicated flags for the Xen libraries
> > > use those instead of the pkg-config output. This will avoid breaking
> > > an in-tree Xen build of an old Xen version while a new Xen version is
> > > installed on the build machine: pkg-config would pick up the installed
> > > Xen config files as the Xen tree wouldn't contain any of them.
> > >
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> > > Tested-by: Paul Durrant <paul.durrant@citrix.com>
> > > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > > ---
> > >  configure | 159 ++++++++++++++++++++++++++++++++++----------------------------
> > >  1 file changed, 88 insertions(+), 71 deletions(-)
> > >
> > > diff --git a/configure b/configure
> > > index 271bea8..3133ef8 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -1975,30 +1975,46 @@ fi
> > >  # xen probe
> > >
> > >  if test "$xen" != "no" ; then
> > > -  xen_libs="-lxenstore -lxenctrl -lxenguest"
> > > -  xen_stable_libs="-lxencall -lxenforeignmemory -lxengnttab -lxenevtchn"
> > > +  # Check whether Xen library path is specified via --extra-ldflags to avoid
> > > +  # overriding this setting with pkg-config output. If not, try pkg-config
> > > +  # to obtain all needed flags.
> > > +
> > > +  if ! echo $EXTRA_LDFLAGS | grep tools/libxc > /dev/null && \
> > > +     $pkg_config --exists xencontrol ; then
> > > +    xen_ctrl_version="$(printf '%d%02d%02d' \
> > > +      $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
> > > +    xen=yes
> > > +    xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
> > > +    xen_pc="$xen_pc xenevtchn xendevicemodel"
> > > +    QEMU_CFLAGS="$QEMU_CFLAGS $($pkg_config --cflags $xen_pc)"
> > > +    libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
> > > +    LDFLAGS="$($pkg_config --libs $xen_pc) $LDFLAGS"
> > > +  else
> > 
> > Hi -- this is an old patch, but MJT has just noticed that
> > it means that (assuming configure takes the "we have a pkg-config
> > for Xen" path) the Xen libraries get added to both libs_softmmu
> > and LDFLAGS, which means that everything, including the linux-user
> > binaries, gets linked against them. The old fallback path
> > only adds them to libs_softmmu.
> > 
> > Juergen: is there a reason why you added the libs to both
> > libs_softmmu and LDFLAGS here? Can we just delete the line
> > that alters LDFLAGS?
> 
> In the 'else' block that takes the non-pkg-config path, the libs are
> only added to "libs_softmmu". So I think removing LDFLAGS is right.

Yes, I think you are correct.
