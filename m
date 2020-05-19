Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BFFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B9D207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw+FYnMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B9D207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3sd-0004wv-9w
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f8-0001Ts-Mw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f1-0003WI-MU
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSGtdA3PtuimXwvSALVl0Atq7pZxkJiJYxU/ZXBFgPI=;
 b=Zw+FYnMT4lmAzrehJcac84ODGHEFZWGp8a0VgIb7P6GUKX1LhhuiNRHdnUonTNg3C7alZN
 LXZq//xCmJnF/nWSv1jALBmu/VhcRNJTHTno7jPyTm7xuIbzjQrGPmRwUSFKvR05yMiamF
 iBdzhi7LzD1bi8x2Vr5oMYx7ACIOLAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-ujpuG0qOMf6-RJmwZxo4sg-1; Tue, 19 May 2020 10:55:57 -0400
X-MC-Unique: ujpuG0qOMf6-RJmwZxo4sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B20E81005512
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 812E260BE1;
 Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED1C111358CE; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/55] isa: New isa_new(), isa_realize_and_unref() etc.
Date: Tue, 19 May 2020 16:55:13 +0200
Message-Id: <20200519145551.22836-18-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
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
2.21.1


