Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B610FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED3220661
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlHK10J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED3220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucfl-0004x6-9x
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9R-0002tb-FQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9Q-0005R5-4C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9Q-0005Q9-0T
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pucqjnQfkQgODQBaQLuvW2l9M7uY/arYC5AvJoD6Bd0=;
 b=hlHK10J7oJdGEtaG7hLHYcacEHa2/MWAwU1HQK9csjF/zfXQYoeg/pTtbjE7cBH5CXoXJJ
 r7bJ/bf9904/uS6xAKBx2ZvoZu6Ecf2Wn4f0me2Pdvy68FRT/jXVP6ejekdGoBqDuG0GmE
 lu+yA2CW3hBizm1u2IHPNAJLJHmvYQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-zSTtl874Mri2JQvO3lArQQ-1; Thu, 23 Jan 2020 06:59:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5F42800D54
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD571CB;
 Thu, 23 Jan 2020 11:59:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 055/111] virtiofsd: Drop CAP_FSETID if client asked for it
Date: Thu, 23 Jan 2020 11:57:45 +0000
Message-Id: <20200123115841.138849-56-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zSTtl874Mri2JQvO3lArQQ-1
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
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 105 +++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 97e7c75667..d53cb1e005 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -201,6 +201,91 @@ static int load_capng(void)
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
@@ -1577,6 +1662,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t i=
no,
     (void)ino;
     ssize_t res;
     struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf))=
;
+    bool cap_fsetid_dropped =3D false;
=20
     out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
     out_buf.buf[0].fd =3D lo_fi_fd(req, fi);
@@ -1588,12 +1674,31 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t=
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
     res =3D fuse_buf_copy(&out_buf, in_buf);
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


