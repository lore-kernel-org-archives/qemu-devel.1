Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61ADC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B808721848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B808721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE4M-00015C-00
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:33:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUE27-0007Ea-DV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUDzW-0004NN-PV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hUDzV-0004MN-Hp; Fri, 24 May 2019 13:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD7E330001EB;
	Fri, 24 May 2019 17:28:24 +0000 (UTC)
Received: from localhost (ovpn-204-150.brq.redhat.com [10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 170545C1B4;
	Fri, 24 May 2019 17:28:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 24 May 2019 19:28:11 +0200
Message-Id: <20190524172812.27308-3-mreitz@redhat.com>
In-Reply-To: <20190524172812.27308-1-mreitz@redhat.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 24 May 2019 17:28:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 2/3] file-posix: Inquire rotational status
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Linux, we can inquire whether the file is stored on a rotating disk
or on a solid-state drive through the sysfs.  (The BLKROTATIONAL ioctl
only works on device files themselves.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index d018429672..f84179c0dc 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -161,6 +161,9 @@ typedef struct BDRVRawState {
     bool check_cache_dropped;
=20
     PRManager *pr_mgr;
+
+    bool has_rotational_info;
+    ImageRotationalInfo rotational_info;
 } BDRVRawState;
=20
 typedef struct BDRVRawReopenState {
@@ -378,6 +381,68 @@ static void raw_probe_alignment(BlockDriverState *bs=
, int fd, Error **errp)
     }
 }
=20
+/**
+ * Tries to inquire whether the file is stored on a rotating disk or a
+ * solid-state drive.
+ */
+static void raw_update_rotational_info(BDRVRawState *s)
+{
+#ifdef CONFIG_LINUX
+    struct stat st;
+    char *part_fname, *rot_fname;
+    char rot_info[3];
+    dev_t dev;
+    int rot_fd;
+    int ret;
+
+    s->has_rotational_info =3D false;
+
+    if (fstat(s->fd, &st) < 0) {
+        return;
+    }
+
+    if (st.st_rdev) {
+        dev =3D st.st_rdev;
+    } else {
+        dev =3D st.st_dev;
+    }
+
+    part_fname =3D g_strdup_printf("/sys/dev/block/%u:%u/partition",
+                                 major(dev), minor(dev));
+    if (access(part_fname, F_OK) =3D=3D 0) {
+        rot_fname =3D g_strdup_printf("/sys/dev/block/%u:%u/../queue/rot=
ational",
+                                    major(dev), minor(dev));
+    } else {
+        rot_fname =3D g_strdup_printf("/sys/dev/block/%u:%u/queue/rotati=
onal",
+                                    major(dev), minor(dev));
+    }
+    g_free(part_fname);
+
+    rot_fd =3D open(rot_fname, O_RDONLY);
+    g_free(rot_fname);
+    if (rot_fd < 0) {
+        return;
+    }
+
+    ret =3D read(rot_fd, rot_info, 2);
+    close(rot_fd);
+    if (ret < 2) {
+        return;
+    }
+
+    rot_info[2] =3D '\0';
+    if (!strcmp(rot_info, "0\n")) {
+        s->rotational_info =3D IMAGE_ROTATIONAL_INFO_SOLID_STATE;
+        s->has_rotational_info =3D true;
+    } else if (!strcmp(rot_info, "1\n")) {
+        s->rotational_info =3D IMAGE_ROTATIONAL_INFO_ROTATING;
+        s->has_rotational_info =3D true;
+    }
+#else /* CONFIG_LINUX */
+    s->has_rotational_info =3D false;
+#endif
+}
+
 static void raw_parse_flags(int bdrv_flags, int *open_flags, bool has_wr=
iters)
 {
     bool read_write =3D false;
@@ -652,6 +717,8 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
     }
 #endif
=20
+    raw_update_rotational_info(s);
+
     bs->supported_zero_flags =3D BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBA=
CK;
     ret =3D 0;
 fail:
@@ -1007,6 +1074,8 @@ static void raw_reopen_commit(BDRVReopenState *stat=
e)
     qemu_close(s->fd);
     s->fd =3D rs->fd;
=20
+    raw_update_rotational_info(s);
+
     g_free(state->opaque);
     state->opaque =3D NULL;
=20
@@ -2731,6 +2800,10 @@ static int raw_get_info(BlockDriverState *bs, Bloc=
kDriverInfo *bdi)
     BDRVRawState *s =3D bs->opaque;
=20
     bdi->unallocated_blocks_are_zero =3D s->discard_zeroes;
+
+    bdi->rotational_info =3D s->rotational_info;
+    bdi->has_rotational_info =3D s->has_rotational_info;
+
     return 0;
 }
=20
--=20
2.21.0


