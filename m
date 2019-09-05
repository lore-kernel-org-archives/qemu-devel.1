Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2006DC3A5AA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF082145D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF082145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nEI-0002EO-Lv
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5n9Z-0006g9-Ng
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5n9Y-0005JZ-EU
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5n9Y-0005JL-3k
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 65C593090FDA
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 08:30:03 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9FE60920;
 Thu,  5 Sep 2019 08:29:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	virtio-fs@redhat.com
Date: Thu,  5 Sep 2019 09:29:46 +0100
Message-Id: <20190905082947.6633-2-stefanha@redhat.com>
In-Reply-To: <20190905082947.6633-1-stefanha@redhat.com>
References: <20190905082947.6633-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 05 Sep 2019 08:30:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RESEND 1/2] virtiofsd: replace warn(3) and
 warnx(3) with fuse_warning()
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use warn(3) and warnx(3) since they print to stderr.  When
--syslog is used these messages must go to syslog(3) instead.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index 0ef01b7e3f..7fab0bf6c1 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -628,12 +628,12 @@ retry:
=20
 	res =3D readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
 	if (res < 0) {
-		warn("lo_parent_and_name: readlink failed");
+		fuse_warning("lo_parent_and_name: readlink failed: %m\n");
 		goto fail_noretry;
 	}
=20
 	if (res >=3D PATH_MAX) {
-		warnx("lo_parent_and_name: readlink overflowed");
+		fuse_warning("lo_parent_and_name: readlink overflowed\n");
 		goto fail_noretry;
 	}
 	path[res] =3D '\0';
@@ -641,7 +641,7 @@ retry:
 	last =3D strrchr(path, '/');
 	if (last =3D=3D NULL) {
 		/* Shouldn't happen */
-		warnx("lo_parent_and_name: INTERNAL ERROR: bad path read from proc");
+		fuse_warning("lo_parent_and_name: INTERNAL ERROR: bad path read from p=
roc\n");
 		goto fail_noretry;
 	}
 	if (last =3D=3D path) {
@@ -655,13 +655,13 @@ retry:
 		res =3D fstatat(AT_FDCWD, last =3D=3D path ? "/" : path, &stat, 0);
 		if (res =3D=3D -1) {
 			if (!retries)
-				warn("lo_parent_and_name: failed to stat parent");
+				fuse_warning("lo_parent_and_name: failed to stat parent: %m\n");
 			goto fail;
 		}
 		p =3D lo_find(lo, &stat);
 		if (p =3D=3D NULL) {
 			if (!retries)
-				warnx("lo_parent_and_name: failed to find parent");
+				fuse_warning("lo_parent_and_name: failed to find parent\n");
 			goto fail;
 		}
 	}
@@ -669,12 +669,12 @@ retry:
 	res =3D fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
 	if (res =3D=3D -1) {
 		if (!retries)
-			warn("lo_parent_and_name: failed to stat last");
+			fuse_warning("lo_parent_and_name: failed to stat last: %m\n");
 		goto fail_unref;
 	}
 	if (stat.st_dev !=3D inode->key.dev || stat.st_ino !=3D inode->key.ino)=
 {
 		if (!retries)
-			warnx("lo_parent_and_name: filed to match last");
+			fuse_warning("lo_parent_and_name: filed to match last\n");
 		goto fail_unref;
 	}
 	*parent =3D p;
@@ -895,9 +895,9 @@ static void get_shared(struct lo_data *lo, struct lo_=
inode *inode)
 	res =3D write(lo->ireg_sock, &msg, sizeof(msg));
 	if (res !=3D sizeof(msg)) {
 		if (res =3D=3D -1)
-			warn("write(lo->ireg_sock, {IREG_GET, ...})");
+			fuse_warning("write(lo->ireg_sock, {IREG_GET, ...}): %m\n");
 		else
-			warnx("short write to ireg_sock: %i", res);
+			fuse_warning("short write to ireg_sock: %i\n", res);
 		return;
 	}
=20
@@ -919,9 +919,9 @@ static void put_shared(struct lo_data *lo, struct lo_=
inode *inode)
 	res =3D write(lo->ireg_sock, &msg, sizeof(msg));
 	if (res !=3D sizeof(msg)) {
 		if (res =3D=3D -1)
-			warn("write(lo->ireg_sock, {IREG_PUT, ...})");
+			fuse_warning("write(lo->ireg_sock, {IREG_PUT, ...}): %m\n");
 		else
-			warnx("short write to ireg_sock: %i", res);
+			fuse_warning("short write to ireg_sock: %i\n", res);
 		return;
 	}
 }
@@ -1428,7 +1428,7 @@ static void unref_inode(struct lo_data *lo, struct =
lo_inode *inode, uint64_t n)
 		lo_map_remove(&lo->ino_map, inode->fuse_ino);
                 g_hash_table_remove(lo->inodes, &inode->key);
 		if (g_hash_table_size(inode->posix_locks)) {
-			warn("Hash table is not empty\n");
+			fuse_warning("Hash table is not empty\n");
 		}
 		g_hash_table_destroy(inode->posix_locks);
 		pthread_mutex_destroy(&inode->plock_mutex);
@@ -2640,19 +2640,19 @@ static void *ireg_do(void *data)
 		res =3D read(lo->ireg_sock, buf, sizeof(buf));
 		if (res <=3D 0) {
 			if (res =3D=3D -1)
-				warn("read(lo->ireg_sock, ...)");
+				fuse_warning("read(lo->ireg_sock, ...): %m\n");
 			else
-				warnx("disconnected from ireg");
+				fuse_warning("disconnected from ireg\n");
 			return NULL;
 		}
 		if (res !=3D sizeof(reply)) {
-			warnx("bad size message: %i", res);
+			fuse_warning("bad size message: %i\n", res);
 			continue;
 		}
=20
 		memcpy(&reply, buf, sizeof(reply));
 		if (reply.op !=3D SRV_VERSION) {
-			warn("bad reply to IREG_GET: %i", reply.op);
+			fuse_warning("bad reply to IREG_GET: %i\n", reply.op);
 			continue;
 		}
=20
@@ -2685,7 +2685,7 @@ static void setup_shared_versions(struct lo_data *l=
o)
 	res =3D connect(sock, (const struct sockaddr *) &name,
 		      sizeof(struct sockaddr_un));
 	if (res =3D=3D -1) {
-		warn("connect to ireg");
+		fuse_warning("connect to ireg: %m\n");
 		close(sock);
 		lo->ireg_sock =3D -1;
 		return;
@@ -2996,7 +2996,7 @@ int main(int argc, char *argv[])
=20
 		ret =3D pthread_create(&ireg_thread, NULL, ireg_do, &lo);
 		if (ret) {
-			warnx("pthread_create: %s", strerror(ret));
+			fuse_warning("pthread_create: %s\n", strerror(ret));
 			ret =3D 1;
 			goto err_out4;
 		}
--=20
2.21.0


