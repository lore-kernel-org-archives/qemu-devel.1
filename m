Received: from eggs.gnu.org ([2001:4830:134:3::10]:33586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e80e7-0000H0-KW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e80e3-0003Zz-GJ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 05:09:43 -0400
Date: Fri, 27 Oct 2017 11:09:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171027090919.GB3368@localhost.localdomain>
References: <cover.1509094209.git.jcody@redhat.com>
	<2f0114c773e8fb917a7a54acccfd2e2adfb6e066.1509094209.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0114c773e8fb917a7a54acccfd2e2adfb6e066.1509094209.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] block/parallels: Don't update header
 until the first actual write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

Am 27.10.2017 um 10:57 hat Jeff Cody geschrieben:
> The on disk image format 'inuse' header field is updated blindly if the
> image is opened RDWR.  This can cause problems if the QEMU runstate is
> set to INMIGRATE, at which point the underlying file is set to INACTIVE.
> This causes an assert in bdrv_co_pwritev().
> 
> Do something similar to what is done in VHDX; latch the first write, and
> update the header the first time we modify the file.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

For VHDX, it seems that we have to have the header update in the write
path anyway, so it might be justifiable, but I think for parallels, it's
just ugly.

The conservative approach to this would be doing the header write in
.bdrv_open() only if BDRV_O_INACTIVE is cleared, and otherwise do it
during .bdrv_invalidate_cache().

By the way, random design thought: It might make sense to change
.bdrv_open() so that it always opens inactive images and then call
.bdrv_invalidate_cache() (possibly renamed to .bdrv_activate())
unconditionally even without migration.

Kevin
