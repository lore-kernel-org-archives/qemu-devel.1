Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C62C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C1E20678
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 20:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWw6Uay2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C1E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRiGH-00083J-VP
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 16:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5y-0002G6-Tt
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRi5u-0005Zv-Jg
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 16:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602448646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMbEFUjxPSyAU3nqy9BsI64+jEiY61NYPw2mnJQxISc=;
 b=KWw6Uay2My7yAixoM1SOKpKd2V70FvVQ+xL8JbUnY9dof3y1JSIqvj+oM/Krptcv41XWgL
 4wQg4DFHs26k+phDPj8lFa9ClDbkOAOLDHvo5/WMWN2hEKnpKc2fJEm7djlLTmKxIBoZgY
 B19EGckYxFvR6ye4S8GliNv9uuVllrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-zhsTWrE0OyuzUIeZtOWrHg-1; Sun, 11 Oct 2020 16:37:22 -0400
X-MC-Unique: zhsTWrE0OyuzUIeZtOWrHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5617802B4A
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 20:37:21 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD9771A8EC;
 Sun, 11 Oct 2020 20:37:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PoCv2 12/15] qga: implement get-host-name in Rust
Date: Mon, 12 Oct 2020 00:35:10 +0400
Message-Id: <20201011203513.1621355-13-marcandre.lureau@redhat.com>
In-Reply-To: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
References: <20201011203513.1621355-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 16:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Use the "hostname" crate (https://github.com/svartalf/hostname)

(notice the wrong error message in our win32 implementation)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/osdep.h | 10 ----------
 qga/Cargo.toml       |  1 +
 qga/commands.c       | 20 ++++----------------
 qga/lib.rs           |  2 ++
 qga/qmp/hostname.rs  |  9 +++++++++
 qga/qmp/mod.rs       |  7 +++++++
 tests/test-qga.c     |  2 ++
 util/oslib-posix.c   | 35 -----------------------------------
 util/oslib-win32.c   | 13 -------------
 9 files changed, 25 insertions(+), 74 deletions(-)
 create mode 100644 qga/qmp/hostname.rs

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f9ec8c84e9..1ea244fc06 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -664,16 +664,6 @@ static inline void qemu_reset_optind(void)
 #endif
 }
 
-/**
- * qemu_get_host_name:
- * @errp: Error object
- *
- * Operating system agnostic way of querying host name.
- *
- * Returns allocated hostname (caller should free), NULL on failure.
- */
-char *qemu_get_host_name(Error **errp);
-
 /**
  * qemu_get_host_physmem:
  *
diff --git a/qga/Cargo.toml b/qga/Cargo.toml
index 9966057594..63a419255d 100644
--- a/qga/Cargo.toml
+++ b/qga/Cargo.toml
@@ -7,6 +7,7 @@ license = "GPLv2"
 [dependencies]
 common = { path = "../rust/common" }
 libc = "^0.2.76"
+hostname = "^0.3.1"
 
 [lib]
 path = "lib.rs"
diff --git a/qga/commands.c b/qga/commands.c
index 3dcd5fbe5c..15478a16e7 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -512,25 +512,13 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     return -1;
 }
 
+#ifndef CONFIG_WITH_RUST
 GuestHostName *qmp_guest_get_host_name(Error **errp)
 {
-    GuestHostName *result = NULL;
-    g_autofree char *hostname = qemu_get_host_name(errp);
-
-    /*
-     * We want to avoid using g_get_host_name() because that
-     * caches the result and we wouldn't reflect changes in the
-     * host name.
-     */
-
-    if (!hostname) {
-        hostname = g_strdup("localhost");
-    }
-
-    result = g_new0(GuestHostName, 1);
-    result->host_name = g_steal_pointer(&hostname);
-    return result;
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
 }
+#endif
 
 GuestTimezone *qmp_guest_get_timezone(Error **errp)
 {
diff --git a/qga/lib.rs b/qga/lib.rs
index 5fe08c25a3..f4967f59e5 100644
--- a/qga/lib.rs
+++ b/qga/lib.rs
@@ -1,3 +1,5 @@
+pub use common::{err, Error, Result};
+
 mod qapi;
 mod qapi_sys;
 mod qmp;
diff --git a/qga/qmp/hostname.rs b/qga/qmp/hostname.rs
new file mode 100644
index 0000000000..c3eb1f6fd2
--- /dev/null
+++ b/qga/qmp/hostname.rs
@@ -0,0 +1,9 @@
+use crate::*;
+
+pub(crate) fn get() -> Result<qapi::GuestHostName> {
+    let host_name = hostname::get()?
+        .into_string()
+        .or_else(|_| err!("Invalid hostname"))?;
+
+    Ok(qapi::GuestHostName { host_name })
+}
diff --git a/qga/qmp/mod.rs b/qga/qmp/mod.rs
index 38060100af..e855aa4bd7 100644
--- a/qga/qmp/mod.rs
+++ b/qga/qmp/mod.rs
@@ -34,3 +34,10 @@ macro_rules! qmp {
         }
     }};
 }
+
+mod hostname;
+
+#[no_mangle]
+extern "C" fn qmp_guest_get_host_name(errp: *mut *mut sys::Error) -> *mut qapi_sys::GuestHostName {
+    qmp!(hostname::get(), errp)
+}
diff --git a/tests/test-qga.c b/tests/test-qga.c
index c1b173b3cb..6190e93e0e 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -863,6 +863,7 @@ static void test_qga_guest_exec_invalid(gconstpointer fix)
 
 static void test_qga_guest_get_host_name(gconstpointer fix)
 {
+#ifdef CONFIG_WITH_RUST
     const TestFixture *fixture = fix;
     QDict *ret, *val;
 
@@ -874,6 +875,7 @@ static void test_qga_guest_get_host_name(gconstpointer fix)
     g_assert(qdict_haskey(val, "host-name"));
 
     qobject_unref(ret);
+#endif
 }
 
 static void test_qga_guest_get_timezone(gconstpointer fix)
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f15234b5c0..1722c269b8 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -804,41 +804,6 @@ void sigaction_invoke(struct sigaction *action,
     action->sa_sigaction(info->ssi_signo, &si, NULL);
 }
 
-#ifndef HOST_NAME_MAX
-# ifdef _POSIX_HOST_NAME_MAX
-#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
-# else
-#  define HOST_NAME_MAX 255
-# endif
-#endif
-
-char *qemu_get_host_name(Error **errp)
-{
-    long len = -1;
-    g_autofree char *hostname = NULL;
-
-#ifdef _SC_HOST_NAME_MAX
-    len = sysconf(_SC_HOST_NAME_MAX);
-#endif /* _SC_HOST_NAME_MAX */
-
-    if (len < 0) {
-        len = HOST_NAME_MAX;
-    }
-
-    /* Unfortunately, gethostname() below does not guarantee a
-     * NULL terminated string. Therefore, allocate one byte more
-     * to be sure. */
-    hostname = g_new0(char, len + 1);
-
-    if (gethostname(hostname, len) < 0) {
-        error_setg_errno(errp, errno,
-                         "cannot get hostname");
-        return NULL;
-    }
-
-    return g_steal_pointer(&hostname);
-}
-
 size_t qemu_get_host_physmem(void)
 {
 #ifdef _SC_PHYS_PAGES
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 051afb217b..804e303c4f 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -822,19 +822,6 @@ bool qemu_write_pidfile(const char *filename, Error **errp)
     return true;
 }
 
-char *qemu_get_host_name(Error **errp)
-{
-    wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
-    DWORD size = G_N_ELEMENTS(tmp);
-
-    if (GetComputerNameW(tmp, &size) == 0) {
-        error_setg_win32(errp, GetLastError(), "failed close handle");
-        return NULL;
-    }
-
-    return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
-}
-
 size_t qemu_get_host_physmem(void)
 {
     MEMORYSTATUSEX statex;
-- 
2.28.0


