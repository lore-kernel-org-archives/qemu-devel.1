Received: from eggs.gnu.org ([2001:4830:134:3::10]:47091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=19068b32a=roger.pau@citrix.com>)
	id 1cW4Cs-00069p-EP
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=19068b32a=roger.pau@citrix.com>)
	id 1cW4Cp-0000qv-By
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:44:30 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:12019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=19068b32a=roger.pau@citrix.com>)
	id 1cW4Cp-0000qf-2n
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:44:27 -0500
Date: Tue, 24 Jan 2017 16:42:53 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Message-ID: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
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

Hello,

The following commit:

commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894
Author: Juergen Gross <jgross@suse.com>
Date:   Tue Nov 22 07:10:58 2016 +0100

xen: create qdev for each backend device

Prevents me from running QEMU on FreeBSD/Xen, the following is printed on the
QEMU log:

char device redirected to /dev/pts/2 (label serial0)
xen be core: xen be core: can't open gnttab device
can't open gnttab device
xen be core: xen be core: can't open gnttab device
can't open gnttab device

# xl create -c ~/domain.cfg
Parsing config from /root/domain.cfg
libxl: error: libxl_dm.c:2201:device_model_spawn_outcome: Domain 32:domain 32 device model: spawn failed (rc=-3)
libxl: error: libxl_create.c:1506:domcreate_devmodel_started: Domain 32:device model did not start: -3
libxl: error: libxl_dm.c:2315:kill_device_model: Device Model already exited
libxl: error: libxl.c:1572:libxl__destroy_domid: Domain 32:Non-existant domain
libxl: error: libxl.c:1531:domain_destroy_callback: Domain 32:Unable to destroy guest
libxl: error: libxl.c:1458:domain_destroy_cb: Domain 32:Destruction of domain failed
# cat /var/log/xen/qemu-dm-domain.log
char device redirected to /dev/pts/2 (label serial0)
xen be core: xen be core: can't open gnttab device
can't open gnttab device
xen be core: xen be core: can't open gnttab device
can't open gnttab device

I'm not really familiar with any of that code, but I think that using
qdev_init_nofail is wrong, since on FreeBSD/Xen for example we don't yet
support the gnttab device, so initialization of the Xen Qdisk backend can fail
(and possibly the same applies to Linux if someone decides to compile a kernel
without the gnttab device). Yet QEMU can be used without the Qdisk backend.

Roger.
