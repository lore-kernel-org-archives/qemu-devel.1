Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF22C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F3F2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPoWQfQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F3F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jithn-00054z-Ls
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMQ-0005FX-0T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMC-0003rH-Qp
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8ucWRQluooxya9hLd54lAWqMMYexkDTTKyQZF6mOVQ=;
 b=FPoWQfQdaaNxdMNcPSHvoX3c0Q8syQ46eSWQV29q0cz/+6ZswuCGy0Pnj3rcoihq3AAHxm
 UhR/f0cpxwIHHoJ3+IQECwG0MeIT0fahrK2zTbPhWv7V5waVYLsi3ek1QsnW2dyc9KhePL
 QgV000WIPD+DFodq7CTAC9IzWxAG/GA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-cb2qUMAvMmm3RvSP9Z9naA-1; Wed, 10 Jun 2020 01:32:57 -0400
X-MC-Unique: cb2qUMAvMmm3RvSP9Z9naA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2844805729
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C303119C71;
 Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D53BB1138484; Wed, 10 Jun 2020 07:32:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 46/58] qdev: Drop qdev_realize() support for null bus
Date: Wed, 10 Jun 2020 07:32:35 +0200
Message-Id: <20200610053247.1583243-47-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "null @bus means main system bus" convenience feature is no longer
used.  Drop it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index a1fdebb3aa..78a06db76e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -408,8 +408,7 @@ void qdev_init_nofail(DeviceState *dev)
 /*
  * Realize @dev.
  * @dev must not be plugged into a bus.
- * Plug @dev into @bus if non-null, else into the main system bus.
- * This takes a reference to @dev.
+ * Plug @dev into @bus.  This takes a reference to @dev.
  * If @dev has no QOM parent, make one up, taking another reference.
  * On success, return true.
  * On failure, store an error through @errp and return false.
@@ -419,18 +418,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     Error *err = NULL;
 
     assert(!dev->realized && !dev->parent_bus);
-
-    if (!bus) {
-        /*
-         * Assert that the device really is a SysBusDevice before we
-         * put it onto the sysbus.  Non-sysbus devices which aren't
-         * being put onto a bus should be realized with
-         * object_property_set_bool(OBJECT(dev), true, "realized",
-         * errp);
-         */
-        g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE));
-        bus = sysbus_get_default();
-    }
+    assert(bus);
 
     qdev_set_parent_bus(dev, bus);
 
-- 
2.26.2


