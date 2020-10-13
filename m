Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1ABC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42117208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCwtmNQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42117208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQu1-0006Kx-7x
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kSQrJ-0003oi-CN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kSQrH-0007mZ-HQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602620718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTelGmRg3aEaFg50Oru4/e/Ms+ZDPD7qPI2W2Hzj6AE=;
 b=UCwtmNQheYughYw1b+2V6uGRAE2GdjkdIly4x2viV02Scs7rGftMPUsrUePYgui9Y0QoVh
 qzo4+OKSsBlQfyRkcRZUg4Y+KAaM4XFxhJ9I4m4nBF0U/Va+g70NI6ls9l2pUqOCqnV4U8
 IyJ549wI4dO12Pb9bKVFxeuxNRwxbCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-6hcBwQ0cNcGJ4XjGL27Lqg-1; Tue, 13 Oct 2020 16:25:16 -0400
X-MC-Unique: 6hcBwQ0cNcGJ4XjGL27Lqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1001D427FF;
 Tue, 13 Oct 2020 20:25:15 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF9586EF53;
 Tue, 13 Oct 2020 20:25:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] glib-compat: add g_unix_get_passwd_entry_qemu()
Date: Wed, 14 Oct 2020 00:25:01 +0400
Message-Id: <20201013202502.335336-2-marcandre.lureau@redhat.com>
In-Reply-To: <20201013202502.335336-1-marcandre.lureau@redhat.com>
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The glib function was introduced in 2.64. It's a safer version of
getpwnam, and also simpler to use than getpwnam_r.

Currently, it's only use by the next patch in qemu-ga, which doesn't
(well well...) need the thread safety guarantees. Since the fallback
version is still unsafe, I would rather keep the _qemu postfix, to make
sure it's not being misused by mistake. When/if necessary, we can
implement a safer fallback and drop the _qemu suffix.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/glib-compat.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/glib-compat.h b/include/glib-compat.h
index 0b0ec76299..2a56b3462b 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -30,6 +30,9 @@
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 
 #include <glib.h>
+#if defined(G_OS_UNIX)
+#include <glib-unix.h>
+#endif
 
 /*
  * Note that because of the GLIB_VERSION_MAX_ALLOWED constant above, allowing
@@ -72,6 +75,27 @@
 gint g_poll_fixed(GPollFD *fds, guint nfds, gint timeout);
 #endif
 
+#if defined(G_OS_UNIX)
+/* Note: The fallback implementation is not MT-safe, and it returns a copy of
+ * the libc passwd (must be g_free() after use) but not the content. Because of
+ * these important differences the caller must be aware of, it's not #define for
+ * GLib API substitution. */
+static inline struct passwd *
+g_unix_get_passwd_entry_qemu(const gchar *user_name, GError **error)
+{
+#if GLIB_CHECK_VERSION(2, 64, 0)
+    return g_unix_get_passwd_entry(user_name, error);
+#else
+    struct passwd *p = getpwnam(user_name);
+    if (!p) {
+        g_set_error(error, G_UNIX_ERROR, 0, g_strerror(errno));
+        return NULL;
+    }
+    return g_memdup(p, sizeof(*p));
+#endif
+}
+#endif /* G_OS_UNIX */
+
 #pragma GCC diagnostic pop
 
 #endif
-- 
2.28.0


