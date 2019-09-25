Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1DC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A413F205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A413F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9HC-0003jO-Lo
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD8o2-00015T-T6
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD8o0-0004ke-Lv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD8o0-0004kL-G3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:02:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B70093090FD2;
 Wed, 25 Sep 2019 15:02:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-251.ams2.redhat.com
 [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640865C1D4;
 Wed, 25 Sep 2019 15:02:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, richardw.yang@linux.intel.com,
 alex.benee@linaro.org
Subject: [PULL 8/9] tests/migration/postcopy: trim migration bandwidth
Date: Wed, 25 Sep 2019 16:01:29 +0100
Message-Id: <20190925150130.12303-9-dgilbert@redhat.com>
In-Reply-To: <20190925150130.12303-1-dgilbert@redhat.com>
References: <20190925150130.12303-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 25 Sep 2019 15:02:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On slow hosts with tcg we were sometimes finding that the migration
would complete during precopy and never get into the postcopy test.
Trim back the bandwidth a bit to make that much less likely.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190923131022.15498-3-dgilbert@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 9c62ee5331..221a33d083 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -753,7 +753,7 @@ static int migrate_postcopy_prepare(QTestState **from=
_ptr,
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    migrate_set_parameter_int(from, "max-bandwidth", 100000000);
+    migrate_set_parameter_int(from, "max-bandwidth", 30000000);
     migrate_set_parameter_int(from, "downtime-limit", 1);
=20
     /* Wait for the first serial output from the source */
--=20
2.21.0


