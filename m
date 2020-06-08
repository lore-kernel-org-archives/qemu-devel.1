Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8749C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4468206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 18:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5GYlXPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4468206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiMWR-0004d9-RM
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 14:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiMU5-0002cx-Q1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:26:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiMU4-0008JD-TV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 14:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591640812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTBrbV00VjsBWhjyByoFXNymoQ6bqPJEnFc75E6AU+M=;
 b=U5GYlXPzQYGRJ9o/0WyERJ56mfM56F+FkXlR6MNxI+Vza8Q+B6WPoYtDzyB46CD6ZaJBhF
 ELXiwVBQ5IOm8fqOganayZSTj6kI+syFJFhjyssWxp1z5AQMy9A0pMEJQezNauJGiEaCey
 3P6F4Fcu5Nv8N9X1gkArvoQT4maoz5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-IalfSdoiMkiG_GlyzvrwmQ-1; Mon, 08 Jun 2020 14:26:51 -0400
X-MC-Unique: IalfSdoiMkiG_GlyzvrwmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2208461;
 Mon,  8 Jun 2020 18:26:49 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3459C768BB;
 Mon,  8 Jun 2020 18:26:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] block: Call attention to truncation of long NBD exports
Date: Mon,  8 Jun 2020 13:26:38 -0500
Message-Id: <20200608182638.3256473-3-eblake@redhat.com>
In-Reply-To: <20200608182638.3256473-1-eblake@redhat.com>
References: <20200608182638.3256473-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, ppandit@redhat.com,
 Max Reitz <mreitz@redhat.com>, xuwei@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 93676c88 relaxed our NBD client code to request export names up
to the NBD protocol maximum of 4096 bytes without NUL terminator, even
though the block layer can't store anything longer than 4096 bytes
including NUL terminator for display to the user.  Since this means
there are some export names where we have to truncate things, we can
at least try to make the truncation a bit more obvious for the user.
Note that in spite of the truncated display name, we can still
communicate with an NBD server using such a long export name; this was
deemed nicer than refusing to even connect to such a server (since the
server may not be under our control, and since determining our actual
length limits gets tricky when nbd://host:port/export and
nbd+unix:///export?socket=/path are themselves variable-length
expansions beyond the export name but count towards the block layer
name length).

Reported-by: Xueqiang Wei <xuwei@redhat.com>
Fixes: https://bugzilla.redhat.com/1843684
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block.c     |  7 +++++--
 block/nbd.c | 21 +++++++++++++--------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 8416376c9b71..6dbcb7e083ea 100644
--- a/block.c
+++ b/block.c
@@ -6809,8 +6809,11 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         pstrcpy(bs->filename, sizeof(bs->filename), bs->exact_filename);
     } else {
         QString *json = qobject_to_json(QOBJECT(bs->full_open_options));
-        snprintf(bs->filename, sizeof(bs->filename), "json:%s",
-                 qstring_get_str(json));
+        if (snprintf(bs->filename, sizeof(bs->filename), "json:%s",
+                     qstring_get_str(json)) >= sizeof(bs->filename)) {
+            /* Give user a hint if we truncated things. */
+            strcpy(bs->filename + sizeof(bs->filename) - 4, "...");
+        }
         qobject_unref(json);
     }
 }
diff --git a/block/nbd.c b/block/nbd.c
index 4ac23c8f6299..eed160c5cda1 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1984,6 +1984,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
     const char *host = NULL, *port = NULL, *path = NULL;
+    size_t len = 0;

     if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         const InetSocketAddress *inet = &s->saddr->u.inet;
@@ -1996,17 +1997,21 @@ static void nbd_refresh_filename(BlockDriverState *bs)
     } /* else can't represent as pseudo-filename */

     if (path && s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd+unix:///%s?socket=%s", s->export, path);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd+unix:///%s?socket=%s", s->export, path);
     } else if (path && !s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd+unix://?socket=%s", path);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd+unix://?socket=%s", path);
     } else if (host && s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd://%s:%s/%s", host, port, s->export);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd://%s:%s/%s", host, port, s->export);
     } else if (host && !s->export) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nbd://%s:%s", host, port);
+        len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
+                       "nbd://%s:%s", host, port);
+    }
+    if (len > sizeof(bs->exact_filename)) {
+        /* Name is too long to represent exactly, so leave it empty. */
+        bs->exact_filename[0] = '\0';
     }
 }

-- 
2.27.0


