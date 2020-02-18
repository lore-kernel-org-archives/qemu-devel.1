Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69058C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EBC208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkQh3Lh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EBC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43nN-0006ho-9k
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43YC-0008Dh-Gy
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43YB-0001j9-DU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43YB-0001io-8U
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqCI6QZU3Y6J3D+/9H+VW/2BTLaArSNSweIdUx1Y1hg=;
 b=CkQh3Lh/+PDCEK/GZQy1X+RvaIf8C5w9BE+7x9Bu/A24kK11U0MIStf94H4zFoVqaEkkPx
 SVKyGhEqM+WO23QDOBH3mGkbb7kk9M7lJjWYYxUHH98kVma3v4eCoOb7S/Ob2fDJnNat0p
 jQCu5dVXsEZ4aUB1BTPCHgDnchNXp7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-VhhKI_jqPPCBnltH4VT2Bw-1; Tue, 18 Feb 2020 09:08:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A0B18FE866;
 Tue, 18 Feb 2020 14:08:29 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 241C319E9C;
 Tue, 18 Feb 2020 14:08:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 28/36] mirror: Double-check immediately before replacing
Date: Tue, 18 Feb 2020 15:07:14 +0100
Message-Id: <20200218140722.23876-29-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: VhhKI_jqPPCBnltH4VT2Bw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

There is no guarantee that we can still replace the node we want to
replace at the end of the mirror job.  Double-check by calling
bdrv_recurse_can_replace().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200218103454.296704-12-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index cacbc70014..447051dbc6 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -700,7 +700,19 @@ static int mirror_exit_common(Job *job)
          * drain potential other users of the BDS before changing the grap=
h. */
         assert(s->in_drain);
         bdrv_drained_begin(target_bs);
-        bdrv_replace_node(to_replace, target_bs, &local_err);
+        /*
+         * Cannot use check_to_replace_node() here, because that would
+         * check for an op blocker on @to_replace, and we have our own
+         * there.
+         */
+        if (bdrv_recurse_can_replace(src, to_replace)) {
+            bdrv_replace_node(to_replace, target_bs, &local_err);
+        } else {
+            error_setg(&local_err, "Can no longer replace '%s' by '%s', "
+                       "because it can no longer be guaranteed that doing =
so "
+                       "would not lead to an abrupt change of visible data=
",
+                       to_replace->node_name, target_bs->node_name);
+        }
         bdrv_drained_end(target_bs);
         if (local_err) {
             error_report_err(local_err);
--=20
2.20.1


