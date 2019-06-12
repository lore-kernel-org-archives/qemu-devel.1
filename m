Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5FEC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A5320896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 22:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A5320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbBVX-0001h2-Oj
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 18:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbBQR-0005lp-NB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbBQP-0006Wd-MP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 18:08:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbBQK-0006Sh-CG; Wed, 12 Jun 2019 18:08:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B245307C945;
 Wed, 12 Jun 2019 22:08:44 +0000 (UTC)
Received: from localhost (unknown [10.40.205.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CE4B61D09;
 Wed, 12 Jun 2019 22:08:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 13 Jun 2019 00:08:38 +0200
Message-Id: <20190612220839.1374-2-mreitz@redhat.com>
In-Reply-To: <20190612220839.1374-1-mreitz@redhat.com>
References: <20190612220839.1374-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 22:08:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] vl: Drain before (block) job cancel when
 quitting
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the main loop cancels all block jobs while the block layer is not
drained, this cancelling may not happen instantaneously.  We can start a
drained section before vm_shutdown(), which entails another
bdrv_drain_all(); this nested bdrv_drain_all() will thus be a no-op,
basically.

We do not have to end the drained section, because we actually do not
want any requests to happen from this point on.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I don't know whether it actually makes sense to never end this drained
section.  It makes sense to me.  Please correct me if I'm wrong.
---
 vl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/vl.c b/vl.c
index cd1fbc4cdc..3f8b3f74f5 100644
--- a/vl.c
+++ b/vl.c
@@ -4538,6 +4538,17 @@ int main(int argc, char **argv, char **envp)
      */
     migration_shutdown();
=20
+    /*
+     * We must cancel all block jobs while the block layer is drained,
+     * or cancelling will be affected by throttling and thus may block
+     * for an extended period of time.
+     * vm_shutdown() will bdrv_drain_all(), so we may as well include
+     * it in the drained section.
+     * We do not need to end this section, because we do not want any
+     * requests happening from here on anyway.
+     */
+    bdrv_drain_all_begin();
+
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
=20
--=20
2.21.0


