Received: from eggs.gnu.org ([2001:4830:134:3::10]:54374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLqcN-0008Kt-Pv
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fLqcK-0006yE-Nu
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:49:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fLqcK-0006y4-Im
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:49:20 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-20-pbonzini@redhat.com>
	<w51in7dch1l.fsf@maestria.local.igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e934c42-1c5c-14d8-ec42-5d2426888819@redhat.com>
Date: Thu, 24 May 2018 15:49:14 +0200
MIME-Version: 1.0
In-Reply-To: <w51in7dch1l.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/19] block: make accounting thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, Greg Kurz <gkurz@linux.vnet.ibm.com>

On 24/05/2018 15:35, Alberto Garcia wrote:
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
> 
> $ qemu-system-x86_64 -monitor stdio \
> -blockdev driver=qcow2,file.driver=file,file.filename=hd0.img,node-name=hd0
> 
> (qemu) qemu-io hd0 "aio_read 0 1M"
> qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
> Aborted

The lock is initialized but it has been destroyed via qemu_mutex_destroy
before you reach this point.  So the bug is actually much more than just
the uninitialized lock!

The destruction happens when blk_delete calls block_acct_cleanup.  It
should be fixed by Greg Kurz's patch that adds a bdrv_drained_begin/end
pair to bdrv_root_unref_child.

Thanks,

Paolo
