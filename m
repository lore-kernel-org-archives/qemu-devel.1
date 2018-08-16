Received: from eggs.gnu.org ([2001:4830:134:3::10]:48691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuQ-0003af-4S
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuN-0001cZ-Hd
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHuN-0001cO-Ba
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:47 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:18 +0100
Message-Id: <20180816130118.31841-12-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/11] authz: delete existing ACL
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The 'qemu_acl' type was a previous non-QOM based attempt to provide an
authorization facility in QEMU. Because it is non-QOM based it cannot be
created via the command line and requires special monitor commands to
manipulate it.

The new QAuthZ subclasses provide a superset of the functionality in
qemu_acl, so the latter can now be deleted. The HMP 'acl_*' monitor
commands are converted to use the new QAuthZSimple data type instead
in order to provide temporary backwards compatibility.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 crypto/tlssession.c            |  35 ++++---
 crypto/trace-events            |   2 +-
 include/qemu/acl.h             |  66 ------------
 monitor.c                      | 180 ++++++++++++++++++++++-----------
 tests/Makefile.include         |   4 +-
 tests/test-crypto-tlssession.c |  15 ++-
 tests/test-io-channel-tls.c    |  16 ++-
 ui/vnc-auth-sasl.c             |  23 +++--
 ui/vnc-auth-sasl.h             |   5 +-
 ui/vnc-auth-vencrypt.c         |   2 +-
 ui/vnc-ws.c                    |   2 +-
 ui/vnc.c                       |  37 ++++---
 ui/vnc.h                       |   4 +-
 util/Makefile.objs             |   1 -
 util/acl.c                     | 179 --------------------------------
 15 files changed, 210 insertions(+), 361 deletions(-)
 delete mode 100644 include/qemu/acl.h
 delete mode 100644 util/acl.c

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 66a6fbe19c..23842aa95d 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -24,7 +24,7 @@
 #include "crypto/tlscredspsk.h"
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
-#include "qemu/acl.h"
+#include "authz/base.h"
 #include "trace.h"
 
 #ifdef CONFIG_GNUTLS
@@ -37,7 +37,7 @@ struct QCryptoTLSSession {
     QCryptoTLSCreds *creds;
     gnutls_session_t handle;
     char *hostname;
-    char *aclname;
+    char *authzid;
     bool handshakeComplete;
     QCryptoTLSSessionWriteFunc writeFunc;
     QCryptoTLSSessionReadFunc readFunc;
@@ -56,7 +56,7 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)
     gnutls_deinit(session->handle);
     g_free(session->hostname);
     g_free(session->peername);
-    g_free(session->aclname);
+    g_free(session->authzid);
     object_unref(OBJECT(session->creds));
     g_free(session);
 }
@@ -101,7 +101,7 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
 QCryptoTLSSession *
 qcrypto_tls_session_new(QCryptoTLSCreds *creds,
                         const char *hostname,
-                        const char *aclname,
+                        const char *authzid,
                         QCryptoTLSCredsEndpoint endpoint,
                         Error **errp)
 {
@@ -111,13 +111,13 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
     session = g_new0(QCryptoTLSSession, 1);
     trace_qcrypto_tls_session_new(
         session, creds, hostname ? hostname : "<none>",
-        aclname ? aclname : "<none>", endpoint);
+        authzid ? authzid : "<none>", endpoint);
 
     if (hostname) {
         session->hostname = g_strdup(hostname);
     }
-    if (aclname) {
-        session->aclname = g_strdup(aclname);
+    if (authzid) {
+        session->authzid = g_strdup(authzid);
     }
     session->creds = creds;
     object_ref(OBJECT(creds));
@@ -268,6 +268,7 @@ qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
     unsigned int nCerts, i;
     time_t now;
     gnutls_x509_crt_t cert = NULL;
+    Error *err = NULL;
 
     now = time(NULL);
     if (now == ((time_t)-1)) {
@@ -355,19 +356,17 @@ qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
                            gnutls_strerror(ret));
                 goto error;
             }
-            if (session->aclname) {
-                qemu_acl *acl = qemu_acl_find(session->aclname);
-                int allow;
-                if (!acl) {
-                    error_setg(errp, "Cannot find ACL %s",
-                               session->aclname);
+            if (session->authzid) {
+                bool allow;
+
+                allow = qauthz_is_allowed_by_id(session->authzid,
+                                                session->peername, &err);
+                if (err) {
+                    error_propagate(errp, err);
                     goto error;
                 }
-
-                allow = qemu_acl_party_is_allowed(acl, session->peername);
-
                 if (!allow) {
-                    error_setg(errp, "TLS x509 ACL check for %s is denied",
+                    error_setg(errp, "TLS x509 authz check for %s is denied",
                                session->peername);
                     goto error;
                 }
@@ -558,7 +557,7 @@ qcrypto_tls_session_get_peer_name(QCryptoTLSSession *session)
 QCryptoTLSSession *
 qcrypto_tls_session_new(QCryptoTLSCreds *creds G_GNUC_UNUSED,
                         const char *hostname G_GNUC_UNUSED,
-                        const char *aclname G_GNUC_UNUSED,
+                        const char *authzid G_GNUC_UNUSED,
                         QCryptoTLSCredsEndpoint endpoint G_GNUC_UNUSED,
                         Error **errp)
 {
diff --git a/crypto/trace-events b/crypto/trace-events
index 597389b73c..a38ad7b787 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -19,5 +19,5 @@ qcrypto_tls_creds_x509_load_cert(void *creds, int isServer, const char *file) "T
 qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds x509 load cert list creds=%p file=%s"
 
 # crypto/tlssession.c
-qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *aclname, int endpoint) "TLS session new session=%p creds=%p hostname=%s aclname=%s endpoint=%d"
+qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
diff --git a/include/qemu/acl.h b/include/qemu/acl.h
deleted file mode 100644
index 7c44119a47..0000000000
--- a/include/qemu/acl.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * QEMU access control list management
- *
- * Copyright (C) 2009 Red Hat, Inc
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef QEMU_ACL_H
-#define QEMU_ACL_H
-
-#include "qemu/queue.h"
-
-typedef struct qemu_acl_entry qemu_acl_entry;
-typedef struct qemu_acl qemu_acl;
-
-struct qemu_acl_entry {
-    char *match;
-    int deny;
-
-    QTAILQ_ENTRY(qemu_acl_entry) next;
-};
-
-struct qemu_acl {
-    char *aclname;
-    unsigned int nentries;
-    QTAILQ_HEAD(,qemu_acl_entry) entries;
-    int defaultDeny;
-};
-
-qemu_acl *qemu_acl_init(const char *aclname);
-
-qemu_acl *qemu_acl_find(const char *aclname);
-
-int qemu_acl_party_is_allowed(qemu_acl *acl,
-			      const char *party);
-
-void qemu_acl_reset(qemu_acl *acl);
-
-int qemu_acl_append(qemu_acl *acl,
-		    int deny,
-		    const char *match);
-int qemu_acl_insert(qemu_acl *acl,
-		    int deny,
-		    const char *match,
-		    int index);
-int qemu_acl_remove(qemu_acl *acl,
-		    const char *match);
-
-#endif /* QEMU_ACL_H */
diff --git a/monitor.c b/monitor.c
index a1999e396c..4f7f6467bc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -51,7 +51,8 @@
 #include "sysemu/balloon.h"
 #include "qemu/timer.h"
 #include "sysemu/hw_accel.h"
-#include "qemu/acl.h"
+#include "authz/list.h"
+#include "qapi/util.h"
 #include "sysemu/tpm.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
@@ -2125,61 +2126,87 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     QLIST_INSERT_HEAD (&capture_head, s, entries);
 }
 
-static qemu_acl *find_acl(Monitor *mon, const char *name)
+static QAuthZList *find_auth(Monitor *mon, const char *name)
 {
-    qemu_acl *acl = qemu_acl_find(name);
+    Object *obj;
+    Object *container;
 
-    if (!acl) {
+    container = object_get_objects_root();
+    obj = object_resolve_path_component(container, name);
+    if (!obj) {
         monitor_printf(mon, "acl: unknown list '%s'\n", name);
+        return NULL;
     }
-    return acl;
+
+    return QAUTHZ_LIST(obj);
 }
 
 static void hmp_acl_show(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
-    qemu_acl *acl = find_acl(mon, aclname);
-    qemu_acl_entry *entry;
-    int i = 0;
-
-    if (acl) {
-        monitor_printf(mon, "policy: %s\n",
-                       acl->defaultDeny ? "deny" : "allow");
-        QTAILQ_FOREACH(entry, &acl->entries, next) {
-            i++;
-            monitor_printf(mon, "%d: %s %s\n", i,
-                           entry->deny ? "deny" : "allow", entry->match);
-        }
+    QAuthZList *auth = find_auth(mon, aclname);
+    QAuthZListRuleList *rules;
+    size_t i = 0;
+
+    if (!auth) {
+        return;
+    }
+
+    monitor_printf(mon, "policy: %s\n",
+                   QAuthZListPolicy_lookup.array[auth->policy]);
+
+    rules = auth->rules;
+    while (rules) {
+        QAuthZListRule *rule = rules->value;
+        i++;
+        monitor_printf(mon, "%zu: %s %s\n", i,
+                       QAuthZListPolicy_lookup.array[rule->policy],
+                       rule->match);
+        rules = rules->next;
     }
 }
 
 static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
-    qemu_acl *acl = find_acl(mon, aclname);
+    QAuthZList *auth = find_auth(mon, aclname);
 
-    if (acl) {
-        qemu_acl_reset(acl);
-        monitor_printf(mon, "acl: removed all rules\n");
+    if (!auth) {
+        return;
     }
+
+    auth->policy = QAUTHZ_LIST_POLICY_DENY;
+    qapi_free_QAuthZListRuleList(auth->rules);
+    auth->rules = NULL;
+    monitor_printf(mon, "acl: removed all rules\n");
 }
 
 static void hmp_acl_policy(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *policy = qdict_get_str(qdict, "policy");
-    qemu_acl *acl = find_acl(mon, aclname);
+    QAuthZList *auth = find_auth(mon, aclname);
+    int val;
+    Error *err = NULL;
 
-    if (acl) {
-        if (strcmp(policy, "allow") == 0) {
-            acl->defaultDeny = 0;
+    if (!auth) {
+        return;
+    }
+
+    val = qapi_enum_parse(&QAuthZListPolicy_lookup,
+                          policy,
+                          QAUTHZ_LIST_POLICY_DENY,
+                          &err);
+    if (err) {
+        error_free(err);
+        monitor_printf(mon, "acl: unknown policy '%s', "
+                       "expected 'deny' or 'allow'\n", policy);
+    } else {
+        auth->policy = val;
+        if (auth->policy == QAUTHZ_LIST_POLICY_ALLOW) {
             monitor_printf(mon, "acl: policy set to 'allow'\n");
-        } else if (strcmp(policy, "deny") == 0) {
-            acl->defaultDeny = 1;
-            monitor_printf(mon, "acl: policy set to 'deny'\n");
         } else {
-            monitor_printf(mon, "acl: unknown policy '%s', "
-                           "expected 'deny' or 'allow'\n", policy);
+            monitor_printf(mon, "acl: policy set to 'deny'\n");
         }
     }
 }
@@ -2188,30 +2215,60 @@ static void hmp_acl_add(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *match = qdict_get_str(qdict, "match");
-    const char *policy = qdict_get_str(qdict, "policy");
+    const char *policystr = qdict_get_str(qdict, "policy");
     int has_index = qdict_haskey(qdict, "index");
     int index = qdict_get_try_int(qdict, "index", -1);
-    qemu_acl *acl = find_acl(mon, aclname);
-    int deny, ret;
-
-    if (acl) {
-        if (strcmp(policy, "allow") == 0) {
-            deny = 0;
-        } else if (strcmp(policy, "deny") == 0) {
-            deny = 1;
-        } else {
-            monitor_printf(mon, "acl: unknown policy '%s', "
-                           "expected 'deny' or 'allow'\n", policy);
-            return;
-        }
-        if (has_index)
-            ret = qemu_acl_insert(acl, deny, match, index);
-        else
-            ret = qemu_acl_append(acl, deny, match);
-        if (ret < 0)
-            monitor_printf(mon, "acl: unable to add acl entry\n");
-        else
-            monitor_printf(mon, "acl: added rule at position %d\n", ret);
+    QAuthZList *auth = find_auth(mon, aclname);
+    Error *err = NULL;
+    QAuthZListPolicy policy;
+    QAuthZListFormat format;
+    size_t i = 0;
+
+    if (!auth) {
+        return;
+    }
+
+    policy = qapi_enum_parse(&QAuthZListPolicy_lookup,
+                             policystr,
+                             QAUTHZ_LIST_POLICY_DENY,
+                             &err);
+    if (err) {
+        error_free(err);
+        monitor_printf(mon, "acl: unknown policy '%s', "
+                       "expected 'deny' or 'allow'\n", policystr);
+        return;
+    }
+
+#ifdef CONFIG_FNMATCH
+    if (strchr(match, '*')) {
+        format = QAUTHZ_LIST_FORMAT_GLOB;
+    } else {
+        format = QAUTHZ_LIST_FORMAT_EXACT;
+    }
+#else
+    /* Historically we silently degraded to plain strcmp
+     * when fnmatch() was missing */
+    format = QAUTHZ_LIST_FORMAT_EXACT;
+#endif
+
+    if (has_index && index == 0) {
+        monitor_printf(mon, "acl: unable to add acl entry\n");
+        return;
+    }
+
+    if (has_index) {
+        i = qauthz_list_insert_rule(auth, match, policy,
+                                    format, index - 1, &err);
+    } else {
+        i = qauthz_list_append_rule(auth, match, policy,
+                                    format, &err);
+    }
+    if (err) {
+        monitor_printf(mon, "acl: unable to add rule: %s",
+                       error_get_pretty(err));
+        error_free(err);
+    } else {
+        monitor_printf(mon, "acl: added rule at position %zu\n", i + 1);
     }
 }
 
@@ -2219,15 +2276,18 @@ static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *match = qdict_get_str(qdict, "match");
-    qemu_acl *acl = find_acl(mon, aclname);
-    int ret;
+    QAuthZList *auth = find_auth(mon, aclname);
+    ssize_t i = 0;
 
-    if (acl) {
-        ret = qemu_acl_remove(acl, match);
-        if (ret < 0)
-            monitor_printf(mon, "acl: no matching acl entry\n");
-        else
-            monitor_printf(mon, "acl: removed rule at position %d\n", ret);
+    if (!auth) {
+        return;
+    }
+
+    i = qauthz_list_delete_rule(auth, match);
+    if (i >= 0) {
+        monitor_printf(mon, "acl: removed rule at position %zu\n", i + 1);
+    } else {
+        monitor_printf(mon, "acl: no matching acl entry\n");
     }
 }
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 50157934c1..9a40971a83 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -614,8 +614,8 @@ test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-events.o tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
-benchmark-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
-test-crypto-obj-y = $(crypto-obj-y) $(test-qom-obj-y)
+benchmark-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
+test-crypto-obj-y = $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
 test-io-obj-y = $(io-obj-y) $(test-crypto-obj-y)
 test-block-obj-y = $(block-obj-y) $(test-io-obj-y) tests/iothread.o
 
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 6fa9950afb..15212ec276 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -28,7 +28,7 @@
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
-#include "qemu/acl.h"
+#include "authz/list.h"
 
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
@@ -229,7 +229,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
     QCryptoTLSCreds *serverCreds;
     QCryptoTLSSession *clientSess = NULL;
     QCryptoTLSSession *serverSess = NULL;
-    qemu_acl *acl;
+    QAuthZList *auth;
     const char * const *wildcards;
     int channel[2];
     bool clientShake = false;
@@ -285,11 +285,15 @@ static void test_crypto_tls_session_x509(const void *opaque)
         SERVER_CERT_DIR);
     g_assert(serverCreds != NULL);
 
-    acl = qemu_acl_init("tlssessionacl");
-    qemu_acl_reset(acl);
+    auth = qauthz_list_new("tlssessionacl",
+                           QAUTHZ_LIST_POLICY_DENY,
+                           &error_abort);
     wildcards = data->wildcards;
     while (wildcards && *wildcards) {
-        qemu_acl_append(acl, 0, *wildcards);
+        qauthz_list_append_rule(auth, *wildcards,
+                                QAUTHZ_LIST_POLICY_ALLOW,
+                                QAUTHZ_LIST_FORMAT_GLOB,
+                                &error_abort);
         wildcards++;
     }
 
@@ -377,6 +381,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
 
     object_unparent(OBJECT(serverCreds));
     object_unparent(OBJECT(clientCreds));
+    object_unparent(OBJECT(auth));
 
     qcrypto_tls_session_free(serverSess);
     qcrypto_tls_session_free(clientSess);
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 4900c6d433..43b707eba7 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -29,8 +29,8 @@
 #include "io-channel-helpers.h"
 #include "crypto/init.h"
 #include "crypto/tlscredsx509.h"
-#include "qemu/acl.h"
 #include "qapi/error.h"
+#include "authz/list.h"
 #include "qom/object_interfaces.h"
 
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
@@ -113,7 +113,7 @@ static void test_io_channel_tls(const void *opaque)
     QIOChannelTLS *serverChanTLS;
     QIOChannelSocket *clientChanSock;
     QIOChannelSocket *serverChanSock;
-    qemu_acl *acl;
+    QAuthZList *auth;
     const char * const *wildcards;
     int channel[2];
     struct QIOChannelTLSHandshakeData clientHandshake = { false, false };
@@ -161,11 +161,15 @@ static void test_io_channel_tls(const void *opaque)
         SERVER_CERT_DIR);
     g_assert(serverCreds != NULL);
 
-    acl = qemu_acl_init("channeltlsacl");
-    qemu_acl_reset(acl);
+    auth = qauthz_list_new("channeltlsacl",
+                           QAUTHZ_LIST_POLICY_DENY,
+                           &error_abort);
     wildcards = data->wildcards;
     while (wildcards && *wildcards) {
-        qemu_acl_append(acl, 0, *wildcards);
+        qauthz_list_append_rule(auth, *wildcards,
+                                QAUTHZ_LIST_POLICY_ALLOW,
+                                QAUTHZ_LIST_FORMAT_GLOB,
+                                &error_abort);
         wildcards++;
     }
 
@@ -253,6 +257,8 @@ static void test_io_channel_tls(const void *opaque)
     object_unref(OBJECT(serverChanSock));
     object_unref(OBJECT(clientChanSock));
 
+    object_unparent(OBJECT(auth));
+
     close(channel[0]);
     close(channel[1]);
 }
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 3751a777a4..7b2b09f242 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "authz/base.h"
 #include "vnc.h"
 #include "trace.h"
 
@@ -146,13 +147,14 @@ size_t vnc_client_read_sasl(VncState *vs)
 static int vnc_auth_sasl_check_access(VncState *vs)
 {
     const void *val;
-    int err;
-    int allow;
+    int rv;
+    Error *err = NULL;
+    bool allow;
 
-    err = sasl_getprop(vs->sasl.conn, SASL_USERNAME, &val);
-    if (err != SASL_OK) {
+    rv = sasl_getprop(vs->sasl.conn, SASL_USERNAME, &val);
+    if (rv != SASL_OK) {
         trace_vnc_auth_fail(vs, vs->auth, "Cannot fetch SASL username",
-                            sasl_errstring(err, NULL, NULL));
+                            sasl_errstring(rv, NULL, NULL));
         return -1;
     }
     if (val == NULL) {
@@ -163,12 +165,19 @@ static int vnc_auth_sasl_check_access(VncState *vs)
     vs->sasl.username = g_strdup((const char*)val);
     trace_vnc_auth_sasl_username(vs, vs->sasl.username);
 
-    if (vs->vd->sasl.acl == NULL) {
+    if (vs->vd->sasl.authzid == NULL) {
         trace_vnc_auth_sasl_acl(vs, 1);
         return 0;
     }
 
-    allow = qemu_acl_party_is_allowed(vs->vd->sasl.acl, vs->sasl.username);
+    allow = qauthz_is_allowed_by_id(vs->vd->sasl.authzid,
+                                    vs->sasl.username, &err);
+    if (err) {
+        trace_vnc_auth_fail(vs, vs->auth, "Error from authz",
+                            error_get_pretty(err));
+        error_free(err);
+        return -1;
+    }
 
     trace_vnc_auth_sasl_acl(vs, allow);
     return allow ? 0 : -1;
diff --git a/ui/vnc-auth-sasl.h b/ui/vnc-auth-sasl.h
index 2ae224ee3a..fb55fe04ca 100644
--- a/ui/vnc-auth-sasl.h
+++ b/ui/vnc-auth-sasl.h
@@ -30,8 +30,8 @@
 typedef struct VncStateSASL VncStateSASL;
 typedef struct VncDisplaySASL VncDisplaySASL;
 
-#include "qemu/acl.h"
 #include "qemu/main-loop.h"
+#include "authz/base.h"
 
 struct VncStateSASL {
     sasl_conn_t *conn;
@@ -60,7 +60,8 @@ struct VncStateSASL {
 };
 
 struct VncDisplaySASL {
-    qemu_acl *acl;
+    QAuthZ *authz;
+    char *authzid;
 };
 
 void vnc_sasl_client_cleanup(VncState *vs);
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index d99ea362c1..f072e16ace 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -109,7 +109,7 @@ static int protocol_client_vencrypt_auth(VncState *vs, uint8_t *data, size_t len
         tls = qio_channel_tls_new_server(
             vs->ioc,
             vs->vd->tlscreds,
-            vs->vd->tlsaclname,
+            vs->vd->tlsauthzid,
             &err);
         if (!tls) {
             trace_vnc_auth_fail(vs, vs->auth, "TLS setup failed",
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 950f1cd2ac..95c9703c72 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -62,7 +62,7 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
     tls = qio_channel_tls_new_server(
         vs->ioc,
         vs->vd->tlscreds,
-        vs->vd->tlsaclname,
+        vs->vd->tlsauthzid,
         &err);
     if (!tls) {
         VNC_DEBUG("Failed to setup TLS %s\n", error_get_pretty(err));
diff --git a/ui/vnc.c b/ui/vnc.c
index 359693238b..9fb8430c35 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -33,7 +33,7 @@
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "qemu/timer.h"
-#include "qemu/acl.h"
+#include "authz/list.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-events.h"
 #include "qapi/error.h"
@@ -3267,12 +3267,24 @@ static void vnc_display_close(VncDisplay *vd)
         object_unparent(OBJECT(vd->tlscreds));
         vd->tlscreds = NULL;
     }
-    g_free(vd->tlsaclname);
-    vd->tlsaclname = NULL;
+    if (vd->tlsauthz) {
+        object_unparent(OBJECT(vd->tlsauthz));
+        vd->tlsauthz = NULL;
+    }
+    g_free(vd->tlsauthzid);
+    vd->tlsauthzid = NULL;
     if (vd->lock_key_sync) {
         qemu_remove_led_event_handler(vd->led);
         vd->led = NULL;
     }
+#ifdef CONFIG_VNC_SASL
+    if (vd->sasl.authz) {
+        object_unparent(OBJECT(vd->sasl.authz));
+        vd->sasl.authz = NULL;
+    }
+    g_free(vd->sasl.authzid);
+    vd->sasl.authzid = NULL;
+#endif
 }
 
 int vnc_display_password(const char *id, const char *password)
@@ -4019,23 +4031,24 @@ void vnc_display_open(const char *id, Error **errp)
 
     if (acl) {
         if (strcmp(vd->id, "default") == 0) {
-            vd->tlsaclname = g_strdup("vnc.x509dname");
+            vd->tlsauthzid = g_strdup("vnc.x509dname");
         } else {
-            vd->tlsaclname = g_strdup_printf("vnc.%s.x509dname", vd->id);
+            vd->tlsauthzid = g_strdup_printf("vnc.%s.x509dname", vd->id);
         }
-        qemu_acl_init(vd->tlsaclname);
+        vd->tlsauthz = QAUTHZ(qauthz_list_new(vd->tlsauthzid,
+                                              QAUTHZ_LIST_POLICY_DENY,
+                                              &error_abort));
     }
 #ifdef CONFIG_VNC_SASL
     if (acl && sasl) {
-        char *aclname;
-
         if (strcmp(vd->id, "default") == 0) {
-            aclname = g_strdup("vnc.username");
+            vd->sasl.authzid = g_strdup("vnc.username");
         } else {
-            aclname = g_strdup_printf("vnc.%s.username", vd->id);
+            vd->sasl.authzid = g_strdup_printf("vnc.%s.username", vd->id);
         }
-        vd->sasl.acl = qemu_acl_init(aclname);
-        g_free(aclname);
+        vd->sasl.authz = QAUTHZ(qauthz_list_new(vd->sasl.authzid,
+                                                QAUTHZ_LIST_POLICY_DENY,
+                                                &error_abort));
     }
 #endif
 
diff --git a/ui/vnc.h b/ui/vnc.h
index a86e0610e8..29ee1738a5 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -39,6 +39,7 @@
 #include "io/channel-socket.h"
 #include "io/channel-tls.h"
 #include "io/net-listener.h"
+#include "authz/base.h"
 #include <zlib.h>
 
 #include "keymaps.h"
@@ -177,7 +178,8 @@ struct VncDisplay
     bool lossy;
     bool non_adaptive;
     QCryptoTLSCreds *tlscreds;
-    char *tlsaclname;
+    QAuthZ *tlsauthz;
+    char *tlsauthzid;
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
 #endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 769d295a27..99a808014e 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -19,7 +19,6 @@ util-obj-y += envlist.o path.o module.o
 util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
-util-obj-y += acl.o
 util-obj-y += cacheinfo.o
 util-obj-y += error.o qemu-error.o
 util-obj-y += id.o
diff --git a/util/acl.c b/util/acl.c
deleted file mode 100644
index c105addadc..0000000000
--- a/util/acl.c
+++ /dev/null
@@ -1,179 +0,0 @@
-/*
- * QEMU access control list management
- *
- * Copyright (C) 2009 Red Hat, Inc
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qemu/acl.h"
-
-#ifdef CONFIG_FNMATCH
-#include <fnmatch.h>
-#endif
-
-
-static unsigned int nacls = 0;
-static qemu_acl **acls = NULL;
-
-
-
-qemu_acl *qemu_acl_find(const char *aclname)
-{
-    int i;
-    for (i = 0 ; i < nacls ; i++) {
-        if (strcmp(acls[i]->aclname, aclname) == 0)
-            return acls[i];
-    }
-
-    return NULL;
-}
-
-qemu_acl *qemu_acl_init(const char *aclname)
-{
-    qemu_acl *acl;
-
-    acl = qemu_acl_find(aclname);
-    if (acl)
-        return acl;
-
-    acl = g_malloc(sizeof(*acl));
-    acl->aclname = g_strdup(aclname);
-    /* Deny by default, so there is no window of "open
-     * access" between QEMU starting, and the user setting
-     * up ACLs in the monitor */
-    acl->defaultDeny = 1;
-
-    acl->nentries = 0;
-    QTAILQ_INIT(&acl->entries);
-
-    acls = g_realloc(acls, sizeof(*acls) * (nacls +1));
-    acls[nacls] = acl;
-    nacls++;
-
-    return acl;
-}
-
-int qemu_acl_party_is_allowed(qemu_acl *acl,
-                              const char *party)
-{
-    qemu_acl_entry *entry;
-
-    QTAILQ_FOREACH(entry, &acl->entries, next) {
-#ifdef CONFIG_FNMATCH
-        if (fnmatch(entry->match, party, 0) == 0)
-            return entry->deny ? 0 : 1;
-#else
-        /* No fnmatch, so fallback to exact string matching
-         * instead of allowing wildcards */
-        if (strcmp(entry->match, party) == 0)
-            return entry->deny ? 0 : 1;
-#endif
-    }
-
-    return acl->defaultDeny ? 0 : 1;
-}
-
-
-void qemu_acl_reset(qemu_acl *acl)
-{
-    qemu_acl_entry *entry, *next_entry;
-
-    /* Put back to deny by default, so there is no window
-     * of "open access" while the user re-initializes the
-     * access control list */
-    acl->defaultDeny = 1;
-    QTAILQ_FOREACH_SAFE(entry, &acl->entries, next, next_entry) {
-        QTAILQ_REMOVE(&acl->entries, entry, next);
-        g_free(entry->match);
-        g_free(entry);
-    }
-    acl->nentries = 0;
-}
-
-
-int qemu_acl_append(qemu_acl *acl,
-                    int deny,
-                    const char *match)
-{
-    qemu_acl_entry *entry;
-
-    entry = g_malloc(sizeof(*entry));
-    entry->match = g_strdup(match);
-    entry->deny = deny;
-
-    QTAILQ_INSERT_TAIL(&acl->entries, entry, next);
-    acl->nentries++;
-
-    return acl->nentries;
-}
-
-
-int qemu_acl_insert(qemu_acl *acl,
-                    int deny,
-                    const char *match,
-                    int index)
-{
-    qemu_acl_entry *tmp;
-    int i = 0;
-
-    if (index <= 0)
-        return -1;
-    if (index > acl->nentries) {
-        return qemu_acl_append(acl, deny, match);
-    }
-
-    QTAILQ_FOREACH(tmp, &acl->entries, next) {
-        i++;
-        if (i == index) {
-            qemu_acl_entry *entry;
-            entry = g_malloc(sizeof(*entry));
-            entry->match = g_strdup(match);
-            entry->deny = deny;
-
-            QTAILQ_INSERT_BEFORE(tmp, entry, next);
-            acl->nentries++;
-            break;
-        }
-    }
-
-    return i;
-}
-
-int qemu_acl_remove(qemu_acl *acl,
-                    const char *match)
-{
-    qemu_acl_entry *entry;
-    int i = 0;
-
-    QTAILQ_FOREACH(entry, &acl->entries, next) {
-        i++;
-        if (strcmp(entry->match, match) == 0) {
-            QTAILQ_REMOVE(&acl->entries, entry, next);
-            acl->nentries--;
-            g_free(entry->match);
-            g_free(entry);
-            return i;
-        }
-    }
-    return -1;
-}
-- 
2.17.1
