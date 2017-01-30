Received: from eggs.gnu.org ([2001:4830:134:3::10]:46180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=1964c29ca=roger.pau@citrix.com>)
	id 1cYChv-0001fe-Hl
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=1964c29ca=roger.pau@citrix.com>)
	id 1cYChr-0008L9-9v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:13:23 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:7525
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=1964c29ca=roger.pau@citrix.com>)
	id 1cYChr-0008Iu-0s
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:13:19 -0500
Date: Mon, 30 Jan 2017 14:13:05 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20170130141304.doxmygo677hhhjuj@dhcp-3-221.uk.xensource.com>
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
	<0b9ad017-4b7f-956c-4b33-8d8cbc16fd66@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b9ad017-4b7f-956c-4b33-8d8cbc16fd66@suse.com>
Subject: Re: [Qemu-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org

On Fri, Jan 27, 2017 at 12:13:58PM +0100, Juergen Gross wrote:
> On 24/01/17 17:42, Roger Pau Monné wrote:
> > Hello,
> > 
> > The following commit:
> > 
> > commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
> > Author: Juergen Gross <jgross@suse.com>
> > Date:   Tue Nov 22 07:10:58 2016 +0100
> > 
> > xen: create qdev for each backend device
> > 
> > Prevents me from running QEMU on FreeBSD/Xen, the following is printed on the
> > QEMU log:
> > 
> > char device redirected to /dev/pts/2 (label serial0)
> > xen be core: xen be core: can't open gnttab device
> > can't open gnttab device
> > xen be core: xen be core: can't open gnttab device
> > can't open gnttab device
> > 
> > # xl create -c ~/domain.cfg
> > Parsing config from /root/domain.cfg
> > libxl: error: libxl_dm.c:2201:device_model_spawn_outcome: Domain 32:domain 32 device model: spawn failed (rc=-3)
> > libxl: error: libxl_create.c:1506:domcreate_devmodel_started: Domain 32:device model did not start: -3
> > libxl: error: libxl_dm.c:2315:kill_device_model: Device Model already exited
> > libxl: error: libxl.c:1572:libxl__destroy_domid: Domain 32:Non-existant domain
> > libxl: error: libxl.c:1531:domain_destroy_callback: Domain 32:Unable to destroy guest
> > libxl: error: libxl.c:1458:domain_destroy_cb: Domain 32:Destruction of domain failed
> > # cat /var/log/xen/qemu-dm-domain.log
> > char device redirected to /dev/pts/2 (label serial0)
> > xen be core: xen be core: can't open gnttab device
> > can't open gnttab device
> > xen be core: xen be core: can't open gnttab device
> > can't open gnttab device
> > 
> > I'm not really familiar with any of that code, but I think that using
> > qdev_init_nofail is wrong, since on FreeBSD/Xen for example we don't yet
> > support the gnttab device, so initialization of the Xen Qdisk backend can fail
> > (and possibly the same applies to Linux if someone decides to compile a kernel
> > without the gnttab device). Yet QEMU can be used without the Qdisk backend.
> 
> I don't think this is due to qdev_init_nofail(). As the gnttab related
> messages are printed _after_ calling qdev_init_nofail() I don't see how
> it could be related.
> 
> I think the error exits of xen_be_get_xendev() are just wrong in using
> g_free(xendev) instead of qdev_unplug(&xendev->qdev, NULL).
> 
> I'll do a test with that modification. Could you test it in parallel?

Yes, that does indeed fix the issue. If you send the patch please add my
"Tested-by".

Roger.
