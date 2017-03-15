Received: from eggs.gnu.org ([2001:4830:134:3::10]:57814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coC7C-00021q-LS
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coC79-0003J5-Il
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:49:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1coC79-0003Im-D7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 12:49:31 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170314015507.13350-1-fanc.fnst@cn.fujitsu.com> (Chao Fan's
	message of "Tue, 14 Mar 2017 09:55:07 +0800")
References: <20170314015507.13350-1-fanc.fnst@cn.fujitsu.com>
Reply-To: quintela@redhat.com
Date: Wed, 15 Mar 2017 17:49:28 +0100
Message-ID: <87varaxz6v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Change the method to calculate
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: pbonzini@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> In function cpu_physical_memory_sync_dirty_bitmap, file
> include/exec/ram_addr.h:
>
> if (src[idx][offset]) {
>     unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>     unsigned long new_dirty;
>     new_dirty = ~dest[k];
>     dest[k] |= bits;
>     new_dirty &= bits;
>     num_dirty += ctpopl(new_dirty);
> }
>
> After these codes executed, only the pages not dirtied in bitmap(dest),
> but dirtied in dirty_memory[DIRTY_MEMORY_MIGRATION] will be calculated.
> For example:
> When ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] = 0b00001111,
> and atomic_rcu_read(&migration_bitmap_rcu)->bmap = 0b00000011,
> the new_dirty will be 0b00001100, and this function will return 2 but not
> 4 which is expected.
> the dirty pages in dirty_memory[DIRTY_MEMORY_MIGRATION] are all new,
> so these should be calculated also.
>
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> ---
> v2: Remove the parameter 'num_dirty_pages_init'
>     Fix incoming parameters of trace_migration_bitmap_sync_end

Reviewed-by: Juan Quintela <quintela@redhat.com>
