Received: from eggs.gnu.org ([2001:4830:134:3::10]:37043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVFTg-0006hI-Fk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVFTd-0008PV-BD
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:06:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVFTd-0008PH-2s
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:06:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CE7480C0F
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:06:40 +0000 (UTC)
Date: Wed, 12 Jul 2017 19:06:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170712110633.GB11040@lemon>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170711145813.GX17792@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711145813.GX17792@stefanha-x1.localdomain>
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, 07/11 15:58, Stefan Hajnoczi wrote:
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
> > 
> >  Makefile.objs                   |   2 +-
> >  hw/block/dataplane/virtio-blk.c |  18 ++--
> >  hw/block/virtio-blk.c           |   6 ++
> >  include/block/aio.h             |  18 ++--
> >  include/hw/virtio/virtio-blk.h  |   2 +
> >  include/sysemu/iothread.h       |  35 ++++++-
> >  iothread-group.c                | 210 ++++++++++++++++++++++++++++++++++++++++
> >  iothread.c                      |  97 +++++++++----------
> >  util/aio-posix.c                |  10 +-
> >  util/aio-win32.c                |   8 +-
> >  10 files changed, 328 insertions(+), 78 deletions(-)
> >  create mode 100644 iothread-group.c
> 
> I reviewed QOM "foo[*]" array syntax but it's very limited.  Basically
> all it does it append the new property to foo[0], foo[1], ... (i.e. it
> allocates an index).  AFAICT there is no way to specify an array
> property and really arrays are just individual properties.
> 
> Daniel Berrange has a patch for non-scalar properties:
> "[PATCH v14 15/21] qom: support non-scalar properties with -object"
> https://patchwork.kernel.org/patch/9358503/
> 
> I think the challenge with existing "[*]" or pre-allocated "foo[0]",
> "foo[1]", ... is that they don't support variable-sized arrays via QAPI.

Plus I'm not a fan of such a "spelling out indexes explicitly" syntax. It makes
me feel like a slave of a poorly coded programme. With it we'll avoid open
coding an iothread group class in QEMU, but will ask the user to "open type"
group configurations.

> With that missing piece solved it would be possible to say:
> 
>   -device virtio-blk-pci,iothread.0=iothread0,iothread.1=iothread1
> 
> Or maybe:
> 
>   -device virtio-blk-pci,iothread[0]=iothread0,iothread[1]=iothread1

Understood. As I said in the other message, I'm not quite convinced with this
"arbitrary grouping" API made possible with this syntax. Probably the simplist
cases are okay, but I'm afraid as the number of virtio-blk-pci and iothread
grows, the configuration can get complicated to manage.

> 
> When the virtio-blk-pci object is realized it can loop over iothread[*]
> properties to set them up (if necessary).
> 
> Your current RFC series uses a single AioContext in IOThreadGroup.  I
> think something similar can be achieved with an iothread property:
> 
>   -object iothread,id=iothread1,share-event-loop-with=iothread0
> 
> The reason I am suggesting this approach is to keep IOThread as the
> first-class object.  Existing QMP APIs continue to apply to all objects.
> We avoid introducing an ad-hoc group object just for IOThread.

Another possibility is to introduce 1) a "TYPE_GROUPABLE" InterfaceInfo that
will add a ".group" str property to IOThread, and build a generic group object
out of the objects sharing the same .group name; 2) a qdev prop
DEFINE_PROP_LINK_TO_GROUP() that can be used to reference a QOM object group
from virtio-blk/scsi. That way it is not specific to IOThread. (Since I am not
QOM expert, this is basically brainstorming.)

Fam
