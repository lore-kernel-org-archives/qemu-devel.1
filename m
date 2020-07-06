Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08AFC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F70920724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdO1BALA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F70920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMRf-0007L2-Qg
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMCf-00027V-Le
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:10:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMCP-0003Dw-9D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594023000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoxaS8HCvhbtSj+AnfqvqebShw8EsKZihvgQYUOkUtk=;
 b=TdO1BALAp1gNw6cL13ksb9cUetOS0y8+pKJZ8ss5gSR5nCFmcLTZLbnQtGhCDuQ4m8wu69
 dRFKjK5jK/kIHAz1mywj11cpMs1OtYQDS6av1dfOniTaFzGkmHYtWjr4U/pCMRA8GTV0kl
 nU1CZmnqYJ4JyvgpQoAtvl7G82p+9+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-u6Dp-a0uNcu8nzHqsYq7Uw-1; Mon, 06 Jul 2020 04:09:58 -0400
X-MC-Unique: u6Dp-a0uNcu8nzHqsYq7Uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C0221883622;
 Mon,  6 Jul 2020 08:09:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 256BA7B40A;
 Mon,  6 Jul 2020 08:09:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4286E1135236; Mon,  6 Jul 2020 10:09:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/44] qdev: Make functions taking Error ** return bool,
 not void
Date: Mon,  6 Jul 2020 10:09:36 +0200
Message-Id: <20200706080950.403087-31-armbru@redhat.com>
In-Reply-To: <20200706080950.403087-1-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See recent commit "error: Document Error API usage rules" for
rationale.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/hw/qdev-properties.h     | 4 ++--
 hw/core/qdev-properties-system.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 49c6cd2460..f12ab9e6bc 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -236,8 +236,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 /*
  * Set properties between creation and realization.
  */
-void qdev_prop_set_drive_err(DeviceState *dev, const char *name,
-                         BlockBackend *value, Error **errp);
+bool qdev_prop_set_drive_err(DeviceState *dev, const char *name,
+                             BlockBackend *value, Error **errp);
 
 /*
  * Set properties between creation and realization.
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 810831b1df..7d2387f22c 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -421,7 +421,7 @@ const PropertyInfo qdev_prop_audiodev = {
     .set = set_audiodev,
 };
 
-void qdev_prop_set_drive_err(DeviceState *dev, const char *name,
+bool qdev_prop_set_drive_err(DeviceState *dev, const char *name,
                              BlockBackend *value, Error **errp)
 {
     const char *ref = "";
@@ -436,7 +436,7 @@ void qdev_prop_set_drive_err(DeviceState *dev, const char *name,
         }
     }
 
-    object_property_set_str(OBJECT(dev), name, ref, errp);
+    return object_property_set_str(OBJECT(dev), name, ref, errp);
 }
 
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
-- 
2.26.2


