Received: from eggs.gnu.org ([2001:4830:134:3::10]:43561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZU-0006Jd-0I
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZP-00071w-Rs
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZP-00071F-Ic
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:08:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2941C6A34
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:08:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:09 +0200
Message-Id: <20170911110623.24981-37-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 36/50] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Add #if defined(CONFIG_VNC) in generated code, and adjust the
qmp/hmp code accordingly.

Commands made conditional:

* query-vnc, query-vnc-servers, change-vnc-password

  Before the patch, the commands for !CONFIG_VNC are stubs that fail
  like this:

    {"error": {"class": "GenericError",
               "desc": "The feature 'vnc' is not enabled"}}

  Afterwards, they fail like this:

    {"error": {"class": "CommandNotFound",
               "desc": "The command FOO has not been found"}}

  I call that an improvement, because it lets clients distinguish
  between command unavailable (class CommandNotFound) and command failed
  (class GenericError).

Events made conditional:

* VNC_CONNECTED, VNC_INITIALIZED, VNC_DISCONNECTED

Enum made conditional:

* QCryptoCipherAlgorithm

    # @des-rfb: RFB specific variant of single DES. Do not use except in =
VNC.

Occurrences of VNC (case insensitive) in the schema that aren't
covered by this change:

* add_client

  Command has other uses, including "socket bases character devices".
  These are unconditional as far as I can tell.

* set_password, expire_password

  In theory, these commands could be used for managing any service's
  password.  In practice, they're used for VNC and SPICE services.
  They're documented for "remote display session" / "remote display
  server".

  The service is selected by argument @protocol.  The code special-cases
  protocol-specific argument checking, then calls a protocol-specific
  function to do the work.  If it fails, the command fails with "Could
  not set password".  It does when the service isn't compiled in (it's a
  stub then).

  We could make these commands conditional on the conjunction of all
  services [currently: defined(CONFIG_VNC) || defined(CONFIG_SPICE)],
  but I doubt it's worthwhile.

* change

  Command has other uses, namely changing media.
  This patch inlines a stub; no functional change.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/crypto.json           |  3 ++-
 qapi/ui.json               | 45 ++++++++++++++++++++++++++++------------=
-----
 ui/vnc.h                   |  2 ++
 crypto/cipher-builtin.c    |  9 +++++++++
 crypto/cipher-gcrypt.c     | 10 ++++++++--
 crypto/cipher-nettle.c     | 14 +++++++++++---
 crypto/cipher.c            | 13 +++++++++++--
 hmp.c                      |  9 ++++++++-
 qmp.c                      | 30 ++++--------------------------
 tests/test-crypto-cipher.c |  2 ++
 hmp-commands-info.hx       |  2 ++
 11 files changed, 87 insertions(+), 52 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 288bc056ef..09535b7be2 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -79,7 +79,8 @@
 { 'enum': 'QCryptoCipherAlgorithm',
   'prefix': 'QCRYPTO_CIPHER_ALG',
   'data': ['aes-128', 'aes-192', 'aes-256',
-           'des-rfb', '3des',
+           { 'name': 'des-rfb', 'if': 'defined(CONFIG_VNC)' },
+           '3des',
            'cast5-128',
            'serpent-128', 'serpent-192', 'serpent-256',
            'twofish-128', 'twofish-192', 'twofish-256']}
diff --git a/qapi/ui.json b/qapi/ui.json
index e5d6610b4a..4b573d214b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -369,7 +369,8 @@
   'data': { 'host': 'str',
             'service': 'str',
             'family': 'NetworkAddressFamily',
-            'websocket': 'bool' } }
+            'websocket': 'bool' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncServerInfo:
@@ -383,7 +384,8 @@
 ##
 { 'struct': 'VncServerInfo',
   'base': 'VncBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncClientInfo:
@@ -400,7 +402,8 @@
 ##
 { 'struct': 'VncClientInfo',
   'base': 'VncBasicInfo',
-  'data': { '*x509_dname': 'str', '*sasl_username': 'str' } }
+  'data': { '*x509_dname': 'str', '*sasl_username': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncInfo:
@@ -441,7 +444,8 @@
 { 'struct': 'VncInfo',
   'data': {'enabled': 'bool', '*host': 'str',
            '*family': 'NetworkAddressFamily',
-           '*service': 'str', '*auth': 'str', '*clients': ['VncClientInf=
o']} }
+           '*service': 'str', '*auth': 'str', '*clients': ['VncClientInf=
o']},
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncPrimaryAuth:
@@ -452,7 +456,8 @@
 ##
 { 'enum': 'VncPrimaryAuth',
   'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
-            'tls', 'vencrypt', 'sasl' ] }
+            'tls', 'vencrypt', 'sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncVencryptSubAuth:
@@ -466,8 +471,8 @@
             'tls-none',  'x509-none',
             'tls-vnc',   'x509-vnc',
             'tls-plain', 'x509-plain',
-            'tls-sasl',  'x509-sasl' ] }
-
+            'tls-sasl',  'x509-sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncServerInfo2:
@@ -484,8 +489,8 @@
 { 'struct': 'VncServerInfo2',
   'base': 'VncBasicInfo',
   'data': { 'auth'      : 'VncPrimaryAuth',
-            '*vencrypt' : 'VncVencryptSubAuth' } }
-
+            '*vencrypt' : 'VncVencryptSubAuth' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncInfo2:
@@ -517,7 +522,8 @@
             'clients'   : ['VncClientInfo'],
             'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth',
-            '*display'  : 'str' } }
+            '*display'  : 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @query-vnc:
@@ -548,8 +554,8 @@
 #    }
 #
 ##
-{ 'command': 'query-vnc', 'returns': 'VncInfo' }
-
+{ 'command': 'query-vnc', 'returns': 'VncInfo',
+  'if': 'defined(CONFIG_VNC)' }
 ##
 # @query-vnc-servers:
 #
@@ -559,7 +565,8 @@
 #
 # Since: 2.3
 ##
-{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
+{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @change-vnc-password:
@@ -573,7 +580,8 @@
 # Notes:  An empty password in this command will set the password to the=
 empty
 #         string.  Existing clients are unaffected by executing this com=
mand.
 ##
-{ 'command': 'change-vnc-password', 'data': {'password': 'str'} }
+{ 'command': 'change-vnc-password', 'data': {'password': 'str'},
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_CONNECTED:
@@ -602,7 +610,8 @@
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncBasicInfo' } }
+            'client': 'VncBasicInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_INITIALIZED:
@@ -629,7 +638,8 @@
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_DISCONNECTED:
@@ -655,7 +665,8 @@
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # =3D Input
diff --git a/ui/vnc.h b/ui/vnc.h
index 694cf32ca9..5572bfdc9e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -291,7 +291,9 @@ struct VncState
     bool encode_ws;
     bool websocket;
=20
+#ifdef CONFIG_VNC
     VncClientInfo *info;
+#endif
=20
     Buffer output;
     Buffer input;
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index d8c811fd33..647850843e 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -35,17 +35,22 @@ struct QCryptoCipherBuiltinAES {
     QCryptoCipherBuiltinAESContext key_tweak;
     uint8_t iv[AES_BLOCK_SIZE];
 };
+
+#ifdef CONFIG_VNC
 typedef struct QCryptoCipherBuiltinDESRFB QCryptoCipherBuiltinDESRFB;
 struct QCryptoCipherBuiltinDESRFB {
     uint8_t *key;
     size_t nkey;
 };
+#endif
=20
 typedef struct QCryptoCipherBuiltin QCryptoCipherBuiltin;
 struct QCryptoCipherBuiltin {
     union {
         QCryptoCipherBuiltinAES aes;
+#ifdef CONFIG_VNC
         QCryptoCipherBuiltinDESRFB desrfb;
+#endif
     } state;
     size_t blocksize;
     void (*free)(QCryptoCipher *cipher);
@@ -403,7 +408,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm a=
lg,
                              QCryptoCipherMode mode)
 {
     switch (alg) {
+#ifdef CONFIG_VNC
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+#endif
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
@@ -449,9 +456,11 @@ static QCryptoCipherBuiltin *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
     }
=20
     switch (alg) {
+#ifdef CONFIG_VNC
     case QCRYPTO_CIPHER_ALG_DES_RFB:
         ctxt =3D qcrypto_cipher_init_des_rfb(mode, key, nkey, errp);
         break;
+#endif
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
     case QCRYPTO_CIPHER_ALG_AES_256:
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c
index 10d75da75d..c240aaee26 100644
--- a/crypto/cipher-gcrypt.c
+++ b/crypto/cipher-gcrypt.c
@@ -29,7 +29,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg=
,
                              QCryptoCipherMode mode)
 {
     switch (alg) {
+#ifdef CONFIG_VNC
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+#endif
     case QCRYPTO_CIPHER_ALG_3DES:
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
@@ -114,10 +116,11 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(=
QCryptoCipherAlgorithm alg,
     }
=20
     switch (alg) {
+#ifdef CONFIG_VNC
     case QCRYPTO_CIPHER_ALG_DES_RFB:
         gcryalg =3D GCRY_CIPHER_DES;
         break;
-
+#endif
     case QCRYPTO_CIPHER_ALG_3DES:
         gcryalg =3D GCRY_CIPHER_3DES;
         break;
@@ -181,6 +184,7 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         }
     }
=20
+#ifdef CONFIG_VNC
     if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB) {
         /* We're using standard DES cipher from gcrypt, so we need
          * to munge the key so that the results are the same as the
@@ -190,7 +194,9 @@ static QCryptoCipherGcrypt *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
         err =3D gcry_cipher_setkey(ctx->handle, rfbkey, nkey);
         g_free(rfbkey);
         ctx->blocksize =3D 8;
-    } else {
+    } else
+#endif /* CONFIG_VNC */
+    {
         if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
             nkey /=3D 2;
             err =3D gcry_cipher_setkey(ctx->handle, key, nkey);
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c
index 3848cb3b3a..ace5ec20f6 100644
--- a/crypto/cipher-nettle.c
+++ b/crypto/cipher-nettle.c
@@ -67,6 +67,7 @@ static void aes_decrypt_native(cipher_ctx_t ctx, cipher=
_length_t length,
     aes_decrypt(&aesctx->dec, length, dst, src);
 }
=20
+#ifdef CONFIG_VNC
 static void des_encrypt_native(cipher_ctx_t ctx, cipher_length_t length,
                                uint8_t *dst, const uint8_t *src)
 {
@@ -78,6 +79,7 @@ static void des_decrypt_native(cipher_ctx_t ctx, cipher=
_length_t length,
 {
     des_decrypt(ctx, length, dst, src);
 }
+#endif
=20
 static void des3_encrypt_native(cipher_ctx_t ctx, cipher_length_t length=
,
                                 uint8_t *dst, const uint8_t *src)
@@ -141,6 +143,7 @@ static void aes_decrypt_wrapper(const void *ctx, size=
_t length,
     aes_decrypt(&aesctx->dec, length, dst, src);
 }
=20
+#ifdef CONFIG_VNC
 static void des_encrypt_wrapper(const void *ctx, size_t length,
                                 uint8_t *dst, const uint8_t *src)
 {
@@ -152,6 +155,7 @@ static void des_decrypt_wrapper(const void *ctx, size=
_t length,
 {
     des_decrypt(ctx, length, dst, src);
 }
+#endif
=20
 static void des3_encrypt_wrapper(const void *ctx, size_t length,
                                 uint8_t *dst, const uint8_t *src)
@@ -221,7 +225,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm a=
lg,
                              QCryptoCipherMode mode)
 {
     switch (alg) {
+#ifdef CONFIG_VNC
     case QCRYPTO_CIPHER_ALG_DES_RFB:
+#endif
     case QCRYPTO_CIPHER_ALG_3DES:
     case QCRYPTO_CIPHER_ALG_AES_128:
     case QCRYPTO_CIPHER_ALG_AES_192:
@@ -271,7 +277,6 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
                                                    Error **errp)
 {
     QCryptoCipherNettle *ctx;
-    uint8_t *rfbkey;
=20
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
@@ -292,7 +297,9 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
     ctx =3D g_new0(QCryptoCipherNettle, 1);
=20
     switch (alg) {
-    case QCRYPTO_CIPHER_ALG_DES_RFB:
+#ifdef CONFIG_VNC
+    case QCRYPTO_CIPHER_ALG_DES_RFB: {
+        uint8_t *rfbkey;
         ctx->ctx =3D g_new0(struct des_ctx, 1);
         rfbkey =3D qcrypto_cipher_munge_des_rfb_key(key, nkey);
         des_set_key(ctx->ctx, rfbkey);
@@ -305,7 +312,8 @@ static QCryptoCipherNettle *qcrypto_cipher_ctx_new(QC=
ryptoCipherAlgorithm alg,
=20
         ctx->blocksize =3D DES_BLOCK_SIZE;
         break;
-
+    }
+#endif
     case QCRYPTO_CIPHER_ALG_3DES:
         ctx->ctx =3D g_new0(struct des3_ctx, 1);
         des3_set_key(ctx->ctx, key);
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 0aad9d6d79..80355f4530 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -28,7 +28,9 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] =3D =
{
     [QCRYPTO_CIPHER_ALG_AES_128] =3D 16,
     [QCRYPTO_CIPHER_ALG_AES_192] =3D 24,
     [QCRYPTO_CIPHER_ALG_AES_256] =3D 32,
+#ifdef CONFIG_VNC
     [QCRYPTO_CIPHER_ALG_DES_RFB] =3D 8,
+#endif
     [QCRYPTO_CIPHER_ALG_3DES] =3D 24,
     [QCRYPTO_CIPHER_ALG_CAST5_128] =3D 16,
     [QCRYPTO_CIPHER_ALG_SERPENT_128] =3D 16,
@@ -43,7 +45,9 @@ static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] =3D=
 {
     [QCRYPTO_CIPHER_ALG_AES_128] =3D 16,
     [QCRYPTO_CIPHER_ALG_AES_192] =3D 16,
     [QCRYPTO_CIPHER_ALG_AES_256] =3D 16,
+#ifdef CONFIG_VNC
     [QCRYPTO_CIPHER_ALG_DES_RFB] =3D 8,
+#endif
     [QCRYPTO_CIPHER_ALG_3DES] =3D 8,
     [QCRYPTO_CIPHER_ALG_CAST5_128] =3D 8,
     [QCRYPTO_CIPHER_ALG_SERPENT_128] =3D 16,
@@ -106,8 +110,11 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo=
rithm alg,
     }
=20
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
-        if (alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB
-                || alg =3D=3D QCRYPTO_CIPHER_ALG_3DES) {
+        if (
+#ifdef CONFIG_VNC
+            alg =3D=3D QCRYPTO_CIPHER_ALG_DES_RFB ||
+#endif
+            alg =3D=3D QCRYPTO_CIPHER_ALG_3DES) {
             error_setg(errp, "XTS mode not compatible with DES-RFB/3DES"=
);
             return false;
         }
@@ -131,6 +138,7 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgor=
ithm alg,
     return true;
 }
=20
+#if defined(CONFIG_VNC)
 #if defined(CONFIG_GCRYPT) || defined(CONFIG_NETTLE)
 static uint8_t *
 qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
@@ -148,6 +156,7 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
     return ret;
 }
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
+#endif /* CONFIG_VNC */
=20
 #ifdef CONFIG_GCRYPT
 #include "crypto/cipher-gcrypt.c"
diff --git a/hmp.c b/hmp.c
index cd046c6d71..5893e5bf16 100644
--- a/hmp.c
+++ b/hmp.c
@@ -604,6 +604,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict *q=
dict)
     qapi_free_BlockStatsList(stats_list);
 }
=20
+#ifdef CONFIG_VNC
 /* Helper for hmp_info_vnc_clients, _servers */
 static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
                                   const char *name)
@@ -691,6 +692,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
     qapi_free_VncInfo2List(info2l);
=20
 }
+#endif
=20
 #ifdef CONFIG_SPICE
 void hmp_info_spice(Monitor *mon, const QDict *qdict)
@@ -1702,12 +1704,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
=20
+#ifdef CONFIG_VNC
 static void hmp_change_read_arg(void *opaque, const char *password,
                                 void *readline_opaque)
 {
     qmp_change_vnc_password(password, NULL);
     monitor_read_command(opaque, 1);
 }
+#endif
=20
 void hmp_change(Monitor *mon, const QDict *qdict)
 {
@@ -1718,6 +1722,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     BlockdevChangeReadOnlyMode read_only_mode =3D 0;
     Error *err =3D NULL;
=20
+#ifdef CONFIG_VNC
     if (strcmp(device, "vnc") =3D=3D 0) {
         if (read_only) {
             monitor_printf(mon,
@@ -1732,7 +1737,9 @@ void hmp_change(Monitor *mon, const QDict *qdict)
             }
         }
         qmp_change("vnc", target, !!arg, arg, &err);
-    } else {
+    } else
+#endif
+    {
         if (read_only) {
             read_only_mode =3D
                 qapi_enum_parse(&BlockdevChangeReadOnlyMode_lookup,
diff --git a/qmp.c b/qmp.c
index b86201e349..2c90dacb56 100644
--- a/qmp.c
+++ b/qmp.c
@@ -130,22 +130,6 @@ void qmp_cpu_add(int64_t id, Error **errp)
     }
 }
=20
-#ifndef CONFIG_VNC
-/* If VNC support is enabled, the "true" query-vnc command is
-   defined in the VNC subsystem */
-VncInfo *qmp_query_vnc(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-    return NULL;
-};
-
-VncInfo2List *qmp_query_vnc_servers(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-    return NULL;
-};
-#endif
-
 #ifndef CONFIG_SPICE
 /*
  * qmp-commands.hx ensures that QMP command query-spice exists only
@@ -403,23 +387,17 @@ static void qmp_change_vnc(const char *target, bool=
 has_arg, const char *arg,
         qmp_change_vnc_listen(target, errp);
     }
 }
-#else
-void qmp_change_vnc_password(const char *password, Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-}
-static void qmp_change_vnc(const char *target, bool has_arg, const char =
*arg,
-                           Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
-}
 #endif /* !CONFIG_VNC */
=20
 void qmp_change(const char *device, const char *target,
                 bool has_arg, const char *arg, Error **errp)
 {
     if (strcmp(device, "vnc") =3D=3D 0) {
+#ifdef CONFIG_VNC
         qmp_change_vnc(target, has_arg, arg, errp);
+#else
+        error_setg(errp, QERR_FEATURE_DISABLED, "vnc");
+#endif
     } else {
         qmp_blockdev_change_medium(true, device, false, NULL, target,
                                    has_arg, arg, false, 0, errp);
diff --git a/tests/test-crypto-cipher.c b/tests/test-crypto-cipher.c
index 07fa2fa616..5980b27389 100644
--- a/tests/test-crypto-cipher.c
+++ b/tests/test-crypto-cipher.c
@@ -149,6 +149,7 @@ static QCryptoCipherTestData test_data[] =3D {
             "39f23369a9d9bacfa530e26304231461"
             "b2eb05e2c39be9fcda6c19078c6a9d1b",
     },
+#ifdef CONFIG_VNC
     {
         .path =3D "/crypto/cipher/des-rfb-ecb-56",
         .alg =3D QCRYPTO_CIPHER_ALG_DES_RFB,
@@ -165,6 +166,7 @@ static QCryptoCipherTestData test_data[] =3D {
             "ffd29f1bb5596ad94ea2d8e6196b7f09"
             "30d8ed0bf2773af36dd82a6280c20926",
     },
+#endif
 #if defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT)
     {
         /* Borrowed from linux-kernel crypto/testmgr.h */
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 4ab7fcee98..aece8c5999 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -420,6 +420,7 @@ STEXI
 Show which guest mouse is receiving events.
 ETEXI
=20
+#if defined(CONFIG_VNC)
     {
         .name       =3D "vnc",
         .args_type  =3D "",
@@ -427,6 +428,7 @@ ETEXI
         .help       =3D "show the vnc server status",
         .cmd        =3D hmp_info_vnc,
     },
+#endif
=20
 STEXI
 @item info vnc
--=20
2.14.1.146.gd35faa819
