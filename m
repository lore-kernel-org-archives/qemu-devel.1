Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30885C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6F92467B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7c6EqVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6F92467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucNh-0000bZ-6a
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub94-0002Oq-PR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub93-0005AY-7z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub93-0005AA-46
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdrT4LOkC8ZKML3gWoy6Ii/nK7cw9vlWojUEEc01X4s=;
 b=A7c6EqVnuainZbOFRniVjgFC+vPJEsTD3MwhcBwAk7MQBoUAKAo/qCGVeMxaufLf8o+98i
 ykqlEIrZqBH/ZllT/J/4kAxJVTWu3p27aEQNCHsxkAOy3AniiEbBU1xImuboZny+huev+0
 LX/LYC8gVdRedjXgp49arbUj2oFOMTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-gcHYy5m2PAeF9i946Yp66A-1; Thu, 23 Jan 2020 06:59:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5866CDB6A
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A627385754;
 Thu, 23 Jan 2020 11:59:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 035/111] virtiofsd: passthrough_ll: add lo_map for ino/fh
 indirection
Date: Thu, 23 Jan 2020 11:57:25 +0000
Message-Id: <20200123115841.138849-36-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: gcHYy5m2PAeF9i946Yp66A-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

A layer of indirection is needed because passthrough_ll cannot expose
pointers or file descriptor numbers to untrusted clients.  Malicious
clients could send invalid pointers or file descriptors in order to
crash or exploit the file system daemon.

lo_map provides an integer key->value mapping.  This will be used for
ino and fh fields in the patches that follow.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 124 +++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 5e061797d4..e83a976587 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -74,6 +74,21 @@ struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
 };
 #endif
=20
+struct lo_map_elem {
+    union {
+        /* Element values will go here... */
+        ssize_t freelist;
+    };
+    bool in_use;
+};
+
+/* Maps FUSE fh or ino values to internal objects */
+struct lo_map {
+    struct lo_map_elem *elems;
+    size_t nelems;
+    ssize_t freelist;
+};
+
 struct lo_inode {
     struct lo_inode *next; /* protected by lo->mutex */
     struct lo_inode *prev; /* protected by lo->mutex */
@@ -130,6 +145,115 @@ static struct lo_data *lo_data(fuse_req_t req)
     return (struct lo_data *)fuse_req_userdata(req);
 }
=20
+__attribute__((unused)) static void lo_map_init(struct lo_map *map)
+{
+    map->elems =3D NULL;
+    map->nelems =3D 0;
+    map->freelist =3D -1;
+}
+
+__attribute__((unused)) static void lo_map_destroy(struct lo_map *map)
+{
+    free(map->elems);
+}
+
+static int lo_map_grow(struct lo_map *map, size_t new_nelems)
+{
+    struct lo_map_elem *new_elems;
+    size_t i;
+
+    if (new_nelems <=3D map->nelems) {
+        return 1;
+    }
+
+    new_elems =3D realloc(map->elems, sizeof(map->elems[0]) * new_nelems);
+    if (!new_elems) {
+        return 0;
+    }
+
+    for (i =3D map->nelems; i < new_nelems; i++) {
+        new_elems[i].freelist =3D i + 1;
+        new_elems[i].in_use =3D false;
+    }
+    new_elems[new_nelems - 1].freelist =3D -1;
+
+    map->elems =3D new_elems;
+    map->freelist =3D map->nelems;
+    map->nelems =3D new_nelems;
+    return 1;
+}
+
+__attribute__((unused)) static struct lo_map_elem *
+lo_map_alloc_elem(struct lo_map *map)
+{
+    struct lo_map_elem *elem;
+
+    if (map->freelist =3D=3D -1 && !lo_map_grow(map, map->nelems + 256)) {
+        return NULL;
+    }
+
+    elem =3D &map->elems[map->freelist];
+    map->freelist =3D elem->freelist;
+
+    elem->in_use =3D true;
+
+    return elem;
+}
+
+__attribute__((unused)) static struct lo_map_elem *
+lo_map_reserve(struct lo_map *map, size_t key)
+{
+    ssize_t *prev;
+
+    if (!lo_map_grow(map, key + 1)) {
+        return NULL;
+    }
+
+    for (prev =3D &map->freelist; *prev !=3D -1;
+         prev =3D &map->elems[*prev].freelist) {
+        if (*prev =3D=3D key) {
+            struct lo_map_elem *elem =3D &map->elems[key];
+
+            *prev =3D elem->freelist;
+            elem->in_use =3D true;
+            return elem;
+        }
+    }
+    return NULL;
+}
+
+__attribute__((unused)) static struct lo_map_elem *
+lo_map_get(struct lo_map *map, size_t key)
+{
+    if (key >=3D map->nelems) {
+        return NULL;
+    }
+    if (!map->elems[key].in_use) {
+        return NULL;
+    }
+    return &map->elems[key];
+}
+
+__attribute__((unused)) static void lo_map_remove(struct lo_map *map,
+                                                  size_t key)
+{
+    struct lo_map_elem *elem;
+
+    if (key >=3D map->nelems) {
+        return;
+    }
+
+    elem =3D &map->elems[key];
+    if (!elem->in_use) {
+        return;
+    }
+
+    elem->in_use =3D false;
+
+    elem->freelist =3D map->freelist;
+    map->freelist =3D key;
+}
+
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
     if (ino =3D=3D FUSE_ROOT_ID) {
--=20
2.24.1


