Received: from eggs.gnu.org ([2001:4830:134:3::10]:59486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW0Za-0000WN-L6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cW0ZZ-0006At-Td
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:51:42 -0500
References: <20170124095350.16679-1-stefanha@redhat.com>
	<20170124120431.GB13714@lemon.Home>
	<1c28bff5-4a36-5343-801c-dd4f891cf307@redhat.com>
	<20170124124719.GG27126@lemon.Home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09a28062-5f21-7922-a945-6d4ec9fad5c9@redhat.com>
Date: Tue, 24 Jan 2017 13:51:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170124124719.GG27126@lemon.Home>
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
To: Fam Zheng <famz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org



On 24/01/2017 13:47, Fam Zheng wrote:
>> I'm not sure I understand why this is related.  aio_poll() only tries
>> poll mode once, so bdrv_flush would only spin until the fsync is complete.
>
> Right, I was confused.  The problematic ones are "drain" style ones that tracks
> a inflight counter. The only suspecious one is in v9fs_reset(), otherwise we are
> safe!

And v9fs_reset in turn is fine because it doesn't use
virtio_queue_aio_set_host_notifier_handler (so it goes to
event_notifier_set_handler and then iohandler_ctx, not
qemu_get_aio_context()).

Paolo
