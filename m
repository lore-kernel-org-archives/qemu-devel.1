Received: from eggs.gnu.org ([2001:4830:134:3::10]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUwrw-0004y8-7c
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dUwrt-0005Po-22
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dUwrs-0005PT-OI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:14:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C80DAFEB3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 15:14:26 +0000 (UTC)
Date: Tue, 11 Jul 2017 23:14:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170711151421.GA7449@lemon>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170711141543.GW17792@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711141543.GW17792@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On Tue, 07/11 15:15, Stefan Hajnoczi wrote:
> On Mon, Jul 10, 2017 at 03:20:22PM +0800, Fam Zheng wrote:
> > Last time we've looked at "-object iothread,spawns=N" but it was a bit abusive.
> > A dedicated "iothread-group" class is cleaner from the interface point of view.
> > This series does that.
> > 
> > It has the same set of poll parameters as the existing "iothread" object, plus
> > a "size" option to specify how many threads to start. Using iothread-group
> > doesn't require the user to explicitly create the contained IOThreads. The
> > IOThreads are created by the group object.
> > 
> > Internally, IOThreads share one AioContext.  This is to make it easier to adapt
> > this to the current data plane code (see the last patch). But it is an
> > implementation detail, and will change depending on the block layer multiqueue
> > needs.
> > 
> > TODO:
> > 
> > - qmp_query_iothread_groups, in addition to proper QOM @child property from
> >   IOThreadGroup to its IOThread instances.
> > - Add virtio-scsi.
> > - Variant of iothread_stop_all().
> > 
> > Fam Zheng (5):
> >   aio: Wrap poll parameters into AioContextPollParams
> >   iothread: Don't error on windows
> >   iothread: Extract iothread_start
> >   Introduce iothread-group
> >   virtio-blk: Add iothread-group property
> 
> From your TODO note above it looks like you plan to duplicate IOThread
> interfaces for IOThreadGroup?  This means existing query-iothreads users
> no longer see the full view of all IOThreads.
> 
> I think it would be cleaner to define and query IOThreads like they are
> today but change virtio-blk/virtio-scsi to accept a list of IOThreads.

That way the groups are formed passively and I'm not sure if it is better for
users/tools to manage in the long run. Consider this syntax:

    -object iothread,id=iot0 \
    -object iothread,id=iot1 \
    -object iothread,id=iot2 \
    -device virtio-blk-pci,id=vblk0,iothread.0=iot0,iothread.1=iot1 \
    -device virtio-blk-pci,id=vblk1,iothread.0=iot1,iothread.1=iot2

where vblk0 uses iot0 and iot1 and vblk1 uses iot1 and iot2. There is a
intersection between the two groups. IMO it is less clean compared to the
rule set by an explicit syntax:

    -object iothread-group,id=iotg0,size=4 \
    -object iothread-group,id=iotg1,size=4 \
    -device virtio-blk-pci,id=vblk0,iothread-group=iotg0 \
    -device virtio-blk-pci,id=vblk1,iothread-group=iotg1 \


Also I have not idea how easy it is to add a "list of links" qdev property. I
remember there was some related work in progress, but I've lost the pointers.

> That way existing management tool functionality can be used and the only
> tweak is that devices can now be added to multiple IOThreads.

Another way could be to still include any IOThreads created by IOThreadGroup in
"query-iothreads" output, and add a "group name" property so users know the
groupings.

> 
> It would be nice to express the group relationship in QOM instead of
> open coding a new group object.  The majority of the RFC code creates a
> child/link list relationship that QOM should support for any type, not
> just IOThread.

Sounds fine, but I'm not sure what exactly you have in mind (I think it is
extending QOM). Can you elaborate?

Fam
