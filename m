Received: from eggs.gnu.org ([209.51.188.92]:56458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=921b93e8d=anthony.perard@citrix.com>)
	id 1gn6GX-0008Fg-8Z
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=921b93e8d=anthony.perard@citrix.com>)
	id 1gn6GW-0005lI-06
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:31:45 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:13847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=921b93e8d=anthony.perard@citrix.com>)
	id 1gn6GV-0005Ra-Mt
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:31:43 -0500
Date: Fri, 25 Jan 2019 18:31:08 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190125183108.GQ1271@perard.uk.xensource.com>
References: <20190122155346.26388-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190122155346.26388-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2] xen: fix xen-bus state model to allow
 frontend re-connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Jan 22, 2019 at 03:53:46PM +0000, Paul Durrant wrote:
> There is a flaw in the xen-bus state model. To allow a frontend to re-
> connect the backend state of an online XenDevice is transitioned from
> Closed to InitWait, but this is currently done unilaterally which is
> incorrect. The backend state should remain Closed until the frontend state
> transitions to Initialising.
> 
> This patch removes the automatic backend state transition from
> xen_device_backend_state_changed() and, instead, adds an extra check in
> xen_device_frontend_state_changed() to determine whether a frontend is
> trying to re-connect to a previously Closed XenDevice. Only if this is
> found to be the case is the backend state transitioned from Closed to
> InitWait. Note that this transition will be common amongst all XenDevice
> classes and hence xen_device_frontend_state_changed() returns immediately
> afterwards without calling into the XenDeviceClass frontend_changed()
> method.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

I've tested OVMF with that patch, and states transitions looks better
when transitionning from ovmf to linux.
(Less Closed->InitWait->Closed..., and ovmf trying to win a race at
reading the backend state at the right time).

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
