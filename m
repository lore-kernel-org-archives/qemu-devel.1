Received: from eggs.gnu.org ([2001:4830:134:3::10]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2iiE-0005rJ-Li
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2iiB-0001Or-Hj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2iiB-0001OO-B4
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 14:27:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1492850128-17472-8-git-send-email-zhang.zhanghailiang@huawei.com>
	(zhanghailiang's message of "Sat, 22 Apr 2017 16:35:17 +0800")
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-8-git-send-email-zhang.zhanghailiang@huawei.com>
Reply-To: quintela@redhat.com
Date: Mon, 24 Apr 2017 20:27:43 +0200
Message-ID: <87pog1oe3k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RESEND v2 07/18] COLO: Load dirty pages
 into SVM's RAM cache firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:
> We should not load PVM's state directly into SVM, because there maybe some
> errors happen when SVM is receving data, which will break SVM.
>
> We need to ensure receving all data before load the state into SVM. We use
> an extra memory to cache these data (PVM's ram). The ram cache in secondary side
> is initially the same as SVM/PVM's memory. And in the process of checkpoint,
> we cache the dirty pages of PVM into this ram cache firstly, so this ram cache
> always the same as PVM's memory at every checkpoint, then we flush this cached ram
> to SVM after we receive all PVM's state.
>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
> v2:
> - Move colo_init_ram_cache() and colo_release_ram_cache() out of
>   incoming thread since both of them need the global lock, if we keep
>   colo_release_ram_cache() in incoming thread, there are potential
>   dead-lock.
> - Remove bool ram_cache_enable flag, use migration_incoming_in_state() instead.
> - Remove the Reviewd-by tag because of the above changes.


> +out_locked:
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        if (block->colo_cache) {
> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
> +            block->colo_cache = NULL;
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    return -errno;
> +}
> +
> +/* It is need to hold the global lock to call this helper */
> +void colo_release_ram_cache(void)
> +{
> +    RAMBlock *block;
> +
> +    rcu_read_lock();
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        if (block->colo_cache) {
> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
> +            block->colo_cache = NULL;
> +        }
> +    }
> +    rcu_read_unlock();
> +}

Create a function from the creation/removal?  We have exactly two copies
of the same code.  Right now the code inside the function is very small,
but it could be bigger, no?

Later, Juan.
