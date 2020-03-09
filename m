Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0064C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA52620728
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qXRvUB8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA52620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDda-0004mh-TN
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amit@kernel.org>) id 1jBDcm-00046A-GX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:18:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@kernel.org>) id 1jBDcl-0005lj-AG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:18:56 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:47028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@kernel.org>) id 1jBDck-0005kz-NZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=WBEmrFWdAI/cBre5Z2IU5yeGwDsevePNG+SZnkmuGdE=; b=qXRvUB8lcwQ+zP2ZHfkI7vKc7A
 hwVEbV02d205VqsRq/Pcno4DtlxaumQ5KcF6+4fnhL/wDTEovTt02193xYynNvJLAblQ7M7QlBhUt
 apnu//25/lwy14hdyd2+VDe6PPdLhf9hMfY/QrOwsy3O8CwCkpDG6AgoilYCyJkb8XjNyJzbZ90Bd
 zys6oWHhDrrrmpPks4OUiKWENUOiCqqx4QF5eD5Gc40+d+kY6kbHAxMvVqmpZiBsAEnSkgr6dquHz
 KWv0fUMRsso8ZIsowofyhrVUTK2wACbmmVXvwecmlnr3enEP1FZEoxryj7HHQqRbZSJg5YRbVN7IW
 0pp+zMgw==;
Received: from [54.239.6.185] (helo=u0c626add9cce5a.ant.amazon.com)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBDce-000475-2V; Mon, 09 Mar 2020 08:18:48 +0000
Message-ID: <aa7ae0db0b16efc14f22954c244c0673ceb21f59.camel@kernel.org>
Subject: Re: [PATCH v3] virtio-serial-bus: Plug memory leak on realize()
 error paths
From: Amit Shah <amit@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Pan Nengyuan
 <pannengyuan@huawei.com>
Date: Mon, 09 Mar 2020 09:18:43 +0100
In-Reply-To: <20200309030140-mutt-send-email-mst@kernel.org>
References: <20200309021738.30072-1-pannengyuan@huawei.com>
 <20200309030140-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:7c80:54:e::133
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
Cc: lvivier@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, euler.robot@huawei.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-03-09 at 03:02 -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 09, 2020 at 10:17:38AM +0800, Pan Nengyuan wrote:
> > We neglect to free port->bh on the error paths.  Fix that.
> > Reproducer:
> >     {'execute': 'device_add', 'arguments': {'id':
> > 'virtio_serial_pci0', 'driver': 'virtio-serial-pci', 'bus':
> > 'pci.0', 'addr': '0x5'}, 'id': 'yVkZcGgV'}
> >     {'execute': 'device_add', 'arguments': {'id': 'port1',
> > 'driver': 'virtserialport', 'name': 'port1', 'chardev': 'channel1',
> > 'bus': 'virtio_serial_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
> >     {'execute': 'device_add', 'arguments': {'id': 'port2',
> > 'driver': 'virtserialport', 'name': 'port2', 'chardev': 'channel2',
> > 'bus': 'virtio_serial_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
> >     {'execute': 'device_add', 'arguments': {'id': 'port2',
> > 'driver': 'virtserialport', 'name': 'port2', 'chardev': 'channel2',
> > 'bus': 'virtio_serial_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}
> > 
> > The leak stack:
> > Direct leak of 40 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f04a8008ae8 in __interceptor_malloc
> > (/lib64/libasan.so.5+0xefae8)
> >     #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
> >     #2 0x56273eaee484 in aio_bh_new
> > /mnt/sdb/backup/qemu/util/async.c:125
> >     #3 0x56273eafe9a8 in qemu_bh_new
> > /mnt/sdb/backup/qemu/util/main-loop.c:532
> >     #4 0x56273d52e62e in virtser_port_device_realize
> > /mnt/sdb/backup/qemu/hw/char/virtio-serial-bus.c:946
> >     #5 0x56273dcc5040 in device_set_realized
> > /mnt/sdb/backup/qemu/hw/core/qdev.c:891
> >     #6 0x56273e5ebbce in property_set_bool
> > /mnt/sdb/backup/qemu/qom/object.c:2238
> >     #7 0x56273e5e5a9c in object_property_set
> > /mnt/sdb/backup/qemu/qom/object.c:1324
> >     #8 0x56273e5ef5f8 in object_property_set_qobject
> > /mnt/sdb/backup/qemu/qom/qom-qobject.c:26
> >     #9 0x56273e5e5e6a in object_property_set_bool
> > /mnt/sdb/backup/qemu/qom/object.c:1390
> >     #10 0x56273daa40de in qdev_device_add
> > /mnt/sdb/backup/qemu/qdev-monitor.c:680
> >     #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-
> > monitor.c:805
> > 
> > Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
> > Reported-by: Euler Robot <euler.robot@huawei.com>
> > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Amit Shah <amit@kernel.org>
> > ---
> > v1->v2:
> > - simply create port->bh last in virtser_port_device_realize() to
> > fix memleaks.(Suggested by Markus Armbruster)
> 
> 
> Markus, Amit do your Reviewed-by tags still stand?

Yep, the review was for v2.



