Received: from eggs.gnu.org ([2001:4830:134:3::10]:54414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clbuz-0001VM-99
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clbuw-00034W-1U
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:46:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1clbuv-00034B-PB
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 08:46:13 -0500
Date: Wed, 8 Mar 2017 13:45:59 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170308134559.GK7470@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170308082819.12196-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170308082819.12196-1-fanc.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2] Add inst_dirty_pages_rate in 'info
 migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com, eblake@redhat.com, armbru@redhat.com, douly.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com

On Wed, Mar 08, 2017 at 04:28:19PM +0800, Chao Fan wrote:
> Auto-converge aims to accelerate migration by slowing down the
> generation of dirty pages. But user doesn't know how to determine the
> throttle value, so, a new item "inst-dirty-pages-rate" in "info migrate"
> would be helpful for user's determination.

The "info migrate" command already reports a "dirty-pages-rate" value.

Maybe I'm mis-understanding what you're calculcating, this this proposal
looks the same, except reporting in bytes rather than page counts.

QEMU in fact already records the bytes count internally too in the
'dirty_pages_bytes' parameter which is calculated from taking
'dirty_pages_size * TARGET_PAGE_SIZE'.

So I wonder if we can just export the existing dirty-pages-bytes
value in info migrate, and avoid needing this new code here:

> +static void migration_inst_rate(void)
> +{
> +    int64_t dirty_pages_time_now;
> +    if (!dirty_pages_time_prev) {
> +        dirty_pages_time_prev = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    }
> +    dirty_pages_time_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (dirty_pages_time_now > dirty_pages_time_prev + 1000) {
> +        RAMBlock *block;
> +        MigrationState *s = migrate_get_current();
> +        int64_t inst_dirty_pages = 0;
> +        int64_t i;
> +        unsigned long *num;
> +        unsigned long len = 0;
> +
> +        rcu_read_lock();
> +        DirtyMemoryBlocks *blocks = atomic_rcu_read(
> +                         &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]);
> +        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +            if (len == 0) {
> +                len = block->offset;
> +            }
> +            len += block->used_length;
> +        }
> +        ram_addr_t idx = (len >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
> +        if (((len >> TARGET_PAGE_BITS) % DIRTY_MEMORY_BLOCK_SIZE) != 0) {
> +            idx++;
> +        }
> +        for (i = 0; i < idx; i++) {
> +            num = blocks->blocks[i];
> +            inst_dirty_pages += bitmap_weight(num, DIRTY_MEMORY_BLOCK_SIZE);
> +        }
> +        rcu_read_unlock();
> +
> +        s->inst_dirty_pages_rate = inst_dirty_pages * TARGET_PAGE_SIZE *
> +                    1000 / (dirty_pages_time_now - dirty_pages_time_prev);
> +    }
> +    dirty_pages_time_prev = dirty_pages_time_now;
>  }

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
