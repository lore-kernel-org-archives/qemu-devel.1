Received: from eggs.gnu.org ([2001:4830:134:3::10]:49819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW00P-0001qJ-75
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW00M-0004ER-1s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:15:21 -0500
References: <20170124095350.16679-1-stefanha@redhat.com>
	<20170124120431.GB13714@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c28bff5-4a36-5343-801c-dd4f891cf307@redhat.com>
Date: Tue, 24 Jan 2017 13:15:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170124120431.GB13714@lemon.Home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] aio-posix: honor is_external in AioContext
 polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org



On 24/01/2017 13:04, Fam Zheng wrote:
> 
> All in all I think we should skip external handlers regardless of
> aio_disable_external(), or even skip try_poll_mode, in nested aio_poll()'s. The
> reasons are 1) many nested aio_poll()'s don't have bdrv_drained_begin, so this
> check is not sufficient [...] bdrv_flush()
> spin longer than necessary, if not forever, when the guest keeps submitting more
> requests with ioeventfd.


I'm not sure I understand why this is related.  aio_poll() only tries
poll mode once, so bdrv_flush would only spin until the fsync is complete.

Nested aio_polls don't have bdrv_drained_begin because draining matters
over the whole section where you need atomicity (e.g. taking a live
snapshot).  It doesn't matter for single I/O operation.

Paolo
