Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341BFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E234A21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gK3h/Vq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E234A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOpO-0007ow-4w
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOev-0003Bi-N6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOet-0005yp-PF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOet-0005xa-K2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K73i1xFaBt3L7a/Q1hsX6M6ZSoHf01uwOXYScWoiKYw=;
 b=gK3h/Vq479sCGWZXnnW+BhY+TfSquoMK+BxbWPZu++8B7d+/wGOaxVn2xV+hgIt8RpHTvq
 yanQ7q9E+R9CMtqrsnTIqf3KgJKi8KIyMYhmirtfQyMQfTkrPn7Wxn7WCbY9qc8pv7kC+R
 2xCNpOWW0qu5t9gI7GFPXdGGs3zpqY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Z3pq1oYDOX2oOltm7lOfrA-1; Tue, 17 Dec 2019 21:01:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5469107ACC5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:48 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A091919C58;
 Wed, 18 Dec 2019 02:01:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] migration: Add zstd compression multifd support
Date: Wed, 18 Dec 2019 03:01:19 +0100
Message-Id: <20191218020119.3776-11-quintela@redhat.com>
In-Reply-To: <20191218020119.3776-1-quintela@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Z3pq1oYDOX2oOltm7lOfrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev-properties.c |   2 +-
 migration/ram.c           | 288 ++++++++++++++++++++++++++++++++++++++
 qapi/migration.json       |   2 +-
 tests/migration-test.c    |   6 +
 4 files changed, 296 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index e8ff317a60..b75467704f 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -654,7 +654,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
 const PropertyInfo qdev_prop_multifd_compress =3D {
     .name =3D "MultifdCompress",
     .description =3D "multifd_compress values, "
-                   "none/zlib",
+                   "none/zlib/zstd",
     .enum_table =3D &MultifdCompress_lookup,
     .get =3D get_enum,
     .set =3D set_enum,
diff --git a/migration/ram.c b/migration/ram.c
index 5006d719b4..db90237977 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -29,6 +29,9 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include <zlib.h>
+#ifdef CONFIG_ZSTD
+#include <zstd.h>
+#endif
 #include "qemu/cutils.h"
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
@@ -584,6 +587,7 @@ exit:
 #define MULTIFD_FLAG_SYNC (1 << 0)
 #define MULTIFD_FLAG_NOCOMP (1 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 2)
+#define MULTIFD_FLAG_ZSTD (1 << 3)
=20
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
@@ -635,6 +639,22 @@ struct zlib_data {
     uint32_t zbuff_len;
 };
=20
+#ifdef CONFIG_ZSTD
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
+#endif
+
 typedef struct {
     /* this fields are not changed once the thread is created */
     /* channel number */
@@ -1109,9 +1129,277 @@ static MultiFDMethods multifd_zlib_ops =3D {
     .recv_pages =3D zlib_recv_pages
 };
=20
+#ifdef CONFIG_ZSTD
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
+                   p->id, MULTIFD_FLAG_ZSTD, p->flags);
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
+#endif /* CONFIG_ZSTD */
+
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESS__MAX] =3D {
     [MULTIFD_COMPRESS_NONE] =3D &multifd_nocomp_ops,
     [MULTIFD_COMPRESS_ZLIB] =3D &multifd_zlib_ops,
+#ifdef CONFIG_ZSTD
+    [MULTIFD_COMPRESS_ZSTD] =3D &multifd_zstd_ops,
+#endif
 };
=20
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 0e3a3db8d0..1b827e55b6 100644
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
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 8985e05c69..7588f50b9b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -1465,6 +1465,11 @@ static void test_multifd_tcp_zlib(void)
     test_multifd_tcp("zlib");
 }
=20
+static void test_multifd_tcp_zstd(void)
+{
+    test_multifd_tcp("zstd");
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1531,6 +1536,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/auto_converge", test_migrate_auto_converge)=
;
     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
     qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);
+    qtest_add_func("/migration/multifd/tcp/zstd", test_multifd_tcp_zstd);
=20
     ret =3D g_test_run();
=20
--=20
2.23.0


