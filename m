Received: from eggs.gnu.org ([2001:4830:134:3::10]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuQ-0003ag-5i
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHuJ-0001aq-Iv
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60600 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHuJ-0001aN-CP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:43 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:17 +0100
Message-Id: <20180816130118.31841-11-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 10/11] authz: add QAuthZPAM object type for
 authorizing using PAM
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

Add an authorization backend that talks to PAM to check whether the user
identity is allowed. This only uses the PAM account validation facility,
which is essentially just a check to see if the provided username is permitted
access. It doesn't use the authentication or session parts of PAM, since
that's dealt with by the relevant part of QEMU (eg VNC server).

Consider starting QEMU with a VNC server and telling it to use TLS with
x509 client certificates and configuring it to use an PAM to validate
the x509 distinguished name. In this example we're telling it to use PAM
for the QAuthZ impl with a service name of "qemu-vnc"

 $ qemu-system-x86_64 \
     -object tls-creds-x509,id=tls0,dir=/home/berrange/security/qemutls,\
             endpoint=server,verify-peer=yes \
     -object authz-pam,id=authz0,service=qemu-vnc \
     -vnc :1,tls-creds=tls0,tls-authz=authz0

This requires an /etc/pam/qemu-vnc file to be created with the auth
rules. A very simple file based whitelist can be setup using

  $ cat > /etc/pam/qemu-vnc <<EOF
  account         requisite       pam_listfile.so item=user sense=allow file=/etc/qemu/vnc.allow
  EOF

The /etc/qemu/vnc.allow file simply contains one username per line. Any
username not in the file is denied. The usernames in this example are
the x509 distinguished name from the client's x509 cert.

  $ cat > /etc/qemu/vnc.allow <<EOF
  CN=laptop.berrange.com,O=Berrange Home,L=London,ST=London,C=GB
  EOF

More interesting would be to configure PAM to use an LDAP backend, so
that the QEMU authorization check data can be centralized instead of
requiring each compute host to have file maintained.

The main limitation with this PAM module is that the rules apply to all
QEMU instances on the host. Setting up different rules per VM, would
require creating a separate PAM service name & config file for every
guest. An alternative approach for the future might be to not pass in
the plain username to PAM, but instead combine the VM name or UUID with
the username. This requires further consideration though.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 authz/Makefile.objs     |   3 +
 authz/pamacct.c         | 149 ++++++++++++++++++++++++++++++++++++++++
 authz/trace-events      |   3 +
 configure               |  37 ++++++++++
 include/authz/pamacct.h | 100 +++++++++++++++++++++++++++
 qemu-options.hx         |  35 ++++++++++
 6 files changed, 327 insertions(+)
 create mode 100644 authz/pamacct.c
 create mode 100644 include/authz/pamacct.h

diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index 8351bf181d..ed7b273596 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -2,3 +2,6 @@ authz-obj-y += base.o
 authz-obj-y += simple.o
 authz-obj-y += list.o
 authz-obj-y += listfile.o
+authz-obj-$(CONFIG_AUTH_PAM) += pamacct.o
+
+pamacct.o-libs = -lpam
diff --git a/authz/pamacct.c b/authz/pamacct.c
new file mode 100644
index 0000000000..a070dda217
--- /dev/null
+++ b/authz/pamacct.c
@@ -0,0 +1,149 @@
+/*
+ * QEMU PAM authorization driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "authz/pamacct.h"
+#include "authz/trace.h"
+#include "qom/object_interfaces.h"
+
+#include <security/pam_appl.h>
+
+
+static bool qauthz_pam_is_allowed(QAuthZ *authz,
+                                  const char *identity,
+                                  Error **errp)
+{
+    QAuthZPam *pauthz = QAUTHZ_PAM(authz);
+    const struct pam_conv pam_conversation = { 0 };
+    pam_handle_t *pamh = NULL;
+    int ret;
+
+    trace_qauthz_pam_check(authz, identity, pauthz->service);
+    ret = pam_start(pauthz->service,
+                    identity,
+                    &pam_conversation,
+                    &pamh);
+    if (ret != PAM_SUCCESS) {
+        error_setg(errp, "Unable to start PAM transaction: %s",
+                   pam_strerror(NULL, ret));
+        return false;
+    }
+
+    ret = pam_acct_mgmt(pamh, PAM_SILENT);
+    if (ret != PAM_SUCCESS) {
+        error_setg(errp, "Unable to authorize user '%s': %s",
+                   identity, pam_strerror(pamh, ret));
+        goto cleanup;
+    }
+
+ cleanup:
+    pam_end(pamh, ret);
+    return ret == PAM_SUCCESS;
+}
+
+
+static void
+qauthz_pam_prop_set_service(Object *obj,
+                            const char *service,
+                            Error **errp G_GNUC_UNUSED)
+{
+    QAuthZPam *pauthz = QAUTHZ_PAM(obj);
+
+    g_free(pauthz->service);
+    pauthz->service = g_strdup(service);
+}
+
+
+static char *
+qauthz_pam_prop_get_service(Object *obj,
+                            Error **errp G_GNUC_UNUSED)
+{
+    QAuthZPam *pauthz = QAUTHZ_PAM(obj);
+
+    return g_strdup(pauthz->service);
+}
+
+
+static void
+qauthz_pam_complete(UserCreatable *uc, Error **errp)
+{
+}
+
+
+static void
+qauthz_pam_finalize(Object *obj)
+{
+    QAuthZPam *pauthz = QAUTHZ_PAM(obj);
+
+    g_free(pauthz->service);
+}
+
+
+static void
+qauthz_pam_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+    QAuthZClass *authz = QAUTHZ_CLASS(oc);
+
+    ucc->complete = qauthz_pam_complete;
+    authz->is_allowed = qauthz_pam_is_allowed;
+
+    object_class_property_add_str(oc, "service",
+                                  qauthz_pam_prop_get_service,
+                                  qauthz_pam_prop_set_service,
+                                  NULL);
+}
+
+
+QAuthZPam *qauthz_pam_new(const char *id,
+                          const char *service,
+                          Error **errp)
+{
+    return QAUTHZ_PAM(
+        object_new_with_props(TYPE_QAUTHZ_PAM,
+                              object_get_objects_root(),
+                              id, errp,
+                              "service", service,
+                              NULL));
+}
+
+
+static const TypeInfo qauthz_pam_info = {
+    .parent = TYPE_QAUTHZ,
+    .name = TYPE_QAUTHZ_PAM,
+    .instance_size = sizeof(QAuthZPam),
+    .instance_finalize = qauthz_pam_finalize,
+    .class_size = sizeof(QAuthZPamClass),
+    .class_init = qauthz_pam_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+qauthz_pam_register_types(void)
+{
+    type_register_static(&qauthz_pam_info);
+}
+
+
+type_init(qauthz_pam_register_types);
diff --git a/authz/trace-events b/authz/trace-events
index fb65349a90..72c411927d 100644
--- a/authz/trace-events
+++ b/authz/trace-events
@@ -13,3 +13,6 @@ qauthz_list_default_policy(void *authz, const char *identity, int policy) "AuthZ
 # auth/listfile.c
 qauthz_list_file_load(void *authz, const char *filename) "AuthZ file %p load filename=%s"
 qauthz_list_file_refresh(void *authz, const char *filename, int success) "AuthZ file %p load filename=%s success=%d"
+
+# auth/pam.c
+qauthz_pam_check(void *authz, const char *identity, const char *service) "AuthZ PAM %p identity=%s service=%s"
diff --git a/configure b/configure
index 2a7796ea80..bebd84c541 100755
--- a/configure
+++ b/configure
@@ -462,6 +462,7 @@ nettle_kdf="no"
 gcrypt=""
 gcrypt_hmac="no"
 gcrypt_kdf="no"
+auth_pam=""
 vte=""
 virglrenderer=""
 tpm="yes"
@@ -1359,6 +1360,10 @@ for opt do
   ;;
   --enable-gcrypt) gcrypt="yes"
   ;;
+  --disable-auth-pam) auth_pam="no"
+  ;;
+  --enable-auth-pam) auth_pam="yes"
+  ;;
   --enable-rdma) rdma="yes"
   ;;
   --disable-rdma) rdma="no"
@@ -1645,6 +1650,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   gnutls          GNUTLS cryptography support
   nettle          nettle cryptography support
   gcrypt          libgcrypt cryptography support
+  auth-pam        PAM access control
   sdl             SDL UI
   --with-sdlabi     select preferred SDL ABI 1.2 or 2.0
   gtk             gtk UI
@@ -2885,6 +2891,33 @@ else
 fi
 
 
+##########################################
+# PAM probe
+
+if test "x$auth_pam" != "no"; then
+    cat > $TMPC <<EOF
+#include <security/pam_appl.h>
+#include <stdio.h>
+int main(void) {
+   const char *service_name = "qemu";
+   const char *user = "frank";
+   const struct pam_conv *pam_conv = NULL;
+   pam_handle_t *pamh = NULL;
+   pam_start(service_name, user, pam_conv, &pamh);
+   return 0;
+}
+EOF
+    if compile_prog "" "-lpam" ; then
+	auth_pam=yes
+    else
+	if test "$auth_pam" = "yes"; then
+	    feature_not_found "PAM" "Install pam-devel"
+	else
+	    auth_pam=no
+	fi
+    fi
+fi
+
 ##########################################
 # getifaddrs (for tests/test-io-channel-socket )
 
@@ -5909,6 +5942,7 @@ echo "libgcrypt kdf     $gcrypt_kdf"
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
 echo "nettle kdf        $nettle_kdf"
 echo "libtasn1          $tasn1"
+echo "PAM               $auth_pam"
 echo "curses support    $curses"
 echo "virgl support     $virglrenderer $(echo_version $virglrenderer $virgl_version)"
 echo "curl support      $curl"
@@ -6373,6 +6407,9 @@ fi
 if test "$tasn1" = "yes" ; then
   echo "CONFIG_TASN1=y" >> $config_host_mak
 fi
+if test "$auth_pam" = "yes" ; then
+    echo "CONFIG_AUTH_PAM=y" >> $config_host_mak
+fi
 if test "$have_ifaddrs_h" = "yes" ; then
     echo "HAVE_IFADDRS_H=y" >> $config_host_mak
 fi
diff --git a/include/authz/pamacct.h b/include/authz/pamacct.h
new file mode 100644
index 0000000000..d2c0149153
--- /dev/null
+++ b/include/authz/pamacct.h
@@ -0,0 +1,100 @@
+/*
+ * QEMU PAM authorization driver
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QAUTHZ_PAM_H__
+#define QAUTHZ_PAM_H__
+
+#include "authz/base.h"
+
+
+#define TYPE_QAUTHZ_PAM "authz-pam"
+
+#define QAUTHZ_PAM_CLASS(klass) \
+     OBJECT_CLASS_CHECK(QAuthZPamClass, (klass), \
+                        TYPE_QAUTHZ_PAM)
+#define QAUTHZ_PAM_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(QAuthZPamClass, (obj), \
+                      TYPE_QAUTHZ_PAM)
+#define QAUTHZ_PAM(obj) \
+     INTERFACE_CHECK(QAuthZPam, (obj), \
+                     TYPE_QAUTHZ_PAM)
+
+typedef struct QAuthZPam QAuthZPam;
+typedef struct QAuthZPamClass QAuthZPamClass;
+
+
+/**
+ * QAuthZPam:
+ *
+ * This authorization driver provides a PAM mechanism
+ * for granting access by matching user names against a
+ * list of globs. Each match rule has an associated policy
+ * and a catch all policy applies if no rule matches
+ *
+ * To create an instance of this class via QMP:
+ *
+ *  {
+ *    "execute": "object-add",
+ *    "arguments": {
+ *      "qom-type": "authz-pam",
+ *      "id": "authz0",
+ *      "parameters": {
+ *        "service": "qemu-vnc-tls"
+ *      }
+ *    }
+ *  }
+ *
+ * The driver only uses the PAM "account" verification
+ * subsystem. The above config would require a config
+ * file /etc/pam.d/qemu-vnc-tls. For a simple file
+ * lookup it would contain
+ *
+ *   account requisite  pam_listfile.so item=user sense=allow \
+ *           file=/etc/qemu/vnc.allow
+ *
+ * The external file would then contain a list of usernames.
+ * If x509 cert was being used as the username, a suitable
+ * entry would match the distinguish name:
+ *
+ *  CN=laptop.berrange.com,O=Berrange Home,L=London,ST=London,C=GB
+ *
+ * On the command line it can be created using
+ *
+ *   -object authz-pam,id=authz0,service=qemu-vnc-tls
+ *
+ */
+struct QAuthZPam {
+    QAuthZ parent_obj;
+
+    char *service;
+};
+
+
+struct QAuthZPamClass {
+    QAuthZClass parent_class;
+};
+
+
+QAuthZPam *qauthz_pam_new(const char *id,
+                          const char *service,
+                          Error **errp);
+
+
+#endif /* QAUTHZ_PAM_H__ */
diff --git a/qemu-options.hx b/qemu-options.hx
index 8fcea2fae2..ad8e0c4715 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4509,6 +4509,41 @@ would look like:
      ...
 @end example
 
+@item -object authz-pam,id=@var{id},service=@var{string}
+
+Create an authorization object that will control access to network services.
+
+The @option{service} parameter provides the name of a PAM service to use
+for authorization. It requires that a file @code{/etc/pam.d/@var{service}}
+exist to provide the configuration for the @code{account} subsystem.
+
+An example authorization object to validate a TLS x509 distinguished
+name would look like:
+
+@example
+ # $QEMU \
+     ...
+     -object authz-simple,id=auth0,service=qemu-vnc
+     ...
+@end example
+
+There would then be a corresponding config file for PAM at
+@code{/etc/pam.d/qemu-vnc} that contains:
+
+@example
+account requisite  pam_listfile.so item=user sense=allow \
+           file=/etc/qemu/vnc.allow
+@end example
+
+Finally the @code{/etc/qemu/vnc.allow} file would contain
+the list of x509 distingished names that are permitted
+access
+
+@example
+CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
+@end example
+
+
 @end table
 
 ETEXI
-- 
2.17.1
