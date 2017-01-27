Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cX4Tk-0003sk-UO
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cX4Tj-0005xF-W4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:14:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:57081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cX4Tj-0005w1-My
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:14:03 -0500
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <0b9ad017-4b7f-956c-4b33-8d8cbc16fd66@suse.com>
Date: Fri, 27 Jan 2017 12:13:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
Content-Type: text/plain; charset=windows-1252
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
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

On 24/01/17 17:42, Roger Pau Monn=E9 wrote:
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

I don't think this is due to qdev_init_nofail(). As the gnttab related
messages are printed _after_ calling qdev_init_nofail() I don't see how
it could be related.

I think the error exits of xen_be_get_xendev() are just wrong in using
g_free(xendev) instead of qdev_unplug(&xendev->qdev, NULL).

I'll do a test with that modification. Could you test it in parallel?


Juergen
