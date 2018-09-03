Received: from eggs.gnu.org ([2001:4830:134:3::10]:50598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwrrq-00074b-F6
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 12:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwrrm-0000Dq-B2
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 12:38:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwrrk-0000DG-Ct
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 12:38:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180903092644.25812-2-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Mon, 3 Sep 2018 17:26:41 +0800")
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-2-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 18:38:08 +0200
Message-ID: <87ftyq35an.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/4] migration: do not
 flush_compressed_data at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> flush_compressed_data() needs to wait all compression threads to
> finish their work, after that all threads are free until the
> migration feeds new request to them, reducing its call can improve
> the throughput and use CPU resource more effectively
> We do not need to flush all threads at the end of iteration, the
> data can be kept locally until the memory block is changed or
> memory migration starts over in that case we will meet a dirtied
> page which may still exists in compression threads's ring
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

I am not so sure about this patch.

Right now, we warantee that after each iteration, all data is written
before we start a new round.

This patch changes to only "flush" the compression threads if we have
"synched" with the kvm migration bitmap.  Idea is good but as far as I
can see:

- we already call flush_compressed_data() inside firnd_dirty_block if we
  synchronize the bitmap.  So, at least, we need to update
  dirty_sync_count there.

- queued pages are "interesting", but I am not sure if compression and
  postcopy work well together.

So, if we don't need to call flush_compressed_data() every round, then
the one inside find_dirty_block() should be enough.  Otherwise, I can't
see why we need this other.


Independent of this patch:
- We always send data for every compression thread without testing if
there is any there.


> @@ -3212,7 +3225,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          }
>          i++;
>      }
> -    flush_compressed_data(rs);
>      rcu_read_unlock();
>  
>      /*

Why is not enough just to remove this call to flush_compressed_data?

Later, Juan.
