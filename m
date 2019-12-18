Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B45C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEE521D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZ6CyatD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEE521D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUqz-0000tc-8e
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWW-00061m-MX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWU-0002WO-I3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWT-0002Tb-7n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6f6Jd/iz7emJKypVVi34B7fHSfFbx40tceL+5zU5Ms=;
 b=AZ6CyatDxz8YtEL8sA2rhzHgwQWRGkP12jxZsXZE8U7c9sZoit2UnV8k92gFw9J6iOqg/G
 JPT9g+j0zuUWzFFciFKcHDt22vwAcuCZ1jgfZplmx1A5eSZuTaT/t4ynTkgru28+L+3oFi
 3EY8dpW96utoKvTwOKoFwWIJd3Xwpuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-5cuFJoTgNeOCn8K52GapuA-1; Wed, 18 Dec 2019 03:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C0FD800D55;
 Wed, 18 Dec 2019 08:17:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D09A1000325;
 Wed, 18 Dec 2019 08:17:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B254A1136428; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 24/35] block/snapshot: rename Error ** parameter to more
 common errp
Date: Wed, 18 Dec 2019 09:17:10 +0100
Message-Id: <20191218081721.23520-25-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 5cuFJoTgNeOCn8K52GapuA-1
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@Redhat.com>
Message-Id: <20191205174635.18758-11-vsementsov@virtuozzo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/snapshot.h | 2 +-
 block/snapshot.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index b5d5084a12..2bfcd57578 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -78,7 +78,7 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState=
 *bs,
=20
 bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
 int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bs=
d_bs,
-                             Error **err);
+                             Error **errp);
 int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_=
bs,
                            Error **errp);
 int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_=
bs);
diff --git a/block/snapshot.c b/block/snapshot.c
index 8081616ae9..bd9fb01817 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -426,7 +426,7 @@ fail:
 }
=20
 int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_ba=
d_bs,
-                             Error **err)
+                             Error **errp)
 {
     int ret =3D 0;
     BlockDriverState *bs;
@@ -441,7 +441,7 @@ int bdrv_all_delete_snapshot(const char *name, BlockDri=
verState **first_bad_bs,
             bdrv_snapshot_find(bs, snapshot, name) >=3D 0)
         {
             ret =3D bdrv_snapshot_delete(bs, snapshot->id_str,
-                                       snapshot->name, err);
+                                       snapshot->name, errp);
         }
         aio_context_release(ctx);
         if (ret < 0) {
--=20
2.21.0


