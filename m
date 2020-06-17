Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A755DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EBB206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmbVqaXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EBB206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZeq-0001O5-Je
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOA-0003XI-LK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53219
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO6-0001nf-DR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWojdpuV8jZ3RVbv7qXlRl7CymuA7CdOoe/U5kUOIGE=;
 b=RmbVqaXdMaNRYphuh0RwYuwaaOENqYTGGUlRvXGHYCrXfHXw7nfjPK5AWAOEF7+8JjPciJ
 rkBg3nwAYfw3WuwFGAcNhxJRp5kB3pK43UTKpWCyq58CY+/VYbkYRYTNRqSv4gL1nVEBmI
 4CfHbnaSc0yOdmuqYBIJcKmcG652dWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-pu_LaA0tPyafdL8jhz47ew-1; Wed, 17 Jun 2020 10:49:58 -0400
X-MC-Unique: pu_LaA0tPyafdL8jhz47ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5164018A266E;
 Wed, 17 Jun 2020 14:49:57 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58C467CAA0;
 Wed, 17 Jun 2020 14:49:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 32/43] qdev-properties: blocksize: use same limits in code and
 description
Date: Wed, 17 Jun 2020 16:48:58 +0200
Message-Id: <20200617144909.192176-33-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 23:30:45
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rvkagan@yandex-team.ru>

Make it easier (more visible) to maintain the limits on the blocksize
properties in sync with the respective description, by using macros both
in the code and in the description.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200528225516.1676602-4-rvkagan@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/qdev-properties.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index cc924815da..249dc69bd8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -729,6 +729,13 @@ const PropertyInfo qdev_prop_pci_devfn = {
 
 /* --- blocksize --- */
 
+/* lower limit is sector size */
+#define MIN_BLOCK_SIZE          512
+#define MIN_BLOCK_SIZE_STR      stringify(MIN_BLOCK_SIZE)
+/* upper limit is the max power of 2 that fits in uint16_t */
+#define MAX_BLOCK_SIZE          32768
+#define MAX_BLOCK_SIZE_STR      stringify(MAX_BLOCK_SIZE)
+
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
@@ -736,8 +743,6 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
     Error *local_err = NULL;
-    const int64_t min = 512;
-    const int64_t max = 32768;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -750,9 +755,12 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
         return;
     }
     /* value of 0 means "unset" */
-    if (value && (value < min || value > max)) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   dev->id ? : "", name, (int64_t)value, min, max);
+    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value %" PRIu16
+                   " (minimum: " MIN_BLOCK_SIZE_STR
+                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
+                   dev->id ? : "", name, value);
         return;
     }
 
@@ -769,7 +777,8 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_blocksize = {
     .name  = "uint16",
-    .description = "A power of two between 512 and 32768",
+    .description = "A power of two between " MIN_BLOCK_SIZE_STR
+                   " and " MAX_BLOCK_SIZE_STR,
     .get   = get_uint16,
     .set   = set_blocksize,
     .set_default_value = set_default_value_uint,
-- 
2.25.4


