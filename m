Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8BD206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmPvv0hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8BD206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlNm-0005uD-UM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFr-0000dZ-Lx
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFo-0006Xv-J3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594357639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzn1o+YUoRu7GB/p8pKHyf+ZTZji1i13R8CKkOW2wV8=;
 b=SmPvv0hcCDOC+UVb4pi48h458FbD7KY0IQOEAtWHwIqPpFAibQVLR/DBO88LwNlEb2QeLE
 pV8w3oI5vr+MCcfBJKXYF902e1DiMnAvFZI8b6UUhIFphyESxmnm4VZf6rdF+Mw22GuOV7
 UshcUIySFwW31KiD/07QfnHzpClqfTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-3RA9QWmlMDubAxmc7UL0qA-1; Fri, 10 Jul 2020 01:07:17 -0400
X-MC-Unique: 3RA9QWmlMDubAxmc7UL0qA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEF0710059BF;
 Fri, 10 Jul 2020 05:07:16 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A1DB10098A1;
 Fri, 10 Jul 2020 05:07:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/12] python/machine.py: change default wait timeout to 3
 seconds
Date: Fri, 10 Jul 2020 01:06:49 -0400
Message-Id: <20200710050649.32434-13-jsnow@redhat.com>
In-Reply-To: <20200710050649.32434-1-jsnow@redhat.com>
References: <20200710050649.32434-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Machine.wait() does not appear to be used except in the acceptance tests,
and an infinite timeout by default in a test suite is not the most helpful.

Change it to 3 seconds, like the default shutdown timeout.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 02d66e3cff..d08a8e4a6e 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -472,12 +472,12 @@ def kill(self):
         """
         self.shutdown(hard=True)
 
-    def wait(self, timeout: Optional[int] = None) -> None:
+    def wait(self, timeout: Optional[int] = 3) -> None:
         """
         Wait for the VM to power off and perform post-shutdown cleanup.
 
         :param timeout: Optional timeout in seconds.
-                        Default None, an infinite wait.
+                        Default 3 seconds, A value of None is an infinite wait.
         """
         self.shutdown(has_quit=True, timeout=timeout)
 
-- 
2.21.3


