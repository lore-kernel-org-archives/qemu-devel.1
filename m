Received: from eggs.gnu.org ([2001:4830:134:3::10]:55285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JR-000858-Hx
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JP-00073Y-9Q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JP-00072O-03
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55890859FA
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:27:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:46 +0200
Message-Id: <20170822132255.23945-46-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 45/54] qapi: add conditions to VNC
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

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
 qapi-schema.json        | 34 ++++++++++++++++++++++------------
 qapi/crypto.json        |  3 ++-
 qapi/event.json         |  9 ++++++---
 crypto/cipher-builtin.c |  9 +++++++++
 crypto/cipher-gcrypt.c  | 10 ++++++++--
 crypto/cipher-nettle.c  | 14 +++++++++++---
 crypto/cipher.c         | 13 +++++++++++--
 hmp.c                   |  9 ++++++++-
 qmp.c                   | 30 ++++--------------------------
 hmp-commands-info.hx    |  2 ++
 10 files changed, 83 insertions(+), 50 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 802ea53d00..4ffbe1d9ff 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1660,7 +1660,8 @@
   'data': { 'host': 'str',
             'service': 'str',
             'family': 'NetworkAddressFamily',
-            'websocket': 'bool' } }
+            'websocket': 'bool' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncServerInfo:
@@ -1674,7 +1675,8 @@
 ##
 { 'struct': 'VncServerInfo',
   'base': 'VncBasicInfo',
-  'data': { '*auth': 'str' } }
+  'data': { '*auth': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncClientInfo:
@@ -1691,7 +1693,8 @@
 ##
 { 'struct': 'VncClientInfo',
   'base': 'VncBasicInfo',
-  'data': { '*x509_dname': 'str', '*sasl_username': 'str' } }
+  'data': { '*x509_dname': 'str', '*sasl_username': 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncInfo:
@@ -1732,7 +1735,8 @@
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
@@ -1743,7 +1747,8 @@
 ##
 { 'enum': 'VncPrimaryAuth',
   'data': [ 'none', 'vnc', 'ra2', 'ra2ne', 'tight', 'ultra',
-            'tls', 'vencrypt', 'sasl' ] }
+            'tls', 'vencrypt', 'sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VncVencryptSubAuth:
@@ -1757,7 +1762,8 @@
             'tls-none',  'x509-none',
             'tls-vnc',   'x509-vnc',
             'tls-plain', 'x509-plain',
-            'tls-sasl',  'x509-sasl' ] }
+            'tls-sasl',  'x509-sasl' ],
+  'if': 'defined(CONFIG_VNC)' }
=20
=20
 ##
@@ -1775,7 +1781,8 @@
 { 'struct': 'VncServerInfo2',
   'base': 'VncBasicInfo',
   'data': { 'auth'      : 'VncPrimaryAuth',
-            '*vencrypt' : 'VncVencryptSubAuth' } }
+            '*vencrypt' : 'VncVencryptSubAuth' },
+  'if': 'defined(CONFIG_VNC)' }
=20
=20
 ##
@@ -1808,7 +1815,8 @@
             'clients'   : ['VncClientInfo'],
             'auth'      : 'VncPrimaryAuth',
             '*vencrypt' : 'VncVencryptSubAuth',
-            '*display'  : 'str' } }
+            '*display'  : 'str' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @query-vnc:
@@ -1839,7 +1847,8 @@
 #    }
 #
 ##
-{ 'command': 'query-vnc', 'returns': 'VncInfo' }
+{ 'command': 'query-vnc', 'returns': 'VncInfo',
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @query-vnc-servers:
@@ -1850,7 +1859,8 @@
 #
 # Since: 2.3
 ##
-{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
+{ 'command': 'query-vnc-servers', 'returns': ['VncInfo2'],
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @SpiceBasicInfo:
@@ -3077,8 +3087,8 @@
 # Notes:  An empty password in this command will set the password to the=
 empty
 #         string.  Existing clients are unaffected by executing this com=
mand.
 ##
-{ 'command': 'change-vnc-password', 'data': {'password': 'str'} }
-
+{ 'command': 'change-vnc-password', 'data': {'password': 'str'},
+  'if': 'defined(CONFIG_VNC)' }
 ##
 # @change:
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6b6fde367a..b9bfff202c 100644
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
diff --git a/qapi/event.json b/qapi/event.json
index 6d22b025cc..c8b8e9f384 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -263,7 +263,8 @@
 ##
 { 'event': 'VNC_CONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncBasicInfo' } }
+            'client': 'VncBasicInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_INITIALIZED:
@@ -290,7 +291,8 @@
 ##
 { 'event': 'VNC_INITIALIZED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @VNC_DISCONNECTED:
@@ -316,7 +318,8 @@
 ##
 { 'event': 'VNC_DISCONNECTED',
   'data': { 'server': 'VncServerInfo',
-            'client': 'VncClientInfo' } }
+            'client': 'VncClientInfo' },
+  'if': 'defined(CONFIG_VNC)' }
=20
 ##
 # @SPICE_CONNECTED:
diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index e956cc5a53..647bcf3247 100644
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
index 3e46ee7502..18c01ca424 100644
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
index 5e70c7984a..7b14f23f7e 100644
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
index 43291cba7e..3e39882b7c 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -29,7 +29,9 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] =3D =
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
@@ -44,7 +46,9 @@ static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] =3D=
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
@@ -107,8 +111,11 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo=
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
@@ -132,6 +139,7 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgor=
ithm alg,
     return true;
 }
=20
+#if defined(CONFIG_VNC)
 #if defined(CONFIG_GCRYPT) || defined(CONFIG_NETTLE)
 static uint8_t *
 qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
@@ -149,6 +157,7 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
     return ret;
 }
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
+#endif /* CONFIG_VNC */
=20
 #ifdef CONFIG_GCRYPT
 #include "crypto/cipher-gcrypt.c"
diff --git a/hmp.c b/hmp.c
index 0eb318f938..bb0a695f2d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -620,6 +620,7 @@ void hmp_info_blockstats(Monitor *mon, const QDict *q=
dict)
     qapi_free_BlockStatsList(stats_list);
 }
=20
+#ifdef CONFIG_VNC
 /* Helper for hmp_info_vnc_clients, _servers */
 static void hmp_info_VncBasicInfo(Monitor *mon, VncBasicInfo *info,
                                   const char *name)
@@ -708,6 +709,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
     qapi_free_VncInfo2List(info2l);
=20
 }
+#endif
=20
 #ifdef CONFIG_SPICE
 void hmp_info_spice(Monitor *mon, const QDict *qdict)
@@ -1718,12 +1720,14 @@ void hmp_eject(Monitor *mon, const QDict *qdict)
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
@@ -1734,6 +1738,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     BlockdevChangeReadOnlyMode read_only_mode =3D 0;
     Error *err =3D NULL;
=20
+#ifdef CONFIG_VNC
     if (strcmp(device, "vnc") =3D=3D 0) {
         if (read_only) {
             monitor_printf(mon,
@@ -1748,7 +1753,9 @@ void hmp_change(Monitor *mon, const QDict *qdict)
             }
         }
         qmp_change("vnc", target, !!arg, arg, &err);
-    } else {
+    } else
+#endif
+    {
         if (read_only) {
             read_only_mode =3D qapi_enum_parse(&BlockdevChangeReadOnlyMo=
de_lookup,
                 read_only, BLOCKDEV_CHANGE_READ_ONLY_MODE_RETAIN, &err);
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
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index d9df238a5f..2fb7a556a3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -419,6 +419,7 @@ STEXI
 Show which guest mouse is receiving events.
 ETEXI
=20
+#if defined(CONFIG_VNC)
     {
         .name       =3D "vnc",
         .args_type  =3D "",
@@ -426,6 +427,7 @@ ETEXI
         .help       =3D "show the vnc server status",
         .cmd        =3D hmp_info_vnc,
     },
+#endif
=20
 STEXI
 @item info vnc
--=20
2.14.1.146.gd35faa819
