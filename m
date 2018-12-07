Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJYR-0005hZ-Bc
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJYO-0005Gd-Rj
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVJYO-0005Ex-Gs
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 12:04:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88ABB307DAC7
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 17:04:39 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  7 Dec 2018 18:03:58 +0100
Message-Id: <20181207170400.5129-5-philmd@redhat.com>
In-Reply-To: <20181207170400.5129-1-philmd@redhat.com>
References: <20181207170400.5129-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] hw/nvram/fw_cfg: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c     | 5 +++++
 hw/nvram/trace-events | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3cb726ff68..582653f07e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -627,6 +627,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, =
uint16_t key,
=20
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t le=
n)
 {
+    trace_fw_cfg_add_bytes(key, len);
     fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true)=
;
 }
=20
@@ -634,6 +635,7 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, c=
onst char *value)
 {
     size_t sz =3D strlen(value) + 1;
=20
+    trace_fw_cfg_add_string(key, value);
     fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
 }
=20
@@ -643,6 +645,7 @@ void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint=
16_t value)
=20
     copy =3D g_malloc(sizeof(value));
     *copy =3D cpu_to_le16(value);
+    trace_fw_cfg_add_i16(key, value);
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
@@ -662,6 +665,7 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint=
32_t value)
=20
     copy =3D g_malloc(sizeof(value));
     *copy =3D cpu_to_le32(value);
+    trace_fw_cfg_add_i32(key, value);
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
@@ -671,6 +675,7 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint=
64_t value)
=20
     copy =3D g_malloc(sizeof(value));
     *copy =3D cpu_to_le64(value);
+    trace_fw_cfg_add_i64(key, value);
     fw_cfg_add_bytes(s, key, copy, sizeof(value));
 }
=20
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 6b55ba7a09..0ee0f8d04a 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -7,4 +7,9 @@ nvram_write(uint32_t addr, uint32_t old, uint32_t val) "w=
rite addr %d: 0x%02x ->
 # hw/nvram/fw_cfg.c
 fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d =3D %d"
 fw_cfg_read(void *s, uint64_t ret) "%p =3D 0x%"PRIx64
+fw_cfg_add_bytes(uint16_t key, size_t len) "key 0x%04" PRIx16 " (%zu byt=
es)"
 fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %s =
(%zd bytes)"
+fw_cfg_add_string(uint16_t key, const char *value) "key 0x%04" PRIx16 ",=
 value '%s'"
+fw_cfg_add_i16(uint16_t key, uint32_t value) "key 0x%04" PRIx16 ", value=
 0x%" PRIx32
+fw_cfg_add_i32(uint16_t key, uint32_t value) "key 0x%04" PRIx16 ", value=
 0x%" PRIx32
+fw_cfg_add_i64(uint16_t key, uint64_t value) "key 0x%04" PRIx16 ", value=
 0x%" PRIx64
--=20
2.17.2
