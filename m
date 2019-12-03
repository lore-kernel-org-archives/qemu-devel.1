Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA7720661
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNZnOYIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA7720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic9Tn-0002P0-Mn
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amit@infradead.org>) id 1ic9An-0003UP-Gd
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@infradead.org>) id 1ic9Ai-0007qc-G8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:29:02 -0500
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1]:39884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@infradead.org>) id 1ic9Ae-00070w-MP
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R5rFSwr295MFgFH4fnvo8+rKqLieHFUB9p93xJXcr90=; b=mNZnOYIy247hbD9M03R3rPinrb
 0xbbilQtMnXXJY11fNnMUywl3BS0S/He8ZyIJQjgkeIfm/l4Z2h0aa2rvv8dJAIZVEvu8JsVO5U6T
 3A6+ITr8vBJJTQuLvaD1vFCIUZ/dmhuZJNq3I+DBnxQhAVCJPxVTiSfhDhMJcQ2P7HreWipERUwwu
 Ex7vBMCH+fSxDmoH/oTMhW84/7KezIpW2uS+LHxPZLOFOcqFEdt7THGhH2vO4mSCXN1Id3ak6Ss5w
 PIAYHhIqz0iVJNehccKx5PQuT+9XbS1zhMYOEJQsu7hiov7wY6yNz1VyccLXCHqhJ3vu41LnySr1W
 pHYfsQNQ==;
Received: from [54.239.6.185] (helo=u0c626add9cce5a.ant.amazon.com)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic9AM-0000en-RW; Tue, 03 Dec 2019 14:28:39 +0000
Message-ID: <79b39e31e0a37d3dd4b886a0027845e09a8fe745.camel@infradead.org>
Subject: Re: [PATCH] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
From: Amit Shah <amit@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, pannengyuan <pannengyuan@huawei.com>
Date: Tue, 03 Dec 2019 15:28:35 +0100
In-Reply-To: <20191203003549-mutt-send-email-mst@kernel.org>
References: <1575285343-21864-1-git-send-email-pannengyuan@huawei.com>
 <dad28876-1850-32f3-fe47-9e4ec2c68f20@redhat.com>
 <4e9efebf-1862-8879-ed01-60f8777d4a65@huawei.com>
 <20191203003549-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:8b0:10b:1231::1
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
Cc: Laurent Vivier <lvivier@redhat.com>, liyiting@huawei.com,
 zhang.zhanghailiang@huawei.com, kuhn.chenqun@huawei.com, amit@kernel.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-12-03 at 00:37 -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 03, 2019 at 08:53:42AM +0800, pannengyuan wrote:
> > 
> > 
> > On 2019/12/2 21:58, Laurent Vivier wrote:
> > > On 02/12/2019 12:15, pannengyuan@huawei.com wrote:
> > > > From: PanNengyuan <pannengyuan@huawei.com>
> > > > 
> > > > ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
> > > > virtio_serial_device_unrealize, the memory leak stack is as
> > > > bellow:
> > > > 
> > > > Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
> > > >     #0 0x7fc9bfc27560 in calloc
> > > > (/usr/lib64/libasan.so.3+0xc7560)
> > > >     #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-
> > > > 2.0.so.0+0x50015)
> > > >     #2 0x5650e02b83e7 in virtio_add_queue /mnt/sdb/qemu-4.2.0-
> > > > rc0/hw/virtio/virtio.c:2327
> > > >     #3 0x5650e02847b5 in virtio_serial_device_realize
> > > > /mnt/sdb/qemu-4.2.0-rc0/hw/char/virtio-serial-bus.c:1089
> > > >     #4 0x5650e02b56a7 in virtio_device_realize /mnt/sdb/qemu-
> > > > 4.2.0-rc0/hw/virtio/virtio.c:3504
> > > >     #5 0x5650e03bf031 in device_set_realized /mnt/sdb/qemu-
> > > > 4.2.0-rc0/hw/core/qdev.c:876
> > > >     #6 0x5650e0531efd in property_set_bool /mnt/sdb/qemu-4.2.0-
> > > > rc0/qom/object.c:2080
> > > >     #7 0x5650e053650e in object_property_set_qobject
> > > > /mnt/sdb/qemu-4.2.0-rc0/qom/qom-qobject.c:26
> > > >     #8 0x5650e0533e14 in object_property_set_bool
> > > > /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:1338
> > > >     #9 0x5650e04c0e37 in virtio_pci_realize /mnt/sdb/qemu-
> > > > 4.2.0-rc0/hw/virtio/virtio-pci.c:1801
> > > > 
> > > > Reported-by: Euler Robot <euler.robot@huawei.com>
> > > > Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> > > > ---
> > > >  hw/char/virtio-serial-bus.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-
> > > > serial-bus.c
> > > > index 3325904..da9019a 100644
> > > > --- a/hw/char/virtio-serial-bus.c
> > > > +++ b/hw/char/virtio-serial-bus.c
> > > > @@ -1126,9 +1126,15 @@ static void
> > > > virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
> > > >  {
> > > >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > > >      VirtIOSerial *vser = VIRTIO_SERIAL(dev);
> > > > +    int i;
> > > >  
> > > >      QLIST_REMOVE(vser, next);
> > > >  
> > > > +    for (i = 0; i <= vser->bus.max_nr_ports; i++) {
> > > > +        virtio_del_queue(vdev, 2 * i);
> > > > +        virtio_del_queue(vdev, 2 * i + 1);
> > > > +    }
> > > > +
> > > 
> > > According to virtio_serial_device_realize() and the number of
> > > virtio_add_queue(), I think you have more queues to delete:
> > > 
> > >   4 + 2 * vser->bus.max_nr_ports
> > > 
> > > (for vser->ivqs[0], vser->ovqs[0], vser->c_ivq, vser->c_ovq,
> > > vser->ivqs[i], vser->ovqs[i]).
> > > 
> > > Thanks,
> > > Laurent
> > > 
> > > 
> > 
> > Thanks, but I think the queues is correct, the queues in
> > virtio_serial_device_realize is as follow:
> > 
> > // here is 2
> > vser->ivqs[0] = virtio_add_queue(vdev, 128, handle_input);
> > vser->ovqs[0] = virtio_add_queue(vdev, 128, handle_output);
> > 
> > // here is 2
> > vser->c_ivq = virtio_add_queue(vdev, 32, control_in);
> > vser->c_ovq = virtio_add_queue(vdev, 32, control_out);
> > 
> > // here 2 * (max_nr_ports - 1)  ----- i is from 1 to max_nr_ports -
> > 1
> > for (i = 1; i < vser->bus.max_nr_ports; i++) {
> >     vser->ivqs[i] = virtio_add_queue(vdev, 128, handle_input);
> >     vser->ovqs[i] = virtio_add_queue(vdev, 128, handle_output);
> > }
> > 
> > so the total queues number is:  2 * (vser->bus.max_nr_ports + 1)
> 
> Rather than worry about this, I posted a patch adding
> virtio_delete_queue.
> How about reusing that, and just using ivqs/ovqs pointers?

Nice, that's cleaner.

> 


