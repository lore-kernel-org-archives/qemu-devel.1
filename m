Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C57C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCE0206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD6rT1+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCE0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LwQ-0002wj-At
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 16:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2Lrv-0005tc-6r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2Lrs-0005QL-Sj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2Lrr-0005DP-KC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 16:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581628669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkfYwI2C4vHahJx6He54R00GSRjiN6IZ4DdNh9BTD00=;
 b=SD6rT1+nYqmuDxfMxt/Z+Id4CGTeHePC6/Cc52ynyp9L0UeZgtRYuxcOrUVtxyuzB7bwID
 mZLVb1f/SaBTsDaE1hZkftDVGbodNXHlO0uyAId0Ufy4yoChD7ZL7e76J8xA0t6fFAyBH0
 xcW8LWmjjSQuuTl/te8DacjGLr0ECHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-ukL0Sv2fPHSUaAyHaIgltA-1; Thu, 13 Feb 2020 16:17:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFB31800D41;
 Thu, 13 Feb 2020 21:17:46 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC3FE19C7F;
 Thu, 13 Feb 2020 21:17:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 8/8] multifd: Add zstd compression multifd support
Date: Thu, 13 Feb 2020 22:17:09 +0100
Message-Id: <20200213211709.59065-9-quintela@redhat.com>
In-Reply-To: <20200213211709.59065-1-quintela@redhat.com>
References: <20200213211709.59065-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ukL0Sv2fPHSUaAyHaIgltA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/core/qdev-properties.c    |   2 +-
 migration/Makefile.objs      |   1 +
 migration/multifd-zstd.c     | 339 +++++++++++++++++++++++++++++++++++
 migration/multifd.h          |   1 +
 migration/ram.c              |   1 -
 qapi/migration.json          |   4 +-
 tests/qtest/migration-test.c |  10 ++
 7 files changed, 355 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-zstd.c

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index db2a7abfb2..2047114fca 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -645,7 +645,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
 const PropertyInfo qdev_prop_multifd_compression =3D {
     .name =3D "MultiFDCompression",
     .description =3D "multifd_compression values, "
-                   "none/zlib",
+                   "none/zlib/zstd",
     .enum_table =3D &MultiFDCompression_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 0308caa5c5..0fc619e380 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -9,6 +9,7 @@ common-obj-y +=3D qjson.o
 common-obj-y +=3D block-dirty-bitmap.o
 common-obj-y +=3D multifd.o
 common-obj-y +=3D multifd-zlib.o
+common-obj-$(CONFIG_ZSTD) +=3D multifd-zstd.o
=20
 common-obj-$(CONFIG_RDMA) +=3D rdma.o
=20
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
new file mode 100644
index 0000000000..693bddf8c9
--- /dev/null
+++ b/migration/multifd-zstd.c
@@ -0,0 +1,339 @@
+/*
+ * Multifd zlib compression implementation
+ *
+ * Copyright (c) 2020 Red Hat Inc
+ *
+ * Authors:
+ *  Juan Quintela <quintela@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <zstd.h>
+#include "qemu/rcu.h"
+#include "exec/target_page.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "trace.h"
+#include "multifd.h"
+
+struct zstd_data {
+    /* stream for compression */
+    ZSTD_CStream *zcs;
+    /* stream for decompression */
+    ZSTD_DStream *zds;
+    /* buffers */
+    ZSTD_inBuffer in;
+    ZSTD_outBuffer out;
+    /* compressed buffer */
+    uint8_t *zbuff;
+    /* size of compressed buffer */
+    uint32_t zbuff_len;
+};
+
+/* Multifd zstd compression */
+
+/**
+ * zstd_send_setup: setup send side
+ *
+ * Setup each channel with zstd compression.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    struct zstd_data *z =3D g_new0(struct zstd_data, 1);
+    int res;
+
+    p->data =3D z;
+    z->zcs =3D ZSTD_createCStream();
+    if (!z->zcs) {
+        g_free(z);
+        error_setg(errp, "multifd %d: zstd createCStream failed", p->id);
+        return -1;
+    }
+
+    res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());
+    if (ZSTD_isError(res)) {
+        ZSTD_freeCStream(z->zcs);
+        g_free(z);
+        error_setg(errp, "multifd %d: initCStream failed with error %s",
+                   p->id, ZSTD_getErrorName(res));
+        return -1;
+    }
+    /* We will never have more than page_count pages */
+    z->zbuff_len =3D page_count * qemu_target_page_size();
+    z->zbuff_len *=3D 2;
+    z->zbuff =3D g_try_malloc(z->zbuff_len);
+    if (!z->zbuff) {
+        ZSTD_freeCStream(z->zcs);
+        g_free(z);
+        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
+        return -1;
+    }
+    return 0;
+}
+
+/**
+ * zstd_send_cleanup: cleanup send side
+ *
+ * Close the channel and return memory.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    struct zstd_data *z =3D p->data;
+
+    ZSTD_freeCStream(z->zcs);
+    z->zcs =3D NULL;
+    g_free(z->zbuff);
+    z->zbuff =3D NULL;
+    g_free(p->data);
+    p->data =3D NULL;
+}
+
+/**
+ * zstd_send_prepare: prepare date to be able to send
+ *
+ * Create a compressed buffer with all the pages that we are going to
+ * send.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ */
+static int zstd_send_prepare(MultiFDSendParams *p, uint32_t used, Error **=
errp)
+{
+    struct iovec *iov =3D p->pages->iov;
+    struct zstd_data *z =3D p->data;
+    int ret;
+    uint32_t i;
+
+    z->out.dst =3D z->zbuff;
+    z->out.size =3D z->zbuff_len;
+    z->out.pos =3D 0;
+
+    for (i =3D 0; i < used; i++) {
+        ZSTD_EndDirective flush =3D ZSTD_e_continue;
+
+        if (i =3D=3D used - 1) {
+            flush =3D ZSTD_e_flush;
+        }
+        z->in.src =3D iov[i].iov_base;
+        z->in.size =3D iov[i].iov_len;
+        z->in.pos =3D 0;
+
+        /*
+         * Welcome to compressStream2 semantics
+         *
+         * We need to loop while:
+         * - return is > 0
+         * - there is input available
+         * - there is output space free
+         */
+        do {
+            ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);
+        } while (ret > 0 && (z->in.size - z->in.pos > 0)
+                         && (z->out.size - z->out.pos > 0));
+        if (ret > 0 && (z->in.size - z->in.pos > 0)) {
+            error_setg(errp, "multifd %d: compressStream buffer too small"=
,
+                       p->id);
+            return -1;
+        }
+        if (ZSTD_isError(ret)) {
+            error_setg(errp, "multifd %d: compressStream error %s",
+                       p->id, ZSTD_getErrorName(ret));
+            return -1;
+        }
+    }
+    p->next_packet_size =3D z->out.pos;
+    p->flags |=3D MULTIFD_FLAG_ZSTD;
+
+    return 0;
+}
+
+/**
+ * zstd_send_write: do the actual write of the data
+ *
+ * Do the actual write of the comprresed buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int zstd_send_write(MultiFDSendParams *p, uint32_t used, Error **er=
rp)
+{
+    struct zstd_data *z =3D p->data;
+
+    return qio_channel_write_all(p->c, (void *)z->zbuff, p->next_packet_si=
ze,
+                                 errp);
+}
+
+/**
+ * zstd_recv_setup: setup receive side
+ *
+ * Create the compressed channel and buffer.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
+    struct zstd_data *z =3D g_new0(struct zstd_data, 1);
+    int ret;
+
+    p->data =3D z;
+    z->zds =3D ZSTD_createDStream();
+    if (!z->zds) {
+        g_free(z);
+        error_setg(errp, "multifd %d: zstd createDStream failed", p->id);
+        return -1;
+    }
+
+    ret =3D ZSTD_initDStream(z->zds);
+    if (ZSTD_isError(ret)) {
+        ZSTD_freeDStream(z->zds);
+        g_free(z);
+        error_setg(errp, "multifd %d: initDStream failed with error %s",
+                   p->id, ZSTD_getErrorName(ret));
+        return -1;
+    }
+
+    /* We will never have more than page_count pages */
+    z->zbuff_len =3D page_count * qemu_target_page_size();
+    /* We know compression "could" use more space */
+    z->zbuff_len *=3D 2;
+    z->zbuff =3D g_try_malloc(z->zbuff_len);
+    if (!z->zbuff) {
+        ZSTD_freeDStream(z->zds);
+        g_free(z);
+        error_setg(errp, "multifd %d: out of memory for zbuff", p->id);
+        return -1;
+    }
+    return 0;
+}
+
+/**
+ * zstd_recv_cleanup: setup receive side
+ *
+ * For no compression this function does nothing.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void zstd_recv_cleanup(MultiFDRecvParams *p)
+{
+    struct zstd_data *z =3D p->data;
+
+    ZSTD_freeDStream(z->zds);
+    z->zds =3D NULL;
+    g_free(z->zbuff);
+    z->zbuff =3D NULL;
+    g_free(p->data);
+    p->data =3D NULL;
+}
+
+/**
+ * zstd_recv_pages: read the data from the channel into actual pages
+ *
+ * Read the compressed buffer, and uncompress it into the actual
+ * pages.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int zstd_recv_pages(MultiFDRecvParams *p, uint32_t used, Error **er=
rp)
+{
+    uint32_t in_size =3D p->next_packet_size;
+    uint32_t out_size =3D 0;
+    uint32_t expected_size =3D used * qemu_target_page_size();
+    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    struct zstd_data *z =3D p->data;
+    int ret;
+    int i;
+
+    if (flags !=3D MULTIFD_FLAG_ZSTD) {
+        error_setg(errp, "multifd %d: flags received %x flags expected %x"=
,
+                   p->id, flags, MULTIFD_FLAG_ZSTD);
+        return -1;
+    }
+    ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp);
+
+    if (ret !=3D 0) {
+        return ret;
+    }
+
+    z->in.src =3D z->zbuff;
+    z->in.size =3D in_size;
+    z->in.pos =3D 0;
+
+    for (i =3D 0; i < used; i++) {
+        struct iovec *iov =3D &p->pages->iov[i];
+
+        z->out.dst =3D iov->iov_base;
+        z->out.size =3D iov->iov_len;
+        z->out.pos =3D 0;
+
+        /*
+         * Welcome to decompressStream semantics
+         *
+         * We need to loop while:
+         * - return is > 0
+         * - there is input available
+         * - we haven't put out a full page
+         */
+        do {
+            ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);
+        } while (ret > 0 && (z->in.size - z->in.pos > 0)
+                         && (z->out.pos < iov->iov_len));
+        if (ret > 0 && (z->out.pos < iov->iov_len)) {
+            error_setg(errp, "multifd %d: decompressStream buffer too smal=
l",
+                       p->id);
+            return -1;
+        }
+        if (ZSTD_isError(ret)) {
+            error_setg(errp, "multifd %d: decompressStream returned %s",
+                       p->id, ZSTD_getErrorName(ret));
+            return ret;
+        }
+        out_size +=3D z->out.pos;
+    }
+    if (out_size !=3D expected_size) {
+        error_setg(errp, "multifd %d: packet size received %d size expecte=
d %d",
+                   p->id, out_size, expected_size);
+        return -1;
+    }
+    return 0;
+}
+
+static MultiFDMethods multifd_zstd_ops =3D {
+    .send_setup =3D zstd_send_setup,
+    .send_cleanup =3D zstd_send_cleanup,
+    .send_prepare =3D zstd_send_prepare,
+    .send_write =3D zstd_send_write,
+    .recv_setup =3D zstd_recv_setup,
+    .recv_cleanup =3D zstd_recv_cleanup,
+    .recv_pages =3D zstd_recv_pages
+};
+
+static void multifd_zstd_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_ZSTD, &multifd_zstd_ops);
+}
+
+migration_init(multifd_zstd_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index c6dad7b990..448a03d89a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -31,6 +31,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_=
addr_t offset);
 /* we need to be compatible. Before compression value was 0 */
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
+#define MULTIFD_FLAG_ZSTD (2 << 1)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/migration/ram.c b/migration/ram.c
index 73a141bb60..0ef68798d2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -28,7 +28,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include <zlib.h>
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
diff --git a/qapi/migration.json b/qapi/migration.json
index 1fba695e2e..0fd41823d3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -495,12 +495,14 @@
 #
 # @none: no compression.
 # @zlib: use zlib compression method.
+# @zstd: use zstd compression method.
 #
 # Since: 5.0
 #
 ##
 { 'enum': 'MultiFDCompression',
-  'data': [ 'none', 'zlib' ] }
+  'data': [ 'none', 'zlib',
+            { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
=20
 ##
 # @MigrationParameter:
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 90c26e879f..3d6cc83b88 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1328,6 +1328,13 @@ static void test_multifd_tcp_zlib(void)
     test_multifd_tcp("zlib");
 }
=20
+#ifdef CONFIG_ZSTD
+static void test_multifd_tcp_zstd(void)
+{
+    test_multifd_tcp("zstd");
+}
+#endif
+
 /*
  * This test does:
  *  source               target
@@ -1492,6 +1499,9 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
     qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_cance=
l);
     qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);
+#ifdef CONFIG_ZSTD
+    qtest_add_func("/migration/multifd/tcp/zstd", test_multifd_tcp_zstd);
+#endif
=20
     ret =3D g_test_run();
=20
--=20
2.24.1


