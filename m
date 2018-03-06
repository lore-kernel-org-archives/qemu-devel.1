Received: from eggs.gnu.org ([2001:4830:134:3::10]:39118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etFbP-0001R3-Dy
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etFbO-0004eq-NJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:38:11 -0500
Date: Tue, 6 Mar 2018 17:37:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306163756.GI7139@localhost.localdomain>
References: <20180301163619.21072-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301163619.21072-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Call check and invalidate_cache
 from coroutine context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 01.03.2018 um 17:36 hat Paolo Bonzini geschrieben:
> Check and invalidate_cache share some parts of the implementation
> with the regular I/O path.  This is sometimes complicated because the
> I/O path wants to use a CoMutex but that is not possible outside coroutine
> context.  By moving things to coroutine context, we can remove special
> cases.  In fact, invalidate_cache is already called from coroutine context
> because incoming migration is placed in a coroutine.
> 
> I'm including two patches from Stefan to rename the bdrv_create callback
> to bdrv_co_create, because it is already called from coroutine context.
> The name is now bdrv_co_create_opts, with bdrv_co_create reserved for
> the QAPI-based version that Kevin is working on.
> 
> qcow2 still has cache flushing in non-coroutine context, coming from
> qcow2_reopen_prepare->qcow2_update_options_prepare,
> qcow2_close->qcow2_inactivate and several dirty bitmap functions.

Thanks, applied to the block branch.

Kevin
