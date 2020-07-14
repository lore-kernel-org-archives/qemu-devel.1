Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C58C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573772072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJ5sk1ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573772072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTOF-0000ed-H6
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJs-0001Ae-MO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJh-0004j9-Ro
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI/gwTOC/ILtlhkZf0FnguyCxPWQjiV56qaIviljiXg=;
 b=cJ5sk1ls3gkj15Zy30hgCk6IQc2XfL1howXf40k0hXnE/hNUZkGXnMOOuQdM6RejPHiqlU
 Z7brF453PuoUdOj3SSQC2hjfxmGO0ZqrojnwacJeDRyQovQYqpKjd/c6l1I3hprqbx4gKK
 hM8SjbxW0GAtYju9HAEFZS5+mdjyL2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-5miYbdudO9CRUfyIytE0fA-1; Tue, 14 Jul 2020 18:22:23 -0400
X-MC-Unique: 5miYbdudO9CRUfyIytE0fA-1
Received: by mail-wr1-f72.google.com with SMTP id i12so20685wrx.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yI/gwTOC/ILtlhkZf0FnguyCxPWQjiV56qaIviljiXg=;
 b=L70WkW7lD7rR8Y8Q+WtWfuc9nDVIbry/XWwXD36lK1iv2z88tRz16qyjH7vduWswoL
 R0+5p4ZJtYnnAJll8GHaXJNZ9MpmmAjbl4SI7idb4NCcGSgCj2iP1gQZGLOxAW2lRLhu
 07ff9kP/Ez9OKQJVY8PgCDH5sgW9hoGoSE1KlbfZ1wtihWM7Gt+Wn3x+Vqm4t/bgxYPK
 BxDxBCGB/eLjP8l4h6L/lws23o7JbDJDQ3Vm4pgg96GlWLRqyWt/41KqFw4KsFPQWnHm
 iE03gR5PkaKceW2QJM+cqFJYrAY/0woOuVmbSsNB8b12+mfQuvDwlTW805dU1U5ZKDh/
 cc9g==
X-Gm-Message-State: AOAM5322zeoiH3eF8kYxEnh75c15Z45zuNVgzVB21MiLPCT+nT97itlp
 8swucyYwHvw4mie4G1WFftTnm6RfsxZTA3sAgqV5ZpnyDSssYyZB/o4kxFNSmZnXHvKsr49urNd
 xc+JxaFbWaVCeCDo=
X-Received: by 2002:a1c:e209:: with SMTP id z9mr5861731wmg.153.1594765341877; 
 Tue, 14 Jul 2020 15:22:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjmKxmbIJW0/cPl2BPl6yPDtNyf1lHyHgquft37qp4ZS8FqBv/eUDsxQxvcesIaxdOKwQPrA==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr5861718wmg.153.1594765341691; 
 Tue, 14 Jul 2020 15:22:21 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k18sm186277wrx.34.2020.07.14.15.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] tests/acceptance: Don't test reboot on cubieboard
Date: Wed, 15 Jul 2020 00:21:23 +0200
Message-Id: <20200714222132.10815-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

cubieboard does not have a functioning reboot, it halts and QEMU does
not exit.

vm.shutdown() is modified in a forthcoming patch that makes it less tolerant
of race conditions on shutdown; tests should consciously decide to WAIT
or to SHUTDOWN qemu.

So long as this test is attempting to reboot, the correct choice would
be to WAIT for the VM to exit. However, since that's broken, we should
SHUTDOWN instead.

SHUTDOWN is indeed what already happens when the test performs teardown,
however, if anyone fixes cubieboard reboot in the future, this test will
develop a new race condition that might be hard to debug.

Therefore: remove the reboot test and make it obvious that the VM is
still running when the test concludes, where the test teardown will do
the right thing.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-10-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 5867ef760c..8b8b828bc5 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -508,9 +508,7 @@ def test_arm_cubieboard_initrd(self):
                                                 'Allwinner sun4i/sun5i')
         exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
                                                 'system-control@1c00000')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # NB: Do not issue vm.wait() here, cubieboard's reboot does not exit!
+        # cubieboard's reboot is not functioning; omit reboot test.
 
     def test_arm_cubieboard_sata(self):
         """
@@ -553,9 +551,7 @@ def test_arm_cubieboard_sata(self):
                                                 'Allwinner sun4i/sun5i')
         exec_command_and_wait_for_pattern(self, 'cat /proc/partitions',
                                                 'sda')
-        exec_command_and_wait_for_pattern(self, 'reboot',
-                                                'reboot: Restarting system')
-        # NB: Do not issue vm.wait() here, cubieboard's reboot does not exit!
+        # cubieboard's reboot is not functioning; omit reboot test.
 
     def test_arm_orangepi(self):
         """
-- 
2.21.3


