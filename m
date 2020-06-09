Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFEFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE538207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2wQWy8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE538207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidTL-0000SK-Tb
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIM-0003Rl-9W
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIG-0005RA-Rf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591705429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CX4vmVsUepFkQOe1GieDnyQg/qbY1mZmgsSUhrM+Ko=;
 b=F2wQWy8Ijkq63Qd8FtJjPeHl24WVCPmAXCTtHtWDauaTLmUttha5xUpdzGqCGNcbxh5rBl
 vYh2bzRD2wegEWnndgbmJJvwZhaBTOy8Nm6yfNPkIQ94AkUokzNlgPEGJ02iWWcih8pUjN
 zos4nC4x7Krhue4rKUy/JNS8ilIGQJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-4zXEgIQTOueZ9XZwdTTa6g-1; Tue, 09 Jun 2020 08:23:45 -0400
X-MC-Unique: 4zXEgIQTOueZ9XZwdTTa6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C41D80B70A
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 12:23:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE4875D9E4;
 Tue,  9 Jun 2020 12:23:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3990C113846D; Tue,  9 Jun 2020 14:23:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/24] qdev: Assert onboard devices all get realized
 properly
Date: Tue,  9 Jun 2020 14:23:39 +0200
Message-Id: <20200609122339.937862-25-armbru@redhat.com>
In-Reply-To: <20200609122339.937862-1-armbru@redhat.com>
References: <20200609122339.937862-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This would have caught some of the bugs I just fixed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/qdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b5b42b2616..a68ba674db 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -427,6 +427,19 @@ void qdev_init_nofail(DeviceState *dev)
     object_unref(OBJECT(dev));
 }
 
+static int qdev_assert_realized_properly(Object *obj, void *opaque)
+{
+    DeviceState *dev = DEVICE(object_dynamic_cast(obj, TYPE_DEVICE));
+    DeviceClass *dc;
+
+    if (dev) {
+        dc = DEVICE_GET_CLASS(dev);
+        assert(dev->realized);
+        assert(dev->parent_bus || !dc->bus_type);
+    }
+    return 0;
+}
+
 void qdev_machine_creation_done(void)
 {
     /*
@@ -434,6 +447,9 @@ void qdev_machine_creation_done(void)
      * only create hotpluggable devices
      */
     qdev_hotplug = true;
+
+    object_child_foreach_recursive(object_get_root(),
+                                   qdev_assert_realized_properly, NULL);
 }
 
 bool qdev_machine_modified(void)
-- 
2.26.2


