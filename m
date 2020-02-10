Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7473DC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401102080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4zpmpky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401102080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Cz4-0008JI-FF
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 12:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1CsI-0001TJ-88
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1CsG-0000hg-JR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:29:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1CsF-0000eU-GS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 12:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581355770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YXhMnsxNiHEjYcRES5pmsI9BN4cwAgVxeBvdlaTZTU=;
 b=W4zpmpkynjUMhZwet6IyPRZlPOwzEGF39S3/cKXKnCr2fyeRH+NVdpZa9XEJ9pp+PJ5NKl
 SXcxtW8Wa5flR9YWX2JuK1d3K3euim8M3ElAnz3Xz/NeJE8aHsFV6P2be3VRnb6S8MAcV/
 YYQijSW9gpBbkwHg1LBa+IpSZ2p7yho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-EcNsCcIHMR2vKkV83Nattw-1; Mon, 10 Feb 2020 12:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7927A1005F6C
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 17:29:24 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-112.ams2.redhat.com
 [10.36.117.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2D0789F0A;
 Mon, 10 Feb 2020 17:29:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 1/5] virtiofsd: Remove fuse_req_getgroups
Date: Mon, 10 Feb 2020 17:29:14 +0000
Message-Id: <20200210172918.95874-2-dgilbert@redhat.com>
In-Reply-To: <20200210172918.95874-1-dgilbert@redhat.com>
References: <20200210172918.95874-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EcNsCcIHMR2vKkV83Nattw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Remove fuse_req_getgroups that's unused in virtiofsd; it came in
from libfuse but we don't actually use it.  It was called from
fuse_getgroups which we previously removed (but had left it's header
in).

Coverity had complained about null termination in it, but removing
it is the easiest answer.

Fixes: Coverity CID: 1413117 (String not null terminated)
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse.h          | 20 ---------
 tools/virtiofsd/fuse_lowlevel.c | 77 ---------------------------------
 tools/virtiofsd/fuse_lowlevel.h | 21 ---------
 3 files changed, 118 deletions(-)

diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h
index 7a4c713559..aba13fef2d 100644
--- a/tools/virtiofsd/fuse.h
+++ b/tools/virtiofsd/fuse.h
@@ -1006,26 +1006,6 @@ void fuse_exit(struct fuse *f);
  */
 struct fuse_context *fuse_get_context(void);
=20
-/**
- * Get the current supplementary group IDs for the current request
- *
- * Similar to the getgroups(2) system call, except the return value is
- * always the total number of group IDs, even if it is larger than the
- * specified size.
- *
- * The current fuse kernel module in linux (as of 2.6.30) doesn't pass
- * the group list to userspace, hence this function needs to parse
- * "/proc/$TID/task/$TID/status" to get the group IDs.
- *
- * This feature may not be supported on all operating systems.  In
- * such a case this function will return -ENOSYS.
- *
- * @param size size of given array
- * @param list array of group IDs to be filled in
- * @return the total number of supplementary group IDs or -errno on failur=
e
- */
-int fuse_getgroups(int size, gid_t list[]);
-
 /**
  * Check if the current request has already been interrupted
  *
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index de2e2e0c65..01c418aade 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2667,83 +2667,6 @@ int fuse_lowlevel_is_virtio(struct fuse_session *se)
     return !!se->virtio_dev;
 }
=20
-#ifdef linux
-int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
-{
-    char *buf;
-    size_t bufsize =3D 1024;
-    char path[128];
-    int ret;
-    int fd;
-    unsigned long pid =3D req->ctx.pid;
-    char *s;
-
-    sprintf(path, "/proc/%lu/task/%lu/status", pid, pid);
-
-retry:
-    buf =3D malloc(bufsize);
-    if (buf =3D=3D NULL) {
-        return -ENOMEM;
-    }
-
-    ret =3D -EIO;
-    fd =3D open(path, O_RDONLY);
-    if (fd =3D=3D -1) {
-        goto out_free;
-    }
-
-    ret =3D read(fd, buf, bufsize);
-    close(fd);
-    if (ret < 0) {
-        ret =3D -EIO;
-        goto out_free;
-    }
-
-    if ((size_t)ret =3D=3D bufsize) {
-        free(buf);
-        bufsize *=3D 4;
-        goto retry;
-    }
-
-    ret =3D -EIO;
-    s =3D strstr(buf, "\nGroups:");
-    if (s =3D=3D NULL) {
-        goto out_free;
-    }
-
-    s +=3D 8;
-    ret =3D 0;
-    while (1) {
-        char *end;
-        unsigned long val =3D strtoul(s, &end, 0);
-        if (end =3D=3D s) {
-            break;
-        }
-
-        s =3D end;
-        if (ret < size) {
-            list[ret] =3D val;
-        }
-        ret++;
-    }
-
-out_free:
-    free(buf);
-    return ret;
-}
-#else /* linux */
-/*
- * This is currently not implemented on other than Linux...
- */
-int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
-{
-    (void)req;
-    (void)size;
-    (void)list;
-    return -ENOSYS;
-}
-#endif
-
 void fuse_session_exit(struct fuse_session *se)
 {
     se->exited =3D 1;
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 138041e5f1..8f6d705b5c 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1704,27 +1704,6 @@ void *fuse_req_userdata(fuse_req_t req);
  */
 const struct fuse_ctx *fuse_req_ctx(fuse_req_t req);
=20
-/**
- * Get the current supplementary group IDs for the specified request
- *
- * Similar to the getgroups(2) system call, except the return value is
- * always the total number of group IDs, even if it is larger than the
- * specified size.
- *
- * The current fuse kernel module in linux (as of 2.6.30) doesn't pass
- * the group list to userspace, hence this function needs to parse
- * "/proc/$TID/task/$TID/status" to get the group IDs.
- *
- * This feature may not be supported on all operating systems.  In
- * such a case this function will return -ENOSYS.
- *
- * @param req request handle
- * @param size size of given array
- * @param list array of group IDs to be filled in
- * @return the total number of supplementary group IDs or -errno on failur=
e
- */
-int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[]);
-
 /**
  * Callback function for an interrupt
  *
--=20
2.24.1


