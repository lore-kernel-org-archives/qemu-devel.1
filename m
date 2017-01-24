Received: from eggs.gnu.org ([2001:4830:134:3::10]:51638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cW8WC-0001wn-RK
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cW8W9-0001W0-E6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:20:44 -0500
Received: from mail.kernel.org ([198.145.29.136]:53404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cW8W9-0001Vw-0o
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 16:20:41 -0500
Date: Tue, 24 Jan 2017 13:20:34 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1701241315310.10192@sstabellini-ThinkPad-X260>
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

On Tue, 24 Jan 2017, Roger Pau Monn=C3=A9 wrote:
> Hello,
>=20
> The following commit:
>=20
> commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
> Author: Juergen Gross <jgross@suse.com>
> Date:   Tue Nov 22 07:10:58 2016 +0100
>=20
> xen: create qdev for each backend device
>=20
> Prevents me from running QEMU on FreeBSD/Xen, the following is printed =
on the
> QEMU log:
>=20
> char device redirected to /dev/pts/2 (label serial0)
> xen be core: xen be core: can't open gnttab device
> can't open gnttab device
> xen be core: xen be core: can't open gnttab device
> can't open gnttab device
>=20
> # xl create -c ~/domain.cfg
> Parsing config from /root/domain.cfg
> libxl: error: libxl_dm.c:2201:device_model_spawn_outcome: Domain 32:dom=
ain 32 device model: spawn failed (rc=3D-3)
> libxl: error: libxl_create.c:1506:domcreate_devmodel_started: Domain 32=
:device model did not start: -3
> libxl: error: libxl_dm.c:2315:kill_device_model: Device Model already e=
xited
> libxl: error: libxl.c:1572:libxl__destroy_domid: Domain 32:Non-existant=
 domain
> libxl: error: libxl.c:1531:domain_destroy_callback: Domain 32:Unable to=
 destroy guest
> libxl: error: libxl.c:1458:domain_destroy_cb: Domain 32:Destruction of =
domain failed
> # cat /var/log/xen/qemu-dm-domain.log
> char device redirected to /dev/pts/2 (label serial0)
> xen be core: xen be core: can't open gnttab device
> can't open gnttab device
> xen be core: xen be core: can't open gnttab device
> can't open gnttab device
>=20
> I'm not really familiar with any of that code, but I think that using
> qdev_init_nofail is wrong, since on FreeBSD/Xen for example we don't ye=
t
> support the gnttab device, so initialization of the Xen Qdisk backend c=
an fail
> (and possibly the same applies to Linux if someone decides to compile a=
 kernel
> without the gnttab device). Yet QEMU can be used without the Qdisk back=
end.

How did you manage to configure QEMU before? The configure script had
xc_gnttab_open calls in it up to Xen 4.6.

I am happy to support a use case where the kernel doesn't have gntdev,
but it needs to be explicit: we need to detect it in the configure
script, then avoid the initialization of devices which require it.
