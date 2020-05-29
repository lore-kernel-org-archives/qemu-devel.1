Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592FC20707
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQTtmUkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592FC20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefgS-0000zW-GP
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKa-0003GA-Eh
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKM-00077S-P2
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdBhkXWUq6/grcJDQFCjBUO29xQZ91Bx/YvZIkfGuyo=;
 b=aQTtmUkK7Sx9uFhBmneH/NJY/gYbIF4tj5ecAMdi8IgrHV6VqxVNbzAjGFv+eGupaY1YZd
 thoKtNUxtmNWlvGWPa2GF1EN3uDbdirCYIPwHzJJxulWV2qQ5U0lig2Q4rnxpxc9V3W5q4
 Vhgt5xvISblCkd9ko8+uEdhI2HoktzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-FhCPdk5lOvu4fFgv6zmu1Q-1; Fri, 29 May 2020 09:45:35 -0400
X-MC-Unique: FhCPdk5lOvu4fFgv6zmu1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835821007271
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 579075D9D5
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B35931135253; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 57/58] qdev: qdev_init_nofail() is now unused, drop
Date: Fri, 29 May 2020 15:45:22 +0200
Message-Id: <20200529134523.8477-58-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/qdev-core.h |  3 +--
 hw/core/qdev.c         | 29 -----------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index ef6137b6a8..7dc10be46f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -57,7 +57,7 @@ typedef void (*BusUnrealize)(BusState *bus);
  * After successful realization, setting static properties will fail.
  *
  * As an interim step, the #DeviceState:realized property can also be
- * set with qdev_realize() or qdev_init_nofail().
+ * set with qdev_realize().
  * In the future, devices will propagate this state change to their children
  * and along busses they expose.
  * The point in time will be deferred to machine creation, so that values
@@ -322,7 +322,6 @@ compat_props_add(GPtrArray *arr,
 
 DeviceState *qdev_new(const char *name);
 DeviceState *qdev_try_new(const char *name);
-void qdev_init_nofail(DeviceState *dev);
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
 void qdev_unrealize(DeviceState *dev);
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 50336168f2..2131c7f951 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -376,35 +376,6 @@ void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-/*
- * Realize @dev.
- * Device properties should be set before calling this function.  IRQs
- * and MMIO regions should be connected/mapped after calling this
- * function.
- * On failure, report an error with error_report() and terminate the
- * program.  This is okay during machine creation.  Don't use for
- * hotplug, because there callers need to recover from failure.
- * Exception: if you know the device's init() callback can't fail,
- * then qdev_init_nofail() can't fail either, and is therefore usable
- * even then.  But relying on the device implementation that way is
- * somewhat unclean, and best avoided.
- */
-void qdev_init_nofail(DeviceState *dev)
-{
-    Error *err = NULL;
-
-    assert(!dev->realized);
-
-    object_ref(OBJECT(dev));
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
-    if (err) {
-        error_reportf_err(err, "Initialization of device %s failed: ",
-                          object_get_typename(OBJECT(dev)));
-        exit(1);
-    }
-    object_unref(OBJECT(dev));
-}
-
 /*
  * Realize @dev.
  * @dev must not be plugged into a bus.
-- 
2.21.3


