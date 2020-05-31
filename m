Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67F3C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8360D2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6krOIEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8360D2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRAw-0002FD-OC
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0m-0003fY-AT
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47003
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0k-00075g-Vv
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NeYhFc6juZkPrqvPgAt2uIQTGjMzeewfSJodiqWwwkw=;
 b=M6krOIEyp+NONDO30S7ZKr5lEfDMnujgBDcVgt3KSk5kdovvN84KQtLMPQd85iiCCyHsP1
 nLT9sn0+xUm4f01nvBdcwBQ61pNKpsmxX7UI4u9zszOVGpLZuHR/Ex1XSgV+FyxlWrHFL0
 yBKjjaqSFmWm54gTEly8w+vMClwWadM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-GlhV1XoaO8aiRkjSiqQ3jQ-1; Sun, 31 May 2020 12:40:32 -0400
X-MC-Unique: GlhV1XoaO8aiRkjSiqQ3jQ-1
Received: by mail-wr1-f72.google.com with SMTP id l18so3650913wrm.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NeYhFc6juZkPrqvPgAt2uIQTGjMzeewfSJodiqWwwkw=;
 b=pg6Q5/BJlc6i/iURgYsDx9L28Lu/PW0YRE/gA07kw2ShcK+97YnQ90tWStXjusw3en
 6EaRUp4LNRgr3RM9LfPPus+XCnlMpBjLP4L0mE3O+Hj0RRF3rqOZZmSzvNnOGga326yJ
 UYq8tIsDpINTEl01a5KXi9FRBRQf5Ah3F5H7EZpcWsjOIP/zpVPeASLlnkt3WpmswyOk
 kkS8oTM6HtGbpX0HJ0/audRX3D0xeUa9rYwZzvHAz/UuRJ30dFjRi75kf2SAHrQArj1I
 PQH8HgS5qMAKa8yqwNc4EyNuGJurNrPkfo792/jwI51RxWs+ZfNXpsyc9f0EU3BnMxuZ
 JYFQ==
X-Gm-Message-State: AOAM533RqkghEYKWLWHtIDSYoWogTg9l95IVkBV3rYRxQDrUR+VMrRD/
 Hq5xTZIgJPPq3Dl1ZNSM26gQfLD3mt/qrqDeizjLk2QaGTv4JgkcpAFsP6TfBOowACc6/GBnQ8b
 t5qv0zV73zVJhgW0=
X-Received: by 2002:a5d:628c:: with SMTP id k12mr17814523wru.211.1590943231326; 
 Sun, 31 May 2020 09:40:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQhmvCd9JeaOCqg0GzXFrykGN6A9vNWGNP+OY36M63eNUdY7+avBRNroyItWUmvC8DxOTmCA==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr17814494wru.211.1590943231095; 
 Sun, 31 May 2020 09:40:31 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id q4sm9026212wma.47.2020.05.31.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/25] tests/vm: allow wait_ssh() to specify command
Date: Sun, 31 May 2020 18:38:41 +0200
Message-Id: <20200531163846.25363-21-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Robert Foley <robert.foley@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

This allows for waiting for completion of arbitrary commands.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200529203458.1038-7-robert.foley@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5a3ce42281..a80b616a08 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -320,24 +320,24 @@ def console_sshd_config(self, prompt):
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
-    def wait_ssh(self, wait_root=False, seconds=300):
+    def wait_ssh(self, wait_root=False, seconds=300, cmd="exit 0"):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
-        guest_up = False
+        cmd_success = False
         while datetime.datetime.now() < endtime:
-            if wait_root and self.ssh_root("exit 0") == 0:
-                guest_up = True
+            if wait_root and self.ssh_root(cmd) == 0:
+                cmd_success = True
                 break
-            elif self.ssh("exit 0") == 0:
-                guest_up = True
+            elif self.ssh(cmd) == 0:
+                cmd_success = True
                 break
             seconds = (endtime - datetime.datetime.now()).total_seconds()
             logging.debug("%ds before timeout", seconds)
             time.sleep(1)
-        if not guest_up:
+        if not cmd_success:
             raise Exception("Timeout while waiting for guest ssh")
 
     def shutdown(self):
-- 
2.21.3


