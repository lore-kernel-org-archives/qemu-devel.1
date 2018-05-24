Received: from eggs.gnu.org ([2001:4830:134:3::10]:54307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fLqc8-00087a-T7
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fLqc3-0006sh-3l
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:49:09 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:53821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1fLqc2-0006rr-Nj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:49:03 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w51in7dch1l.fsf@maestria.local.igalia.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-20-pbonzini@redhat.com>
	<w51in7dch1l.fsf@maestria.local.igalia.com>
Date: Thu, 24 May 2018 15:49:00 +0200
Message-ID: <w51fu2hcgfn.fsf@maestria.local.igalia.com>
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

On Thu 24 May 2018 03:35:50 PM CEST, Alberto Garcia wrote:
> On Mon 05 Jun 2017 02:39:08 PM CEST, Paolo Bonzini wrote:
>> @@ -102,6 +107,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
>>  
>>      assert(cookie->type < BLOCK_MAX_IOTYPE);
>>  
>> +    qemu_mutex_lock(&stats->lock);
>
> QEMU crashes because this lock is not initialized if you do aio_read
> directly from a BDS not attached to a BlockBackend (should that
> operation be legal at all?)

I see, hmp_qemu_io() creates a temporary BlockBackend in these
situations, so I guess what we need is something like this:

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 9b3cd00af6..7b195ec4e3 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1294,6 +1294,7 @@ static void aio_read_done(void *opaque, int ret)
     print_report("read", &t2, ctx->offset, ctx->qiov.size,
                  ctx->qiov.size, 1, ctx->Cflag);
 out:
+    blk_unref(ctx->blk);
     qemu_io_free(ctx->buf);
     qemu_iovec_destroy(&ctx->qiov);
     g_free(ctx);
@@ -1392,6 +1393,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv)
     gettimeofday(&ctx->t1, NULL);
     block_acct_start(blk_get_stats(blk), &ctx->acct, ctx->qiov.size,
                      BLOCK_ACCT_READ);
+    blk_ref(blk);
     blk_aio_preadv(blk, ctx->offset, &ctx->qiov, 0, aio_read_done,
     ctx);
     return 0;
 }

Berto
