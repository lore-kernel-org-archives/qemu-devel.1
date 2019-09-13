Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DEFC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868BE20717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868BE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8hWj-0003jO-Gt
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8hW3-0003Fc-CN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8hW1-0005qm-Rr
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8hVx-0005op-Sw; Fri, 13 Sep 2019 05:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FF6A18CB8E2;
 Fri, 13 Sep 2019 09:05:12 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D7B919C78;
 Fri, 13 Sep 2019 09:04:58 +0000 (UTC)
Date: Fri, 13 Sep 2019 11:04:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190913090457.GA8312@dhcp-200-226.str.redhat.com>
References: <20190912181924.48539-1-slp@redhat.com>
 <20190912155023-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912155023-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 13 Sep 2019 09:05:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] virtio-blk: schedule
 virtio_notify_config to run on main context
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mreitz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.09.2019 um 21:51 hat Michael S. Tsirkin geschrieben:
> On Thu, Sep 12, 2019 at 08:19:25PM +0200, Sergio Lopez wrote:
> > Another AioContext-related issue, and this is a tricky one.
> > 
> > Executing a QMP block_resize request for a virtio-blk device running
> > on an iothread may cause a deadlock involving the following mutexes:
> > 
> >  - main thead
> >   * Has acquired: qemu_mutex_global.
> >   * Is trying the acquire: iothread AioContext lock via
> >     AIO_WAIT_WHILE (after aio_poll).
> > 
> >  - iothread
> >   * Has acquired: AioContext lock.
> >   * Is trying to acquire: qemu_mutex_global (via
> >     virtio_notify_config->prepare_mmio_access).
> 
> Hmm is this really the only case iothread takes qemu mutex?
> If any such access can deadlock, don't we need a generic
> solution? Maybe main thread can drop qemu mutex
> before taking io thread AioContext lock?

The rule is that iothreads must not take the qemu mutex. If they do
(like in this case), it's a bug.

Maybe we could actually assert this in qemu_mutex_lock_iothread()?

> > With this change, virtio_blk_resize checks if it's being called from a
> > coroutine context running on a non-main thread, and if that's the
> > case, creates a new coroutine and schedules it to be run on the main
> > thread.
> > 
> > This works, but means the actual operation is done
> > asynchronously, perhaps opening a window in which a "device_del"
> > operation may fit and remove the VirtIODevice before
> > virtio_notify_config() is executed.
> > 
> > I *think* it shouldn't be possible, as BHs will be processed before
> > any new QMP/monitor command, but I'm open to a different approach.
> > 
> > RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1744955
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  hw/block/virtio-blk.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 18851601cb..c763d071f6 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/iov.h"
> >  #include "qemu/module.h"
> >  #include "qemu/error-report.h"
> > +#include "qemu/main-loop.h"
> >  #include "trace.h"
> >  #include "hw/block/block.h"
> >  #include "hw/qdev-properties.h"
> > @@ -1086,11 +1087,33 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
> >      return 0;
> >  }
> >  
> > +static void coroutine_fn virtio_resize_co_entry(void *opaque)
> > +{
> > +    VirtIODevice *vdev = opaque;
> > +
> > +    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> > +    virtio_notify_config(vdev);
> > +    aio_wait_kick();
> > +}
> > +
> >  static void virtio_blk_resize(void *opaque)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
> > +    Coroutine *co;
> >  
> > -    virtio_notify_config(vdev);
> > +    if (qemu_in_coroutine() &&
> > +        qemu_get_current_aio_context() != qemu_get_aio_context()) {
> > +        /*
> > +         * virtio_notify_config() needs to acquire the global mutex,
> > +         * so calling it from a coroutine running on a non-main context
> > +         * may cause a deadlock. Instead, create a new coroutine and
> > +         * schedule it to be run on the main thread.
> > +         */
> > +        co = qemu_coroutine_create(virtio_resize_co_entry, vdev);
> > +        aio_co_schedule(qemu_get_aio_context(), co);
> > +    } else {
> > +        virtio_notify_config(vdev);
> > +    }
> >  }

Wouldn't a simple BH suffice (aio_bh_schedule_oneshot)? I don't see why
you need a coroutine when you never yield.

The reason why it deadlocks also has nothing to do with whether we are
called from a coroutine or not. The important part is that we're running
in an iothread.

Kevin

