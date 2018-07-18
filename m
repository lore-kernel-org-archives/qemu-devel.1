Received: from eggs.gnu.org ([2001:4830:134:3::10]:49515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fflBD-0007bp-Mg
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fflBB-00036G-LO
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fflBB-00035u-DX
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 08:03:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F26D281A4EB7
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 12:03:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 18 Jul 2018 13:03:32 +0100
Message-Id: <20180718120334.27138-2-berrange@redhat.com>
In-Reply-To: <20180718120334.27138-1-berrange@redhat.com>
References: <20180718120334.27138-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] crypto: require gnutls >= 3.1.18 for
 building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

gnutls 3.0.0 was released in 2011 and all the distros that are build
target platforms for QEMU [1] include it:

  RHEL-7: 3.1.18
  Debian (Stretch): 3.5.8
  Debian (Jessie): 3.3.8
  OpenBSD (ports): 3.5.18
  FreeBSD (ports): 3.5.18
  OpenSUSE Leap 15: 3.6.2
  Ubuntu (Xenial): 3.4.10
  macOS (Homebrew): 3.5.19

Based on this, it is reasonable to require gnutls >=3D 3.1.18 in QEMU
which allows for all conditional version checks in the code to be
removed.

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure                        | 135 +++++++++----------------------
 crypto/Makefile.objs             |   4 +-
 crypto/init.c                    |  20 +----
 crypto/tlscredsx509.c            |  21 -----
 crypto/tlssession.c              |   8 +-
 tests/crypto-tls-x509-helpers.h  |   3 +-
 tests/test-crypto-tlscredsx509.c |   8 +-
 7 files changed, 46 insertions(+), 153 deletions(-)

diff --git a/configure b/configure
index 2a7796ea80..856cb07be5 100755
--- a/configure
+++ b/configure
@@ -456,7 +456,6 @@ gtkabi=3D""
 gtk_gl=3D"no"
 tls_priority=3D"NORMAL"
 gnutls=3D""
-gnutls_rnd=3D""
 nettle=3D""
 nettle_kdf=3D"no"
 gcrypt=3D""
@@ -2675,79 +2674,28 @@ fi
 ##########################################
 # GNUTLS probe
=20
-gnutls_works() {
-    # Unfortunately some distros have bad pkg-config information for gnu=
tls
-    # such that it claims to exist but you get a compiler error if you t=
ry
-    # to use the options returned by --libs. Specifically, Ubuntu for --=
static
-    # builds doesn't work:
-    # https://bugs.launchpad.net/ubuntu/+source/gnutls26/+bug/1478035
-    #
-    # So sanity check the cflags/libs before assuming gnutls can be used=
.
-    if ! $pkg_config --exists "gnutls"; then
-        return 1
-    fi
-
-    write_c_skeleton
-    compile_prog "$($pkg_config --cflags gnutls)" "$($pkg_config --libs =
gnutls)"
-}
-
-gnutls_gcrypt=3Dno
-gnutls_nettle=3Dno
 if test "$gnutls" !=3D "no"; then
-    if gnutls_works; then
+    if $pkg_config --exists "gnutls >=3D 3.1.18"; then
         gnutls_cflags=3D$($pkg_config --cflags gnutls)
         gnutls_libs=3D$($pkg_config --libs gnutls)
         libs_softmmu=3D"$gnutls_libs $libs_softmmu"
         libs_tools=3D"$gnutls_libs $libs_tools"
 	QEMU_CFLAGS=3D"$QEMU_CFLAGS $gnutls_cflags"
         gnutls=3D"yes"
-
-	# gnutls_rnd requires >=3D 2.11.0
-	if $pkg_config --exists "gnutls >=3D 2.11.0"; then
-	    gnutls_rnd=3D"yes"
-	else
-	    gnutls_rnd=3D"no"
-	fi
-
-	if $pkg_config --exists 'gnutls >=3D 3.0'; then
-	    gnutls_gcrypt=3Dno
-	    gnutls_nettle=3Dyes
-	elif $pkg_config --exists 'gnutls >=3D 2.12'; then
-	    case $($pkg_config --libs --static gnutls) in
-		*gcrypt*)
-		    gnutls_gcrypt=3Dyes
-		    gnutls_nettle=3Dno
-		    ;;
-		*nettle*)
-		    gnutls_gcrypt=3Dno
-		    gnutls_nettle=3Dyes
-		    ;;
-		*)
-		    gnutls_gcrypt=3Dyes
-		    gnutls_nettle=3Dno
-		    ;;
-	    esac
-	else
-	    gnutls_gcrypt=3Dyes
-	    gnutls_nettle=3Dno
-	fi
     elif test "$gnutls" =3D "yes"; then
-	feature_not_found "gnutls" "Install gnutls devel"
+	feature_not_found "gnutls" "Install gnutls devel >=3D 3.1.18"
     else
         gnutls=3D"no"
-        gnutls_rnd=3D"no"
     fi
-else
-    gnutls_rnd=3D"no"
 fi
=20
=20
 # If user didn't give a --disable/enable-gcrypt flag,
 # then mark as disabled if user requested nettle
-# explicitly, or if gnutls links to nettle
+# explicitly
 if test -z "$gcrypt"
 then
-    if test "$nettle" =3D "yes" || test "$gnutls_nettle" =3D "yes"
+    if test "$nettle" =3D "yes"
     then
         gcrypt=3D"no"
     fi
@@ -2755,10 +2703,10 @@ fi
=20
 # If user didn't give a --disable/enable-nettle flag,
 # then mark as disabled if user requested gcrypt
-# explicitly, or if gnutls links to gcrypt
+# explicitly
 if test -z "$nettle"
 then
-    if test "$gcrypt" =3D "yes" || test "$gnutls_gcrypt" =3D "yes"
+    if test "$gcrypt" =3D "yes"
     then
         nettle=3D"no"
     fi
@@ -2782,6 +2730,40 @@ has_libgcrypt_config() {
     return 0
 }
=20
+
+if test "$nettle" !=3D "no"; then
+    if $pkg_config --exists "nettle"; then
+        nettle_cflags=3D$($pkg_config --cflags nettle)
+        nettle_libs=3D$($pkg_config --libs nettle)
+        nettle_version=3D$($pkg_config --modversion nettle)
+        libs_softmmu=3D"$nettle_libs $libs_softmmu"
+        libs_tools=3D"$nettle_libs $libs_tools"
+        QEMU_CFLAGS=3D"$QEMU_CFLAGS $nettle_cflags"
+        nettle=3D"yes"
+
+        cat > $TMPC << EOF
+#include <stddef.h>
+#include <nettle/pbkdf2.h>
+int main(void) {
+     pbkdf2_hmac_sha256(8, NULL, 1000, 8, NULL, 8, NULL);
+     return 0;
+}
+EOF
+        if test -z "$gcrypt"; then
+           gcrypt=3D"no"
+        fi
+        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
+            nettle_kdf=3Dyes
+        fi
+    else
+        if test "$nettle" =3D "yes"; then
+            feature_not_found "nettle" "Install nettle devel"
+        else
+            nettle=3D"no"
+        fi
+    fi
+fi
+
 if test "$gcrypt" !=3D "no"; then
     if has_libgcrypt_config; then
         gcrypt_cflags=3D$(libgcrypt-config --cflags)
@@ -2797,9 +2779,6 @@ if test "$gcrypt" !=3D "no"; then
         libs_tools=3D"$gcrypt_libs $libs_tools"
         QEMU_CFLAGS=3D"$QEMU_CFLAGS $gcrypt_cflags"
         gcrypt=3D"yes"
-        if test -z "$nettle"; then
-           nettle=3D"no"
-        fi
=20
         cat > $TMPC << EOF
 #include <gcrypt.h>
@@ -2836,36 +2815,6 @@ EOF
 fi
=20
=20
-if test "$nettle" !=3D "no"; then
-    if $pkg_config --exists "nettle"; then
-        nettle_cflags=3D$($pkg_config --cflags nettle)
-        nettle_libs=3D$($pkg_config --libs nettle)
-        nettle_version=3D$($pkg_config --modversion nettle)
-        libs_softmmu=3D"$nettle_libs $libs_softmmu"
-        libs_tools=3D"$nettle_libs $libs_tools"
-        QEMU_CFLAGS=3D"$QEMU_CFLAGS $nettle_cflags"
-        nettle=3D"yes"
-
-        cat > $TMPC << EOF
-#include <stddef.h>
-#include <nettle/pbkdf2.h>
-int main(void) {
-     pbkdf2_hmac_sha256(8, NULL, 1000, 8, NULL, 8, NULL);
-     return 0;
-}
-EOF
-        if compile_prog "$nettle_cflags" "$nettle_libs" ; then
-            nettle_kdf=3Dyes
-        fi
-    else
-        if test "$nettle" =3D "yes"; then
-            feature_not_found "nettle" "Install nettle devel"
-        else
-            nettle=3D"no"
-        fi
-    fi
-fi
-
 if test "$gcrypt" =3D "yes" && test "$nettle" =3D "yes"
 then
     error_exit "Only one of gcrypt & nettle can be enabled"
@@ -5903,7 +5852,6 @@ echo "GTK GL support    $gtk_gl"
 echo "VTE support       $vte $(echo_version $vte $vteversion)"
 echo "TLS priority      $tls_priority"
 echo "GNUTLS support    $gnutls"
-echo "GNUTLS rnd        $gnutls_rnd"
 echo "libgcrypt         $gcrypt"
 echo "libgcrypt kdf     $gcrypt_kdf"
 echo "nettle            $nettle $(echo_version $nettle $nettle_version)"
@@ -6351,9 +6299,6 @@ echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $=
config_host_mak
 if test "$gnutls" =3D "yes" ; then
   echo "CONFIG_GNUTLS=3Dy" >> $config_host_mak
 fi
-if test "$gnutls_rnd" =3D "yes" ; then
-  echo "CONFIG_GNUTLS_RND=3Dy" >> $config_host_mak
-fi
 if test "$gcrypt" =3D "yes" ; then
   echo "CONFIG_GCRYPT=3Dy" >> $config_host_mak
   if test "$gcrypt_hmac" =3D "yes" ; then
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 756bab111b..a62cedaf36 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -20,8 +20,8 @@ crypto-obj-y +=3D tlscredsx509.o
 crypto-obj-y +=3D tlssession.o
 crypto-obj-y +=3D secret.o
 crypto-obj-$(CONFIG_GCRYPT) +=3D random-gcrypt.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS_RND)) +=3D random-gnu=
tls.o
-crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS_RND),n,y)) +=3D =
random-platform.o
+crypto-obj-$(if $(CONFIG_GCRYPT),n,$(CONFIG_GNUTLS)) +=3D random-gnutls.=
o
+crypto-obj-$(if $(CONFIG_GCRYPT),n,$(if $(CONFIG_GNUTLS),n,y)) +=3D rand=
om-platform.o
 crypto-obj-y +=3D pbkdf.o
 crypto-obj-$(CONFIG_NETTLE_KDF) +=3D pbkdf-nettle.o
 crypto-obj-$(if $(CONFIG_NETTLE_KDF),n,$(CONFIG_GCRYPT_KDF)) +=3D pbkdf-=
gcrypt.o
diff --git a/crypto/init.c b/crypto/init.c
index f131c42306..10bf72463c 100644
--- a/crypto/init.c
+++ b/crypto/init.c
@@ -37,31 +37,13 @@
 /* #define DEBUG_GNUTLS */
=20
 /*
- * If GNUTLS is built against GCrypt then
- *
- *  - When GNUTLS >=3D 2.12, we must not initialize gcrypt threading
- *    because GNUTLS will do that itself
- *  - When GNUTLS < 2.12 we must always initialize gcrypt threading
- *  - When GNUTLS is disabled we must always initialize gcrypt threading
- *
- * But....
- *
- *    When gcrypt >=3D 1.6.0 we must not initialize gcrypt threading
- *    because gcrypt will do that itself.
- *
- * So we need to init gcrypt threading if
+ * We need to init gcrypt threading if
  *
  *   - gcrypt < 1.6.0
- * AND
- *      - gnutls < 2.12
- *   OR
- *      - gnutls is disabled
  *
  */
=20
 #if (defined(CONFIG_GCRYPT) &&                  \
-     (!defined(CONFIG_GNUTLS) ||                \
-     (LIBGNUTLS_VERSION_NUMBER < 0x020c00)) &&    \
      (!defined(GCRYPT_VERSION_NUMBER) ||        \
       (GCRYPT_VERSION_NUMBER < 0x010600)))
 #define QCRYPTO_INIT_GCRYPT_THREADS
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 98ee0424e5..d6ab4a9862 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -72,14 +72,6 @@ qcrypto_tls_creds_check_cert_times(gnutls_x509_crt_t c=
ert,
 }
=20
=20
-#if LIBGNUTLS_VERSION_NUMBER >=3D 2
-/*
- * The gnutls_x509_crt_get_basic_constraints function isn't
- * available in GNUTLS 1.0.x branches. This isn't critical
- * though, since gnutls_certificate_verify_peers2 will do
- * pretty much the same check at runtime, so we can just
- * disable this code
- */
 static int
 qcrypto_tls_creds_check_cert_basic_constraints(QCryptoTLSCredsX509 *cred=
s,
                                                gnutls_x509_crt_t cert,
@@ -130,7 +122,6 @@ qcrypto_tls_creds_check_cert_basic_constraints(QCrypt=
oTLSCredsX509 *creds,
=20
     return 0;
 }
-#endif
=20
=20
 static int
@@ -299,14 +290,12 @@ qcrypto_tls_creds_check_cert(QCryptoTLSCredsX509 *c=
reds,
         return -1;
     }
=20
-#if LIBGNUTLS_VERSION_NUMBER >=3D 2
     if (qcrypto_tls_creds_check_cert_basic_constraints(creds,
                                                        cert, certFile,
                                                        isServer, isCA,
                                                        errp) < 0) {
         return -1;
     }
-#endif
=20
     if (qcrypto_tls_creds_check_cert_key_usage(creds,
                                                cert, certFile,
@@ -615,7 +604,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
     }
=20
     if (cert !=3D NULL && key !=3D NULL) {
-#if LIBGNUTLS_VERSION_NUMBER >=3D 0x030111
         char *password =3D NULL;
         if (creds->passwordid) {
             password =3D qcrypto_secret_lookup_as_utf8(creds->passwordid=
,
@@ -630,15 +618,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cre=
ds,
                                                     password,
                                                     0);
         g_free(password);
-#else /* LIBGNUTLS_VERSION_NUMBER < 0x030111 */
-        if (creds->passwordid) {
-            error_setg(errp, "PKCS8 decryption requires GNUTLS >=3D 3.1.=
11");
-            goto cleanup;
-        }
-        ret =3D gnutls_certificate_set_x509_key_file(creds->data,
-                                                   cert, key,
-                                                   GNUTLS_X509_FMT_PEM);
-#endif
         if (ret < 0) {
             error_setg(errp, "Cannot load certificate '%s' & key '%s': %=
s",
                        cert, key, gnutls_strerror(ret));
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 66a6fbe19c..2f28fa7f71 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -90,13 +90,7 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size=
_t len)
 }
=20
 #define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
-
-#if GNUTLS_VERSION_MAJOR >=3D 3
-#define TLS_ECDHE_PSK "+ECDHE-PSK:"
-#else
-#define TLS_ECDHE_PSK ""
-#endif
-#define TLS_PRIORITY_ADDITIONAL_PSK TLS_ECDHE_PSK "+DHE-PSK:+PSK"
+#define TLS_PRIORITY_ADDITIONAL_PSK "+ECDHE-PSK:+DHE-PSK:+PSK"
=20
 QCryptoTLSSession *
 qcrypto_tls_session_new(QCryptoTLSCreds *creds,
diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-help=
ers.h
index 921341c649..88c30d7c94 100644
--- a/tests/crypto-tls-x509-helpers.h
+++ b/tests/crypto-tls-x509-helpers.h
@@ -22,8 +22,7 @@
 #include <gnutls/x509.h>
=20
 #if !(defined WIN32) && \
-    defined(CONFIG_TASN1) && \
-    (LIBGNUTLS_VERSION_NUMBER >=3D 0x020600)
+    defined(CONFIG_TASN1)
 # define QCRYPTO_HAVE_TLS_TEST_SUPPORT
 #endif
=20
diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscred=
sx509.c
index af2f80e89c..9bc45d4619 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -290,14 +290,8 @@ int main(int argc, char **argv)
                  true, true, GNUTLS_KP_TLS_WWW_SERVER, NULL,
                  0, 0);
=20
-    /* Technically a CA cert with basic constraints
-     * key purpose =3D=3D key signing + non-critical should
-     * be rejected. GNUTLS < 3.1 does not reject it and
-     * we don't anticipate them changing this behaviour
-     */
     TLS_TEST_REG(badca1, true, cacert4req.filename, servercert4req.filen=
ame,
-                (GNUTLS_VERSION_MAJOR =3D=3D 3 && GNUTLS_VERSION_MINOR >=
=3D 1) ||
-                GNUTLS_VERSION_MAJOR > 3);
+                 true);
     TLS_TEST_REG(badca2, true,
                  cacert5req.filename, servercert5req.filename, true);
     TLS_TEST_REG(badca3, true,
--=20
2.17.1
