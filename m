Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD07EC2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F6121D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LF8R0xLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F6121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42929 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx1C-0002aP-6c
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:43:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwx3-0004xs-TG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwwy-0005t3-Nn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46915
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwwy-0005pz-GG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDiFPHbOFpju66FawHjji7Do0ZeX+r8QrT3pt5/E+10=;
 b=LF8R0xLMD4GX+c7JOHJiCO2j+VtwnTTGJTo9iwORLyx72Fw8Izd7+7nNa3LZReStdVEkfr
 b5Ht67fqMjLnwiSYQ06N82Yn3t5cpRPrT+y6y09SHqnuECkS9qiA0BKNcOEl2V2tfZy2cR
 wU7KJOgkdvjG6nTIOBDd8ByEb9sDVqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-ohbq6LxyP3e-E3DjW1elIA-1; Thu, 19 Dec 2019 09:38:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3A77DBEE;
 Thu, 19 Dec 2019 14:38:43 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E80F4808EE;
 Thu, 19 Dec 2019 14:38:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 05/18] fuse: Allow growable exports
Date: Thu, 19 Dec 2019 15:38:05 +0100
Message-Id: <20191219143818.1646168-6-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ohbq6LxyP3e-E3DjW1elIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These will behave more like normal files in that writes beyond the EOF
will automatically grow the export size.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/fuse.c    | 16 +++++++++++++++-
 qapi/block.json |  6 +++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/fuse.c b/block/fuse.c
index 4e662e6dfb..d7c7824815 100644
--- a/block/fuse.c
+++ b/block/fuse.c
@@ -42,6 +42,7 @@ typedef struct BdrvFuseSession {
     uint64_t perm, shared_perm;
     bool mounted, fd_handler_set_up;
     bool writable;
+    bool growable;
 } BdrvFuseSession;
=20
 static GHashTable *sessions;
@@ -59,6 +60,7 @@ static bool is_regular_file(const char *path, Error **err=
p);
=20
 void qmp_fuse_export_add(const char *node_name, const char *mountpoint,
                          bool has_writable, bool writable,
+                         bool has_growable, bool growable,
                          Error **errp)
 {
     BlockDriverState *bs;
@@ -67,6 +69,9 @@ void qmp_fuse_export_add(const char *node_name, const cha=
r *mountpoint,
     if (!has_writable) {
         writable =3D false;
     }
+    if (!has_growable) {
+        growable =3D false;
+    }
=20
     init_fuse();
=20
@@ -98,6 +103,7 @@ void qmp_fuse_export_add(const char *node_name, const ch=
ar *mountpoint,
         },
=20
         .writable =3D writable,
+        .growable =3D growable,
     };
=20
     session->perm =3D BLK_PERM_CONSISTENT_READ;
@@ -463,7 +469,15 @@ static void fuse_write(fuse_req_t req, fuse_ino_t inod=
e, const char *buf,
=20
     size =3D MIN(size, BDRV_REQUEST_MAX_BYTES);
     if (offset + size > length) {
-        size =3D length - offset;
+        if (session->growable) {
+            ret =3D fuse_do_truncate(session, offset + size, PREALLOC_MODE=
_OFF);
+            if (ret < 0) {
+                fuse_reply_err(req, -ret);
+                return;
+            }
+        } else {
+            size =3D length - offset;
+        }
     }
=20
     ret =3D blk_pwrite(session->blk, offset, buf, size, 0);
diff --git a/qapi/block.json b/qapi/block.json
index 26768dc8ef..039cbc6773 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -330,13 +330,17 @@
 # @writable: Whether clients should be able to write to the block
 #            device via the FUSE export. (default: false)
 #
+# @growable: Whether writes beyond the EOF should grow the block node
+#            fit. (default: false)
+#
 # Since: 5.0
 ##
 { 'command': 'fuse-export-add',
   'data': {
       'node-name': 'str',
       'mountpoint': 'str',
-      '*writable': 'bool'
+      '*writable': 'bool',
+      '*growable': 'bool'
   },
   'if': 'defined(CONFIG_FUSE)' }
=20
--=20
2.23.0


