Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A49C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DAE20830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DAE20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhOs-0004pc-Vg
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:27:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFy-0005d5-4p
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNhFx-00050U-0v
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNhFu-0004wH-CL; Mon, 06 May 2019 13:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6F3081E0C;
	Mon,  6 May 2019 17:18:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-82.ams2.redhat.com
	[10.36.117.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E4D51001DF9;
	Mon,  6 May 2019 17:18:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 19:18:02 +0200
Message-Id: <20190506171805.14236-8-kwolf@redhat.com>
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 06 May 2019 17:18:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 07/10] block: Add
 blk_set_allow_aio_context_change()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some users (like block jobs) can tolerate an AioContext change for their
BlockBackend. Add a function that tells the BlockBackend that it can
allow changes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend.h |  1 +
 block/block-backend.c          | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backen=
d.h
index 5be6224226..938de34fe9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -103,6 +103,7 @@ int blk_set_perm(BlockBackend *blk, uint64_t perm, ui=
nt64_t shared_perm,
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_pe=
rm);
=20
 void blk_set_allow_write_beyond_eof(BlockBackend *blk, bool allow);
+void blk_set_allow_aio_context_change(BlockBackend *blk, bool allow);
 void blk_iostatus_enable(BlockBackend *blk);
 bool blk_iostatus_is_enabled(const BlockBackend *blk);
 BlockDeviceIoStatus blk_iostatus(const BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 0e75fc8849..4c0a8ef88d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -71,6 +71,7 @@ struct BlockBackend {
     uint64_t shared_perm;
     bool disable_perm;
=20
+    bool allow_aio_context_change;
     bool allow_write_beyond_eof;
=20
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
@@ -1092,6 +1093,11 @@ void blk_set_allow_write_beyond_eof(BlockBackend *=
blk, bool allow)
     blk->allow_write_beyond_eof =3D allow;
 }
=20
+void blk_set_allow_aio_context_change(BlockBackend *blk, bool allow)
+{
+    blk->allow_aio_context_change =3D allow;
+}
+
 static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
                                   size_t size)
 {
@@ -1891,6 +1897,10 @@ static bool blk_root_can_set_aio_ctx(BdrvChild *ch=
ild, AioContext *ctx,
 {
     BlockBackend *blk =3D child->opaque;
=20
+    if (blk->allow_aio_context_change) {
+        return true;
+    }
+
     /* Only manually created BlockBackends that are not attached to anyt=
hing
      * can change their AioContext without updating their user. */
     if (!blk->name || blk->dev) {
--=20
2.20.1


