Received: from eggs.gnu.org ([2001:4830:134:3::10]:51701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fLqPz-0003gY-3y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fLqPs-0003tW-Rr
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:36:34 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:51549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1fLqPs-0003XY-Ev
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:36:28 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170605123908.18777-20-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-20-pbonzini@redhat.com>
Date: Thu, 24 May 2018 15:35:50 +0200
Message-ID: <w51in7dch1l.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 19/19] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On Mon 05 Jun 2017 02:39:08 PM CEST, Paolo Bonzini wrote:
> @@ -102,6 +107,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>  
>      assert(cookie->type < BLOCK_MAX_IOTYPE);
>  
> +    qemu_mutex_lock(&stats->lock);

QEMU crashes because this lock is not initialized if you do aio_read
directly from a BDS not attached to a BlockBackend (should that
operation be legal at all?)

$ qemu-system-x86_64 -monitor stdio \
-blockdev driver=qcow2,file.driver=file,file.filename=hd0.img,node-name=hd0

(qemu) qemu-io hd0 "aio_read 0 1M"
qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
Aborted

Berto
