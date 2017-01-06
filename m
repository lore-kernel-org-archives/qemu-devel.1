Received: from eggs.gnu.org ([2001:4830:134:3::10]:47358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPKTG-00054P-KE
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 21:41:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPKTB-0006dM-IU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 21:41:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPKTB-0006cg-AP
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 21:41:29 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A13E804EF
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 02:41:28 +0000 (UTC)
Date: Fri, 6 Jan 2017 10:41:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170106024118.GA4135@pxdev.xzpeter.org>
References: <1483610987-24331-1-git-send-email-peterx@redhat.com>
	<1483610987-24331-2-git-send-email-peterx@redhat.com>
	<20170105124958.GC2332@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170105124958.GC2332@work-vm>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: allow to prioritize save
 state entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, mst@redhat.com, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 05, 2017 at 12:49:59PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > During migration, save state entries are saved/loaded without a specific
> > order - we just traverse the savevm_state.handlers list and do it one by
> > one. This might not be enough in the future.
> > 
> > There is case that we need to load specific device's vmstate first
> > before others. For example, VT-d IOMMU contains DMA address remapping
> > information, which is required by all the PCI devices to do address
> > translations. We need to make sure IOMMU's device state is loaded before
> > the rest of the PCI devices, so that DMA address translation can work
> > properly.
> > 
> > This patch provide a VMStateDescription.priority value to allow specify
> > the priority of the saved states. The loadvm operation will be done with
> > those devices with higher vmsd priority.
> > 
> > Current ordering logic is still naive and slow, but after all that's not
> > a critical path so IMO it's a workable solution for now.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/vmstate.h |  1 +
> >  migration/savevm.c          | 27 +++++++++++++++++++++++----
> >  2 files changed, 24 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 1638ee5..dd5e26a 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -207,6 +207,7 @@ struct VMStateDescription {
> >      int version_id;
> >      int minimum_version_id;
> >      int minimum_version_id_old;
> > +    int priority;
> 
> Would it be possible to make this an 'enum' and define
> a migration_priority_default  then you can add
> your migration_priority_iommu  rather than the magic '100';
> so we'd then end up with something like:
> 
> enum migration_priority {
>    migration_priority_default = 0,
>    migration_priority_iommu,       /* Must happen before PCI devices */
> }
> 
> and that way we'd have one place where we could see all
> the priorities next to each other.

Yes this sounds better. :-)

> 
> I know there are some other existing ordering requirements that happen
> to work because of the order devices are created - however
> I dont think they're documented anywhere and I don't think any one knows
> them all!

Thank you for solving this "unsolved mistery" for me since I felt like
we should have such an ordering before but failed to find it... Looks
like it's hard to do this ordering thing once and for all, then let's
do it starting from this VT-d migration.

Let me prepare another version. Thanks Dave!

-- peterx
