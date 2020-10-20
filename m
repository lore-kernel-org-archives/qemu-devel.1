Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982BAC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3BE206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIGFHtC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3BE206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmsy-00069c-QN
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kUmmW-0006pB-97
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kUmmS-0001mi-Q2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603181643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5SDg3P76a+sbXL0s7Nt+dkyVY87caCOtIVPNNwrOjg=;
 b=OIGFHtC6INKsYMPcYgX6e12Zqp81T07hX6ADxY6U9P62ikRw7VoVnW6G0wAdrn74lTHTt0
 MR+OMcDqaiocIb+U3t7O/gLL8dZrX7Lbt2xuAT+oRToMgCFn/fQJzFGZu0qZQKYdYsvIfT
 RiYouuo9wHKxM7fr5qVqhbM7B99GZ54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-co-509pbPR-ScqIri0ijEg-1; Tue, 20 Oct 2020 04:14:00 -0400
X-MC-Unique: co-509pbPR-ScqIri0ijEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73748803F47;
 Tue, 20 Oct 2020 08:13:59 +0000 (UTC)
Received: from localhost (unknown [10.36.110.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 198B31992D;
 Tue, 20 Oct 2020 08:13:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] qga: add ssh-get-authorized-keys
Date: Tue, 20 Oct 2020 12:12:57 +0400
Message-Id: <20201020081257.2054548-8-marcandre.lureau@redhat.com>
In-Reply-To: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
References: <20201020081257.2054548-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: berrange@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix-ssh.c | 66 ++++++++++++++++++++++++++++++++++++++++
 qga/meson.build          | 11 +++++--
 qga/qapi-schema.json     | 31 +++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index f974bc4b64..4d75cb0113 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -268,6 +268,46 @@ qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
     write_authkeys(authkeys_path, new_keys, p, errp);
 }
 
+GuestAuthorizedKeys *
+qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
+{
+    g_autofree struct passwd *p = NULL;
+    g_autofree char *authkeys_path = NULL;
+    g_auto(GStrv) authkeys = NULL;
+    g_autoptr(GuestAuthorizedKeys) ret = NULL;
+    int i;
+
+    ERRP_GUARD();
+
+    p = get_passwd_entry(username, errp);
+    if (p == NULL) {
+        return NULL;
+    }
+
+    authkeys_path = g_build_filename(p->pw_dir, ".ssh",
+                                     "authorized_keys", NULL);
+    authkeys = read_authkeys(authkeys_path, errp);
+    if (authkeys == NULL) {
+        return NULL;
+    }
+
+    ret = g_new0(GuestAuthorizedKeys, 1);
+    for (i = 0; authkeys[i] != NULL; i++) {
+        strList *new;
+
+        g_strstrip(authkeys[i]);
+        if (!authkeys[i][0] || authkeys[i][0] == '#') {
+            continue;
+        }
+
+        new = g_new0(strList, 1);
+        new->value = g_strdup(authkeys[i]);
+        new->next = ret->keys;
+        ret->keys = new;
+    }
+
+    return g_steal_pointer (&ret);
+}
 
 #ifdef QGA_BUILD_UNIT_TEST
 #if GLIB_CHECK_VERSION(2, 60, 0)
@@ -426,6 +466,31 @@ test_remove_keys(void)
                                "algo some-key another\n");
 }
 
+static void
+test_get_keys(void)
+{
+    Error *err = NULL;
+    static const char *authkeys =
+        "algo key1 comments\n"
+        "# a commented line\n"
+        "algo some-key another\n";
+    g_autoptr(GuestAuthorizedKeys) ret = NULL;
+    strList *k;
+    size_t len = 0;
+
+    test_authorized_keys_set(authkeys);
+
+    ret = qmp_guest_ssh_get_authorized_keys(g_get_user_name(), &err);
+    g_assert_null(err);
+
+    for (len = 0, k = ret->keys; k != NULL; k = k->next) {
+        g_assert(g_str_has_prefix(k->value, "algo "));
+        len++;
+    }
+
+    g_assert_cmpint(len, ==, 2);
+}
+
 int main(int argc, char *argv[])
 {
     setlocale(LC_ALL, "");
@@ -437,6 +502,7 @@ int main(int argc, char *argv[])
     g_test_add_func("/qga/ssh/add_keys", test_add_keys);
     g_test_add_func("/qga/ssh/add_reset_keys", test_add_reset_keys);
     g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
+    g_test_add_func("/qga/ssh/get_keys", test_get_keys);
 
     return g_test_run();
 }
diff --git a/qga/meson.build b/qga/meson.build
index 8340892139..80e7487f32 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -90,8 +90,15 @@ test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
 test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 if 'CONFIG_POSIX' in config_host
-  qga_ssh_test = executable('qga-ssh-test',
-                            files('commands-posix-ssh.c'),
+  srcs = [files('commands-posix-ssh.c')]
+  i = 0
+  foreach output: qga_qapi_outputs
+    if output.startswith('qga-qapi-types') or output.startswith('qga-qapi-visit')
+      srcs += qga_qapi_files[i]
+    endif
+    i = i + 1
+  endforeach
+  qga_ssh_test = executable('qga-ssh-test', srcs,
                             dependencies: [qemuutil],
                             c_args: ['-DQGA_BUILD_UNIT_TEST'])
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 6b7cb86dee..4702bc7d72 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1307,6 +1307,37 @@
 { 'command': 'guest-get-devices',
   'returns': ['GuestDeviceInfo'] }
 
+##
+# @GuestAuthorizedKeys:
+#
+# @keys: public keys (in OpenSSH/sshd(8) authorized_keys format)
+#
+# Since: 5.2
+##
+{ 'struct': 'GuestAuthorizedKeys',
+  'data': {
+      'keys': ['str']
+  },
+  'if': 'defined(CONFIG_POSIX)' }
+
+
+##
+# @guest-ssh-get-authorized-keys:
+#
+# @username: the user account to add the authorized keys
+#
+# Return the public keys from user .ssh/authorized_keys on Unix systems (not
+# implemented for other systems).
+#
+# Returns: @GuestAuthorizedKeys
+#
+# Since: 5.2
+##
+{ 'command': 'guest-ssh-get-authorized-keys',
+  'data': { 'username': 'str' },
+  'returns': 'GuestAuthorizedKeys',
+  'if': 'defined(CONFIG_POSIX)' }
+
 ##
 # @guest-ssh-add-authorized-keys:
 #
-- 
2.28.0


