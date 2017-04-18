Received: from eggs.gnu.org ([2001:4830:134:3::10]:46852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2740b9405=Paul.Durrant@citrix.com>)
	id 1d0Pw9-00006W-70
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2740b9405=Paul.Durrant@citrix.com>)
	id 1d0Pw6-0007ah-6d
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:00:41 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:25233
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2740b9405=Paul.Durrant@citrix.com>)
	id 1d0Pw5-0007Zz-Sd
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:00:38 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 18 Apr 2017 10:00:34 +0000
Message-ID: <03cfd81856554ecd91c0c317353e819b@AMSPEX02CL03.citrite.net>
References: <alpine.DEB.2.10.1704141429110.23677@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1704141734161.23677@sstabellini-ThinkPad-X260>
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
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 15 April 2017 01:40
> To: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; qemu-devel@nongnu.org;
> Anthony Perard <anthony.perard@citrix.com>; Wei Liu
> <wei.liu2@citrix.com>; jgross@suse.com; julien.grall@arm.com; xen-
> devel@lists.xenproject.org
> Subject: Re: QEMU build breakage on ARM against Xen 4.9 caused by
> libxendevicemodel
>=20
> On Fri, 14 Apr 2017, Stefano Stabellini wrote:
> > Hi Paul,
> >
> > The following commit in my qemu "next" branch breaks the build on arm
> > and arm64:
> >
> > commit 670271647ad15e9d937ced7a72c892349c709216
> > Author: Paul Durrant <paul.durrant@citrix.com>
> > Date:   Tue Mar 7 10:55:34 2017 +0000
> >
> >     xen: use libxendevicemodel when available
> >
> > See the appended build log. Sorry for not realizing it sooner.
>=20
> As I imagined, this bug is easy to solve. It is reproducible on x86 too,
> if you pass -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1 to configure and
> forcefully disable Xen 4.9 detection in the configure script.
>=20
> If QEMU detects xen_ctrl_version =3D 480, the build will fail against Xen
> 4.9, even when -DXC_WANT_COMPAT_DEVICEMODEL_API=3D1 is specified.
>=20
> The appended patch solves the problem. However, Xen 4.9 detection and
> compilation remain broken.

Ok, that fix looks fine to me.

  Paul

>=20
> ---
>=20
> diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> index 274accc..b1f5f53 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -9,7 +9,6 @@
>  #undef XC_WANT_COMPAT_EVTCHN_API
>  #undef XC_WANT_COMPAT_GNTTAB_API
>  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
> -#undef XC_WANT_COMPAT_DEVICEMODEL_API
>=20
>  #include <xenctrl.h>
>  #include <xenstore.h>
> @@ -154,6 +153,7 @@ static inline int xendevicemodel_set_mem_type(
>=20
>  #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >=3D 490 */
>=20
> +#undef XC_WANT_COMPAT_DEVICEMODEL_API
>  #include <xendevicemodel.h>
>=20
>  #endif
