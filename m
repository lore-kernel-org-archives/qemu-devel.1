Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E3DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE862072D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="IyJ61abD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE862072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQIN-0004CJ-Fx
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jeQGI-0001FG-8r; Thu, 28 May 2020 17:40:28 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:35644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jeQGG-0000of-TC; Thu, 28 May 2020 17:40:25 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id BA59E2E0E4D;
 Fri, 29 May 2020 00:40:21 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 cApy1ma1ft-eIeujrcV; Fri, 29 May 2020 00:40:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590702021; bh=7tQKIjaOXt/4Y7vYYUMOTnckyEJyyiKNNu3wuyOniCw=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=IyJ61abDZvYdolV88vhvsRf/qW/U9Jap3J3kd6DM7xB7m+T+ajR/cSZy9vxxpNxa2
 ZxymbfVphokM0ohXrOdASuTtNlN1PdAbADJyPpV2CZkMzy2juLJPZeOcM5N3AgbSSK
 PYCYZwm6nmz+tuIaEtq3V6JA4jSnR+uDVG77Scik=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1318::1:10])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 KqoauPPys3-eHXqcO0n; Fri, 29 May 2020 00:40:18 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 4/8] qdev-properties: add size32 property type
Date: Fri, 29 May 2020 00:39:42 +0300
Message-Id: <20200528213946.1636444-5-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213946.1636444-1-rvkagan@yandex-team.ru>
References: <20200528213946.1636444-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.45.199.163; envelope-from=rvkagan@yandex-team.ru;
 helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:40:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce size32 property type which handles size suffixes (k, m) just
like size property, but is uint32_t rather than uint64_t.  It's going to
be useful for properties that are byte sizes but are inherently 32bit,
like BlkConf.opt_io_size or .discard_granularity (they are switched to
this new property type in a followup commit).

The getter for size32 is left out for a separate patch as its benefit is
less obvious, and it affects test output; for now the regular uint32
getter is used.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
v6 -> v7:
- split out into separate patch [Eric]

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
index 249dc69bd8..d943755832 100644
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
+                   " (maximum: " stringify(UINT32_MAX) ")",
+                   dev->id ? : "", name, value);
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
2.26.2


