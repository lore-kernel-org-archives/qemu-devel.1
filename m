Received: from eggs.gnu.org ([2001:4830:134:3::10]:41429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLAEZ-0005sb-JF
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLAET-0002iY-JV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:29:27 -0400
Received: from mail-eopbgr30105.outbound.protection.outlook.com
	([40.107.3.105]:14962
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dLAES-0002hc-Nd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:29:21 -0400
Date: Wed, 14 Jun 2017 18:28:50 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614152848.GA19027@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-18-rkagan@virtuozzo.com>
	<ebb4867f-a072-cfa0-6ca8-b493ef157458@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb4867f-a072-cfa0-6ca8-b493ef157458@redhat.com>
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

On Wed, Jun 14, 2017 at 05:08:02PM +0200, Paolo Bonzini wrote:
> 
> 
> On 06/06/2017 20:19, Roman Kagan wrote:
> > +    sint_route->msg_status = ret;
> > +    /* notify the msg originator of the progress made; if the slot was busy we
> > +     * set msg_pending flag in it so it will be the guest who will do EOM and
> > +     * trigger the notification from KVM via sint_ack_notifier */
> > +    if (ret != -EAGAIN) {
> > +        qemu_bh_schedule(sint_route->msg_bh);
> > +    }
> 
> It may be faster to use aio_bh_schedule_oneshot, depending on the number
> of devices.

Messages aren't used on fast paths, they are only exchanged at device
setup/teardown.  So I cared more about readability than speed here.

Thanks,
Roman.
