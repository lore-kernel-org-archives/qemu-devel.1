Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27766C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88362051A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu/dFX7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88362051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittCX-0003QW-PY
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itseX-0000VC-J3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itseT-0003QZ-JU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:29:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itseT-0003PC-Fv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6iYJX+2+Iy0D8smU5ukjVL/qx0vBxETehkGh1p53Ys=;
 b=Zu/dFX7qOwpU8RxQpbcBbmwFzx3HqlTbr57J9Uxt5y4BE4sxANnT3JTUH6tDfUjpbLMibE
 CJMWiVs2lGcYtep3w9S1BveHcsfwJLygJIl8Rni6nblXPtpvHv0Ny6IJ+HoONsm+zF3qxc
 OzjMP3C9MxKARIgxIUiMaxrZQcoXUvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-CVdvfJcXNv-DbVi7eqTZhA-1; Tue, 21 Jan 2020 07:28:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB7A8800D41;
 Tue, 21 Jan 2020 12:28:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B481E60BE0;
 Tue, 21 Jan 2020 12:28:53 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 054/109] virtiofsd: Drop CAP_FSETID if client asked for it
Date: Tue, 21 Jan 2020 12:23:38 +0000
Message-Id: <20200121122433.50803-55-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CVdvfJcXNv-DbVi7eqTZhA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

If client requested killing setuid/setgid bits on file being written, drop
CAP_FSETID capability so that setuid/setgid bits are cleared upon write
automatically.

pjdfstest chown/12.t needs this.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
  dgilbert: reworked for libcap-ng
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 105 +++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index bf939d06ae..3f7ec85938 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -200,6 +200,91 @@ static int load_capng(void)
     return 0;
 }
=20
+/*
+ * Helpers for dropping and regaining effective capabilities. Returns 0
+ * on success, error otherwise
+ */
+static int drop_effective_cap(const char *cap_name, bool *cap_dropped)
+{
+    int cap, ret;
+
+    cap =3D capng_name_to_capability(cap_name);
+    if (cap < 0) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "capng_name_to_capability(%s) failed:%s\n",
+                 cap_name, strerror(errno));
+        goto out;
+    }
+
+    if (load_capng()) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "load_capng() failed\n");
+        goto out;
+    }
+
+    /* We dont have this capability in effective set already. */
+    if (!capng_have_capability(CAPNG_EFFECTIVE, cap)) {
+        ret =3D 0;
+        goto out;
+    }
+
+    if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE, cap)) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "capng_update(DROP,) failed\n");
+        goto out;
+    }
+
+    if (capng_apply(CAPNG_SELECT_CAPS)) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "drop:capng_apply() failed\n");
+        goto out;
+    }
+
+    ret =3D 0;
+    if (cap_dropped) {
+        *cap_dropped =3D true;
+    }
+
+out:
+    return ret;
+}
+
+static int gain_effective_cap(const char *cap_name)
+{
+    int cap;
+    int ret =3D 0;
+
+    cap =3D capng_name_to_capability(cap_name);
+    if (cap < 0) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "capng_name_to_capability(%s) failed:%s\n",
+                 cap_name, strerror(errno));
+        goto out;
+    }
+
+    if (load_capng()) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "load_capng() failed\n");
+        goto out;
+    }
+
+    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap)) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "capng_update(ADD,) failed\n");
+        goto out;
+    }
+
+    if (capng_apply(CAPNG_SELECT_CAPS)) {
+        ret =3D errno;
+        fuse_log(FUSE_LOG_ERR, "gain:capng_apply() failed\n");
+        goto out;
+    }
+    ret =3D 0;
+
+out:
+    return ret;
+}
+
 static void lo_map_init(struct lo_map *map)
 {
     map->elems =3D NULL;
@@ -1576,6 +1661,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t i=
no,
     (void)ino;
     ssize_t res;
     struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf))=
;
+    bool cap_fsetid_dropped =3D false;
=20
     out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
     out_buf.buf[0].fd =3D lo_fi_fd(req, fi);
@@ -1587,12 +1673,31 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t=
 ino,
                  out_buf.buf[0].size, (unsigned long)off);
     }
=20
+    /*
+     * If kill_priv is set, drop CAP_FSETID which should lead to kernel
+     * clearing setuid/setgid on file.
+     */
+    if (fi->kill_priv) {
+        res =3D drop_effective_cap("FSETID", &cap_fsetid_dropped);
+        if (res !=3D 0) {
+            fuse_reply_err(req, res);
+            return;
+        }
+    }
+
     res =3D fuse_buf_copy(&out_buf, in_buf, 0);
     if (res < 0) {
         fuse_reply_err(req, -res);
     } else {
         fuse_reply_write(req, (size_t)res);
     }
+
+    if (cap_fsetid_dropped) {
+        res =3D gain_effective_cap("FSETID");
+        if (res) {
+            fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
+        }
+    }
 }
=20
 static void lo_statfs(fuse_req_t req, fuse_ino_t ino)
--=20
2.24.1


