Received: from eggs.gnu.org ([2001:4830:134:3::10]:38422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze1b-0003Yp-FU
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze1a-0000vx-QI
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:27:55 -0400
Date: Tue, 11 Sep 2018 16:27:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911082746.GJ19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-10-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/14] block-backend: Fix potential double
 blk_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> blk_unref() first decreases the refcount of the BlockBackend and calls
> blk_delete() if the refcount reaches zero. Requests can still be in
> flight at this point, they are only drained during blk_delete():
> 
> At this point, arbitrary callbacks can run. If any callback takes a
> temporary BlockBackend reference, it will first increase the refcount to
> 1 and then decrease it to 0 again, triggering another blk_delete(). This
> will cause a use-after-free crash in the outer blk_delete().
> 
> Fix it by draining the BlockBackend before decreasing to refcount to 0.
> Assert in blk_ref() that it never takes the first refcount (which would
> mean that the BlockBackend is already being deleted).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Good one!

Reviewed-by: Fam Zheng <famz@redhat.com>
