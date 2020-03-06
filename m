Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB28C3F2D4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3E4208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RtcDdwPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3E4208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA7OU-0000sZ-I9
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 02:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amit@kernel.org>) id 1jA7NW-0007lX-Ua
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amit@kernel.org>) id 1jA7NV-0003Pu-K0
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:26:38 -0500
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1]:47122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amit@kernel.org>) id 1jA7NV-0002u9-15
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=f1Ax7wWv2VU0DXiWyuT9CCi8qfaEMBtTjZAQ/j5/gdY=; b=RtcDdwPxakl5bwDkB+Fcwk5Bqe
 puXAPI3WGNCZ8pBi5gQkBn7Aoxdrnmnwdk/qz7oOop40esg79cILjqE7xLPFqcmET6ctLwf/0kIFp
 xg19giDOkIeWsQSxamU6HcvJmS2nPaCPZOhTMYxC2/rDqRKMRb5PIUEN71hg5mvzYXZPPbtdBLfT/
 30No0nkliQ0B+o0ZmbqLyfH2BFF3DqldTt6JsNKMtAZTD+klrmMSl61QFQXlHq4DVRZ8xVEBcuKxz
 MfpH0UwfvMEzJ4qoeQSdpLSqRhbGwRL6jjcTWjUxYrzsqELezDvFa/aUY7mW6RKn/YZvYQ7cnwlEm
 MLcM8sYw==;
Received: from [54.239.6.185] (helo=u0c626add9cce5a.drs10.amazon.com)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jA7NL-0000Gv-Vy; Fri, 06 Mar 2020 07:26:28 +0000
Message-ID: <dd5130d76c914846989d52a6c9a8ba5f0a34c12e.camel@kernel.org>
Subject: Re: [PATCH v2] virtio-serial-bus: do cleanup on the error path in
 realize() to avoid memleaks
From: Amit Shah <amit@kernel.org>
To: Pan Nengyuan <pannengyuan@huawei.com>, lvivier@redhat.com,
 mst@redhat.com,  marcandre.lureau@redhat.com, pbonzini@redhat.com
Date: Fri, 06 Mar 2020 08:26:23 +0100
In-Reply-To: <20200306025030.28824-1-pannengyuan@huawei.com>
References: <20200306025030.28824-1-pannengyuan@huawei.com>
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-03-06 at 10:50 +0800, Pan Nengyuan wrote:
> port->bh forgot to delete on the error path, this patch add it to fix
> memleaks. It's easy to reproduce as follow(add a same nr port):
>     {'execute': 'device_add', 'arguments': {'id':
> 'virtio_serial_pci0', 'driver': 'virtio-serial-pci', 'bus': 'pci.0',
> 'addr': '0x5'}, 'id': 'yVkZcGgV'}
>     {'execute': 'device_add', 'arguments': {'id': 'port1', 'driver':
> 'virtserialport', 'name': 'port1', 'chardev': 'channel1', 'bus':
> 'virtio_serial_pci0.0', 'nr': 1}, 'id': '3dXdUgJA'}
>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver':
> 'virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus':
> 'virtio_serial_pci0.0', 'nr': 1}, 'id': 'qLzcCkob'}
>     {'execute': 'device_add', 'arguments': {'id': 'port2', 'driver':
> 'virtserialport', 'name': 'port2', 'chardev': 'channel2', 'bus':
> 'virtio_serial_pci0.0', 'nr': 2}, 'id': 'qLzcCkob'}
> 
> The leak stack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f04a8008ae8 in __interceptor_malloc
> (/lib64/libasan.so.5+0xefae8)
>     #1 0x7f04a73cf1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>     #2 0x56273eaee484 in aio_bh_new
> /mnt/sdb/backup/qemu/util/async.c:125
>     #3 0x56273eafe9a8 in qemu_bh_new /mnt/sdb/backup/qemu/util/main-
> loop.c:532
>     #4 0x56273d52e62e in virtser_port_device_realize
> /mnt/sdb/backup/qemu/hw/char/virtio-serial-bus.c:946
>     #5 0x56273dcc5040 in device_set_realized
> /mnt/sdb/backup/qemu/hw/core/qdev.c:891
>     #6 0x56273e5ebbce in property_set_bool
> /mnt/sdb/backup/qemu/qom/object.c:2238
>     #7 0x56273e5e5a9c in object_property_set
> /mnt/sdb/backup/qemu/qom/object.c:1324
>     #8 0x56273e5ef5f8 in object_property_set_qobject
> /mnt/sdb/backup/qemu/qom/qom-qobject.c:26
>     #9 0x56273e5e5e6a in object_property_set_bool
> /mnt/sdb/backup/qemu/qom/object.c:1390
>     #10 0x56273daa40de in qdev_device_add /mnt/sdb/backup/qemu/qdev-
> monitor.c:680
>     #11 0x56273daa53e9 in qmp_device_add /mnt/sdb/backup/qemu/qdev-
> monitor.c:805
> 
> Fixes: 199646d81522509ac2dba6d28c31e8c7d807bc93
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> v1->v2:
> - simply create port->bh last in virtser_port_device_realize() to fix
> memleaks.(Suggested by Markus Armbruster)

v2 looks much better.

Reviewed-by: Amit Shah <amit@kernel.org>

> ---
>  hw/char/virtio-serial-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-
> bus.c
> index 941ed5aca9..99a65bab7f 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -943,7 +943,6 @@ static void
> virtser_port_device_realize(DeviceState *dev, Error **errp)
>      Error *err = NULL;
>  
>      port->vser = bus->vser;
> -    port->bh = qemu_bh_new(flush_queued_data_bh, port);
>  
>      assert(vsc->have_data);
>  
> @@ -992,6 +991,7 @@ static void
> virtser_port_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    port->bh = qemu_bh_new(flush_queued_data_bh, port);
>      port->elem = NULL;
>  }
>  


