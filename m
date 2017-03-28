Received: from eggs.gnu.org ([2001:4830:134:3::10]:39689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cswQf-0005pL-Jk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cswQa-0006fe-Kt
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cswQa-0006fR-Cd
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:05:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45D6F1C13C0
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 19:05:11 +0000 (UTC)
Date: Tue, 28 Mar 2017 20:05:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170328190507.GJ5740@work-vm>
References: <20170323210124.12300-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323210124.12300-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Split migration bitmaps by ramblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Hi
> 
> This series split the migration and unsent bitmaps by ramblock.  This
> makes it easier to synchronize in small bits.  This is on top of the
> RAMState and not-hotplug series.

So I think generally this is a good idea; my main reason is I'd like
to see per-NUMA node syncing, preferably tied with multi-fd so that
each of the NUMA nodes syncs and stuffs data over it's own NIC.
Although we would still have to be careful about cases where one
node is hammering it's RAM and the others are idleing.

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

There are some fun problems with changing the bitmap page size;
off the top of my head, the ones I can remember include:
    a) I'm sure I've seen rare cases where a target page is marked as
       dirty inside a hostpage; I'm guessing that was qemu's doing, but
       there are more subtle cases, e.g. running a 4kb guest on a 64kb host;
       it's legal - and 4kb power guests used to exist;  I think in those
       cases you see KVM only marking one target page as dirty.

    b) Are we required to support migration across hosts of different pagesize;
       and if we do that what size should a bit represent?
       People asked about it during postcopy but I think it's restricted to
       matching sizes.  I don't think precopy has any requirement for matching
       host pagesize at the moment.  64bit ARM does 4k, 64k and I think 16k was
       added later.

    c) Hugepages have similar issues; precopy doesn't currently have any
       requirement for the hugepage selection on the two hosts to match,
       but it does on postcopy.  Also you don't want to have a single dirty
       bit for a 1GB host hugepage if you can handle detecting changes at
       a finer grain level.

Dave
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
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
