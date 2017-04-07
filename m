Received: from eggs.gnu.org ([2001:4830:134:3::10]:34889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwV2O-0003IG-DH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwV2K-00059w-7N
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwV2J-00059d-U9
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE9A963E25
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:38:50 +0000 (UTC)
Received: from work-vm (ovpn-116-136.ams2.redhat.com [10.36.116.136])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E4B118235
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 14:38:49 +0000 (UTC)
Date: Fri, 7 Apr 2017 15:38:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407143847.GM2138@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,
   Fedora 26 has gcc 7.0.1 which has the normal compliment
of new fussy warnings; so far I've posted :

tests/check-qdict: Fix missing brackets
slirp/smb: Replace constant strings by glib string

that fix one actual mistake and work around something it's being
fussy over.

But I've also got a pile of hacks, attached below that I'm
not too sure what I'll do with them yet, but they're attached
for anyone else trying to build.  Note they're smoke-only-tested.

I also have gcc bug https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D80346
filed for what I reckon is a couple of overly pessimistic warnings.

Enjoy,

Dave

=46rom 15353ce59e35e1d85927138982241491ea65cee2 Mon Sep 17 00:00:00 2001
=46rom: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Thu, 6 Apr 2017 15:44:50 +0100
Subject: [HACK!] Hacks for f26 build

---
 block/blkdebug.c         | 4 ++--
 block/blkverify.c        | 4 ++--
 hw/usb/bus.c             | 5 +++--
 include/qemu/iov.h       | 4 ++--
 tests/bios-tables-test.c | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 67e8024e36..34c645d095 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -689,9 +689,9 @@ static void blkdebug_refresh_filename(BlockDriverState =
*bs, QDict *options)
     }
=20
     if (!force_json && bs->file->bs->exact_filename[0]) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+        g_assert_cmpint(snprintf(bs->exact_filename, sizeof(bs->exact_file=
name),
                  "blkdebug:%s:%s", s->config_file ?: "",
-                 bs->file->bs->exact_filename);
+                 bs->file->bs->exact_filename), <, sizeof(bs->exact_filena=
me));
     }
=20
     opts =3D qdict_new();
diff --git a/block/blkverify.c b/block/blkverify.c
index 9a1e21c6ad..d038947a5a 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -305,10 +305,10 @@ static void blkverify_refresh_filename(BlockDriverSta=
te *bs, QDict *options)
     if (bs->file->bs->exact_filename[0]
         && s->test_file->bs->exact_filename[0])
     {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+        g_assert_cmpint(snprintf(bs->exact_filename, sizeof(bs->exact_file=
name),
                  "blkverify:%s:%s",
                  bs->file->bs->exact_filename,
-                 s->test_file->bs->exact_filename);
+                 s->test_file->bs->exact_filename), <, sizeof(bs->exact_fi=
lename));
     }
 }
=20
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 24f1608b4b..6023f3b419 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -8,6 +8,7 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include "qemu/cutils.h"
+#include <glib.h>
=20
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
=20
@@ -407,8 +408,8 @@ void usb_register_companion(const char *masterbus, USBP=
ort *ports[],
 void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr)
 {
     if (upstream) {
-        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
-                 upstream->path, portnr);
+        g_assert_cmpint(snprintf(downstream->path, sizeof(downstream->path=
), "%s.%d",
+                 upstream->path, portnr), <, sizeof(downstream->path));
         downstream->hubcount =3D upstream->hubcount + 1;
     } else {
         snprintf(downstream->path, sizeof(downstream->path), "%d", portnr);
diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index bd9fd55b0a..ebb0221140 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -46,7 +46,7 @@ static inline size_t
 iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
              size_t offset, const void *buf, size_t bytes)
 {
-    if (__builtin_constant_p(bytes) && iov_cnt &&
+    if (__builtin_constant_p(bytes) && iov_cnt && bytes <=3D INT_MAX &&
         offset <=3D iov[0].iov_len && bytes <=3D iov[0].iov_len - offset) {
         memcpy(iov[0].iov_base + offset, buf, bytes);
         return bytes;
@@ -59,7 +59,7 @@ static inline size_t
 iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
            size_t offset, void *buf, size_t bytes)
 {
-    if (__builtin_constant_p(bytes) && iov_cnt &&
+    if (__builtin_constant_p(bytes) && iov_cnt && bytes <=3D INT_MAX &&
         offset <=3D iov[0].iov_len && bytes <=3D iov[0].iov_len - offset) {
         memcpy(buf, iov[0].iov_base + offset, bytes);
         return bytes;
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 88dbf97853..c55de4f65b 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -98,7 +98,7 @@ static void test_acpi_rsdt_table(test_data *data)
     AcpiRsdtDescriptorRev1 *rsdt_table =3D &data->rsdt_table;
     uint32_t addr =3D data->rsdp_table.rsdt_physical_address;
     uint32_t *tables;
-    int tables_nr;
+    unsigned int tables_nr;
     uint8_t checksum;
=20
     /* read the header */
--=20
2.12.2



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
