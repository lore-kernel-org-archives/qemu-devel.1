Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0875C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7711621835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEJ9LG1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucSV-0006SD-Uu
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub9I-0002er-LH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub9G-0005KR-Ko
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub9F-0005Jk-Io
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmR++/UB7tB9YHLVfmWEjAOrZHAusU9S0A7UEFOiS+s=;
 b=OEJ9LG1AA7/JOauDVxkZPPaOWfKgEkwQqslujyqccXP+07n+Hczv6uWdWcQTZKpFfAO8D+
 /3g2WysDEzf2h8ORcfRx7SQhWazpKlj5zL6hTYwnNyL33EBsKvoRrw2qnkoDVHCC//AJoi
 OWPBQuNtA93NKdKLO6mxfge9NXa7Tx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-5y8GCWqpN1qQOTRpXvc_uA-1; Thu, 23 Jan 2020 06:59:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2AF5DB63
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:42 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C2B719C69;
 Thu, 23 Jan 2020 11:59:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 21/21] migration: Add zstd compression multifd support
Date: Thu, 23 Jan 2020 12:58:31 +0100
Message-Id: <20200123115831.36842-22-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5y8GCWqpN1qQOTRpXvc_uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev-properties.c    |   2 +-
 migration/Makefile.objs      |   1 +
 migration/migration.c        |   6 +
 migration/multifd-zstd.c     | 304 +++++++++++++++++++++++++++++++++++
 migration/multifd.h          |  20 +++
 migration/ram.c              |   1 -
 qapi/migration.json          |   2 +-
 tests/qtest/migration-test.c |  10 ++
 8 files changed, 343 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-zstd.c

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 07ec75d8e3..c9c56d3123 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -647,7 +647,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
 const PropertyInfo qdev_prop_multifd_compress =3D {
     .name =3D "MultifdCompress",
     .description =3D "multifd_compress values, "
-                   "none/zlib",
+                   "none/zlib/zstd",
     .enum_table =3D &MultifdCompress_lookup,
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
diff --git a/migration/migration.c b/migration/migration.c
index d25fdb3e6b..f0d5ade1df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1256,6 +1256,12 @@ static bool migrate_params_check(MigrationParameters=
 *params, Error **errp)
                    "is invalid, it must be in the range of 1 to 10000 ms")=
;
        return false;
     }
+    if (params->has_multifd_compress &&
+       params->multifd_compress =3D=3D MULTIFD_COMPRESS_ZSTD &&
+       !multifd_compress_zstd_is_enabled()) {
+        error_setg(errp, "The multifd compression method zstd is compiled =
out");
+        return false;
+    }
     return true;
 }
=20
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
new file mode 100644
index 0000000000..d13c93d297
--- /dev/null
+++ b/migration/multifd-zstd.c
@@ -0,0 +1,304 @@
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
+    res =3D ZSTD_initCStream(z->zcs, migrate_compress_level());
+    if (ZSTD_isError(res)) {
+        ZSTD_freeCStream(z->zcs);
+        g_free(z);
+        error_setg(errp, "multifd %d: initCStream failed", p->id);
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
+        ret =3D ZSTD_compressStream2(z->zcs, &z->out, &z->in, flush);
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
+    int res;
+
+    p->data =3D z;
+    z->zds =3D ZSTD_createDStream();
+    if (!z->zds) {
+        g_free(z);
+        error_setg(errp, "multifd %d: zstd createDStream failed", p->id);
+        return -1;
+    }
+
+    res =3D ZSTD_initDStream(z->zds);
+    if (ZSTD_isError(res)) {
+        ZSTD_freeDStream(z->zds);
+        g_free(z);
+        error_setg(errp, "multifd %d: initDStream failed", p->id);
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
+    struct zstd_data *z =3D p->data;
+    int ret;
+    int i;
+
+    if (p->flags !=3D MULTIFD_FLAG_ZSTD) {
+        error_setg(errp, "multifd %d: flags received %x flags expected %x"=
,
+                   p->id, p->flags, MULTIFD_FLAG_ZSTD);
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
+        ret =3D ZSTD_decompressStream(z->zds, &z->out, &z->in);
+        if (ZSTD_isError(ret)) {
+            error_setg(errp, "multifd %d: decompressStream returned %s",
+                       p->id, ZSTD_getErrorName(ret));
+            return ret;
+        }
+        out_size +=3D iov->iov_len;
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
+    multifd_register_ops(MULTIFD_COMPRESS_ZSTD, &multifd_zstd_ops);
+}
+
+migration_init(multifd_zstd_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index 85542f3222..7ec55a4534 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -27,6 +27,7 @@ int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_=
addr_t offset);
 #define MULTIFD_FLAG_SYNC (1 << 0)
 #define MULTIFD_FLAG_NOCOMP (1 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 2)
+#define MULTIFD_FLAG_ZSTD (1 << 3)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
@@ -161,5 +162,24 @@ typedef struct {
=20
 void multifd_register_ops(int method, MultiFDMethods *ops);
=20
+
+/*
+ * This is gross, but we don't want to have ifdefs in migration.h
+ * And we need to know if ZSTD is compiled in to be able to know
+ * if we can setup multifd_compress with that parameter.
+ *
+ * As far as I can see there is no way to convince qapi that the value
+ * of multifd_compress is none/zlib if zstd is compiled out, or
+ * none/zlib/zstd when zstd is compiled in.
+ */
+
+static inline bool multifd_compress_zstd_is_enabled(void)
+{
+#ifdef CONFIG_ZSTD
+    return true;
+#else
+    return false;
+#endif
+}
 #endif
=20
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
index 1714ea51e3..65db85970e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -499,7 +499,7 @@
 #
 ##
 { 'enum': 'MultifdCompress',
-  'data': [ 'none', 'zlib' ] }
+  'data': [ 'none', 'zlib', 'zstd' ] }
=20
 ##
 # @MigrationParameter:
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 985a7d4b97..99eee5d891 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1318,6 +1318,13 @@ static void test_multifd_tcp_zlib(void)
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
@@ -1481,6 +1488,9 @@ int main(int argc, char **argv)
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


