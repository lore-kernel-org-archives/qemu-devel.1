Received: from eggs.gnu.org ([209.51.188.92]:48915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2mdM-0001EO-Kz
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2mdL-0006WF-So
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2mdL-0006Vj-Ik
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:48:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB1B9A85F
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 00:48:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun, 10 Mar 2019 01:47:46 +0100
Message-Id: <20190310004749.27029-2-philmd@redhat.com>
In-Reply-To: <20190310004749.27029-1-philmd@redhat.com>
References: <20190310004749.27029-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/4] hw/nvram/fw_cfg: Add
 fw_cfg_add_file_from_host()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Add a function to read the full content of file on the host, and add
a new 'file' name item to the fw_cfg device.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: s/ptr/data, corrected documentation (Laszlo)
v3: inverted the if() logic
---
 hw/nvram/fw_cfg.c         | 21 +++++++++++++++++++++
 include/hw/nvram/fw_cfg.h | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7fdf04adc9..2a345bfd5c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -826,6 +826,27 @@ void fw_cfg_add_file(FWCfgState *s,  const char *fil=
ename,
     fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, t=
rue);
 }
=20
+void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
+                                const char *host_path, size_t *len)
+{
+    GError *gerr =3D NULL;
+    gchar *data =3D NULL;
+    gsize contents_len =3D 0;
+
+    if (!g_file_get_contents(host_path, &data, &contents_len, &gerr)) {
+        error_report("%s", gerr->message);
+        g_error_free(gerr);
+        return NULL;
+    }
+    fw_cfg_add_file(s, filename, data, contents_len);
+
+    if (len) {
+        *len =3D contents_len;
+    }
+
+    return data;
+}
+
 void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
                         void *data, size_t len)
 {
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f5a6895a74..7c4dbe2a2a 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -166,6 +166,29 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uin=
t64_t value);
 void fw_cfg_add_file(FWCfgState *s, const char *filename, void *data,
                      size_t len);
=20
+/**
+ * fw_cfg_add_file_from_host:
+ * @s: fw_cfg device being modified
+ * @filename: name of new fw_cfg file item
+ * @host_path: path of the host file to read the data from
+ * @len: pointer to hold the length of the host file (optional)
+ *
+ * Read the content of a host file as a raw "blob" then add a new NAMED
+ * fw_cfg item of the file size. If @len is provided, it will contain th=
e
+ * total length read from the host file. The data read from the host
+ * filesystem is owned by the new fw_cfg entry, and is stored into the d=
ata
+ * structure of the fw_cfg device.
+ * The next available (unused) selector key starting at FW_CFG_FILE_FIRS=
T
+ * will be used; also, a new entry will be added to the file directory
+ * structure residing at key value FW_CFG_FILE_DIR, containing the item =
name,
+ * data size, and assigned selector key value.
+ *
+ * Returns: pointer to the newly allocated file content, or NULL if an e=
rror
+ * occured. The returned pointer must be freed with g_free().
+ */
+void *fw_cfg_add_file_from_host(FWCfgState *s, const char *filename,
+                                const char *host_path, size_t *len);
+
 /**
  * fw_cfg_add_file_callback:
  * @s: fw_cfg device being modified
--=20
2.20.1
