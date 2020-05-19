Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563B0207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROPJapxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563B0207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3u5-0000Ak-Ch
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3fC-0001g2-GA
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f3-0003X0-B0
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8W/5wz987Z1WGTwRZeDqEYT1KkF9awmOO0MBvI36TI=;
 b=ROPJapxKukqGhYdQqBi2FGaV0/viZMXjh25y66/i13hLkiIJGgH+VLWIZMmPsOI8mtWKsh
 1gYiDO/OYZPPcqeTpsmWFSXVeS3fjF9n0rVMSWvTfvgkQyy2JbykaeRpMolqdtj4APaVI2
 R0tGV4ztt9IXyBmmHx6nh5/BZgp2KFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-PMcX33tfORKYJLHggF9ghA-1; Tue, 19 May 2020 10:56:02 -0400
X-MC-Unique: PMcX33tfORKYJLHggF9ghA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D49107ACF3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:56:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 015B9105911B;
 Tue, 19 May 2020 14:56:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F4451135231; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/55] qdev: Make qdev_realize() support bus-less devices
Date: Tue, 19 May 2020 16:55:47 +0200
Message-Id: <20200519145551.22836-52-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

So far, qdev_realize() supports only devices that plug into a bus:
argument @bus cannot be null.  Extend it to support bus-less devices,
too.

qdev_realize_and_unref() remains restricted, because its reference
counting would become rather confusing for bus-less devices.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 323b6328c8..0662bbc812 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -408,7 +408,7 @@ void qdev_init_nofail(DeviceState *dev)
 /*
  * Realize @dev.
  * @dev must not be plugged into a bus.
- * Plug @dev into @bus.  This takes a reference to @dev.
+ * If @bus, plug @dev into @bus.  This takes a reference to @dev.
  * If @dev has no QOM parent, make one up, taking another reference.
  * On success, return true.
  * On failure, store an error through @errp and return false.
@@ -418,9 +418,12 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
     Error *err = NULL;
 
     assert(!dev->realized && !dev->parent_bus);
-    assert(bus);
 
-    qdev_set_parent_bus(dev, bus);
+    if (bus) {
+        qdev_set_parent_bus(dev, bus);
+    } else {
+        assert(!DEVICE_GET_CLASS(dev)->bus_type);
+    }
 
     object_ref(OBJECT(dev));
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
@@ -442,7 +445,7 @@ void qdev_unrealize(DeviceState *dev)
  * Realize @dev and drop a reference.
  * This is like qdev_realize(), except it steals a reference rather
  * than take one to plug @dev into @bus.  On failure, it drops that
- * reference instead.  Intended use:
+ * reference instead.  @bus must not be null.  Intended use:
  *     dev = qdev_new();
  *     [...]
  *     qdev_realize_and_unref(dev, bus, errp);
@@ -452,6 +455,8 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 {
     bool ret;
 
+    assert(bus);
+
     ret = qdev_realize(dev, bus, errp);
     object_unref(OBJECT(dev));
     return ret;
-- 
2.21.1


