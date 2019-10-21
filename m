Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E148CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE80206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr/PtHRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE80206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVg0-0003Z4-Fp
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPt-0003d8-9a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPs-0003wO-6d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPs-0003wE-2d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq3dVPpkMY0sp1aV3tXLcOQPKVgrUBg6UKecjOlmPkI=;
 b=Zr/PtHRVS9Bp1vOp0YtuoZBvxYevRfrhNQ+Z3OFqiy/+Ot81U7Qn1zkHRGur3ioKUZkZbP
 MltzAoZ/ovkJ9WONo/RdZe88VYDK3ZGUDCpVP6wy1hLJI2fwpe8VZBIwKv4qh+jIpH/joJ
 2jgPq1dDNVWzkUVzZ1+5hrVcup0lsSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-GNg4UOQ9O8eLkhLtwQzcTg-1; Mon, 21 Oct 2019 06:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99DFB476;
 Mon, 21 Oct 2019 10:59:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB1E364029;
 Mon, 21 Oct 2019 10:59:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 12/30] virtiofsd: Make fsync work even if only inode is passed
 in
Date: Mon, 21 Oct 2019 11:58:14 +0100
Message-Id: <20191021105832.36574-13-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: GNg4UOQ9O8eLkhLtwQzcTg-1
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vivek Goyal <vgoyal@redhat.com>

If caller has not sent file handle in request, then using inode, retrieve
the fd opened using O_PATH and use that to open file again and issue
fsync. This will be needed when dax_flush() calls fsync. At that time
we only have inode information (and not file).

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c  |  9 ++++++---
 contrib/virtiofsd/passthrough_ll.c | 24 ++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index ff68ec0c9d..6fe7506ead 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -1083,9 +1083,12 @@ static void do_fsync(fuse_req_t req, fuse_ino_t node=
id, const void *inarg)
 =09memset(&fi, 0, sizeof(fi));
 =09fi.fh =3D arg->fh;
=20
-=09if (req->se->op.fsync)
-=09=09req->se->op.fsync(req, nodeid, datasync, &fi);
-=09else
+=09if (req->se->op.fsync) {
+=09=09if (fi.fh =3D=3D (uint64_t)-1)
+=09=09=09req->se->op.fsync(req, nodeid, datasync, NULL);
+=09=09else
+=09=09=09req->se->op.fsync(req, nodeid, datasync, &fi);
+=09} else
 =09=09fuse_reply_err(req, ENOSYS);
 }
=20
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 72fae9d10b..63a32c87c3 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -863,10 +863,30 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino, =
int datasync,
 {
 =09int res;
 =09(void) ino;
+=09int fd;
+=09char *buf;
+
+=09fuse_log(FUSE_LOG_DEBUG, "lo_fsync(ino=3D%" PRIu64 ", fi=3D0x%p)\n", in=
o,
+=09=09 (void *)fi);
+
+=09if (!fi) {
+=09=09res =3D asprintf(&buf, "/proc/self/fd/%i", lo_fd(req, ino));
+=09=09if (res =3D=3D -1)
+=09=09=09return (void) fuse_reply_err(req, errno);
+
+=09=09fd =3D open(buf, O_RDWR);
+=09=09free(buf);
+=09=09if (fd =3D=3D -1)
+=09=09=09return (void) fuse_reply_err(req, errno);
+=09} else
+=09=09fd =3D fi->fh;
+
 =09if (datasync)
-=09=09res =3D fdatasync(fi->fh);
+=09=09res =3D fdatasync(fd);
 =09else
-=09=09res =3D fsync(fi->fh);
+=09=09res =3D fsync(fd);
+=09if (!fi)
+=09=09close(fd);
 =09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
--=20
2.23.0


