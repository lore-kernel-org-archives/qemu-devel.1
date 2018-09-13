Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TNQ-00077M-BN
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TNP-0005VH-LS
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:17:52 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-9-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98c140fc-2d06-29a5-404e-0c5fe7a85629@redhat.com>
Date: Thu, 13 Sep 2018 17:17:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/17] block: Add missing locking in
 bdrv_co_drain_bh_cb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On 13/09/2018 14:52, Kevin Wolf wrote:
> bdrv_do_drained_begin/end() assume that they are called with the
> AioContext lock of bs held. If we call drain functions from a coroutine
> with the AioContext lock held, we yield and schedule a BH to move out of
> coroutine context. This means that the lock for the home context of the
> coroutine is released and must be re-acquired in the bottom half.

What exactly needs the lock, is it bdrv_drain_invoke?

Would it make sense to always do release/acquire in bdrv_drain, and
always do acquire/release in bdrv_drain_invoke?  (Conditional locking is
tricky...).

Thanks,

Paolo
