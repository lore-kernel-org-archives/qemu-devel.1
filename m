Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3504C2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZcRj59r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3504C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQEf-0004pO-Cq
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnQDi-0003n4-04
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:26:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jnQDg-00068K-Ak
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592846815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4mj57v5yU1nCJH7jOSXLZpM4EHPNkY6Oi4TT47QtvY=;
 b=CZcRj59rn389wdAL8eq0IUbwv4gkH5HeEBl06Ck5ixnCEtbCCQkvVij9UaA65ku4KpN9s6
 1ooW50s/MBuPPmA43xwuvW2582ratzU+0RF+nHqT4nTV/+oDMBdQabF0BD56e2UqmwW5T0
 pLlqhkp1jp2lxtDFt4As/D0RrWZJz5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-nNIhR39JP7C_WucnRWpx7A-1; Mon, 22 Jun 2020 13:26:54 -0400
X-MC-Unique: nNIhR39JP7C_WucnRWpx7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E58835B41;
 Mon, 22 Jun 2020 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63E585C1BD;
 Mon, 22 Jun 2020 17:26:51 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] util: Introduce qemu_get_host_name()
Date: Mon, 22 Jun 2020 19:26:44 +0200
Message-Id: <567f969602c1742e23c7760944e909346b2d012b.1592846572.git.mprivozn@redhat.com>
In-Reply-To: <cover.1592846572.git.mprivozn@redhat.com>
References: <cover.1592846572.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: pbonzini@redhat.com, vfeenstr@redhat.com, marcandre.lureau@gmail.com,
 mdroth@linux.vnet.ibm.com, sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function offers operating system agnostic way to fetch host
name. It is implemented for both POSIX-like and Windows systems.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 include/qemu/osdep.h | 10 ++++++++++
 util/oslib-posix.c   | 32 ++++++++++++++++++++++++++++++++
 util/oslib-win32.c   | 13 +++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index ff7c17b857..a795d46b28 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -607,4 +607,14 @@ static inline void qemu_reset_optind(void)
 #endif
 }
 
+/**
+ * qemu_get_host_name:
+ * @errp: Error object
+ *
+ * Operating system agnostic way of querying host name.
+ *
+ * Returns allocated hostname (caller should free), NULL on failure.
+ */
+char *qemu_get_host_name(Error **errp);
+
 #endif
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 916f1be224..865a3d71a7 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -761,3 +761,35 @@ void sigaction_invoke(struct sigaction *action,
     }
     action->sa_sigaction(info->ssi_signo, &si, NULL);
 }
+
+#ifndef HOST_NAME_MAX
+# ifdef _POSIX_HOST_NAME_MAX
+#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
+# else
+#  define HOST_NAME_MAX 255
+# endif
+#endif
+
+char *qemu_get_host_name(Error **errp)
+{
+    long len = -1;
+    char *hostname;
+
+#ifdef _SC_HOST_NAME_MAX
+    len = sysconf(_SC_HOST_NAME_MAX);
+#endif /* _SC_HOST_NAME_MAX */
+
+    if (len < 0) {
+        len = HOST_NAME_MAX;
+    }
+
+    hostname = g_malloc0(len + 1);
+
+    if (gethostname(hostname, len) < 0) {
+        error_setg_errno(errp, errno,
+                         "cannot get hostname");
+        return NULL;
+    }
+
+    return hostname;
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index e9b14ab178..3b49d27297 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -808,3 +808,16 @@ bool qemu_write_pidfile(const char *filename, Error **errp)
     }
     return true;
 }
+
+char *qemu_get_host_name(Error **errp)
+{
+    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
+    DWORD size = G_N_ELEMENTS(tmp);
+
+    if (GetComputerNameW(tmp, &size) == 0) {
+        error_setg_win32(errp, GetLastError(), "failed close handle");
+        return NULL;
+    }
+
+    return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
+}
-- 
2.26.2


