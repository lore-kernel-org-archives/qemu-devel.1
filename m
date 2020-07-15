Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC995C433E8
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C10206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPaWSGuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C10206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvizf-0002DM-Rz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jvivQ-00051R-9S
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:02:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jvivO-0004db-H7
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594825341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Lc3GPEP4WXv0QcCSmMLHeZu/ejwA37Ij+YnrXr6y/0=;
 b=IPaWSGuEwJmeBxs5jfonlVd00fvYurWj1OTvNLVq9yU7jSE8bml27CXSnT7MNYQBEi6qQE
 Lqqw426AxjxYIuzGJOUKjpfJx44OOy0NQaRcYhJs+Vjyao7KkXezAjs674gBzUrBzTwOBn
 zrodo/Ez5S0DSv0D+mXomXeXuRDeiNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-IlsBy40PN6CyXgG4Sza-_Q-1; Wed, 15 Jul 2020 11:02:19 -0400
X-MC-Unique: IlsBy40PN6CyXgG4Sza-_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2FBE18C63C0;
 Wed, 15 Jul 2020 15:02:18 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2F0D710C8;
 Wed, 15 Jul 2020 15:02:16 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/7] device-core: use atomic_set on .realized property
Date: Wed, 15 Jul 2020 18:01:56 +0300
Message-Id: <20200715150159.95050-5-mlevitsk@redhat.com>
In-Reply-To: <20200715150159.95050-1-mlevitsk@redhat.com>
References: <20200715150159.95050-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/core/qdev.c         | 19 ++++++++++++++++++-
 include/hw/qdev-core.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ee69b11d11..2ec4971aec 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -966,7 +966,25 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
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
+        atomic_set(&dev->realized, value);
+        /*
+         * execute full memory barrier to ensure that concurrent users
+         * see this update prior to any other changes to the device
+         */
+        smp_mb();
+
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             qbus_unrealize(bus);
         }
@@ -981,7 +999,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     }
 
     assert(local_err == NULL);
-    dev->realized = value;
     return;
 
 child_realize_fail:
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e252640c1a..5faa715449 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -165,6 +165,8 @@ struct NamedClockList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ *            When accessed outsize big qemu lock, must be accessed with
+ *            atomic_load_acquire()
  * @reset: ResettableState for the device; handled by Resettable interface.
  *
  * This structure should not be accessed directly.  We declare it here
-- 
2.26.2


