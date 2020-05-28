Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF647C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4D2206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bG7AGXMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4D2206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGeR-0005H7-Tk
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jeGdv-0004s9-H0
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:24:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58193
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jeGdu-0006Vh-NZ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590665049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8s1sajyTDysXtQR/5vlYbK8JS6GWA7D7j5SlkOmjbXI=;
 b=bG7AGXMCIeRyzkIcuWOZSDh+LLiUTnqBXobFrZvzkuXXewiv0es93y69EZ56M6vZtfRsdx
 8HuBN+DwJpFzxHd7IdVlAEpPHfOYzsycVlhsrGG5PoKg6KThgPsmKZTapcu5P6iEpYrmeP
 mxDmbIIdU6Nu/b8clrjfSSU360nGWXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-p00UGW8XMR2aKXoHLl3a6w-1; Thu, 28 May 2020 07:24:07 -0400
X-MC-Unique: p00UGW8XMR2aKXoHLl3a6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B413C64AD0;
 Thu, 28 May 2020 11:24:06 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-230.ams2.redhat.com
 [10.36.114.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6F7A5D9EF;
 Thu, 28 May 2020 11:24:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org,
	ovoshcha@redhat.com
Subject: [PATCH] tests/acceptance/migration.py: Wait for both sides
Date: Thu, 28 May 2020 12:24:04 +0100
Message-Id: <20200528112404.121972-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When the source finishes migration the destination will still be
receiving the data sent by the source, so it might not have quite
finished yet, so won't quite have reached 'completed'.
This lead to occasional asserts in the next few checks.

After the source has finished, check the destination as well.
(We can't just switch to checking the destination, because it doesn't
give a status until it has started receiving the migration).

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/migration.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 0365289cda..792639cb69 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -35,6 +35,10 @@ class Migration(Test):
                       timeout=self.timeout,
                       step=0.1,
                       args=(src_vm,))
+        wait.wait_for(self.migration_finished,
+                      timeout=self.timeout,
+                      step=0.1,
+                      args=(dst_vm,))
         self.assertEqual(src_vm.command('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.command('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.command('query-status')['status'], 'running')
-- 
2.26.2


