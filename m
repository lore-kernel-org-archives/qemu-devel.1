Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7147206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWOsHNNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7147206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZr3-00040I-4m
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOB-0003Y5-Iu
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZO9-0001oX-Vi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8eey7xparn6EiYKkK4D9XdwiuvnjzzdXKZSyblvuEI=;
 b=OWOsHNNtoKNhJrDTLNVjxuTWkts0nLUEhVTzooJEPmXOYOjHnsf4B5g8X0mUlJrBvSUpJ6
 ObIyuGmSezzySpMCWPN4zeLwhbrtqGTX+66QSpxvhgokpkoMckJuGjPwaOOuv/tAenvL8d
 dGzQ9W9j26KPBJpH0o4DQFhZLXkrI0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-WTht3TI8PkaEkxIL5-x3Yw-1; Wed, 17 Jun 2020 10:49:59 -0400
X-MC-Unique: WTht3TI8PkaEkxIL5-x3Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9198A8730B2;
 Wed, 17 Jun 2020 14:49:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9AB7CAA0;
 Wed, 17 Jun 2020 14:49:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/43] qdev-properties: add size32 property type
Date: Wed, 17 Jun 2020 16:48:59 +0200
Message-Id: <20200617144909.192176-34-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rvkagan@yandex-team.ru>

Introduce size32 property type which handles size suffixes (k, m, g)
just like size property, but is uint32_t rather than uint64_t.  It's
going to be useful for properties that are byte sizes but are inherently
32bit, like BlkConf.opt_io_size or .discard_granularity (they are
switched to this new property type in a followup commit).

The getter for size32 is left out for a separate patch as its benefit is
less obvious, and it affects test output; for now the regular uint32
getter is used.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Message-Id: <20200528225516.1676602-5-rvkagan@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/qdev-properties.h |  3 +++
 hw/core/qdev-properties.c    | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..c03eadfad6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -29,6 +29,7 @@ extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_drive_iothread;
 extern const PropertyInfo qdev_prop_netdev;
 extern const PropertyInfo qdev_prop_pci_devfn;
+extern const PropertyInfo qdev_prop_size32;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
 extern const PropertyInfo qdev_prop_uuid;
@@ -196,6 +197,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
                         BlockdevOnError)
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
+#define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 249dc69bd8..40c13f6ebe 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -727,6 +727,46 @@ const PropertyInfo qdev_prop_pci_devfn = {
     .set_default_value = set_default_value_int,
 };
 
+/* --- 32bit unsigned int 'size' type --- */
+
+static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
+                       Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (value > UINT32_MAX) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value %" PRIu64
+                   " (maximum: %u)",
+                   dev->id ? : "", name, value, UINT32_MAX);
+        return;
+    }
+
+    *ptr = value;
+}
+
+const PropertyInfo qdev_prop_size32 = {
+    .name  = "size",
+    .get = get_uint32,
+    .set = set_size32,
+    .set_default_value = set_default_value_uint,
+};
+
 /* --- blocksize --- */
 
 /* lower limit is sector size */
-- 
2.25.4


