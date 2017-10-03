Received: from eggs.gnu.org ([2001:4830:134:3::10]:34958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=442e384dd=anthony.perard@citrix.com>)
	id 1dzLfz-0003n8-UC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=442e384dd=anthony.perard@citrix.com>)
	id 1dzLfw-0007x8-Ph
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:47:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:56749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=442e384dd=anthony.perard@citrix.com>)
	id 1dzLfw-0007uk-JO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 07:47:48 -0400
Date: Tue, 3 Oct 2017 12:47:43 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171003114742.GC2116@perard.uk.xensource.com>
References: <20171002163058.15651-1-anthony.perard@citrix.com>
	<20171003113337.nkde7v236fww3npt@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171003113337.nkde7v236fww3npt@MacBook-Pro-de-Roger.local>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] migration,
 xen: Fix block image lock issue on live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu2@citrix.com>, Juan Quintela <quintela@redhat.com>, Ian Jackson <ian.jackson@eu.citrix.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, xen-devel@lists.xenproject.org

On Tue, Oct 03, 2017 at 12:33:37PM +0100, Roger Pau Monné wrote:
> On Mon, Oct 02, 2017 at 04:30:58PM +0000, Anthony PERARD wrote:
> > When doing a live migration of a Xen guest with libxl, the images for
> > block devices are locked by the original QEMU process, and this prevent
> > the QEMU at the destination to take the lock and the migration fail.
> > 
> > From QEMU point of view, once the RAM of a domain is migrated, there is
> > two QMP commands, "stop" then "xen-save-devices-state", at which point a
> > new QEMU is spawned at the destination.
> > 
> > Release locks in "xen-save-devices-state" so the destination can takes
> > them.
> 
> What happens if the migration fails on the destination? Will QEMU pick
> the lock again when resuming on the source in this case?

Yes, calling the QMP command "cont" to resume the activity makes QEMU
take the lock again, and libxl would call "cont". (I don't think you can
pick this kind of lock ;-). )

-- 
Anthony PERARD
