Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8FCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8DE206F7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNVz/B6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8DE206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl74e-0003lt-S3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jl73g-0002wh-Vz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:35:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jl73e-0006m8-MO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592296501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=441Au4JLZA/lYrgUqCSi3fJDG1QA5awJFvDGE3V4cZM=;
 b=WNVz/B6/Upmd7CdBmkso2ZqgQq8QMcRz+sdVbEnVJwWQP7/4DTr9fyh+biwmz4AfmZfHRK
 OcC6A3q6lWTI/J/51u0AJIl7E4MvmOdJESgB5W3KxkYQ6IWNg9IWbgLFQsh4u/ObpmHbjH
 WROs16M2rh7pJIdsbwl/jFapRNlDR5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-khKAqqNjOAWnzVWF1GxOHw-1; Tue, 16 Jun 2020 04:34:57 -0400
X-MC-Unique: khKAqqNjOAWnzVWF1GxOHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D63B6803330;
 Tue, 16 Jun 2020 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02CAB79301;
 Tue, 16 Jun 2020 08:34:55 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qga: Use gethostname() instead of g_get_host_name()
Date: Tue, 16 Jun 2020 10:34:47 +0200
Message-Id: <8e73f685e10c684eb5e2c88c2185504d26f024fc.1592296355.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: vfeenstr@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Problem with g_get_host_name() is that on the first call it saves
the hostname into a global variable and from then on, every
subsequent call returns the saved hostname. Even if the hostname
changes. This doesn't play nicely with guest agent, because if
the hostname is acquired before the guest is set up (e.g. on the
first boot, or before DHCP) we will report old, invalid hostname.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1845127

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qga/commands.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index efc8b90281..ce3c2041a6 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -512,14 +512,62 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     return -1;
 }
 
+#ifndef HOST_NAME_MAX
+# ifdef _POSIX_HOST_NAME_MAX
+#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
+# else
+#  define HOST_NAME_MAX 255
+# endif
+#endif
+
 GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
     GuestHostName *result = NULL;
-    gchar const *hostname = g_get_host_name();
-    if (hostname != NULL) {
-        result = g_new0(GuestHostName, 1);
-        result->host_name = g_strdup(hostname);
+    g_autofree char *hostname = NULL;
+
+    /*
+     * We want to avoid using g_get_host_name() because that
+     * caches the result and we wouldn't reflect changes in the
+     * host name.
+     */
+
+#ifndef G_OS_WIN32
+    long len = -1;
+
+#ifdef _SC_HOST_NAME_MAX
+    len = sysconf(_SC_HOST_NAME_MAX);
+#endif /* _SC_HOST_NAME_MAX */
+
+    if (len < 0) {
+        len = HOST_NAME_MAX;
     }
+
+    hostname = g_malloc0(len + 1);
+
+    if (gethostname(hostname, len) < 0) {
+        return NULL;
+    }
+
+#else /* G_OS_WIN32 */
+
+    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
+    DWORD size = G_N_ELEMENTS(tmp);
+
+    if (GetComputerNameW(tmp, &size) != 0) {
+        /*
+         * Indeed, on Windows retval of zero means failure
+         * and nonzero means success.
+         */
+        hostname = g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
+    }
+#endif /* G_OS_WIN32 */
+
+    if (!hostname) {
+        hostname = g_strdup("localhost");
+    }
+
+    result = g_new0(GuestHostName, 1);
+    result->host_name = g_steal_pointer(&hostname);
     return result;
 }
 
-- 
2.26.2


