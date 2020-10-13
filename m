Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8105C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7147208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHOAJhvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7147208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSQv9-0007Lb-OZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kSQrU-000482-0L
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kSQrQ-0007ul-T2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602620728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEJ7kHpJdGlwPPItFY0VQH2bV06cMDObvqMj69rNz9Y=;
 b=VHOAJhvnAzXLCmmv7QPE6BGuFQqGVznIdtFi6Dd8P9GphZX0I4RFHtsRQlGulyl/RtcRNT
 yYhGAzVHAmOEyxQF8hoP30bJuCtapmP0HXfolBAbehDlu3ZFSmuitapushsMOe1Flf3WEs
 I+9VLkReCnONPR12Jxkllm2RAUNwxNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-_55L7spiNTWIYd1azJcTrw-1; Tue, 13 Oct 2020 16:25:25 -0400
X-MC-Unique: _55L7spiNTWIYd1azJcTrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D98427FE;
 Tue, 13 Oct 2020 20:25:24 +0000 (UTC)
Received: from localhost (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2338F2C31E;
 Tue, 13 Oct 2020 20:25:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qga: add ssh-{add,remove}-authorized-keys
Date: Wed, 14 Oct 2020 00:25:02 +0400
Message-Id: <20201013202502.335336-3-marcandre.lureau@redhat.com>
In-Reply-To: <20201013202502.335336-1-marcandre.lureau@redhat.com>
References: <20201013202502.335336-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add new commands to add and remove SSH public keys from
~/.ssh/authorized_keys.

I took a different approach for testing, including the unit tests right
with the code. I wanted to overwrite the function to get the user
details, I couldn't easily do that over QMP. Furthermore, I prefer
having unit tests very close to the code, and unit files that are domain
specific (commands-posix is too crowded already). Fwiw, that
coding/testing style is Rust-style (where tests can or should even be
part of the documentation!).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1885332

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix-ssh.c | 394 +++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c     |  10 +
 qga/meson.build          |  17 +-
 qga/qapi-schema.json     |  32 ++++
 4 files changed, 452 insertions(+), 1 deletion(-)
 create mode 100644 qga/commands-posix-ssh.c

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
new file mode 100644
index 0000000000..3721ac4975
--- /dev/null
+++ b/qga/commands-posix-ssh.c
@@ -0,0 +1,394 @@
+ /*
+  * This work is licensed under the terms of the GNU GPL, version 2 or later.
+  * See the COPYING file in the top-level directory.
+  */
+#include "qemu/osdep.h"
+
+#include <glib-unix.h>
+#include <glib/gstdio.h>
+#include <locale.h>
+#include <pwd.h>
+
+#include "qapi/error.h"
+#include "qga-qapi-commands.h"
+
+#ifdef QGA_BUILD_UNIT_TEST
+static struct passwd *
+test_get_passwd_entry(const gchar *user_name, GError **error)
+{
+    struct passwd *p;
+    int ret;
+
+    if (!user_name || g_strcmp0(user_name, g_get_user_name())) {
+        g_set_error_literal(error, G_FILE_ERROR, G_FILE_ERROR_FAILED, "Invalid user name");
+        return NULL;
+    }
+
+    p = g_new0(struct passwd, 1);
+    p->pw_dir = (char *)g_get_home_dir();
+    p->pw_uid = geteuid();
+    p->pw_gid = getegid();
+
+    ret = g_mkdir_with_parents(p->pw_dir, 0700);
+    g_assert_cmpint(ret, ==, 0);
+
+    return p;
+}
+
+#define g_unix_get_passwd_entry_qemu(username, err) test_get_passwd_entry(username, err)
+#endif
+
+static struct passwd *
+get_passwd_entry(const char *username, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+    struct passwd *p;
+
+    ERRP_GUARD();
+
+    p = g_unix_get_passwd_entry_qemu(username, &err);
+    if (p == NULL) {
+        error_setg(errp, "failed to lookup user '%s': %s",
+                   username, err->message);
+        return NULL;
+    }
+
+    return p;
+}
+
+static bool
+mkdir_for_user(const char *path, const struct passwd *p, mode_t mode, Error **errp)
+{
+    ERRP_GUARD();
+
+    if (g_mkdir(path, mode) == -1) {
+        error_setg(errp, "failed to create directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    if (chown(path, p->pw_uid, p->pw_gid) == -1) {
+        error_setg(errp, "failed to set ownership of directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    if (chmod(path, mode) == -1) {
+        error_setg(errp, "failed to set permissions of directory '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+check_openssh_pub_key(const char *key, Error **errp)
+{
+    ERRP_GUARD();
+
+    /* simple sanity-check, we may want more? */
+    if (!key || key[0] == '#' || strchr(key, '\n')) {
+        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
+{
+    size_t n = 0;
+    strList *k;
+
+    ERRP_GUARD();
+
+    for (k = keys; k != NULL; k = k->next) {
+        if (!check_openssh_pub_key(k->value, errp)) {
+            return false;
+        }
+        n++;
+    }
+
+    if (nkeys) {
+        *nkeys = n;
+    }
+    return true;
+}
+
+static bool
+write_authkeys(const char *path, const GStrv keys, Error **errp)
+{
+    g_autofree char *contents = NULL;
+    g_autoptr(GError) err = NULL;
+
+    ERRP_GUARD();
+
+    contents = g_strjoinv("\n", keys);
+    if (!g_file_set_contents(path, contents, -1, &err)) {
+        error_setg(errp, "failed to write to '%s': %s", path, err->message);
+        return false;
+    }
+
+    if (chmod(path, 0600) == -1) {
+        error_setg(errp, "failed to set permissions of '%s': %s",
+                   path, g_strerror(errno));
+        return false;
+    }
+
+    return true;
+}
+
+static GStrv
+read_authkeys(const char *path, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *contents = NULL;
+
+    ERRP_GUARD();
+
+    if (!g_file_get_contents(path, &contents, NULL, &err)) {
+        error_setg(errp, "failed to read '%s': %s", path, err->message);
+        return NULL;
+    }
+
+    return g_strsplit(contents, "\n", -1);
+
+}
+
+void
+qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
+                                  Error **errp)
+{
+    g_autofree struct passwd *p = NULL;
+    g_autofree char *ssh_path = NULL;
+    g_autofree char *authkeys_path = NULL;
+    g_auto(GStrv) authkeys = NULL;
+    strList *k;
+    size_t nkeys, nauthkeys;
+
+    ERRP_GUARD();
+
+    if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
+        return;
+    }
+
+    p = get_passwd_entry(username, errp);
+    if (p == NULL) {
+        return;
+    }
+
+    ssh_path = g_build_filename(p->pw_dir, ".ssh", NULL);
+    authkeys_path = g_build_filename(ssh_path, "authorized_keys", NULL);
+
+    authkeys = read_authkeys(authkeys_path, NULL);
+    if (authkeys == NULL) {
+        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
+            !mkdir_for_user(ssh_path, p, 0700, errp)) {
+            return;
+        }
+    }
+
+    nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
+    authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
+    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
+
+    for (k = keys; k != NULL; k = k->next) {
+        if (g_strv_contains((const gchar * const *)authkeys, k->value)) {
+            continue;
+        }
+        authkeys[nauthkeys++] = g_strdup(k->value);
+    }
+
+    write_authkeys(authkeys_path, authkeys, errp);
+}
+
+void
+qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
+                                     Error **errp)
+{
+    g_autofree struct passwd *p = NULL;
+    g_autofree char *authkeys_path = NULL;
+    g_autofree GStrv new_keys = NULL; /* do not own the strings */
+    g_auto(GStrv) authkeys = NULL;
+    GStrv a;
+    size_t nkeys = 0;
+
+    ERRP_GUARD();
+
+    if (!check_openssh_pub_keys(keys, NULL, errp)) {
+        return;
+    }
+
+    p = get_passwd_entry(username, errp);
+    if (p == NULL) {
+        return;
+    }
+
+    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
+                                     "authorized_keys", NULL);
+    if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
+        return;
+    }
+    authkeys = read_authkeys(authkeys_path, errp);
+    if (authkeys == NULL) {
+        return;
+    }
+
+    new_keys = g_new0(char *, g_strv_length(authkeys) + 1);
+    for (a = authkeys; *a != NULL; a++) {
+        strList *k;
+
+        for (k = keys; k != NULL; k = k->next) {
+            if (g_str_equal(k->value, *a)) {
+                break;
+            }
+        }
+        if (k != NULL) {
+            continue;
+        }
+
+        new_keys[nkeys++] = *a;
+    }
+
+    write_authkeys(authkeys_path, new_keys, errp);
+}
+
+
+#ifdef QGA_BUILD_UNIT_TEST
+static const strList test_key2 = {
+    .value = (char *)"algo key2 comments"
+};
+
+static const strList test_key1_2 = {
+    .value = (char *)"algo key1 comments",
+    .next = (strList *)&test_key2,
+};
+
+static char *
+test_get_authorized_keys_path(void)
+{
+    return g_build_filename(g_get_home_dir(), ".ssh", "authorized_keys", NULL);
+}
+
+static void
+test_authorized_keys_set(const char *contents)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *path = NULL;
+    int ret;
+
+    path = g_build_filename(g_get_home_dir(), ".ssh", NULL);
+    ret = g_mkdir_with_parents(path, 0700);
+    g_assert_cmpint(ret, ==, 0);
+    g_free(path);
+
+    path = test_get_authorized_keys_path();
+    g_file_set_contents(path, contents, -1, &err);
+    g_assert_no_error(err);
+}
+
+static void
+test_authorized_keys_equal(const char *expected)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *path = NULL;
+    g_autofree char *contents = NULL;
+
+    path = test_get_authorized_keys_path();
+    g_file_get_contents(path, &contents, NULL, &err);
+    g_assert_no_error(err);
+
+    g_assert_cmpstr(contents, ==, expected);
+}
+
+static void
+test_invalid_user(void)
+{
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys("", NULL, &err);
+    error_free_or_abort(&err);
+
+    qmp_guest_ssh_remove_authorized_keys("", NULL, &err);
+    error_free_or_abort(&err);
+}
+
+static void
+test_invalid_key(void)
+{
+    strList key = {
+        .value = (char *)"not a valid\nkey"
+    };
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(), &key, &err);
+    error_free_or_abort(&err);
+
+    qmp_guest_ssh_remove_authorized_keys(g_get_user_name(), &key, &err);
+    error_free_or_abort(&err);
+}
+
+static void
+test_add_keys(void)
+{
+    Error *err = NULL;
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2, &err);
+    g_assert_null(err);
+
+    test_authorized_keys_equal("algo key2 comments");
+
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key1_2, &err);
+    g_assert_null(err);
+
+    /*  key2 came first, and should'nt be duplicated */
+    test_authorized_keys_equal("algo key2 comments\n"
+                               "algo key1 comments");
+}
+
+static void
+test_remove_keys(void)
+{
+    Error *err = NULL;
+    static const char *authkeys =
+        "algo key1 comments\n"
+        /* originally duplicated */
+        "algo key1 comments\n"
+        "# a commented line\n"
+        "algo some-key another\n";
+
+    test_authorized_keys_set(authkeys);
+    qmp_guest_ssh_remove_authorized_keys(g_get_user_name(),
+                                         (strList *)&test_key2, &err);
+    g_assert_null(err);
+    test_authorized_keys_equal(authkeys);
+
+    qmp_guest_ssh_remove_authorized_keys(g_get_user_name(),
+                                         (strList *)&test_key1_2, &err);
+    g_assert_null(err);
+    test_authorized_keys_equal("# a commented line\n"
+                               "algo some-key another\n");
+}
+
+int main(int argc, char *argv[])
+{
+#if GLIB_CHECK_VERSION(2, 60, 0)
+    setlocale(LC_ALL, "");
+
+    g_test_init(&argc, &argv, G_TEST_OPTION_ISOLATE_DIRS, NULL);
+
+    g_test_add_func("/qga/ssh/invalid_user", test_invalid_user);
+    g_test_add_func("/qga/ssh/invalid_key", test_invalid_key);
+    g_test_add_func("/qga/ssh/add_keys", test_add_keys);
+    g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
+
+    return g_test_run();
+#else
+    g_test_message("test skipped, needs glib >= 2.60");
+#endif
+}
+#endif /*  BUILD_UNIT_TEST */
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0c3c05484f..27ac3f24f5 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2457,3 +2457,13 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     }
     return head;
 }
+
+void qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+}
+
+void qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys, Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+}
diff --git a/qga/meson.build b/qga/meson.build
index cd08bd953a..58303c70d8 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -35,7 +35,9 @@ qga_ss.add(files(
 ))
 qga_ss.add(when: 'CONFIG_POSIX', if_true: files(
   'channel-posix.c',
-  'commands-posix.c'))
+  'commands-posix.c',
+  'commands-posix-ssh.c',
+))
 qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
   'channel-win32.c',
   'commands-win32.c',
@@ -87,3 +89,16 @@ else
 endif
 
 alias_target('qemu-ga', all_qga)
+
+qga_ssh_test = executable('qga-ssh-test',
+                          files('commands-posix-ssh.c'),
+                          dependencies: [qemuutil],
+                          c_args: ['-DQGA_BUILD_UNIT_TEST'])
+
+test_env = environment()
+test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
+test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
+test('qga-ssh-test',
+     qga_ssh_test,
+     env: test_env,
+     suite: ['unit', 'qga'])
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index cec98c7e06..50e2854b45 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1306,3 +1306,35 @@
 ##
 { 'command': 'guest-get-devices',
   'returns': ['GuestDeviceInfo'] }
+
+##
+# @guest-ssh-add-authorized-keys:
+#
+# @username: the user account to add the authorized key
+# @keys: the public keys to add (in OpenSSH format)
+#
+# Append a public key to user $HOME/.ssh/authorized_keys on Unix systems (not
+# implemented for other systems).
+#
+# Returns: Nothing on success.
+#
+# Since: 5.2
+##
+{ 'command': 'guest-ssh-add-authorized-keys',
+  'data': { 'username': 'str', 'keys': ['str'] } }
+
+##
+# @guest-ssh-remove-authorized-keys:
+#
+# @username: the user account to add the authorized key
+# @keys: the public keys to remove (in OpenSSH format)
+#
+# Remove public keys from the user $HOME/.ssh/authorized_keys on Unix systems
+# (not implemented for other systems).
+#
+# Returns: Nothing on success.
+#
+# Since: 5.2
+##
+{ 'command': 'guest-ssh-remove-authorized-keys',
+  'data': { 'username': 'str', 'keys': ['str'] } }
-- 
2.28.0


