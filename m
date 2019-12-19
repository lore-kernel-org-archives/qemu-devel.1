Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70932C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B66A2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxfZLZ4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B66A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx46-0006mV-PI
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwx8-00056g-66
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwx6-0006DF-Ir
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwx6-0006Ao-DT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OJdEG9K3oz1yTpyJugSSCRB3nl8CW8qYKPJyr3BmcA=;
 b=FxfZLZ4oDMrxvPdMz1lVzb9cLyav+laKpE4atrElZE3YwZ2ELGf8Hglx/Xb9+Pil8bks66
 7+foOEXa4xHVmj1DE7VoYHiykUKYGMrXuZzylTVWaza9zyAnW4usHm2FBwyGYXNKWN52Ml
 QxRBou+UuM0jJdY0iJj5L0JIIFhLJ/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-Nf6miwxqPzuPSRjn28fO6Q-1; Thu, 19 Dec 2019 09:38:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC70E80574D;
 Thu, 19 Dec 2019 14:38:51 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DCA77D9D9;
 Thu, 19 Dec 2019 14:38:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 07/18] fuse: Implement hole detection through lseek
Date: Thu, 19 Dec 2019 15:38:07 +0100
Message-Id: <20191219143818.1646168-8-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Nf6miwxqPzuPSRjn28fO6Q-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a relatively new feature in libfuse (available since 3.8.0,
which was released in November 2019), so we have to let configure check
whether it is available before making use of it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/fuse.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure    | 33 ++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/block/fuse.c b/block/fuse.c
index 018afee6cd..6b693b05b7 100644
--- a/block/fuse.c
+++ b/block/fuse.c
@@ -579,6 +579,80 @@ static void fuse_flush(fuse_req_t req, fuse_ino_t inod=
e,
     fuse_reply_err(req, ret < 0 ? -ret : 0);
 }
=20
+#ifdef CONFIG_FUSE_LSEEK
+/**
+ * Let clients inquire allocation status.
+ */
+static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
+                       int whence, struct fuse_file_info *fi)
+{
+    BdrvFuseSession *session =3D fuse_req_userdata(req);
+
+    if (whence !=3D SEEK_HOLE && whence !=3D SEEK_DATA) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    while (true) {
+        int64_t pnum;
+        int ret;
+
+        ret =3D bdrv_block_status_above(blk_bs(session->blk), NULL,
+                                      offset, INT64_MAX, &pnum, NULL, NULL=
);
+        if (ret < 0) {
+            fuse_reply_err(req, -ret);
+            return;
+        }
+
+        if (!pnum && (ret & BDRV_BLOCK_EOF)) {
+            int64_t blk_len;
+
+            /*
+             * If blk_getlength() rounds (e.g. by sectors), then the
+             * export length will be rounded, too.  However,
+             * bdrv_block_status_above() may return EOF at unaligned
+             * offsets.  We must not let this become visible and thus
+             * always simulate a hole between @offset (the real EOF)
+             * and @blk_len (the client-visible EOF).
+             */
+
+            blk_len =3D blk_getlength(session->blk);
+            if (blk_len < 0) {
+                fuse_reply_err(req, -blk_len);
+                return;
+            }
+
+            if (offset > blk_len || whence =3D=3D SEEK_DATA) {
+                fuse_reply_err(req, ENXIO);
+            } else {
+                fuse_reply_lseek(req, offset);
+            }
+            return;
+        }
+
+        if (ret & BDRV_BLOCK_DATA) {
+            if (whence =3D=3D SEEK_DATA) {
+                fuse_reply_lseek(req, offset);
+                return;
+            }
+        } else {
+            if (whence =3D=3D SEEK_HOLE) {
+                fuse_reply_lseek(req, offset);
+                return;
+            }
+        }
+
+        /* Safety check against infinite loops */
+        if (!pnum) {
+            fuse_reply_err(req, ENXIO);
+            return;
+        }
+
+        offset +=3D pnum;
+    }
+}
+#endif
+
 static const struct fuse_lowlevel_ops fuse_ops =3D {
     .lookup     =3D fuse_lookup,
     .getattr    =3D fuse_getattr,
@@ -588,4 +662,7 @@ static const struct fuse_lowlevel_ops fuse_ops =3D {
     .write      =3D fuse_write,
     .fallocate  =3D fuse_fallocate,
     .flush      =3D fuse_flush,
+#ifdef CONFIG_FUSE_LSEEK
+    .lseek      =3D fuse_lseek,
+#endif
 };
diff --git a/configure b/configure
index ff7d760a0a..18c38f111b 100755
--- a/configure
+++ b/configure
@@ -6062,11 +6062,39 @@ EOF
   fuse_libs=3D$(pkg-config --libs fuse3)
   if compile_prog "$fuse_cflags" "$fuse_libs"; then
     fuse=3Dyes
+
+    cat > $TMPC <<EOF
+#define FUSE_USE_VERSION 31
+#include <fuse.h>
+#include <fuse_lowlevel.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
+                       int whence, struct fuse_file_info *fi)
+{
+    if (whence =3D=3D SEEK_DATA || whence =3D=3D SEEK_HOLE) {
+        fuse_reply_lseek(req, offset);
+    } else {
+        fuse_reply_err(req, EINVAL);
+    }
+}
+const struct fuse_lowlevel_ops fuse_ops =3D {
+    .lseek =3D fuse_lseek,
+};
+int main(void) { return 0; }
+EOF
+    if compile_prog "$fuse_cflags" "$fuse_libs"; then
+      fuse_lseek=3Dyes
+    else
+      fuse_lseek=3Dno
+    fi
   else
     if test "$fuse" =3D "yes"; then
       feature_not_found "fuse"
     fi
     fuse=3Dno
+    fuse_lseek=3Dno
   fi
 fi
=20
@@ -6585,6 +6613,7 @@ echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
 echo "fuse exports      $fuse"
+echo "fuse lseek        $fuse_lseek"
=20
 if test "$supported_cpu" =3D "no"; then
     echo
@@ -7443,6 +7472,10 @@ if test "$fuse" =3D "yes"; then
   echo "CONFIG_FUSE=3Dy" >> $config_host_mak
   echo "FUSE_CFLAGS=3D$fuse_cflags" >> $config_host_mak
   echo "FUSE_LIBS=3D$fuse_libs" >> $config_host_mak
+
+  if test "$fuse_lseek" =3D "yes"; then
+    echo "CONFIG_FUSE_LSEEK=3Dy" >> $config_host_mak
+  fi
 fi
=20
 if test "$tcg_interpreter" =3D "yes"; then
--=20
2.23.0


