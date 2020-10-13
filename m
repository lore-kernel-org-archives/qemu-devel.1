Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7753BC43467
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FA921548
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pw7NsqBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FA921548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHTb-0007tB-UG
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHSN-0007NS-QE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSHSM-0002HN-42
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602584577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I2xLcUCOg+w2ZAQrbFZfCxIVaFLFEbcnv9+M6NmjtDk=;
 b=Pw7NsqBvquAIi7+qRaCTBkpZ1ExLp1goRu1+6JFAA/wF+aKY+nIrvSRy+B3MGIzpGtcGlu
 c99y+Mm9KJdHf2f7/NhHYHoU3+9STnWjjLRRekstyNUOyqOYezVv4s7ciNq/VapsAmSRlG
 DLXXuoxhgDwipXw9jJFIvaMy0WG0eUA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-E2EW-WxdPFKTNfdqWeIlrQ-1; Tue, 13 Oct 2020 06:22:56 -0400
X-MC-Unique: E2EW-WxdPFKTNfdqWeIlrQ-1
Received: by mail-wr1-f72.google.com with SMTP id m20so4369591wrb.21
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I2xLcUCOg+w2ZAQrbFZfCxIVaFLFEbcnv9+M6NmjtDk=;
 b=twP5vxLcYhpqmuVYEbn0dwvJrbLJxVmB6oDGm+lSKckNMisgNLHJuq85FNrpsOjO6e
 ZGl+v1r5wNTktCTxLwgygVZ3/b5BiYD9njPiU//0dpO4F5t4ldh7phLAp6Di/tbJWhOY
 VFgYf+IHrpkZmLnxD+X7FZ9N4uaD1jKZcKiPlhDHajwpZ5nzhipzVHn1hEdb+2aYStjc
 lwGMNy/Ih7QRpBZXlgc7kOQxbygPWF8Jq5pLDxBRPwFrmpvnmOJ7muGEVoYhNldLiCP2
 PVSK47XZmObrdcEEj0BTgd34GCbXJlJQ9hjIItD/03ZDX8s3RHgkHbRl2Fb0oEXx1ItF
 6V8w==
X-Gm-Message-State: AOAM533hcgVXtfgjejj4yCVsq3xM0sRDSYs73qBCTa6dXtaQN35mhPAZ
 Zx9lFn1m9OmmxvMTXD7G5xk6YrSMGNSryuC1mumzWBxuspdDgrXyP1JK0uTvrR9xUoY+8SiWa0p
 f+2Xvt4PE820qC5c=
X-Received: by 2002:adf:ff88:: with SMTP id j8mr33823734wrr.69.1602584574623; 
 Tue, 13 Oct 2020 03:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdhnZRV6Rqa5x2UJW9trFmtSmPBOMpbDO9EjlqOAZfmwJ3Vx2FBQPxXdGkSGGp0y8+8/OysQ==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr33823709wrr.69.1602584574355; 
 Tue, 13 Oct 2020 03:22:54 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u195sm4367399wmu.18.2020.10.13.03.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:22:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/core/qdev-properties-system: Rewrite
 set_pci_host_devaddr using GLib
Date: Tue, 13 Oct 2020 12:22:52 +0200
Message-Id: <20201013102252.3562860-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Klaus Herman <kherman@inbox.lv>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

set_pci_host_devaddr() is hard to follow, thus bug-prone.
We indeed introduced a bug in commit bccb20c49df, as the
same line might be used to parse a bus (up to 0xff) or a
slot (up to 0x1f). Instead of making things worst, rewrite
using g_strsplit().

Fixes: bccb20c49df ("Use qemu_strtoul() in set_pci_host_devaddr()")
Reported-by: Klaus Herman <kherman@inbox.lv>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: Free g_strsplit() with g_auto(GStrv) (Daniel)
---
 hw/core/qdev-properties-system.c | 61 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 49bdd125814..36d4fd8b22a 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -878,11 +878,11 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
-    char *str, *p;
-    const char *e;
+    g_autofree char *str = NULL;
+    g_auto(GStrv) col_s0 = NULL;
+    g_auto(GStrv) dot_s = NULL;
+    char **col_s;
     unsigned long val;
-    unsigned long dom = 0, bus = 0;
-    unsigned int slot = 0, func = 0;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -893,57 +893,50 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    p = str;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
+    col_s = col_s0 = g_strsplit(str, ":", 3);
+    if (!col_s || !col_s[0] || !col_s[1]) {
         goto inval;
     }
-    if (*e != ':') {
-        goto inval;
-    }
-    bus = val;
 
-    p = (char *)e + 1;
-    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
-        goto inval;
-    }
-    if (*e == ':') {
-        dom = bus;
-        bus = val;
-        p = (char *)e + 1;
-        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
+    /* domain */
+    if (col_s[2]) {
+        if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xffff) {
             goto inval;
         }
+        addr->domain = val;
+        col_s++;
+    } else {
+        addr->domain = 0;
     }
-    slot = val;
 
-    if (*e != '.') {
+    /* bus */
+    if (qemu_strtoul(col_s[0], NULL, 16, &val) < 0 || val > 0xff) {
         goto inval;
     }
-    p = (char *)e + 1;
-    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
-        goto inval;
-    }
-    func = val;
+    addr->bus = val;
 
-    if (bus > 0xff) {
+    /* <slot>.<func> */
+    dot_s = g_strsplit(col_s[1], ".", 2);
+    if (!dot_s || !dot_s[0] || !dot_s[1]) {
         goto inval;
     }
 
-    if (*e) {
+    /* slot */
+    if (qemu_strtoul(dot_s[0], NULL, 16, &val) < 0 || val > 0x1f) {
         goto inval;
     }
+    addr->slot = val;
 
-    addr->domain = dom;
-    addr->bus = bus;
-    addr->slot = slot;
-    addr->function = func;
+    /* func */
+    if (qemu_strtoul(dot_s[1], NULL, 10, &val) < 0 || val > 7) {
+        goto inval;
+    }
+    addr->function = val;
 
-    g_free(str);
     return;
 
 inval:
     error_set_from_qdev_prop_error(errp, EINVAL, dev, prop, str);
-    g_free(str);
 }
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
-- 
2.26.2


