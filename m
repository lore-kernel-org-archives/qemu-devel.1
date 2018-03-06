Received: from eggs.gnu.org ([2001:4830:134:3::10]:48233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etASr-0004vR-4T
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etASq-0005iG-7o
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:09:01 -0500
Date: Tue, 6 Mar 2018 12:08:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180306110844.GC7139@localhost.localdomain>
References: <20180306105354.15197-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306105354.15197-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: make BDRV_POLL_WHILE() re-entrancy
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 06.03.2018 um 11:53 hat Stefan Hajnoczi geschrieben:
> Nested BDRV_POLL_WHILE() calls can occur.  Currently
> assert(!bs_->wakeup) will fail when this happens.
> 
> This patch converts bs->wakeup from bool to a counter.
> 
> Nesting works correctly because outer BDRV_POLL_WHILE() callers evaluate
> the condition again after the inner caller completes (invoking the inner
> caller counts as aio_poll() progress).
> 
> Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Doesn't this conflict with your own AIO_WAIT_WHILE() patch?

Kevin
