Received: from eggs.gnu.org ([2001:4830:134:3::10]:58666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cW0VW-0005Rk-U4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cW0VW-0005AI-4A
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:47:30 -0500
Date: Tue, 24 Jan 2017 20:47:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170124124719.GG27126@lemon.Home>
References: <20170124095350.16679-1-stefanha@redhat.com>
	<20170124120431.GB13714@lemon.Home>
	<1c28bff5-4a36-5343-801c-dd4f891cf307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c28bff5-4a36-5343-801c-dd4f891cf307@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org

On Tue, 01/24 13:15, Paolo Bonzini wrote:
> 
> 
> On 24/01/2017 13:04, Fam Zheng wrote:
> > 
> > All in all I think we should skip external handlers regardless of
> > aio_disable_external(), or even skip try_poll_mode, in nested aio_poll()'s. The
> > reasons are 1) many nested aio_poll()'s don't have bdrv_drained_begin, so this
> > check is not sufficient [...] bdrv_flush()
> > spin longer than necessary, if not forever, when the guest keeps submitting more
> > requests with ioeventfd.
> 
> 
> I'm not sure I understand why this is related.  aio_poll() only tries
> poll mode once, so bdrv_flush would only spin until the fsync is complete.

Right, I was confused.  The problematic ones are "drain" style ones that tracks
a inflight counter. The only suspecious one is in v9fs_reset(), otherwise we are
safe!

Fam
