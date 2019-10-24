Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91682CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569352166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCabeUca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569352166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbqA-0000Qe-OY
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIX-0004T2-Ai
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIV-0000Eo-TB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIV-0000EO-Or
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iix76qz+D3wDmXlNY++4q7SA/90h60kTtY/hGCP0X6c=;
 b=SCabeUcaUS5ULMzHhBxPRJqeneNkJihmbsQmQoiEHMvJmapa+E1ldA5YknOOdrvnCL+ASN
 4lmV3LAIA+AenQonXLVHTjsUCj4L25tNgPbdnld3bdFPQHNNblruPBIAbr4LnwAWRxa9nf
 x8juoKdmsA+kidPkrm64+4Y3pe/CaAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-gFI1Ck6KPZmbKdaMff5QkQ-1; Thu, 24 Oct 2019 07:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FD39800D49;
 Thu, 24 Oct 2019 11:28:49 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F999196B2;
 Thu, 24 Oct 2019 11:28:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 21/25] virtiofsd: Drop CAP_FSETID if client asked for it
Date: Thu, 24 Oct 2019 12:27:14 +0100
Message-Id: <20191024112718.34657-22-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gFI1Ck6KPZmbKdaMff5QkQ-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

If client requested killing setuid/setgid bits on file being written, drop
CAP_FSETID capability so that setuid/setgid bits are cleared upon write
automatically.

pjdfstest chown/12.t needs this.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/Makefile.objs    |   2 +
 contrib/virtiofsd/passthrough_ll.c | 127 +++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile.o=
bjs
index 941b19f18e..25f1e8dd73 100644
--- a/contrib/virtiofsd/Makefile.objs
+++ b/contrib/virtiofsd/Makefile.objs
@@ -11,3 +11,5 @@ virtiofsd-obj-y =3D buffer.o \
=20
 seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
 seccomp.o-libs :=3D $(SECCOMP_LIBS)
+
+passthrough_ll.o-libs +=3D -lcap
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 93873bf6f4..fe46b25fb6 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -51,6 +51,7 @@
 #include <sys/file.h>
 #include <sys/syscall.h>
 #include <sys/xattr.h>
+#include <sys/capability.h>
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -174,6 +175,115 @@ static struct lo_data *lo_data(fuse_req_t req)
 =09return (struct lo_data *) fuse_req_userdata(req);
 }
=20
+/* Helpers for dropping and regaining effective capabilities. Returns 0
+ * on success, error otherwise  */
+static int drop_effective_cap(const char *cap_name, bool *cap_dropped)
+{
+=09cap_t caps;
+=09cap_value_t cap;
+=09cap_flag_value_t cap_value;
+=09int ret =3D 0;
+
+=09ret =3D cap_from_name(cap_name, &cap);
+=09if (ret =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_from_name(%s) failed:%s\n", cap_name,
+=09=09=09 strerror(errno));
+=09=09goto out;
+=09}
+
+=09if (!CAP_IS_SUPPORTED(cap)) {
+=09=09fuse_log(FUSE_LOG_ERR, "capability(%s) is not supported\n", cap_name=
);
+=09=09return EINVAL;
+=09}
+
+=09caps =3D cap_get_proc();
+=09if (caps =3D=3D NULL) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_get_proc() failed\n");
+=09=09goto out;
+=09}
+
+=09if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &cap_value) =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_get_flag() failed\n");
+=09=09goto out_cap_free;
+=09}
+
+=09/* We dont have this capability in effective set already. */
+=09if (cap_value =3D=3D CAP_CLEAR) {
+=09=09ret =3D 0;
+=09=09goto out_cap_free;
+=09}
+
+=09if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, CAP_CLEAR) =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_set_flag() failed\n");
+=09=09goto out_cap_free;
+=09}
+
+=09if (cap_set_proc(caps) =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_set_procs() failed\n");
+=09=09goto out_cap_free;
+=09}
+
+=09ret =3D 0;
+=09if (cap_dropped)
+=09=09*cap_dropped =3D true;
+
+out_cap_free:
+=09cap_free(caps);
+out:
+=09return ret;
+}
+
+static int gain_effective_cap(const char *cap_name)
+{
+=09cap_t caps;
+=09cap_value_t cap;
+=09int ret =3D 0;
+
+=09ret =3D cap_from_name(cap_name, &cap);
+=09if (ret =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_from_name(%s) failed:%s\n", cap_name,
+=09=09=09 strerror(errno));
+=09=09goto out;
+=09}
+
+=09if (!CAP_IS_SUPPORTED(cap)) {
+=09=09fuse_log(FUSE_LOG_ERR, "capability(%s) is not supported\n", cap_name=
);
+=09=09return EINVAL;
+=09}
+
+=09caps =3D cap_get_proc();
+=09if (caps =3D=3D NULL) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_get_proc() failed\n");
+=09=09goto out;
+=09}
+
+
+=09if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, CAP_SET) =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_set_flag() failed\n");
+=09=09goto out_cap_free;
+=09}
+
+=09if (cap_set_proc(caps) =3D=3D -1) {
+=09=09ret =3D errno;
+=09=09fuse_log(FUSE_LOG_ERR, "cap_set_procs() failed\n");
+=09=09goto out_cap_free;
+=09}
+=09ret =3D 0;
+
+out_cap_free:
+=09cap_free(caps);
+out:
+=09return ret;
+}
+
 static void lo_map_init(struct lo_map *map)
 {
 =09map->elems =3D NULL;
@@ -1447,6 +1557,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t i=
no,
 =09(void) ino;
 =09ssize_t res;
 =09struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
+=09bool cap_fsetid_dropped =3D false;
=20
 =09out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
 =09out_buf.buf[0].fd =3D lo_fi_fd(req, fi);
@@ -1456,11 +1567,27 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t=
 ino,
 =09=09fuse_log(FUSE_LOG_DEBUG, "lo_write(ino=3D%" PRIu64 ", size=3D%zd, of=
f=3D%lu)\n",
 =09=09=09ino, out_buf.buf[0].size, (unsigned long) off);
=20
+=09/*
+=09 * If kill_priv is set, drop CAP_FSETID which should lead to kernel
+=09 * clearing setuid/setgid on file.
+=09 */
+=09if (fi->kill_priv) {
+=09=09res =3D drop_effective_cap("cap_fsetid", &cap_fsetid_dropped);
+=09=09if (res !=3D 0)
+=09=09=09fuse_reply_err(req, res);
+=09}
+
 =09res =3D fuse_buf_copy(&out_buf, in_buf, 0);
 =09if(res < 0)
 =09=09fuse_reply_err(req, -res);
 =09else
 =09=09fuse_reply_write(req, (size_t) res);
+
+=09if (cap_fsetid_dropped) {
+=09=09res =3D gain_effective_cap("cap_fsetid");
+=09=09if (res)
+=09=09=09fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
+=09}
 }
=20
 static void lo_statfs(fuse_req_t req, fuse_ino_t ino)
--=20
2.23.0


