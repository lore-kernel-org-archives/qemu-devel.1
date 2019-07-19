Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717FC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC182173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC182173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTEA-0006tf-GB
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTBI-00048c-Lh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTBH-0003dL-LT
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTBF-0003a2-DC; Fri, 19 Jul 2019 09:44:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B51BC0703A8;
 Fri, 19 Jul 2019 13:44:11 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFD29608A4;
 Fri, 19 Jul 2019 13:44:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:44 +0200
Message-Id: <20190719134345.23526-13-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 19 Jul 2019 13:44:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/13] vl: Drain before (block) job cancel when
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

If the main loop cancels all block jobs while the block layer is not
drained, this cancelling may not happen instantaneously.  We can start a
drained section before vm_shutdown(), which entails another
bdrv_drain_all(); this nested bdrv_drain_all() will thus be a no-op,
basically.

We do not have to end the drained section, because we actually do not
want any requests to happen from this point on.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 vl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/vl.c b/vl.c
index a5808f9a02..53335a5470 100644
--- a/vl.c
+++ b/vl.c
@@ -4480,6 +4480,17 @@ int main(int argc, char **argv, char **envp)
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
2.20.1


