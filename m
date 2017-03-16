Received: from eggs.gnu.org ([2001:4830:134:3::10]:46724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=241876a3f=anthony.perard@citrix.com>)
	id 1coUUV-000865-RF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=241876a3f=anthony.perard@citrix.com>)
	id 1coUUR-0006Pk-S1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:26:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:4980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=241876a3f=anthony.perard@citrix.com>)
	id 1coUUR-0006PM-LW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:26:47 -0400
Date: Thu, 16 Mar 2017 12:26:44 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170316122644.GC1882@perard.uk.xensource.com>
References: <1489593679-31468-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1489593679-31468-1-git-send-email-igor.druzhinin@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v5] xen: don't save/restore the physmap on
 VM save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: sstabellini@kernel.org, paul.durrant@citrix.com, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net

On Wed, Mar 15, 2017 at 04:01:19PM +0000, Igor Druzhinin wrote:
> Saving/restoring the physmap to/from xenstore was introduced to
> QEMU majorly in order to cover up the VRAM region restore issue.
> The sequence of restore operations implies that we should know
> the effective guest VRAM address *before* we have the VRAM region
> restored (which happens later). Unfortunately, in Xen environment
> VRAM memory does actually belong to a guest - not QEMU itself -
> which means the position of this region is unknown beforehand and
> can't be mapped into QEMU address space immediately.
> 
> Previously, recreating xenstore keys, holding the physmap, by the
> toolstack helped to get this information in place at the right
> moment ready to be consumed by QEMU to map the region properly.
> 
> The extraneous complexity of having those keys transferred by the
> toolstack and unnecessary redundancy prompted us to propose a
> solution which doesn't require any extra data in xenstore. The idea
> is to defer the VRAM region mapping till the point we actually know
> the effective address and able to map it. To that end, we initially
> just skip the mapping request for the framebuffer if we unable to
> map it now. Then, after the memory region restore phase, we perform
> the mapping again, this time successfully, and update the VRAM region
> metadata accordingly.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

I've tried to migrate a guest with this patch, but once migrated, the
screen is black (via VNC, keyboard is working fine).

I haven't try to migrate a guest from QEMU without this patch to a QEMU
with it.

-- 
Anthony PERARD
