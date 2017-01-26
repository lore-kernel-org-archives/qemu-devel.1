Received: from eggs.gnu.org ([2001:4830:134:3::10]:46063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWpqa-00054m-Ge
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 14:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWpqX-0008E7-BP
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 14:36:40 -0500
Received: from mail.kernel.org ([198.145.29.136]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cWpqX-0008DB-1U
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 14:36:37 -0500
Date: Thu, 26 Jan 2017 11:36:31 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170126154509.rxi5sy4bcob2ioen@dhcp-3-221.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1701261017370.2884@sstabellini-ThinkPad-X260>
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701241315310.10192@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1701241326560.10192@sstabellini-ThinkPad-X260>
	<20170125110529.5rgu7xrh3gkoadog@dhcp-3-221.uk.xensource.com>
	<20170126154509.rxi5sy4bcob2ioen@dhcp-3-221.uk.xensource.com>
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.10.1701261039010.2884@sstabellini-ThinkPad-X260>
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Thu, 26 Jan 2017, Roger Pau Monn=C3=A9 wrote:
> On Wed, Jan 25, 2017 at 11:05:29AM +0000, Roger Pau Monn=C3=A9 wrote:
> > On Tue, Jan 24, 2017 at 01:30:02PM -0800, Stefano Stabellini wrote:
> > > On Tue, 24 Jan 2017, Stefano Stabellini wrote:
> > > > On Tue, 24 Jan 2017, Roger Pau Monn=C3=A9 wrote:
> > > > > Hello,
> > > > >=20
> > > > > The following commit:
> > > > >=20
> > > > > commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
> > > > > Author: Juergen Gross <jgross@suse.com>
> > > > > Date:   Tue Nov 22 07:10:58 2016 +0100
> > > > >=20
> > > > > xen: create qdev for each backend device
> > > > >=20
> > > > > Prevents me from running QEMU on FreeBSD/Xen, the following is =
printed on the
> > > > > QEMU log:
> > > > >=20
> > > > > char device redirected to /dev/pts/2 (label serial0)
> > > > > xen be core: xen be core: can't open gnttab device
> > > > > can't open gnttab device
> > > > > xen be core: xen be core: can't open gnttab device
> > > > > can't open gnttab device
> > > > >=20
> > > > > # xl create -c ~/domain.cfg
> > > > > Parsing config from /root/domain.cfg
> > > > > libxl: error: libxl_dm.c:2201:device_model_spawn_outcome: Domai=
n 32:domain 32 device model: spawn failed (rc=3D-3)
> > > > > libxl: error: libxl_create.c:1506:domcreate_devmodel_started: D=
omain 32:device model did not start: -3
> > > > > libxl: error: libxl_dm.c:2315:kill_device_model: Device Model a=
lready exited
> > > > > libxl: error: libxl.c:1572:libxl__destroy_domid: Domain 32:Non-=
existant domain
> > > > > libxl: error: libxl.c:1531:domain_destroy_callback: Domain 32:U=
nable to destroy guest
> > > > > libxl: error: libxl.c:1458:domain_destroy_cb: Domain 32:Destruc=
tion of domain failed
> > > > > # cat /var/log/xen/qemu-dm-domain.log
> > > > > char device redirected to /dev/pts/2 (label serial0)
> > > > > xen be core: xen be core: can't open gnttab device
> > > > > can't open gnttab device
> > > > > xen be core: xen be core: can't open gnttab device
> > > > > can't open gnttab device
> > > > >=20
> > > > > I'm not really familiar with any of that code, but I think that=
 using
> > > > > qdev_init_nofail is wrong, since on FreeBSD/Xen for example we =
don't yet
> > > > > support the gnttab device, so initialization of the Xen Qdisk b=
ackend can fail
> > > > > (and possibly the same applies to Linux if someone decides to c=
ompile a kernel
> > > > > without the gnttab device). Yet QEMU can be used without the Qd=
isk backend.
> > > >=20
> > > > How did you manage to configure QEMU before? The configure script=
 had
> > > > xc_gnttab_open calls in it up to Xen 4.6.
> > >=20
> > > I know the answer! Because the configure script only compiles the c=
ode,
> > > doesn't try to run it. xc_gnttab_open compiled correctly but return=
ed
> > > error when executed. Is that right?
> >=20
> > Yes, I'm quite that's right. FreeBSD is using gnttab_unimp.c, which i=
mplements
> > xengnttab_open, so compilation will not fail.
> >=20
> > >=20
> > >=20
> > > > I am happy to support a use case where the kernel doesn't have gn=
tdev,
> > > > but it needs to be explicit: we need to detect it in the configur=
e
> > > > script, then avoid the initialization of devices which require it=
.
> > >=20
> > > I would still prefer configure to be able to detect this case. If i=
t
> > > cannot be made to detect it, then we can try to figure out a way to
> > > catch the initialization errors at run time.=20
> >=20
> > I think it's better to simply fail to initialize Xen Qdisk at runtime=
, or else
> > a xen-tools/QEMU compiled on a non-Xen environment won't get gnttab a=
nd as a
> > consequence Xen Qdisk support enabled, and I think it's quite common =
for
> > distros to compile Xen packages on non-Xen environments (where /dev/x=
en/gnttab
> > is not available).
>=20
> Ping?

Sorry for the delay. Obviously, you are correct.


> I'm not really sure how to solve this because I have zero experience wi=
th QEMU
> internals (all this qdev stuff). Can we restore the previous behavior, =
where
> the failure to initialize a device wouldn't prevent QEMU from starting?

I am convinced that we need to be able to handle the initialization
errors at run time, but I would prefer not to revert
3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894.

It should be just a matter of replacing qdev_init_nofail with something
that can fail. I couldn't find a regular qdev_init that can return
error, so maybe we would need to add it.

Juergen, would you be up for coming up with a patch?
