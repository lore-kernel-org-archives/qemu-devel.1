Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C1CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F96020650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjVP2ugH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F96020650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4wI-0003nD-C0
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xO-0003Zw-Us
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xJ-0002FI-Fd
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53979
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xJ-0002A1-7n
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kPed5/fsHktSEaX2QTOmKq2J20PAl/gvdH8RRD3K/M=;
 b=gjVP2ugHunTxvmLbem0uNLDq3S+h8SSa8DJYv70oXHAUWjsZ9EhvexFPEsVdRjnjq0nA4p
 KXU7+TVqgXPK2QwqsnzYI54G7xXCMlphjpBfQp0XdnGypwwSkVyJzj6SkNkIyWvEjG3tDy
 vSS6H5zEZ5Xti6WxcHRj/ZeKcYxFlnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-UFj1NjvBOJerjysGg9R4hw-1; Mon, 28 Oct 2019 08:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36B8280183E;
 Mon, 28 Oct 2019 12:16:57 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD43E100164D;
 Mon, 28 Oct 2019 12:16:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 55/69] qcow2: Keep track of the snapshot table length
Date: Mon, 28 Oct 2019 13:14:47 +0100
Message-Id: <20191028121501.15279-56-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UFj1NjvBOJerjysGg9R4hw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When repairing the snapshot table, we truncate entries that have too
much extra data.  This frees up space that we do not have to count
towards the snapshot table size.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191011152814.14791-12-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-snapshot.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 53dc1635ec..582eb3386a 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -68,6 +68,7 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs, =
bool repair,
     QCowSnapshot *sn;
     int i, id_str_size, name_size;
     int64_t offset;
+    uint64_t table_length =3D 0;
     int ret;
=20
     if (!s->nb_snapshots) {
@@ -82,6 +83,8 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs, =
bool repair,
     for(i =3D 0; i < s->nb_snapshots; i++) {
         bool truncate_unknown_extra_data =3D false;
=20
+        table_length =3D ROUND_UP(table_length, 8);
+
         /* Read statically sized part of the snapshot header */
         offset =3D ROUND_UP(offset, 8);
         ret =3D bdrv_pread(bs->file, offset, &h, sizeof(h));
@@ -184,7 +187,16 @@ static int qcow2_do_read_snapshots(BlockDriverState *b=
s, bool repair,
         offset +=3D name_size;
         sn->name[name_size] =3D '\0';
=20
-        if (offset - s->snapshots_offset > QCOW_MAX_SNAPSHOTS_SIZE) {
+        /* Note that the extra data may have been truncated */
+        table_length +=3D sizeof(h) + sn->extra_data_size + id_str_size +
+                        name_size;
+        if (!repair) {
+            assert(table_length =3D=3D offset - s->snapshots_offset);
+        }
+
+        if (table_length > QCOW_MAX_SNAPSHOTS_SIZE ||
+            offset - s->snapshots_offset > INT_MAX)
+        {
             ret =3D -EFBIG;
             error_setg(errp, "Snapshot table is too big");
             goto fail;
--=20
2.21.0


