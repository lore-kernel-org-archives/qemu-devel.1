Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25212078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 21:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2qP0xpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25212078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwOh-0007J8-Tx
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 17:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvug-0003ZY-8B
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:41:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21553
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvua-0000gZ-1a
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tgykM8yebuXnWA485vQCkpG1Wqoyaj6Mg6VkyCjcuY=;
 b=O2qP0xpuBtvERUtYSZ4FdL/kppeSctCtkIjX6TZLdyBPi7VMBkAC3QzBjOQ0udGm9YAZk8
 xy0yAa2AJbvG88F58BxaIwNCL9tfP49HNiO+PYKEKvqnNTsjmJJuZaUg1VPi0qNOv5GvPS
 KrPMK5hX/hLPO7vEAkYt5DPF/262HTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-BNvwQAVqP2GwS3GYH8fvLA-1; Mon, 15 Jun 2020 16:40:39 -0400
X-MC-Unique: BNvwQAVqP2GwS3GYH8fvLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648E6188360F
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 20:40:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 358157CAA0;
 Mon, 15 Jun 2020 20:40:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB81B1132F3B; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/84] isa: New isa_new(), isa_realize_and_unref() etc.
Date: Mon, 15 Jun 2020 22:39:28 +0200
Message-Id: <20200615204008.3069956-45-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm converting from qdev_create()/qdev_init_nofail() to
qdev_new()/qdev_realize_and_unref(); recent commit "qdev: New
qdev_new(), qdev_realize(), etc." explains why.

ISA devices use qdev_create() through isa_create() and
isa_try_create().

Provide isa_new(), isa_try_new(), and isa_realize_and_unref() for
converting ISA devices.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200610053247.1583243-19-armbru@redhat.com>
---
 include/hw/isa/isa.h |  3 +++
 hw/isa/isa-bus.c     | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 02c2350274..3b6215fafe 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -105,6 +105,9 @@ MemoryRegion *isa_address_space(ISADevice *dev);
 MemoryRegion *isa_address_space_io(ISADevice *dev);
 ISADevice *isa_create(ISABus *bus, const char *name);
 ISADevice *isa_try_create(ISABus *bus, const char *name);
+ISADevice *isa_new(const char *name);
+ISADevice *isa_try_new(const char *name);
+bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
 
 ISADevice *isa_vga_init(ISABus *bus);
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 1c9d7e19ab..e6412d39b4 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -176,6 +176,16 @@ ISADevice *isa_try_create(ISABus *bus, const char *name)
     return ISA_DEVICE(dev);
 }
 
+ISADevice *isa_new(const char *name)
+{
+    return ISA_DEVICE(qdev_new(name));
+}
+
+ISADevice *isa_try_new(const char *name)
+{
+    return ISA_DEVICE(qdev_try_new(name));
+}
+
 ISADevice *isa_create_simple(ISABus *bus, const char *name)
 {
     ISADevice *dev;
@@ -185,6 +195,11 @@ ISADevice *isa_create_simple(ISABus *bus, const char *name)
     return dev;
 }
 
+bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp)
+{
+    return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
+}
+
 ISADevice *isa_vga_init(ISABus *bus)
 {
     switch (vga_interface_type) {
-- 
2.26.2


