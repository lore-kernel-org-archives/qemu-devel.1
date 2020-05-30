Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7EFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 05:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A822073B
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 05:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jleg8nwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A822073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jetjG-0001zI-BH
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 01:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jetij-0001an-Fh
 for qemu-devel@nongnu.org; Sat, 30 May 2020 01:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jetih-00067R-VH
 for qemu-devel@nongnu.org; Sat, 30 May 2020 01:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590815262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06EO1O4Zz50cF5NJPhHWBFJzO5ij5yEPFB8AzS9bA/4=;
 b=Jleg8nwZlzi1Dg1a+wKWFYIueE5l43vVuol9CMa1QVIdr1wYdqe1s7fty3uD3cydqwQNVf
 hu8fKo38a36YbFi0DaLKhoztNovANlEYkXPp+J+U94o7nm+HXdyW9wb2nMgv0q7k3eto4h
 0J4xrRb4BwZEv7X8tFMn2ZPUdjgEyR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-X3A5P9hKM-C-cOcTqabbMw-1; Sat, 30 May 2020 01:07:40 -0400
X-MC-Unique: X3A5P9hKM-C-cOcTqabbMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82B7460
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 05:07:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C7695D9D7
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 05:07:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E667B113864A; Sat, 30 May 2020 07:07:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 19/58] isa: Convert uses of isa_create() with Coccinelle
References: <20200529134523.8477-1-armbru@redhat.com>
 <20200529134523.8477-20-armbru@redhat.com>
Date: Sat, 30 May 2020 07:07:37 +0200
In-Reply-To: <20200529134523.8477-20-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 29 May 2020 15:44:44 +0200")
Message-ID: <87r1v2f1t2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 01:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Replace
>
>     dev = isa_create(bus, type_name);
>     ...
>     qdev_init_nofail(dev);
>
> by
>
>     dev = isa_new(type_name);
>     ...
>     isa_realize_and_unref(dev, bus, &error_fatal);
>
> Recent commit "qdev: New qdev_new(), qdev_realize(), etc." explains
> why.
>
> Coccinelle script:
>
>     @@
>     expression dev, bus, expr;
>     expression list args;
>     expression d;
>     @@
>     -    dev = isa_create(bus, args);
>     +    dev = isa_new(args);
>     (
>          d = &dev->qdev;
>     |
>          d = DEVICE(dev);
>     )
>          ... when != dev = expr
>     -    qdev_init_nofail(d);
>     +    isa_realize_and_unref(dev, bus, &error_fatal);
>
>     @@
>     expression dev, bus, expr;
>     expression list args;
>     @@
>     -    dev = isa_create(bus, args);
>     +    dev = isa_new(args);
>          ... when != dev = expr
>     -    qdev_init_nofail(DEVICE(dev));
>     +    isa_realize_and_unref(dev, bus, &error_fatal);
>
>     @@
>     expression dev, bus, expr;
>     expression list args;
>     @@
>     -    dev = DEVICE(isa_create(bus, args));
>     +    ISADevice *isa_dev; // TODO move
>     +    isa_dev = isa_new(args);
>     +    dev = DEVICE(isa_dev);
>          ... when != dev = expr
>     -    qdev_init_nofail(dev);
>     +    isa_realize_and_unref(isa_dev, bus, &error_fatal);
>
> Missing #include "qapi/error.h" added manually, whitespace changes
> minimized manually.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Squash in:

From 82cd9900d9c24048bc4cc0c22568af4d1ea663c2 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Sat, 30 May 2020 07:06:06 +0200
Subject: [PATCH] fixup! isa: Convert uses of isa_create() with Coccinelle

---
 hw/rtc/m48t59-isa.c | 2 +-
 hw/sparc64/sun4u.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index f641225301..50430b7a85 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -62,6 +62,7 @@ static M48txxInfo m48txx_isa_info[] = {
 Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
                        int base_year, int model)
 {
+    ISADevice *isa_dev;
     DeviceState *dev;
     int i;
 
@@ -71,7 +72,6 @@ Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
             continue;
         }
 
-        ISADevice *isa_dev; // TODO move
         isa_dev = isa_new(m48txx_isa_info[i].bus_name);
         dev = DEVICE(isa_dev);
         qdev_prop_set_uint32(dev, "iobase", io_base);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 11440e7457..97e6d3a025 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -300,6 +300,7 @@ static void ebus_isa_irq_handler(void *opaque, int n, int level)
 static void ebus_realize(PCIDevice *pci_dev, Error **errp)
 {
     EbusState *s = EBUS(pci_dev);
+    ISADevice *isa_dev;
     SysBusDevice *sbd;
     DeviceState *dev;
     qemu_irq *isa_irq;
@@ -338,7 +339,6 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     for (i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
     }
-    ISADevice *isa_dev; // TODO move
     isa_dev = isa_new(TYPE_ISA_FDC);
     dev = DEVICE(isa_dev);
     if (fd[0]) {
-- 
2.21.3


