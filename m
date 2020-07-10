Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AA32076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dajxNXVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AA32076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlJq-00089c-3y
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFf-00009b-7W
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlFd-0006Wy-P0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594357629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHT0VN6/ENNVofGVCn0KbOgk28q5J4kD2/DQcPQ/Wy8=;
 b=dajxNXVWI/isUpwWWcDLH+OJfY8J4rr2fyfQ1KTFR6cufNAq2bnCapWGBHTT1Ndqqq93rG
 GF5AI85NiJ2qtFhGl5m9FlB6xO+wpUBkhz6ou8THP+FTUgXfthIMXLsS/OtIZppGqUNq0I
 7qNyrJRhlmVXqNM1e8RrFL4N+AIm0LY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-m-gbBxRLN1W44H5tNcQ7QQ-1; Fri, 10 Jul 2020 01:07:06 -0400
X-MC-Unique: m-gbBxRLN1W44H5tNcQ7QQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9624380183C;
 Fri, 10 Jul 2020 05:07:05 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BFFA10023A5;
 Fri, 10 Jul 2020 05:07:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/12] python/machine.py: Add a configurable timeout to
 shutdown()
Date: Fri, 10 Jul 2020 01:06:43 -0400
Message-Id: <20200710050649.32434-7-jsnow@redhat.com>
In-Reply-To: <20200710050649.32434-1-jsnow@redhat.com>
References: <20200710050649.32434-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Three seconds is hardcoded. Use it as a default parameter instead, and use that
value for both waits that may occur in the function.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index e66a7d66dd..120e0df3ee 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -382,7 +382,9 @@ def wait(self):
         self._popen.wait()
         self._post_shutdown()
 
-    def shutdown(self, has_quit=False, hard=False):
+    def shutdown(self, has_quit: bool = False,
+                 hard: bool = False,
+                 timeout: Optional[int] = 3) -> None:
         """
         Terminate the VM and clean up
         """
@@ -398,10 +400,10 @@ def shutdown(self, has_quit=False, hard=False):
                 try:
                     if not has_quit:
                         self._qmp.cmd('quit')
-                    self._popen.wait(timeout=3)
+                    self._popen.wait(timeout=timeout)
                 except:
                     self._popen.kill()
-            self._popen.wait()
+            self._popen.wait(timeout=timeout)
 
         self._post_shutdown()
 
-- 
2.21.3


