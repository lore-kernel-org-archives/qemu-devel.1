Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0352AC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4C42085B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0xg0eEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4C42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfNi-00036Q-BS
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJ3-0006Pz-GH
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJ0-00073m-7o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEjJONFrTBimyHKi2i/2D3r46cwVifpdF+Aae2zJhkU=;
 b=J0xg0eEOOoY8flM+9UNAGfshJqNwEqoLqBlOyWiB4NFsX1VFct+Sd86nMLTFLwAylUg4Pv
 9zIM7mNqEtSiWL1hiDZ5CExW1UHDBk6o4bIn4F1JCyZov7d+jjfVoqw5rVxA1ZbPjbzJ23
 CSby1lDru0/xNTtNXO8AbyOgS/kCcc0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-l0gqRVf5OgWJVW3-lKPVpA-1; Wed, 30 Sep 2020 12:50:12 -0400
X-MC-Unique: l0gqRVf5OgWJVW3-lKPVpA-1
Received: by mail-wm1-f71.google.com with SMTP id b20so220851wmj.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AEjJONFrTBimyHKi2i/2D3r46cwVifpdF+Aae2zJhkU=;
 b=PeWAeYhW+XElFBaKVeFDTQ+UWsHQ4GyflkqtJQn6a8vrfwaD+Spxk+wvOl088PJz0g
 JsSYH62r8QRiQQlP5nFyik2QjERdiL0XvFelDFZbb2bFWPQ2+Cn1kM9F4rDV7l18DsAQ
 v2aQeE0wY1FNuyuMGva+VPeNYaXVRe9QCO2Pw1gQoMnQ0zq621fWknqqOe0Vj2potYzj
 /buJU1MJCg2aLiuWQ+Fkvgt5tlEu00yVwGJb2eH3k+as3DBUGln/OFvWa1MWX2Oy7Jrl
 Bxw1lu/+1nS0DcPvpzwcZxtJhNEl3GMdcLX0oXrb0eD+xjgAuQI8VDTdUITEFwDz3uNi
 5+Ag==
X-Gm-Message-State: AOAM530HoCSd2+6kcfwQpfyx4XMhTtqeWch86fIl1ctJQ+73R+C+8EOT
 XnSvqWM3syUtfszhpHGNJZs18bqrgspd8cydJP+9EqDtVBkXn2A6y51P1fUllToWRDnlzKosAIq
 QuN9TAPJD1huJHd8=
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr4121744wmc.151.1601484607738; 
 Wed, 30 Sep 2020 09:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwynqRkbqXGunLbcXXsuq4/kf0mah5iSCwc05KRFVcDGC/tNwtcfpL+8lz9Cc3EmsmQpYveTQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr4121721wmc.151.1601484607506; 
 Wed, 30 Sep 2020 09:50:07 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b188sm3867646wmb.2.2020.09.30.09.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 03/11] hw/core/qdev-properties: Use qemu_strtoul() in
 set_pci_host_devaddr()
Date: Wed, 30 Sep 2020 18:49:41 +0200
Message-Id: <20200930164949.1425294-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace strtoul() by qemu_strtoul() so checkpatch.pl won't complain
if we move this code later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/qdev-properties.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 080ba319a1..a1190a5db9 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -951,7 +951,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
     char *str, *p;
-    char *e;
+    const char *e;
     unsigned long val;
     unsigned long dom = 0, bus = 0;
     unsigned int slot = 0, func = 0;
@@ -966,23 +966,23 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     }
 
     p = str;
-    val = strtoul(p, &e, 16);
-    if (e == p || *e != ':') {
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0xffff || e == p) {
+        goto inval;
+    }
+    if (*e != ':') {
         goto inval;
     }
     bus = val;
 
-    p = e + 1;
-    val = strtoul(p, &e, 16);
-    if (e == p) {
+    p = (char *)e + 1;
+    if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
         goto inval;
     }
     if (*e == ':') {
         dom = bus;
         bus = val;
-        p = e + 1;
-        val = strtoul(p, &e, 16);
-        if (e == p) {
+        p = (char *)e + 1;
+        if (qemu_strtoul(p, &e, 16, &val) < 0 || val > 0x1f || e == p) {
             goto inval;
         }
     }
@@ -991,14 +991,13 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     if (*e != '.') {
         goto inval;
     }
-    p = e + 1;
-    val = strtoul(p, &e, 10);
-    if (e == p) {
+    p = (char *)e + 1;
+    if (qemu_strtoul(p, &e, 10, &val) < 0 || val > 7 || e == p) {
         goto inval;
     }
     func = val;
 
-    if (dom > 0xffff || bus > 0xff || slot > 0x1f || func > 7) {
+    if (bus > 0xff) {
         goto inval;
     }
 
-- 
2.26.2


