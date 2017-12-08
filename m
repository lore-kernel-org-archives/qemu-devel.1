Received: from eggs.gnu.org ([2001:4830:134:3::10]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNIis-0008FK-9P
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eNIir-0007xz-H8
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:29:50 -0500
Date: Fri, 8 Dec 2017 14:29:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171208132936.GB4217@localhost.localdomain>
References: <20171206144550.22295-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206144550.22295-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] blockdev: fix QMP 'transaction'
 with IOThreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>

Am 06.12.2017 um 15:45 hat Stefan Hajnoczi geschrieben:
> v2:
>  * Use StrOrNull for x-blockdev-set-iothread iothread argument [eblake]
> 
> (This is for QEMU 2.12 because this bug is not -rc4 critical)
> 
> Previously AioContext was held across QMP 'transaction' in an attempt to
> achieve bdrv_drained_begin/end() semantics.  Nowadays we have
> bdrv_drained_begin/end() and the AioContext lock just protects state.
> Therefore there is no reason to hold AioContext across
> .prepare/.commit/.abort/.clean() anymore.
> 
> Besides being cleanup-worthy, holding AioContext also exposes a bug:
> BDRV_POLL_WHILE() doesn't support recursive AioContext locking and will hang if
> depth > 1.  This is easy to trigger by submitting a transaction with 2 actions
> that touch two drives assigned to an IOThread.  The IOThread's AioContext will
> be locked twice and BDRV_POLL_WHILE() will hang.
> 
> BDRV_POLL_WHILE() is best fixed by eliminating the AioContext lock entirely in
> favor of fine-grained locking.  I discussed some fixes for BDRV_POLL_WHILE()
> with Paolo but we came to the conclusion that it will just add complexity when
> we really want to stop using AioContext locking.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

The only thing that I see that could use some improvements is the test
case, which tests only a small part of the bugs that are fixed by this
series. This doesn't invalidate any of the review, but I think without
full test coverage, it's incomplete.

Kevin
