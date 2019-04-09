Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6633C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BC020850
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BC020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE0Bi-0002lJ-UR
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:29:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hE0Az-0002SN-1v
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hE0Ay-0008ST-8K
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hE0Ay-0008S2-0U
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 909D43018ECF
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 23:20:09 +0000 (UTC)
Received: from worklaptop.redhat.com (ovpn-123-33.rdu2.redhat.com
	[10.10.123.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91B4F64046;
	Tue,  9 Apr 2019 23:20:01 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 19:19:57 -0400
Message-Id:
 <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 09 Apr 2019 23:20:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] migration: savevm: fix error code with
 migration blockers
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cole Robinson <crobinso@redhat.com>,
	dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409231957.cQnVFebE5h7PKHuKYhKbJVgCcVw2JtCUhp8I_O3YNU8@z>

The only caller that checks the error code is looking for !=3D 0,
so returning false is incorrect.

Fixes: 5aaac467938 "migration: savevm: consult migration blockers"

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 migration/savevm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 34bcad3807..a3dae4cf02 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2544,7 +2544,7 @@ int save_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
=20
     if (migration_is_blocked(errp)) {
-        return false;
+        return ret;
     }
=20
     if (!replay_can_snapshot()) {
--=20
2.21.0


