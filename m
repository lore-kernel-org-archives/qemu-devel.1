Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F6CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2915420717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqYuhQyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2915420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4mb-0005RN-Hl
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xO-0003a0-VS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xJ-0002FO-G0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xJ-0002Dt-9S
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qlezfbb+DroBt18ovLnjs/YdrlwJEgwyBAG2+VKYQKI=;
 b=fqYuhQyimCEsfNdDHT3Dsa3XVjOL4ZIVyPTY4QI30kooipoi62HpbKKpQv24Y8cRU4Remb
 URhhb9vBFB63njHmXIbMeAkWyZZpG37Tv/LDZEQ5gkFQnuUBx7a2Molovd8m5d82UM5fgy
 j8FKf4BdVBUm9+8XZjPEioQyccoZlOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-E7H7BWO_MZiiSzYJ-S0v1Q-1; Mon, 28 Oct 2019 08:17:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EB46107AD28;
 Mon, 28 Oct 2019 12:17:01 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DE39100194E;
 Mon, 28 Oct 2019 12:17:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 57/69] qcow2: Repair snapshot table with too many entries
Date: Mon, 28 Oct 2019 13:14:49 +0100
Message-Id: <20191028121501.15279-58-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: E7H7BWO_MZiiSzYJ-S0v1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The user cannot choose which snapshots are removed.  This is fine
because we have chosen the maximum snapshot table size to be so large
(65536 entries) that it cannot be reasonably reached.  If the snapshot
table exceeds this size, the image has probably been corrupted in some
way; in this case, it is most important to just make the image usable
such that the user can copy off at least the active layer.
(Also note that the snapshots will be removed only with "-r all", so a
plain "check" or "check -r leaks" will not delete any data.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191011152814.14791-14-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-snapshot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 366d9f574c..dac8a778e4 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -444,6 +444,14 @@ int coroutine_fn qcow2_check_read_snapshot_table(Block=
DriverState *bs,
     s->snapshots_offset =3D be64_to_cpu(snapshot_table_pointer.snapshots_o=
ffset);
     s->nb_snapshots =3D be32_to_cpu(snapshot_table_pointer.nb_snapshots);
=20
+    if (s->nb_snapshots > QCOW_MAX_SNAPSHOTS && (fix & BDRV_FIX_ERRORS)) {
+        fprintf(stderr, "Discarding %u overhanging snapshots\n",
+                s->nb_snapshots - QCOW_MAX_SNAPSHOTS);
+
+        nb_clusters_reduced +=3D s->nb_snapshots - QCOW_MAX_SNAPSHOTS;
+        s->nb_snapshots =3D QCOW_MAX_SNAPSHOTS;
+    }
+
     ret =3D qcow2_validate_table(bs, s->snapshots_offset, s->nb_snapshots,
                                sizeof(QCowSnapshotHeader),
                                sizeof(QCowSnapshotHeader) * QCOW_MAX_SNAPS=
HOTS,
@@ -452,6 +460,12 @@ int coroutine_fn qcow2_check_read_snapshot_table(Block=
DriverState *bs,
         result->check_errors++;
         error_reportf_err(local_err, "ERROR ");
=20
+        if (s->nb_snapshots > QCOW_MAX_SNAPSHOTS) {
+            fprintf(stderr, "You can force-remove all %u overhanging snaps=
hots "
+                    "with qemu-img check -r all\n",
+                    s->nb_snapshots - QCOW_MAX_SNAPSHOTS);
+        }
+
         /* We did not read the snapshot table, so invalidate this informat=
ion */
         s->snapshots_offset =3D 0;
         s->nb_snapshots =3D 0;
--=20
2.21.0


