Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC38C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAA42173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CbKJAPw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAA42173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Wwv-0006sC-5l
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36820)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <35-hkXQYKCj4xfrjnilttlqj.htrvjrz-ij0jqstslsz.twl@flex--sameid.bounces.google.com>)
 id 1i2Wmw-0005AP-4f
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <35-hkXQYKCj4xfrjnilttlqj.htrvjrz-ij0jqstslsz.twl@flex--sameid.bounces.google.com>)
 id 1i2Wmu-0007zl-KX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:14 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a]:32794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <35-hkXQYKCj4xfrjnilttlqj.htrvjrz-ij0jqstslsz.twl@flex--sameid.bounces.google.com>)
 id 1i2Wmu-0007yO-Do
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:25:12 -0400
Received: by mail-qt1-x84a.google.com with SMTP id z4so7765747qts.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=8eLgMvSwORUZUmDlsIJbtbpzEk6fBmFl/QdEmSm+N6s=;
 b=CbKJAPw1MT/IBrPU8qQ6swEAaAYIdWjHRJRpRIcxJ3pOz34LIGk3RvyLDuz6Cizf7l
 HQwvZQOkaHTWmbmyY2frSZdUI43cLDiE7Xzr4xOviAgKRJaZtAlmEXtEPLNPhSsOxt4T
 9d3q5+f7C2OyQ1BgCWrYQ8vFPX+ykhbt+osW/cCWKcI92i+4GT3bBGM+P/e9GJa/sNSt
 GgkBcoZg09Eoj4OxKtL42Clv/swGGz+hV3qvlNuCEuTr6jd0sIWyX0nWoP9yi28yMHPm
 dpTAdmOqu6dhiMqo56uP2lNHJp2i2xXig93spewf6Kv0i/aVct2kDh/RH+ugG5/EnZZ7
 wv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=8eLgMvSwORUZUmDlsIJbtbpzEk6fBmFl/QdEmSm+N6s=;
 b=Yf5q6gRfOUkwNWzJ+F57y5PTd6QRN8mkHTW9+W31VJWFYt/EXGyqmw2Qb6bFICv8X9
 Q79wRIegYpCRO2CSgh0I59g+ElYdNqGNE8+wJP9rPCLcyyIbO/bvEtWtK2fJ0xuq3Y4R
 3Wm/DBuWrk7Cf1FLsacAcfHIK7Mi3nkWJ98XRssp2cIVcZb6q5Fpueof0WkpbKUFWFIV
 FP6a9aJDisiYvD4u4xYfxmBOdfNQ5gbca8OfR8jtnYkY7OzlAMEZ2ULRbWBYowLm6mm7
 8mmDV9qZ2Lcnbw3sGZZHxfK6AXT4/NDDwO57KGbG/OYPATu/r5N9LiRnvz7u5iWQHRS/
 /sBw==
X-Gm-Message-State: APjAAAXz0f2U+1nWyJLMAK8BhGFZchS5stNz6sbjrVr+7Vy0hbxXdx4k
 eV4FIxapxjAzmJpUt39PnOY51p6MzfVwSMuX4xGJlyc/gA/I8r0Y7C1FT+OREx/0TwI8tJ1q4j8
 8I06FhE3T8qR/zRxE1Jd845Iy0F9+Z5yWlPOMDNJZRqJAoPwbG3vqLLQbvdN5
X-Google-Smtp-Source: APXvYqzR2Bu5tguLmNI2OJs0vJYQdBPkgBFglYW047s6xn9s/pmimcdYPkN3v+UNZqcUaKuhGP9+ar6pLMg=
X-Received: by 2002:a05:620a:16d6:: with SMTP id
 a22mr20275853qkn.414.1566894311112; 
 Tue, 27 Aug 2019 01:25:11 -0700 (PDT)
Date: Tue, 27 Aug 2019 11:24:25 +0300
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Message-Id: <20190827082427.64280-7-sameid@google.com>
Mime-Version: 1.0
References: <20190827082427.64280-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::84a
Subject: [Qemu-devel] [PATCH v6 6/8] bootdevice: Refactor
 get_boot_devices_list
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Arbel Moshe <arbel.moshe@oracle.com>, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, sameid@google.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

Move device name construction to a separate function.

We will reuse this function in the following commit to pass logical CHS
parameters through fw_cfg much like we currently pass bootindex.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 bootdevice.c | 61 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index bc5e1c2de4..2b12fb85a4 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
     return res;
 }
 
+static char *get_boot_device_path(DeviceState *dev, bool ignore_suffixes,
+                                  char *suffix)
+{
+    char *devpath = NULL, *s = NULL, *d, *bootpath;
+
+    if (dev) {
+        devpath = qdev_get_fw_dev_path(dev);
+        assert(devpath);
+    }
+
+    if (!ignore_suffixes) {
+        if (dev) {
+            d = qdev_get_own_fw_dev_path_from_handler(dev->parent_bus, dev);
+            if (d) {
+                assert(!suffix);
+                s = d;
+            } else {
+                s = g_strdup(suffix);
+            }
+        } else {
+            s = g_strdup(suffix);
+        }
+    }
+
+    bootpath = g_strdup_printf("%s%s",
+                               devpath ? devpath : "",
+                               s ? s : "");
+    g_free(devpath);
+    g_free(s);
+
+    return bootpath;
+}
+
 /*
  * This function returns null terminated string that consist of new line
  * separated device paths.
@@ -218,36 +251,10 @@ char *get_boot_devices_list(size_t *size)
     bool ignore_suffixes = mc->ignore_boot_device_suffixes;
 
     QTAILQ_FOREACH(i, &fw_boot_order, link) {
-        char *devpath = NULL,  *suffix = NULL;
         char *bootpath;
-        char *d;
         size_t len;
 
-        if (i->dev) {
-            devpath = qdev_get_fw_dev_path(i->dev);
-            assert(devpath);
-        }
-
-        if (!ignore_suffixes) {
-            if (i->dev) {
-                d = qdev_get_own_fw_dev_path_from_handler(i->dev->parent_bus,
-                                                          i->dev);
-                if (d) {
-                    assert(!i->suffix);
-                    suffix = d;
-                } else {
-                    suffix = g_strdup(i->suffix);
-                }
-            } else {
-                suffix = g_strdup(i->suffix);
-            }
-        }
-
-        bootpath = g_strdup_printf("%s%s",
-                                   devpath ? devpath : "",
-                                   suffix ? suffix : "");
-        g_free(devpath);
-        g_free(suffix);
+        bootpath = get_boot_device_path(i->dev, ignore_suffixes, i->suffix);
 
         if (total) {
             list[total-1] = '\n';
-- 
2.23.0.187.g17f5b7556c-goog


