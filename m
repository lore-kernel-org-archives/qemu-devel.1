Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769EC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE8E2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D94j3Vr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE8E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYB1v-0004Na-Ej
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0U-0002UR-1x
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0T-00019P-6B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589213416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=P4QIO4kgNzm3qXY393mDHSXk7baXBdVjmzR7Zrg69Ik=;
 b=D94j3Vr9BNpT3QCxTUf7qCg+qQfqnJ2ROWTJB4bzZuYotk9ynnfMCZHjkkujNvEIoj249j
 jftycTUGIaAIMh6tj2jTZt6DZv4rzP4z6SllHB5HnVRbUGOWG8R/Jhodyz55y+BEWmQqfN
 pQ21xtVZuwie063y3iRdNfGS1Ldndfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-VGBZvO5nMcOEAO_HGQXfAw-1; Mon, 11 May 2020 12:10:11 -0400
X-MC-Unique: VGBZvO5nMcOEAO_HGQXfAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66870100CCC0;
 Mon, 11 May 2020 16:10:10 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80AAD5C1B5;
 Mon, 11 May 2020 16:10:08 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] device-core: use atomic_set on .realized property
Date: Mon, 11 May 2020 19:09:48 +0300
Message-Id: <20200511160951.8733-5-mlevitsk@redhat.com>
In-Reply-To: <20200511160951.8733-1-mlevitsk@redhat.com>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some code might race with placement of new devices on a bus.
We currently first place a (unrealized) device on the bus
and then realize it.

As a workaround, users that scan the child device list, can
check the realized property to see if it is safe to access such a device.
Use an atomic write here too to aid with this.

A separate discussion is what to do with devices that are unrealized:
It looks like for this case we only call the hotplug handler's unplug
callback and its up to it to unrealize the device.
An atomic operation doesn't cause harm for this code path though.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/core/qdev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 732789e2b7..d530c5922f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -964,7 +964,20 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
        }
 
+       atomic_store_release(&dev->realized, value);
+
     } else if (!value && dev->realized) {
+
+        /*
+         * Change the value so that any concurrent users are aware
+         * that the device is going to be unrealized
+         *
+         * TODO: change .realized property to enum that states
+         * each phase of the device realization/unrealization
+         */
+
+        atomic_store_release(&dev->realized, value);
+
         /* We want local_err to track only the first error */
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             object_property_set_bool(OBJECT(bus), false, "realized",
@@ -980,12 +993,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
 
         if (local_err != NULL) {
+            atomic_store_release(&dev->realized, true);
             goto fail;
         }
     }
 
     assert(local_err == NULL);
-    dev->realized = value;
     return;
 
 child_realize_fail:
-- 
2.17.2


