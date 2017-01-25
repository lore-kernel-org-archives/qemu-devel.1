Received: from eggs.gnu.org ([2001:4830:134:3::10]:51591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=19161f0f8=roger.pau@citrix.com>)
	id 1cWLOZ-0006cL-UK
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=19161f0f8=roger.pau@citrix.com>)
	id 1cWLOV-0005Q4-Uw
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:05:43 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:58766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=19161f0f8=roger.pau@citrix.com>)
	id 1cWLOV-0005Pw-Fg
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:05:39 -0500
Date: Wed, 25 Jan 2017 11:05:29 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20170125110529.5rgu7xrh3gkoadog@dhcp-3-221.uk.xensource.com>
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701241315310.10192@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1701241326560.10192@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.10.1701241326560.10192@sstabellini-ThinkPad-X260>
Subject: Re: [Qemu-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Tue, Jan 24, 2017 at 01:30:02PM -0800, Stefano Stabellini wrote:
> On Tue, 24 Jan 2017, Stefano Stabellini wrote:
> > On Tue, 24 Jan 2017, Roger Pau Monné wrote:
> > > Hello,
> > > 
> > > The following commit:
> > > 
> > > commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
> > > Author: Juergen Gross <jgross@suse.com>
> > > Date:   Tue Nov 22 07:10:58 2016 +0100
> > > 
> > > xen: create qdev for each backend device
> > > 
> > > Prevents me from running QEMU on FreeBSD/Xen, the following is printed on the
> > > QEMU log:
> > > 
> > > char device redirected to /dev/pts/2 (label serial0)
> > > xen be core: xen be core: can't open gnttab device
> > > can't open gnttab device
> > > xen be core: xen be core: can't open gnttab device
> > > can't open gnttab device
> > > 
> > > # xl create -c ~/domain.cfg
> > > Parsing config from /root/domain.cfg
> > > libxl: error: libxl_dm.c:2201:device_model_spawn_outcome: Domain 32:domain 32 device model: spawn failed (rc=-3)
> > > libxl: error: libxl_create.c:1506:domcreate_devmodel_started: Domain 32:device model did not start: -3
> > > libxl: error: libxl_dm.c:2315:kill_device_model: Device Model already exited
> > > libxl: error: libxl.c:1572:libxl__destroy_domid: Domain 32:Non-existant domain
> > > libxl: error: libxl.c:1531:domain_destroy_callback: Domain 32:Unable to destroy guest
> > > libxl: error: libxl.c:1458:domain_destroy_cb: Domain 32:Destruction of domain failed
> > > # cat /var/log/xen/qemu-dm-domain.log
> > > char device redirected to /dev/pts/2 (label serial0)
> > > xen be core: xen be core: can't open gnttab device
> > > can't open gnttab device
> > > xen be core: xen be core: can't open gnttab device
> > > can't open gnttab device
> > > 
> > > I'm not really familiar with any of that code, but I think that using
> > > qdev_init_nofail is wrong, since on FreeBSD/Xen for example we don't yet
> > > support the gnttab device, so initialization of the Xen Qdisk backend can fail
> > > (and possibly the same applies to Linux if someone decides to compile a kernel
> > > without the gnttab device). Yet QEMU can be used without the Qdisk backend.
> > 
> > How did you manage to configure QEMU before? The configure script had
> > xc_gnttab_open calls in it up to Xen 4.6.
> 
> I know the answer! Because the configure script only compiles the code,
> doesn't try to run it. xc_gnttab_open compiled correctly but returned
> error when executed. Is that right?

Yes, I'm quite that's right. FreeBSD is using gnttab_unimp.c, which implements
xengnttab_open, so compilation will not fail.

> 
> 
> > I am happy to support a use case where the kernel doesn't have gntdev,
> > but it needs to be explicit: we need to detect it in the configure
> > script, then avoid the initialization of devices which require it.
> 
> I would still prefer configure to be able to detect this case. If it
> cannot be made to detect it, then we can try to figure out a way to
> catch the initialization errors at run time. 

I think it's better to simply fail to initialize Xen Qdisk at runtime, or else
a xen-tools/QEMU compiled on a non-Xen environment won't get gnttab and as a
consequence Xen Qdisk support enabled, and I think it's quite common for
distros to compile Xen packages on non-Xen environments (where /dev/xen/gnttab
is not available).

Roger.
