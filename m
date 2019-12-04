Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C3C2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611FB20656
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlTKrvOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611FB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ica2y-000425-As
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ica18-0002ZG-Ky
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ica15-0005Pw-A1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ica15-0005PK-0Y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575486530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtQy2nb+w6js/FC7hyDX4RQMgk6gm8WimLPO9TMsXP4=;
 b=MlTKrvOCTxhg3KNF5QmKUT+bC5Yf0UEgt3N/I+kMYqhI1KxqkCYvhjHPwI9f0z/9cLC1yI
 YKHxn25YeLxvxRYl5N2Mv52LtUS4xKbwcoylf27I6/I+nXNnXBkSsv52q6MvBuU8E9CMie
 7y06YQoB3IPEt57I/CSGADNLv6HWbfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-bhuuTWqpMYyvsqgpjmQ9qQ-1; Wed, 04 Dec 2019 14:08:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBE481023139
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:08:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99ED419C68;
 Wed,  4 Dec 2019 19:08:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 1C8572246B1; Wed,  4 Dec 2019 14:08:42 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] virtiofsd: Release file locks using F_UNLCK
Date: Wed,  4 Dec 2019 14:08:33 -0500
Message-Id: <20191204190836.31324-3-vgoyal@redhat.com>
In-Reply-To: <20191204190836.31324-1-vgoyal@redhat.com>
References: <20191204190836.31324-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bhuuTWqpMYyvsqgpjmQ9qQ-1
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
Cc: mszeredi@redhat.com, dgilbert@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are emulating posix locks for guest using open file description locks
in virtiofsd. When any of the fd is closed in guest, we find associated
OFD lock fd (if there is one) and close it to release all the locks.

Assumption here is that there is no other thread using lo_inode_plock
structure or plock->fd, hence it is safe to do so.

But now we are about to introduce blocking variant of locks (SETLKW),
and that means we might be waiting to a lock to be available and
using plock->fd. And that means there are still users of plock structure.

So release locks using fcntl(SETLK, F_UNLCK) instead and plock will
be freed later.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 31 ++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index bc214df0c7..6aa56882e8 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -936,6 +936,14 @@ static void put_shared(struct lo_data *lo, struct lo_i=
node *inode)
 =09}
 }
=20
+static void posix_locks_value_destroy(gpointer data)
+{
+=09struct lo_inode_plock *plock =3D data;
+
+=09close(plock->fd);
+=09free(plock);
+}
+
 /* Increments nlookup and caller must release refcount using
  * lo_inode_put(&parent).
  */
@@ -994,7 +1002,9 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
 =09=09inode->key.ino =3D e->attr.st_ino;
 =09=09inode->key.dev =3D e->attr.st_dev;
 =09=09pthread_mutex_init(&inode->plock_mutex, NULL);
-=09=09inode->posix_locks =3D g_hash_table_new(g_direct_hash, g_direct_equa=
l);
+=09=09inode->posix_locks =3D g_hash_table_new_full(g_direct_hash,
+=09=09=09=09=09g_direct_equal, NULL,
+=09=09=09=09=09posix_locks_value_destroy);
=20
 =09=09get_shared(lo, inode);
=20
@@ -1436,9 +1446,6 @@ static void unref_inode(struct lo_data *lo, struct lo=
_inode *inode, uint64_t n)
 =09if (!inode->nlookup) {
 =09=09lo_map_remove(&lo->ino_map, inode->fuse_ino);
                 g_hash_table_remove(lo->inodes, &inode->key);
-=09=09if (g_hash_table_size(inode->posix_locks)) {
-=09=09=09fuse_log(FUSE_LOG_WARNING, "Hash table is not empty\n");
-=09=09}
 =09=09g_hash_table_destroy(inode->posix_locks);
 =09=09pthread_mutex_destroy(&inode->plock_mutex);
=20
@@ -1868,6 +1875,7 @@ static struct lo_inode_plock *lookup_create_plock_ctx=
(struct lo_data *lo,
 =09plock->fd =3D fd;
 =09g_hash_table_insert(inode->posix_locks,
 =09=09=09    GUINT_TO_POINTER(plock->lock_owner), plock);
+=09fuse_log(FUSE_LOG_DEBUG, "lookup_create_plock_ctx(): Inserted element i=
n posix_locks hash table with value pointer %p\n", plock);
 =09return plock;
 }
=20
@@ -2046,6 +2054,7 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
 =09(void) ino;
 =09struct lo_inode *inode;
 =09struct lo_inode_plock *plock;
+=09struct flock flock;
=20
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
@@ -2058,14 +2067,16 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi)
 =09plock =3D g_hash_table_lookup(inode->posix_locks,
 =09=09=09=09    GUINT_TO_POINTER(fi->lock_owner));
 =09if (plock) {
-=09=09g_hash_table_remove(inode->posix_locks,
-=09=09=09=09    GUINT_TO_POINTER(fi->lock_owner));
 =09=09/*
-=09=09 * We had used open() for locks and had only one fd. So
-=09=09 * closing this fd should release all OFD locks.
+=09=09 * An fd is being closed. For posix locks, this means
+=09=09 * drop all the associated locks.
 =09=09 */
-=09=09close(plock->fd);
-=09=09free(plock);
+=09=09memset(&flock, 0, sizeof(struct flock));
+=09=09flock.l_type =3D F_UNLCK;
+=09=09flock.l_whence =3D SEEK_SET;
+=09=09/* Unlock whole file */
+=09=09flock.l_start =3D flock.l_len =3D 0;
+=09=09fcntl(plock->fd, F_OFD_SETLK, &flock);
 =09}
 =09pthread_mutex_unlock(&inode->plock_mutex);
=20
--=20
2.20.1


