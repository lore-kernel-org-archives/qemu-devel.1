Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF0C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8A82068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXa3ly7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8A82068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7TK-0001PD-AZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OW-0004rP-3c
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7OS-0000hO-Kw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2i9yh38GZyNj64lBiN9zdfC8q/cs4LpcQhIxX3M+EjM=;
 b=LXa3ly7f9BCaNcmaoM3yeltnBWxQQIhopZbw+zbuzv/BqthaFlIUbRQwnmCTOVXjQvmpQu
 nyyaip+cHLv7Rjc7auvt/CG2MQ0jDm36/oEl6oidXKRZGIURwMAHo4d6YL22ApF7vw4RoZ
 GhuHh13VpddZUg5HRy2O+OhwVrSMrko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-eIkX4TetM3if0VZJNoAF3g-1; Mon, 09 Nov 2020 08:39:33 -0500
X-MC-Unique: eIkX4TetM3if0VZJNoAF3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C029E188C12D
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 13:39:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 716676EF40;
 Mon,  9 Nov 2020 13:39:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] qemu-option: simplify search for end of key
Date: Mon,  9 Nov 2020 08:39:26 -0500
Message-Id: <20201109133931.979563-2-pbonzini@redhat.com>
In-Reply-To: <20201109133931.979563-1-pbonzini@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use strcspn to find an equal or comma value, and pass the result directly
to get_opt_name to avoid another strchr.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-option.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index acefbc23fa..ab3b58599e 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -38,27 +38,19 @@
 #include "qemu/help_option.h"
 
 /*
- * Extracts the name of an option from the parameter string (p points at the
+ * Extracts the name of an option from the parameter string (@p points at the
  * first byte of the option name)
  *
- * The option name is delimited by delim (usually , or =) or the string end
- * and is copied into option. The caller is responsible for free'ing option
- * when no longer required.
+ * The option name is @len characters long and is copied into @option. The
+ * caller is responsible for free'ing @option when no longer required.
  *
  * The return value is the position of the delimiter/zero byte after the option
- * name in p.
+ * name in @p.
  */
-static const char *get_opt_name(const char *p, char **option, char delim)
+static const char *get_opt_name(const char *p, char **option, size_t len)
 {
-    char *offset = strchr(p, delim);
-
-    if (offset) {
-        *option = g_strndup(p, offset - p);
-        return offset;
-    } else {
-        *option = g_strdup(p);
-        return p + strlen(p);
-    }
+    *option = g_strndup(p, len);
+    return p + len;
 }
 
 /*
@@ -769,12 +761,11 @@ static const char *get_opt_name_value(const char *params,
                                       const char *firstname,
                                       char **name, char **value)
 {
-    const char *p, *pe, *pc;
-
-    pe = strchr(params, '=');
-    pc = strchr(params, ',');
+    const char *p;
+    size_t len;
 
-    if (!pe || (pc && pc < pe)) {
+    len = strcspn(params, "=,");
+    if (params[len] != '=') {
         /* found "foo,more" */
         if (firstname) {
             /* implicitly named first option */
@@ -782,7 +773,7 @@ static const char *get_opt_name_value(const char *params,
             p = get_opt_value(params, value);
         } else {
             /* option without value, must be a flag */
-            p = get_opt_name(params, name, ',');
+            p = get_opt_name(params, name, len);
             if (strncmp(*name, "no", 2) == 0) {
                 memmove(*name, *name + 2, strlen(*name + 2) + 1);
                 *value = g_strdup("off");
@@ -792,7 +783,7 @@ static const char *get_opt_name_value(const char *params,
         }
     } else {
         /* found "foo=bar,more" */
-        p = get_opt_name(params, name, '=');
+        p = get_opt_name(params, name, len);
         assert(*p == '=');
         p++;
         p = get_opt_value(p, value);
-- 
2.26.2



