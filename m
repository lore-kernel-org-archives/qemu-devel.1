Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BB6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F418820856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT4G0pRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F418820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbvv-0002wI-Rp
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHJ-0001f1-0f
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHG-0008Gu-Nj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHG-0008Gn-KB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TDQPoSF4UvJcq7ii3li4Ka6lEXcuALQAkQFwosbXC0=;
 b=hT4G0pRHpNrtUN2uo/tBvHcD2DFk4BI4Iw7sfoHOXXpD9jHQAV0H/x1eWYeSmcNtNhzdR7
 dBZwTLyhjAcY6RTo6LiPf1a5nLHJ243ml+dpxru26KHimBe31E71p8iem0vHLPnrQ7syUR
 Byf96pTji2oMf+qEvTK37FStvy0mmqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-B5MqDZ2XMgS_XUcA8ITOTA-1; Thu, 24 Oct 2019 07:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA3E80183D;
 Thu, 24 Oct 2019 11:27:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8A19166A0;
 Thu, 24 Oct 2019 11:27:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 02/25] virtiofsd: passthrough_ll: add lo_map for ino/fh
 indirection
Date: Thu, 24 Oct 2019 12:26:55 +0100
Message-Id: <20191024112718.34657-3-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: B5MqDZ2XMgS_XUcA8ITOTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Stefan Hajnoczi <stefanha@redhat.com>

A layer of indirection is needed because passthrough_ll cannot expose
pointers or file descriptor numbers to untrusted clients.  Malicious
clients could send invalid pointers or file descriptors in order to
crash or exploit the file system daemon.

lo_map provides an integer key->value mapping.  This will be used for
ino and fh fields in the patches that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 113 +++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 2de35d4d3d..3093d1171e 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -69,6 +69,21 @@ struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct \
 =09=09=09((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1); };
 #endif
=20
+struct lo_map_elem {
+=09union {
+=09=09/* Element values will go here... */
+=09=09ssize_t freelist;
+=09};
+=09bool in_use;
+};
+
+/* Maps FUSE fh or ino values to internal objects */
+struct lo_map {
+=09struct lo_map_elem *elems;
+=09size_t nelems;
+=09ssize_t freelist;
+};
+
 struct lo_inode {
 =09struct lo_inode *next; /* protected by lo->mutex */
 =09struct lo_inode *prev; /* protected by lo->mutex */
@@ -137,6 +152,104 @@ static struct lo_data *lo_data(fuse_req_t req)
 =09return (struct lo_data *) fuse_req_userdata(req);
 }
=20
+static void lo_map_init(struct lo_map *map)
+{
+=09map->elems =3D NULL;
+=09map->nelems =3D 0;
+=09map->freelist =3D -1;
+}
+
+static void lo_map_destroy(struct lo_map *map)
+{
+=09free(map->elems);
+}
+
+static int lo_map_grow(struct lo_map *map, size_t new_nelems)
+{
+=09struct lo_map_elem *new_elems;
+=09size_t i;
+
+=09if (new_nelems <=3D map->nelems)
+=09=09return 1;
+
+=09new_elems =3D realloc(map->elems, sizeof(map->elems[0]) * new_nelems);
+=09if (!new_elems)
+=09=09return 0;
+
+=09for (i =3D map->nelems; i < new_nelems; i++) {
+=09=09new_elems[i].freelist =3D i + 1;
+=09=09new_elems[i].in_use =3D false;
+=09}
+=09new_elems[new_nelems - 1].freelist =3D -1;
+
+=09map->elems =3D new_elems;
+=09map->freelist =3D map->nelems;
+=09map->nelems =3D new_nelems;
+=09return 1;
+}
+
+static struct lo_map_elem *lo_map_alloc_elem(struct lo_map *map)
+{
+=09struct lo_map_elem *elem;
+
+=09if (map->freelist =3D=3D -1 && !lo_map_grow(map, map->nelems + 256))
+=09=09return NULL;
+
+=09elem =3D &map->elems[map->freelist];
+=09map->freelist =3D elem->freelist;
+
+=09elem->in_use =3D true;
+
+=09return elem;
+}
+
+static struct lo_map_elem *lo_map_reserve(struct lo_map *map, size_t key)
+{
+=09ssize_t *prev;
+
+=09if (!lo_map_grow(map, key + 1))
+=09=09return NULL;
+
+=09for (prev =3D &map->freelist;
+=09     *prev !=3D -1;
+=09     prev =3D &map->elems[*prev].freelist) {
+=09=09if (*prev =3D=3D key) {
+=09=09=09struct lo_map_elem *elem =3D &map->elems[key];
+
+=09=09=09*prev =3D elem->freelist;
+=09=09=09elem->in_use =3D true;
+=09=09=09return elem;
+=09=09}
+=09}
+=09return NULL;
+}
+
+static struct lo_map_elem *lo_map_get(struct lo_map *map, size_t key)
+{
+=09if (key >=3D map->nelems)
+=09=09return NULL;
+=09if (!map->elems[key].in_use)
+=09=09return NULL;
+=09return &map->elems[key];
+}
+
+static void lo_map_remove(struct lo_map *map, size_t key)
+{
+=09struct lo_map_elem *elem;
+
+=09if (key >=3D map->nelems)
+=09=09return;
+
+=09elem =3D &map->elems[key];
+=09if (!elem->in_use)
+=09=09return;
+
+=09elem->in_use =3D false;
+
+=09elem->freelist =3D map->freelist;
+=09map->freelist =3D key;
+}
+
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
 =09if (ino =3D=3D FUSE_ROOT_ID)
--=20
2.23.0


