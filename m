Received: from eggs.gnu.org ([2001:4830:134:3::10]:54346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=27718f940=Paul.Durrant@citrix.com>)
	id 1d1TwJ-0008Ok-8h
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=27718f940=Paul.Durrant@citrix.com>)
	id 1d1TwC-0001Wp-1c
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:12 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:11421
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=27718f940=Paul.Durrant@citrix.com>)
	id 1d1TwB-0001VW-NL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 04:29:07 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 21 Apr 2017 08:29:04 +0000
Message-ID: <940f2508180f48518e4d7d2523ccbcd7@AMSPEX02CL03.citrite.net>
References: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
	<03cfd81856554ecd91c0c317353e819b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704181038360.31486@sstabellini-ThinkPad-X260>
	<51ac3ff38f464abfb98928e6fb959bf7@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704191552450.31486@sstabellini-ThinkPad-X260>
	<6738c7d96a1c476187f69616f25b28d1@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1704201035390.18403@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1704201035390.18403@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Wei Liu <wei.liu2@citrix.com>, "jgross@suse.com" <jgross@suse.com>, "julien.grall@arm.com" <julien.grall@arm.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
[snip]
> >
> > I think xencall should be part of the base xen_stable_libs anyway.
>=20
> Yes, you are right. However I noticed that -lxencall needs to come after
> -lxendevicemodel. So, I'll have to move -lxendevicemodel before
> $xen_stable_libs, see below. I'll merge this patch into "configure:
> detect presence of libxendevicemodel", if that's OK.
>=20

Sure.

> diff --git a/configure b/configure
> index 99d6cbc..3133ef8 100755
> --- a/configure
> +++ b/configure
> @@ -1992,7 +1992,7 @@ if test "$xen" !=3D "no" ; then
>    else
>=20
>      xen_libs=3D"-lxenstore -lxenctrl -lxenguest"
> -    xen_stable_libs=3D"-lxenforeignmemory -lxengnttab -lxenevtchn"
> +    xen_stable_libs=3D"-lxencall -lxenforeignmemory -lxengnttab -lxenevt=
chn"
>=20
>      # First we test whether Xen headers and libraries are available.
>      # If no, we are done and there is no Xen support.
> @@ -2027,9 +2027,9 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -        compile_prog "" "$xen_libs $xen_stable_libs -lxendevicemodel"
> +        compile_prog "" "$xen_libs -lxendevicemodel $xen_stable_libs"
>        then
> -      xen_stable_libs=3D"$xen_stable_libs -lxendevicemodel"
> +      xen_stable_libs=3D"-lxendevicemodel $xen_stable_libs"
>        xen_ctrl_version=3D40900
>        xen=3Dyes
>      elif

LGTM.

Cheers,

  Paul
