Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A213EC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69519206B9
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY7hTwOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69519206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk0l-0005X4-Iz
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvG-0005Mb-Ie
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvF-0001tp-87
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IReM5vr2YU9Za6UX44VSSvjguZ4B2J9+rjpPtlOS9DE=;
 b=OY7hTwOUOB0h3fQnm3VBKQX8NgjncriwMvMWtwDsDFZSfy34ANvrKgQwixvR7jbqejIR4b
 L0iqK8pWnsoqSZbGZb/Qdv1ttcZCk/kkxzCAU5OC5VYRIiF2zwJ9gyyLxT80pS+Y+RelSw
 kDVg3Yru5q0z/lYWkmfopv/KQbEXDyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-iRBLGE6_Og-MP4gq6eVpBw-1; Thu, 07 May 2020 13:02:53 -0400
X-MC-Unique: iRBLGE6_Og-MP4gq6eVpBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7971800D4A;
 Thu,  7 May 2020 17:02:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50CE610013BD;
 Thu,  7 May 2020 17:02:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 10/12] migration/xbzrle: add encoding rate
Date: Thu,  7 May 2020 18:02:09 +0100
Message-Id: <20200507170211.238283-11-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Wang <wei.w.wang@intel.com>

Users may need to check the xbzrle encoding rate to know if the guest
memory is xbzrle encoding-friendly, and dynamically turn off the
encoding if the encoding rate is low.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Message-Id: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c |  1 +
 migration/ram.c       | 39 +++++++++++++++++++++++++++++++++++++--
 monitor/hmp-cmds.c    |  2 ++
 qapi/migration.json   |  5 ++++-
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f5dbffc442..0bb042a0f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -932,6 +932,7 @@ static void populate_ram_info(MigrationInfo *info, Migr=
ationState *s)
         info->xbzrle_cache->pages =3D xbzrle_counters.pages;
         info->xbzrle_cache->cache_miss =3D xbzrle_counters.cache_miss;
         info->xbzrle_cache->cache_miss_rate =3D xbzrle_counters.cache_miss=
_rate;
+        info->xbzrle_cache->encoding_rate =3D xbzrle_counters.encoding_rat=
e;
         info->xbzrle_cache->overflow =3D xbzrle_counters.overflow;
     }
=20
diff --git a/migration/ram.c b/migration/ram.c
index 08eb382f53..859f835f1a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -327,6 +327,10 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
+    /* Amount of xbzrle pages since the beginning of the period */
+    uint64_t xbzrle_pages_prev;
+    /* Amount of xbzrle encoded bytes since the beginning of the period */
+    uint64_t xbzrle_bytes_prev;
=20
     /* compression statistics since the beginning of the period */
     /* amount of count that no free thread to compress data */
@@ -710,6 +714,18 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **cu=
rrent_data,
         return -1;
     }
=20
+    /*
+     * Reaching here means the page has hit the xbzrle cache, no matter wh=
at
+     * encoding result it is (normal encoding, overflow or skipping the pa=
ge),
+     * count the page as encoded. This is used to caculate the encoding ra=
te.
+     *
+     * Example: 2 pages (8KB) being encoded, first page encoding generates=
 2KB,
+     * 2nd page turns out to be skipped (i.e. no new bytes written to the
+     * page), the overall encoding rate will be 8KB / 2KB =3D 4, which has=
 the
+     * skipped page included. In this way, the encoding rate can tell if t=
he
+     * guest page is good for xbzrle encoding.
+     */
+    xbzrle_counters.pages++;
     prev_cached_page =3D get_cached_data(XBZRLE.cache, current_addr);
=20
     /* save current buffer into memory */
@@ -740,6 +756,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **cur=
rent_data,
     } else if (encoded_len =3D=3D -1) {
         trace_save_xbzrle_page_overflow();
         xbzrle_counters.overflow++;
+        xbzrle_counters.bytes +=3D TARGET_PAGE_SIZE;
         return -1;
     }
=20
@@ -750,8 +767,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **cu=
rrent_data,
     qemu_put_be16(rs->f, encoded_len);
     qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle +=3D encoded_len + 1 + 2;
-    xbzrle_counters.pages++;
-    xbzrle_counters.bytes +=3D bytes_xbzrle;
+    /*
+     * Like compressed_size (please see update_compress_thread_counts),
+     * the xbzrle encoded bytes don't count the 8 byte header with
+     * RAM_SAVE_FLAG_CONTINUE.
+     */
+    xbzrle_counters.bytes +=3D bytes_xbzrle - 8;
     ram_counters.transferred +=3D bytes_xbzrle;
=20
     return 1;
@@ -884,9 +905,23 @@ static void migration_update_rates(RAMState *rs, int64=
_t end_time)
     }
=20
     if (migrate_use_xbzrle()) {
+        double encoded_size, unencoded_size;
+
         xbzrle_counters.cache_miss_rate =3D (double)(xbzrle_counters.cache=
_miss -
             rs->xbzrle_cache_miss_prev) / page_count;
         rs->xbzrle_cache_miss_prev =3D xbzrle_counters.cache_miss;
+        unencoded_size =3D (xbzrle_counters.pages - rs->xbzrle_pages_prev)=
 *
+                         TARGET_PAGE_SIZE;
+        encoded_size =3D xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
+        if (xbzrle_counters.pages =3D=3D rs->xbzrle_pages_prev) {
+            xbzrle_counters.encoding_rate =3D 0;
+        } else if (!encoded_size) {
+            xbzrle_counters.encoding_rate =3D UINT64_MAX;
+        } else {
+            xbzrle_counters.encoding_rate =3D unencoded_size / encoded_siz=
e;
+        }
+        rs->xbzrle_pages_prev =3D xbzrle_counters.pages;
+        rs->xbzrle_bytes_prev =3D xbzrle_counters.bytes;
     }
=20
     if (migrate_use_compression()) {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ade1f85e0c..9c61e769ca 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -303,6 +303,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->xbzrle_cache->cache_miss);
         monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
                        info->xbzrle_cache->cache_miss_rate);
+        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
+                       info->xbzrle_cache->encoding_rate);
         monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
                        info->xbzrle_cache->overflow);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index ee6c5a0cae..d5000558c6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -70,6 +70,8 @@
 #
 # @cache-miss-rate: rate of cache miss (since 2.1)
 #
+# @encoding-rate: rate of encoded bytes (since 5.1)
+#
 # @overflow: number of overflows
 #
 # Since: 1.2
@@ -77,7 +79,7 @@
 { 'struct': 'XBZRLECacheStats',
   'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
            'cache-miss': 'int', 'cache-miss-rate': 'number',
-           'overflow': 'int' } }
+           'encoding-rate': 'number', 'overflow': 'int' } }
=20
 ##
 # @CompressionStats:
@@ -337,6 +339,7 @@
 #             "pages":2444343,
 #             "cache-miss":2244,
 #             "cache-miss-rate":0.123,
+#             "encoding-rate":80.1,
 #             "overflow":34434
 #          }
 #       }
--=20
2.26.2


