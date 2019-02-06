Received: from eggs.gnu.org ([209.51.188.92]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIl-00005q-D7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIk-0007xx-GK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:07 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:47 +0100
Message-Id: <20190206195551.28893-5-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/8] qapi: Formalize qcow2 encryption probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

Currently, you can give no encryption format for a qcow2 file while
still passing a key-secret.  That does not conform to the schema, so
this patch changes the schema to allow it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 31 ++++++++++++++++++++++++++++---
 block/qcow2.c        |  3 +++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5f17d67d71..abf9af0c4d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -47,6 +47,9 @@
 ##
 # @ImageInfoSpecificQCow2Encryption:
 #
+# @format will never be "auto", as this pseudo-format just tells the
+# qcow2 driver to read the actual format from the image header.
+#
 # Since: 2.10
 ##
 { 'union': 'ImageInfoSpecificQCow2Encryption',
@@ -2961,10 +2964,30 @@
 # @BlockdevQcow2EncryptionFormat:
 # @aes: AES-CBC with plain64 initialization venctors
 #
+# @auto:            Determine the encryption format from the image
+#                   header.  This only allows the use of the
+#                   key-secret option.  (Since: 4.0)
+#
 # Since: 2.10
 ##
 { 'enum': 'BlockdevQcow2EncryptionFormat',
-  'data': [ 'aes', 'luks' ] }
+  'data': [ 'aes', 'luks', 'auto' ] }
+
+##
+# @BlockdevQcow2EncryptionSecret:
+#
+# Allows specifying a key-secret without specifying the exact
+# encryption format, which is determined automatically from the image
+# header.
+#
+# @key-secret:      The ID of a QCryptoSecret object providing the
+#                   decryption key.  Mandatory except when probing
+#                   image for metadata only.
+#
+# Since: 4.0
+##
+{ 'struct': 'BlockdevQcow2EncryptionSecret',
+  'data': { '*key-secret': 'str' } }
=20
 ##
 # @BlockdevQcow2Encryption:
@@ -2972,10 +2995,12 @@
 # Since: 2.10
 ##
 { 'union': 'BlockdevQcow2Encryption',
-  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
+  'base': { '*format': 'BlockdevQcow2EncryptionFormat' },
   'discriminator': 'format',
+  'default-variant': 'auto',
   'data': { 'aes': 'QCryptoBlockOptionsQCow',
-            'luks': 'QCryptoBlockOptionsLUKS'} }
+            'luks': 'QCryptoBlockOptionsLUKS',
+            'auto': 'BlockdevQcow2EncryptionSecret' } }
=20
 ##
 # @BlockdevOptionsQcow2:
diff --git a/block/qcow2.c b/block/qcow2.c
index c21452bc2f..5885f5175e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -883,6 +883,9 @@ static int qcow2_update_options_prepare(BlockDriverSt=
ate *bs,
=20
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
     encryptfmt =3D qdict_get_try_str(encryptopts, "format");
+    if (!g_strcmp0(encryptfmt, "auto")) {
+        encryptfmt =3D NULL;
+    }
=20
     opts =3D qemu_opts_create(&qcow2_runtime_opts, NULL, 0, &error_abort=
);
     qemu_opts_absorb_qdict(opts, options, &local_err);
--=20
2.20.1
