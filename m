Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2277aaf80=Paul.Durrant@citrix.com>)
	id 1cjMhF-00081s-H0
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2277aaf80=Paul.Durrant@citrix.com>)
	id 1cjMhC-0008BG-CO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:06:49 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:23915
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2277aaf80=Paul.Durrant@citrix.com>)
	id 1cjMhC-00089B-3B
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 04:06:46 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 2 Mar 2017 09:06:43 +0000
Message-ID: <61002dc9691a49d98a7feca8c9a676ce@AMSPEX02CL03.citrite.net>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-5-git-send-email-paul.durrant@citrix.com>
	<20170301171735.GE1760@perard.uk.xensource.com>
In-Reply-To: <20170301171735.GE1760@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 4/5] configure: detect presence of
 libxendevicemodel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 01 March 2017 17:18
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 4/5] configure: detect presence of libxendevicemodel
>=20
> On Thu, Feb 23, 2017 at 02:53:54PM +0000, Paul Durrant wrote:
> > This patch adds code in configure to set
> CONFIG_XEN_CTRL_INTERFACE_VERSION
> > to a new value of 490 if libxendevicemodel is present in the build
> > environment.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > ---
> >  configure | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 8e8f18d..fc1e12b 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1980,6 +1980,25 @@ EOF
> >    # Xen unstable
> >    elif
> >        cat > $TMPC <<EOF &&
> > +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> > +#define __XEN_TOOLS__
>=20
> Isn't __XEN_TOOLS__ supposed to be reserved for some to tools inside
> xen.git?
>=20
> Also it seems to be the only time this define is used in your patch
> series.
>
No. QEMU falls under the definition of 'tools' as far as Xen goes and the h=
ypercalls and xendevicemodel API are protected by that. The reason you don'=
t see it elsewhere is that xenctrl.h defines it. (See http://xenbits.xen.or=
g/gitweb/?p=3Dxen.git;a=3Dblob;f=3Dtools/libxc/include/xenctrl.h;hb=3DHEAD#=
l27).
I think that's a little underhand so I thought I'd make the new code in con=
figure more transparent. I can change it to just include xenctrl.h before x=
endevicemodel.h if you'd prefer.

  Paul

> > +#include <xendevicemodel.h>
> > +int main(void) {
> > +  xendevicemodel_handle *xd;
> > +
> > +  xd =3D xendevicemodel_open(0, 0);
> > +  xendevicemodel_close(xd);
> > +
> > +  return 0;
> > +}
> > +EOF
> > +      compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> > +    then
> > +    xen_stable_libs=3D"$xen_stable_libs -lxendevicemodel"
> > +    xen_ctrl_version=3D490
> > +    xen=3Dyes
> > +  elif
> > +      cat > $TMPC <<EOF &&
> >  /*
> >   * If we have stable libs the we don't want the libxc compat
> >   * layers, regardless of what CFLAGS we may have been given.
> > --
> > 2.1.4
> >
>=20
> --
> Anthony PERARD
