Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A315C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27718206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuM52CfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27718206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jipOE-0003XI-Dz
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 21:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMs-0001jP-52
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMo-00033E-HQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591751841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sbb5NIHlkIoe04XoUF9mQEBQAX1DqP/DIziu20cSf1E=;
 b=WuM52CfK6ltT6rKg8zpbS4tk1kJr4yZD4qNsM8GDNNTt729qhwqaplghY3TC/1jlEwr7LD
 4LCiN2w8/W/3W5nT/YDIMC6tCorRzVcfZkhesaVsc0ezeeeUcRFSDWK5QLpKRLeY+7MDc1
 tvu+HXkH1gd9C/EjsEYJghK2l97fLGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-9aEyk3D4MlGMaEACjAkCeg-1; Tue, 09 Jun 2020 21:17:20 -0400
X-MC-Unique: 9aEyk3D4MlGMaEACjAkCeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F39388014D9;
 Wed, 10 Jun 2020 01:17:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 841545C1BD;
 Wed, 10 Jun 2020 01:17:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] block: Call attention to truncation of long NBD exports
Date: Tue,  9 Jun 2020 20:17:13 -0500
Message-Id: <20200610011713.3687895-4-eblake@redhat.com>
In-Reply-To: <20200610011713.3687895-1-eblake@redhat.com>
References: <20200610011713.3687895-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Xueqiang Wei <xuwei@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
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
Message-Id: <20200608182638.3256473-3-eblake@redhat.com>
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


