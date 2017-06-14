Received: from eggs.gnu.org ([2001:4830:134:3::10]:45722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLAP4-00007v-KV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLAOz-0001ux-7V
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:40:18 -0400
Received: from mail-db5eur01on0118.outbound.protection.outlook.com
	([104.47.2.118]:47104
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dLAOy-0001t1-HA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:40:13 -0400
Date: Wed, 14 Jun 2017 18:39:47 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614153946.GB19027@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-18-rkagan@virtuozzo.com>
	<ebb4867f-a072-cfa0-6ca8-b493ef157458@redhat.com>
	<20170614152848.GA19027@rkaganb.sw.ru>
	<62f00098-87c5-b0d9-6a07-71990b537c8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f00098-87c5-b0d9-6a07-71990b537c8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/23] hyperv: add synic message delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 05:32:12PM +0200, Paolo Bonzini wrote:
> 
> 
> On 14/06/2017 17:28, Roman Kagan wrote:
> > On Wed, Jun 14, 2017 at 05:08:02PM +0200, Paolo Bonzini wrote:
> >>
> >>
> >> On 06/06/2017 20:19, Roman Kagan wrote:
> >>> +    sint_route->msg_status = ret;
> >>> +    /* notify the msg originator of the progress made; if the slot was busy we
> >>> +     * set msg_pending flag in it so it will be the guest who will do EOM and
> >>> +     * trigger the notification from KVM via sint_ack_notifier */
> >>> +    if (ret != -EAGAIN) {
> >>> +        qemu_bh_schedule(sint_route->msg_bh);
> >>> +    }
> >>
> >> It may be faster to use aio_bh_schedule_oneshot, depending on the number
> >> of devices.
> > 
> > Messages aren't used on fast paths, they are only exchanged at device
> > setup/teardown.  So I cared more about readability than speed here.
> 
> Then you really want to use aio_bh_schedule_oneshot, because bottom
> halves incur a (small) cost even when you don't use them: each iteration
> of the event loop visits the list of bottom halves.

I didn't realize that (yes that's easy to see in the code but the API
didn't suggest I needed to ;).

> Persistent bottom halves, thus, are only a good idea if they are
> expected to trigger very often on a busy VM.  If this bottom half is
> only triggered at setup/teardown, it shouldn't use them.

Thanks for pointing that out; we'll have to adjust our vmbus code too as
we used a persistent bottom half for message interactions there too.

Roman.
