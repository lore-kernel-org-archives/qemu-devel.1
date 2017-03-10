Received: from eggs.gnu.org ([2001:4830:134:3::10]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cmKda-0007gL-2u
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cmKdW-0004tK-64
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:31:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cmKdV-0004sQ-U2
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 08:31:14 -0500
Date: Fri, 10 Mar 2017 13:31:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170310133108.GG32264@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170308082819.12196-1-fanc.fnst@cn.fujitsu.com>
	<20170308134559.GK7470@redhat.com>
	<20170309100538.GA22103@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309100538.GA22103@localhost.localdomain>
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

On Thu, Mar 09, 2017 at 06:05:38PM +0800, Chao Fan wrote:
> On Wed, Mar 08, 2017 at 01:45:59PM +0000, Daniel P. Berrange wrote:
> >On Wed, Mar 08, 2017 at 04:28:19PM +0800, Chao Fan wrote:
> >> Auto-converge aims to accelerate migration by slowing down the
> >> generation of dirty pages. But user doesn't know how to determine the
> >> throttle value, so, a new item "inst-dirty-pages-rate" in "info migrate"
> >> would be helpful for user's determination.
> Hi Daniel,
> 
> Thank you for your reply.
> >
> >The "info migrate" command already reports a "dirty-pages-rate" value.
> >
> >Maybe I'm mis-understanding what you're calculcating, this this proposal
> >looks the same, except reporting in bytes rather than page counts.
> >
> >QEMU in fact already records the bytes count internally too in the
> >'dirty_pages_bytes' parameter which is calculated from taking
> >'dirty_pages_size * TARGET_PAGE_SIZE'.
> >
> >So I wonder if we can just export the existing dirty-pages-bytes
> >value in info migrate, and avoid needing this new code here:
> >
> It's different, inst-dirty-pages-rate in this patch is greater than
> or equal to dirty-pages-bytes. Because in function
> cpu_physical_memory_sync_dirty_bitmap, file include/exec/ram_addr.h:
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
> After these codes, only the pages not dirtied in bitmap(dest), but dirtied
> in dirty_memory[DIRTY_MEMORY_MIGRATION] will be calculated. For example:
> When ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] = 0b00001111,
> and atomic_rcu_read(&migration_bitmap_rcu)->bmap = 0b00000011,
> the new_dirty will be 0b00001100, and this function will return 2 but not
> 4 which is expected.

Perhaps this is a reason to change how the current dirty-pages-rate and
dirty-pages-bytes values are calculated, rather than adding a new parameter
inst-dirty-pages-rate.

IMHO it will be pretty confusing to have two very similar parameters exposed
in the 'info migration' output, with subtley different calculations behind
them. You can only really understand the difference by looking at QEMU
code which is bad for apps consuming QEMU.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
