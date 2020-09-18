Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E24C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5C021D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ5FC6iF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5C021D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMGv-00011o-0U
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJLuZ-0001CO-5e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:19:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJLuX-0003Uq-7v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 15:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600456747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHifekctAkQUw0C78X6fF5aZ8jpanmBPsUw9doBQVOU=;
 b=MQ5FC6iFo0gfKgU3/BAVVVM5laYPyJ0F7fH7b4vaXfRK1pZ3plzFE2J2gcx+VAus1B35Lt
 hoNi2/1OrAYMgkB6YsDeawX55Wfu1ArnaSScy97Rz41iisSh7lO/dnLvgEZq6G/82Bo3li
 4Y/SABhS6z3MN/gfyaChg9ilMvfTVHs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-WfBDlqpwOvylgKXj6jVQsA-1; Fri, 18 Sep 2020 15:19:06 -0400
X-MC-Unique: WfBDlqpwOvylgKXj6jVQsA-1
Received: by mail-wm1-f69.google.com with SMTP id w3so2419532wmg.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 12:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yHifekctAkQUw0C78X6fF5aZ8jpanmBPsUw9doBQVOU=;
 b=U2RZVBIoEkfn0QEIGpfDcjsdBfRJAfLhFfRqdK7dkXNmZEpYlJqSgS36Rb+tJ4lSDk
 npPNIUlkwfOCDeGG95ZRFrQNLLWwtfoxV4ImnslAmFX6l91MKVTiliKx8gbgZ/L+hQJs
 LnGniUS/S3H0Cur03hVxWgaiA56BDjc+XX+upeIQWgGaIRQ+ydxWTKbth4PydMRaPipw
 zaf4zhGFxXI9j4BpRJEGSK9wq051H9rrLIOEItlUZcRMmmBRtlohShAr4ALUopnZ1Y8L
 VgyZbXn1/4DWDpkM5rbFfbbILoBhWO7RYJgMW3OaC7oQs3mO2yJKMqheunJ6UpzKhd7V
 Fsqw==
X-Gm-Message-State: AOAM532crU5yZRJznAh48GumEQ6x1RSqkaWsEJ2AsB5C0FqlWGdh6DY1
 vuHPtZ7z0Ui6pksU6zq8x5qn3c4cm/cqkhuIHOGj1ervq07rnnyRI73+d6peK1Nf3KxQ1FKIour
 jwyJiMg1QbsZqKBI=
X-Received: by 2002:a1c:750d:: with SMTP id o13mr17975848wmc.54.1600456744811; 
 Fri, 18 Sep 2020 12:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRrSTn7eFHtH1NWxV1xhkYdYmUFNi06C4my9MoYPOXW1vKVq6wWvmnSfT50ziqy54l4QEPtw==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr17975836wmc.54.1600456744608; 
 Fri, 18 Sep 2020 12:19:04 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q13sm7602093wra.93.2020.09.18.12.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 12:19:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] tests/acceptance: Skip slow quanta-gsj U-boot+Linux test
Date: Fri, 18 Sep 2020 21:18:52 +0200
Message-Id: <20200918191852.189151-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918191852.189151-1-philmd@redhat.com>
References: <20200918191852.189151-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Willian Rampazzo <willianr@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
https://gitlab.com/philmd/qemu/-/jobs/745483978#L846
and also sometimes on my workstation, so proceed as with
the other slow tests: do not run it by default.
The test can still be run setting the AVOCADO_TIMEOUT_EXPECTED
environment variable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Havard Skinnemoen <hskinnemoen@google.com>
Tested-by: Havard Skinnemoen <hskinnemoen@google.com>
Message-Id: <20200918143355.153522-1-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 68534693109..0118ed59156 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -572,6 +572,7 @@ def test_arm_cubieboard_sata(self):
                                                 'sda')
         # cubieboard's reboot is not functioning; omit reboot test.
 
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
     def test_arm_quanta_gsj(self):
         """
         :avocado: tags=arch:arm
-- 
2.26.2


