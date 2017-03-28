Received: from eggs.gnu.org ([2001:4830:134:3::10]:53565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csvSr-0006gi-Oh
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csvSo-0003Uf-Fb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1csvSo-0003UX-Ag
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:03:26 -0400
Date: Tue, 28 Mar 2017 19:03:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170328180321.GH5740@work-vm>
References: <20170323205025.12113-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323205025.12113-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/2] Disable hotplug during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, lizhijian@cn.fujitsu.com, wency@cn.fujitsu.com
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Hi
> 
> This series disable hotplug/unplug during migration.  Thank to Markus
> for explaining where I had to put the checks.  Why?  Because during
> migration we will fail if there are changes.  For instance, in
> postcopy, if we add a memory region, we would failing.  Same for other
> devices if they are not setup exactly the same on destination.
> 
> Iidea would be to disable it, andthen enable for the thing that we know that work.
> 
> This series are on top of my previous RAMState v2 serie.
> 
> Commets, please?

So I think this is probably a good idea, but we should ask Li Zhijian who added
migration_bitmap_extend if the reason for adding it was because they
needed the hot add to work.
cc'd.

IMHO we really need a 'configuration change mutex' that you can take
to stop any changes in the VM hardware, and that would probably reduce
a lot of the places that hold the BQL for just stopping changes.

Dave

> 
> Thanks, Juan.
> 
> 
> Juan Quintela (2):
>   migration: Disable hotplug/unplug during migration
>   ram: remove migration_bitmap_extend()
> 
>  exec.c                  |  1 -
>  hw/core/qdev.c          |  5 +++++
>  include/exec/ram_addr.h |  2 --
>  migration/ram.c         | 34 ----------------------------------
>  qdev-monitor.c          |  7 ++++++-
>  5 files changed, 11 insertions(+), 38 deletions(-)
> 
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
