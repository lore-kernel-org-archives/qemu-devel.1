Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF4C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E764C20578
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7X17C6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E764C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiD5-0004RE-1H
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5k-00027Z-BI
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5i-0005ZP-M0
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XlKLzn5XQx+MgQAM4EHXhVcJekM1LfEac+tlMU7Ov/E=;
 b=I7X17C6smd4vtpBWPnXTsTPr40hZyxZAltHebzhRwc0/t7GQy+HMuvHFNyJrHX+y9e/b+X
 ood9S8O8HbFDEEs0L0nmznNB08yU+ajQZewFc87KoAIwyoCVKtmnh6M1gl7oc4ON7z1xkD
 b2fr9diMJt4sUoCpBIXZ+sOZWqbRTOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-tbs0h5hQO9S8vGCEgpbzTg-1; Sun, 11 Oct 2020 16:37:12 -0400
X-MC-Unique: tbs0h5hQO9S8vGCEgpbzTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42468802B4A
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:37:11 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC5B660C05;
 Sun, 11 Oct 2020 20:37:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 11/15] qga: add qmp! macro helper
Date: Mon, 12 Oct 2020 00:35:09 +0400
Message-Id: <20201011203513.1621355-12-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:23:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add a macro to help wrapping higher-level qmp handlers, by taking care
of errors and return value pointer translation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/lib.rs     |  1 +
 qga/qmp/mod.rs | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 qga/qmp/mod.rs

diff --git a/qga/lib.rs b/qga/lib.rs
index bff4107569..5fe08c25a3 100644
--- a/qga/lib.rs
+++ b/qga/lib.rs
@@ -1,2 +1,3 @@
 mod qapi;
 mod qapi_sys;
+mod qmp;
diff --git a/qga/qmp/mod.rs b/qga/qmp/mod.rs
new file mode 100644
index 0000000000..38060100af
--- /dev/null
+++ b/qga/qmp/mod.rs
@@ -0,0 +1,36 @@
+use common::*;
+
+use crate::*;
+
+macro_rules! qmp {
+    // the basic return value variant
+    ($e:expr, $errp:ident, $errval:expr) => {{
+        assert!(!$errp.is_null());
+        unsafe {
+            *$errp = std::ptr::null_mut();
+        }
+
+        match $e {
+            Ok(val) => val,
+            Err(err) => unsafe {
+                *$errp = err.to_qemu_full();
+                $errval
+            },
+        }
+    }};
+    // the ptr return value variant
+    ($e:expr, $errp:ident) => {{
+        assert!(!$errp.is_null());
+        unsafe {
+            *$errp = std::ptr::null_mut();
+        }
+
+        match $e {
+            Ok(val) => val.to_qemu_full().into(),
+            Err(err) => unsafe {
+                *$errp = err.to_qemu_full();
+                std::ptr::null_mut()
+            },
+        }
+    }};
+}
-- 
2.28.0


