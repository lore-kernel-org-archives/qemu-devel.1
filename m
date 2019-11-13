Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ABDC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA76222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPFBJoL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA76222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUts3-0002p5-OH
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnf-0005lN-Da
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtne-0006K9-8e
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:15 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtne-0006Jh-1r
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:14 -0500
Received: by mail-wr1-x443.google.com with SMTP id w9so2667517wrr.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6wm1YNSrTob9W5VNPA38HVv/k6LxUe96COGHHCY161w=;
 b=oPFBJoL38PVR1ol2az3KUBrpbiNr9VgxBSksE9oSOCnavSy/r7o4LRgsNlCjTWKRlK
 kLGV3z7TzTQ3NhihFeh89C2OW2tQpbChnFEDpKkhyikzsSyrjPiI/YbCF1Ioe2HP9DdF
 Pz/hypjBfAB/wkO7HF1ogFp+Wv7gqzl7SqILiJzUrOBo0Vy0oZE1jOFk/UXTyU8NX/+u
 x7CZ8SrE/KIf1LUtgwhrAn3OZUuw7zGaRauLD35cn6zhW3SkFfwQ7z4b9H6AaOPp2gNw
 IFvT1/AXBYEs0UjGtIAxXFAFgA8Qctmi8/ykbMa93i3qj6zUw+jc9I9Pq6eB2z9EHZy4
 ZCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=6wm1YNSrTob9W5VNPA38HVv/k6LxUe96COGHHCY161w=;
 b=YuSWJTLFUXEM+r0AjhXqIhp+SCZVqTb+xlFPewkRho/AsiiCNMQflCthVsvGTRoqeH
 KXaz+9xY0ACS9jK505E3vrZ7W7g9f5czxoxiMfUfFnrm3XYGFEb8mwX4jMWJ2V9B7gzF
 K4VkbxjRY8oNzWEr5qbZprhvvCCkM4FefsSeShMpQtrPg/n/256co2dcUsUjvWXUOa6f
 0LWvZRHasghu/xhNGdc7znsqmOHWfCVb4GEbYOtsNdzrxWIfBFsLeoEs8Y1WujXLLHiw
 A2rUYBzN8pUIXH80QpvGcmnZlBVMQYa6YkfKPGW8h4FoB7WZJtBB0EcdAfsgHL7p3Ow8
 BnpQ==
X-Gm-Message-State: APjAAAVc24HPzFNvdOCWnv6BREAtGMvk9VVszML6lwg7VVnt6PyIZo8s
 VgllYpySI+64BKzqQgjIJ5EQDNu9
X-Google-Smtp-Source: APXvYqzUrmONQ+8hhQE0/fVsVs9ymd4Sk37dNFmBesDoEUank1GzRxH6yMZXs9ZMZsdhWdJL4ABomw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr3368543wrs.288.1573655951866; 
 Wed, 13 Nov 2019 06:39:11 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] vl: introduce object_parse_property_opt
Date: Wed, 13 Nov 2019 15:38:54 +0100
Message-Id: <1573655945-14912-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will reuse the parsing loop of machine_set_property soon for "-accel",
but we do not want the "_" -> "-" conversion since "-accel" can just
standardize on dashes.  We will also add a bunch of legacy option handling
to keep the QOM machine object clean.  Extract the loop into a separate
function, and keep the legacy handling in machine_set_property.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/vl.c b/vl.c
index dbc99d7..b93217d 100644
--- a/vl.c
+++ b/vl.c
@@ -2617,27 +2617,17 @@ static MachineClass *select_machine(void)
     return machine_class;
 }
 
-static int machine_set_property(void *opaque,
-                                const char *name, const char *value,
-                                Error **errp)
+static int object_parse_property_opt(Object *obj,
+                                     const char *name, const char *value,
+                                     const char *skip, Error **errp)
 {
-    Object *obj = OBJECT(opaque);
     Error *local_err = NULL;
-    char *p, *qom_name;
 
-    if (strcmp(name, "type") == 0) {
+    if (g_str_equal(name, skip)) {
         return 0;
     }
 
-    qom_name = g_strdup(name);
-    for (p = qom_name; *p; p++) {
-        if (*p == '_') {
-            *p = '-';
-        }
-    }
-
-    object_property_parse(obj, value, qom_name, &local_err);
-    g_free(qom_name);
+    object_property_parse(obj, value, name, &local_err);
 
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2647,6 +2637,24 @@ static int machine_set_property(void *opaque,
     return 0;
 }
 
+static int machine_set_property(void *opaque,
+                                const char *name, const char *value,
+                                Error **errp)
+{
+    char *qom_name = g_strdup(name);
+    char *p;
+    int r;
+
+    for (p = qom_name; *p; p++) {
+        if (*p == '_') {
+            *p = '-';
+        }
+    }
+
+    r = object_parse_property_opt(opaque, name, value, "type", errp);
+    g_free(qom_name);
+    return r;
+}
 
 /*
  * Initial object creation happens before all other
-- 
1.8.3.1



