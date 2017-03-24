Received: from eggs.gnu.org ([2001:4830:134:3::10]:54730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1crEUG-0000hr-MH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1crEUD-0003bD-KD
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:57:56 -0400
Received: from [45.249.212.187] (port=3011 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1crEUC-0003VY-Pt
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:57:53 -0400
References: <20170323210124.12300-1-quintela@redhat.com>
From: Yang Hongyang <yanghongyang@huawei.com>
Message-ID: <5023e01f-ee47-d066-eb7b-0ac4b8837283@huawei.com>
Date: Fri, 24 Mar 2017 09:57:31 +0800
MIME-Version: 1.0
In-Reply-To: <20170323210124.12300-1-quintela@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi Juan,

  First of all, I like the refactor patchset about RAMState, it makes
things clean, great!

On 2017/3/24 5:01, Juan Quintela wrote:
> Hi
> 
> This series split the migration and unsent bitmaps by ramblock.  This
> makes it easier to synchronize in small bits.  This is on top of the
> RAMState and not-hotplug series.
> 
> Why?
> 
> reason 1:
> 
> People have complained that by the time that we detect that a page is
> sent, it has already been marked dirty "again" inside kvm, so we are
> going to send it again.  On top of this patch, my idea is, for words
> of the bitmap that have any bit set, just synchonize the bitmap before
> sending the pages.  I have not looking into performance numbers yet,
> jsut asking for comments about how it is done.

Here you said 'synchonize the bitmap before sending the pages', do you
mean synchronize the bitmap from kvm? If so, I doubt the performance...
because every synchronization will require a ioctl(). If not, the
synchronization of per block is useless.

Currently, migration thread will synchronize the bitmap from kvm every
iter(migration_bitmap_sync()). The RAMBlock already has kind of per block
bitmap for this kind of sync. And the migration bitmap is used to put all
those per block bitmap together for data sending use.

> 
> reason 2:
> 
> In case where the host page is a multiple of the the TARGET_PAGE_SIZE,
> we do a lot of work when we are synchronizing the bitmaps to pass it
> to target page size.  The idea is to change the bitmaps on that
> RAMBlocks to mean host page size and not TARGET_PAGE_SIZE.
> 
> Note that there are two reason for this, ARM and PPC do things like
> guests with 4kb pages on hosts with 16/64kb hosts, and then we have
> HugePages.  Note all the workarounds that postcopy has to do because
> to work in HugePages size.
> 
> Please, comment?
> 
> Later, Juan.
> 
> Juan Quintela (1):
>   ram: Split dirty bitmap by RAMBlock
> 
>  include/exec/ram_addr.h |  13 +++-
>  migration/ram.c         | 201 ++++++++++++++++++------------------------------
>  2 files changed, 85 insertions(+), 129 deletions(-)
> 

-- 
Thanks,
Yang
