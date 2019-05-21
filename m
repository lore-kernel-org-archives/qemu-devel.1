Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2370C04AAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632D02173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 03:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632D02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSv9O-0008TS-F1
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 23:09:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSv8X-0008Cq-Fs
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hSv8W-0001QA-4I
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:08:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:62490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hSv8V-0001PJ-RB
	for qemu-devel@nongnu.org; Mon, 20 May 2019 23:08:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 May 2019 20:08:17 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 20 May 2019 20:08:15 -0700
Date: Tue, 21 May 2019 11:07:45 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190521030745.GA24543@richard>
References: <20190515121544.4597-1-quintela@redhat.com>
	<20190515121544.4597-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515121544.4597-8-quintela@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH v3 7/8] multifd: Add zlib compression
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 02:15:43PM +0200, Juan Quintela wrote:
>Signed-off-by: Juan Quintela <quintela@redhat.com>
>---
> hw/core/qdev-properties.c |  2 +-
> migration/migration.c     |  9 ++++++++
> migration/migration.h     |  1 +
> migration/ram.c           | 47 +++++++++++++++++++++++++++++++++++++++
> qapi/migration.json       |  2 +-
> tests/migration-test.c    |  6 +++++
> 6 files changed, 65 insertions(+), 2 deletions(-)
>
>diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>index ebeeb5c88d..e40aa806e2 100644
>--- a/hw/core/qdev-properties.c
>+++ b/hw/core/qdev-properties.c
>@@ -651,7 +651,7 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
> const PropertyInfo qdev_prop_multifd_compress = {
>     .name = "MultifdCompress",
>     .description = "multifd_compress values, "
>-                   "none",
>+                   "none/zlib",
>     .enum_table = &MultifdCompress_lookup,
>     .get = get_enum,
>     .set = set_enum,
>diff --git a/migration/migration.c b/migration/migration.c
>index d6f8ef342a..69d85cbe5e 100644
>--- a/migration/migration.c
>+++ b/migration/migration.c
>@@ -2141,6 +2141,15 @@ bool migrate_use_multifd(void)
>     return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIFD];
> }
> 
>+bool migrate_use_multifd_zlib(void)
>+{
>+    MigrationState *s;
>+
>+    s = migrate_get_current();
>+
>+    return s->parameters.multifd_compress == MULTIFD_COMPRESS_ZLIB;
>+}
>+
> bool migrate_pause_before_switchover(void)
> {
>     MigrationState *s;
>diff --git a/migration/migration.h b/migration/migration.h
>index 438f17edad..fc4fb841d4 100644
>--- a/migration/migration.h
>+++ b/migration/migration.h
>@@ -269,6 +269,7 @@ bool migrate_ignore_shared(void);
> 
> bool migrate_auto_converge(void);
> bool migrate_use_multifd(void);
>+bool migrate_use_multifd_zlib(void);
> bool migrate_pause_before_switchover(void);
> int migrate_multifd_channels(void);
> 
>diff --git a/migration/ram.c b/migration/ram.c
>index 6679e4f213..fdb5bf07a5 100644
>--- a/migration/ram.c
>+++ b/migration/ram.c
>@@ -582,6 +582,7 @@ exit:
> #define MULTIFD_VERSION 1
> 
> #define MULTIFD_FLAG_SYNC (1 << 0)
>+#define MULTIFD_FLAG_ZLIB (1 << 1)
> 

If no one use this in this patch, prefer to put it where it will be used.

> /* This value needs to be a multiple of qemu_target_page_size() */
> #define MULTIFD_PACKET_SIZE (512 * 1024)
>@@ -663,6 +664,12 @@ typedef struct {
>     uint64_t num_pages;
>     /* syncs main thread and channels */
>     QemuSemaphore sem_sync;
>+    /* stream for compression */
>+    z_stream zs;
>+    /* compressed buffer */
>+    uint8_t *zbuff;
>+    /* size of compressed buffer */
>+    uint32_t zbuff_len;
> }  MultiFDSendParams;
> 
> typedef struct {
>@@ -698,6 +705,12 @@ typedef struct {
>     uint64_t num_pages;
>     /* syncs main thread and channels */
>     QemuSemaphore sem_sync;
>+    /* stream for compression */
>+    z_stream zs;
>+    /* compressed buffer */
>+    uint8_t *zbuff;
>+    /* size of compressed buffer */
>+    uint32_t zbuff_len;
> } MultiFDRecvParams;
> 
> typedef struct {
>@@ -1071,6 +1084,9 @@ void multifd_save_cleanup(void)
>         p->packet_len = 0;
>         g_free(p->packet);
>         p->packet = NULL;
>+        deflateEnd(&p->zs);
>+        g_free(p->zbuff);
>+        p->zbuff = NULL;
>     }
>     qemu_sem_destroy(&multifd_send_state->channels_ready);
>     qemu_sem_destroy(&multifd_send_state->sem_sync);
>@@ -1240,6 +1256,7 @@ int multifd_save_setup(void)
> 
>     for (i = 0; i < thread_count; i++) {
>         MultiFDSendParams *p = &multifd_send_state->params[i];
>+        z_stream *zs = &p->zs;
> 
>         qemu_mutex_init(&p->mutex);
>         qemu_sem_init(&p->sem, 0);
>@@ -1253,6 +1270,17 @@ int multifd_save_setup(void)
>         p->packet = g_malloc0(p->packet_len);
>         p->name = g_strdup_printf("multifdsend_%d", i);
>         socket_send_channel_create(multifd_new_send_channel_async, p);
>+        zs->zalloc = Z_NULL;
>+        zs->zfree = Z_NULL;
>+        zs->opaque = Z_NULL;

Since zlib is not default option, is it better to setup these when zlib is
set?

>+        if (deflateInit(zs, migrate_compress_level()) != Z_OK) {
>+            printf("deflate init failed\n");
>+            return -1;
>+        }
>+        /* We will never have more than page_count pages */
>+        p->zbuff_len = page_count * qemu_target_page_size();
>+        p->zbuff_len *= 2;
>+        p->zbuff = g_malloc0(p->zbuff_len);
>     }
>     return 0;
> }
>@@ -1322,6 +1350,9 @@ int multifd_load_cleanup(Error **errp)
>         p->packet_len = 0;
>         g_free(p->packet);
>         p->packet = NULL;
>+        inflateEnd(&p->zs);
>+        g_free(p->zbuff);
>+        p->zbuff = NULL;
>     }
>     qemu_sem_destroy(&multifd_recv_state->sem_sync);
>     g_free(multifd_recv_state->params);
>@@ -1440,6 +1471,7 @@ int multifd_load_setup(void)
> 
>     for (i = 0; i < thread_count; i++) {
>         MultiFDRecvParams *p = &multifd_recv_state->params[i];
>+        z_stream *zs = &p->zs;
> 
>         qemu_mutex_init(&p->mutex);
>         qemu_sem_init(&p->sem_sync, 0);
>@@ -1449,6 +1481,21 @@ int multifd_load_setup(void)
>                       + sizeof(ram_addr_t) * page_count;
>         p->packet = g_malloc0(p->packet_len);
>         p->name = g_strdup_printf("multifdrecv_%d", i);
>+
>+        zs->zalloc = Z_NULL;
>+        zs->zfree = Z_NULL;
>+        zs->opaque = Z_NULL;
>+        zs->avail_in = 0;
>+        zs->next_in = Z_NULL;
>+        if (inflateInit(zs) != Z_OK) {
>+            printf("inflate init failed\n");
>+            return -1;
>+        }
>+        /* We will never have more than page_count pages */
>+        p->zbuff_len = page_count * qemu_target_page_size();
>+        /* We know compression "could" use more space */
>+        p->zbuff_len *= 2;
>+        p->zbuff = g_malloc0(p->zbuff_len);
>     }
>     return 0;
> }
>diff --git a/qapi/migration.json b/qapi/migration.json
>index 8ec1944b7a..e6c27fae06 100644
>--- a/qapi/migration.json
>+++ b/qapi/migration.json
>@@ -493,7 +493,7 @@
> #
> ##
> { 'enum': 'MultifdCompress',
>-  'data': [ 'none' ] }
>+  'data': [ 'none', 'zlib' ] }
> 
> ##
> # @MigrationParameter:
>diff --git a/tests/migration-test.c b/tests/migration-test.c
>index 8a1ccc2516..2dd4d4c5b4 100644
>--- a/tests/migration-test.c
>+++ b/tests/migration-test.c
>@@ -1119,6 +1119,11 @@ static void test_multifd_tcp_none(void)
>     test_multifd_tcp("none");
> }
> 
>+static void test_multifd_tcp_zlib(void)
>+{
>+    test_multifd_tcp("zlib");
>+}
>+
> int main(int argc, char **argv)
> {
>     char template[] = "/tmp/migration-test-XXXXXX";
>@@ -1174,6 +1179,7 @@ int main(int argc, char **argv)
>     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
>     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
>     qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
>+    qtest_add_func("/migration/multifd/tcp/zlib", test_multifd_tcp_zlib);

Actually zlib is not enabled at this moment, the test here may not touch the
real functionality.

> 
>     ret = g_test_run();
> 
>-- 
>2.21.0
>

-- 
Wei Yang
Help you, Help me

