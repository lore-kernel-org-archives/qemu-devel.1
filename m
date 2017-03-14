Received: from eggs.gnu.org ([2001:4830:134:3::10]:36201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnisT-0002gV-Bp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnisP-0000E2-E1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:36:25 -0400
Received: from [59.151.112.132] (port=35094 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnisP-00009e-2b
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:36:21 -0400
Date: Tue, 14 Mar 2017 17:35:34 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Message-ID: <20170314093534.GA13034@localhost.localdomain>
References: <20170314015507.13350-1-fanc.fnst@cn.fujitsu.com>
	<8760jcuuax.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8760jcuuax.fsf@secure.mitica>
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
To: Juan Quintela <quintela@redhat.com>
Cc: pbonzini@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Mar 14, 2017 at 09:38:46AM +0100, Juan Quintela wrote:
>Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> In function cpu_physical_memory_sync_dirty_bitmap, file
>> include/exec/ram_addr.h:
>>
>> if (src[idx][offset]) {
>>     unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>>     unsigned long new_dirty;
>>     new_dirty = ~dest[k];
>>     dest[k] |= bits;
>>     new_dirty &= bits;
>>     num_dirty += ctpopl(new_dirty);
>> }
>>
>> After these codes executed, only the pages not dirtied in bitmap(dest),
>> but dirtied in dirty_memory[DIRTY_MEMORY_MIGRATION] will be calculated.
>> For example:
>> When ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] = 0b00001111,
>> and atomic_rcu_read(&migration_bitmap_rcu)->bmap = 0b00000011,
>> the new_dirty will be 0b00001100, and this function will return 2 but not
>> 4 which is expected.
>> the dirty pages in dirty_memory[DIRTY_MEMORY_MIGRATION] are all new,
>> so these should be calculated also.
>#
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>
>> ---
>> v2: Remove the parameter 'num_dirty_pages_init'
>>     Fix incoming parameters of trace_migration_bitmap_sync_end
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
Hi Juan,

Thank you for your review!

>
>Just curious, does this change show any difference in any load?
I think this method can show the new dirty pages more precisely than
before, so it's helpful to determine the cpu throttle value.

You can see this mail:
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03479.html

And according to Daniel's suggestion, 'inst-dirty-pages-rate' in my
old patch isn't needed anymore after this patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg436183.html

Thanks,
Chao Fan
>
>Later, Juan.
>
>
