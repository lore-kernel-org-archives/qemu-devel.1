Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8D8C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E012242A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRhKsSMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E012242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZb4g-00041h-Qm
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb2y-00023K-SA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb2x-00056I-1M
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604328178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UYZMAjZdsbOMrPX+8Jgmz9tN62XrUtMBK1x3PbC+Aw=;
 b=RRhKsSMQduGnJNwDczl75swbIy5rmF3RzvLC9IM3n2YnXQJla9epnzA9AvtlduF3Ih2EJc
 O8X3Hn7pTadBFPz4qtzlw88n45JPe1Wn9GVQTJlOlBsh82s7mU5q439vrcC2kbinLoQg+G
 vicaOIdQP2RRG9BOiVRYlVvx810l6Yo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-VEVnV-M1N2-UCnDOBVB5-g-1; Mon, 02 Nov 2020 09:42:56 -0500
X-MC-Unique: VEVnV-M1N2-UCnDOBVB5-g-1
Received: by mail-wr1-f70.google.com with SMTP id i1so6495425wrb.18
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0UYZMAjZdsbOMrPX+8Jgmz9tN62XrUtMBK1x3PbC+Aw=;
 b=G6YL6bpJ9DaSXgsETNRMr5O+W8FqvQOEQETuspny7aDjzgtcupuKta1EHEHvGXC77q
 RO+8XUWXjYGRpNUJR9Gok9P2d3HfCbxXWwjHIThYqbmmCo4RUBnKSY1CTVcOxBaCrdxU
 aaWTJCJ47ePN43zVD/zsB1rd3ztd3ifYmHomj7xfTL4uodc09CVw8avLZNoDHWLWQD1S
 eZqQd34bXDf8kxt0kgOhwXWGkPmi0bF30ahQ4E0gwN74X5OBEf6YDxSgh/rgzmpBNCdO
 SOyBfh0wE2iOBImdh/AUNI8gYfzuvo73vGp9bMDB/LOpilSnR/B72vtQqf3aM2W3zKAE
 aGFg==
X-Gm-Message-State: AOAM532epYSUfM7NlmU/duaz2t6lbckyEgrFFCEYgqu76jHyzWfZHDBi
 Z95JE3ivvyTdWV5hQVwOyU2clq51OEF/xIfNfLNZHyWaQ/j9Kr/+AgtrhSy4bmJkEZRah8KE43f
 zyvcbN08Xf7Km+ak=
X-Received: by 2002:adf:fd8a:: with SMTP id d10mr19953668wrr.85.1604328175170; 
 Mon, 02 Nov 2020 06:42:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwhUurGPjd7MjqRJk55FT+bsDcssvJr4f8xbzMPSaiwDsDHEzYI7k+J13o1BvOQ1u7yAhBPg==
X-Received: by 2002:adf:fd8a:: with SMTP id d10mr19953642wrr.85.1604328174982; 
 Mon, 02 Nov 2020 06:42:54 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b8sm1715681wmj.9.2020.11.02.06.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 06:42:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH-for-5.2? 1/5] tests/acceptance: Restrict virtio_check_params
 tests to X86 target
Date: Mon,  2 Nov 2020 15:42:41 +0100
Message-Id: <20201102144245.2134077-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102144245.2134077-1-philmd@redhat.com>
References: <20201102144245.2134077-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>, Aurelien Jarno <aurelien@aurel32.net>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We disabled the virtio_check_params tests in commit 2d6a6e238a2
("tests/acceptance/virtio_check_params: Disable the test"),
because these tests were making multiarch CI fail (virtio is
multiarch).

We took the big hammer, as we can restrict the tests to the X86
arch. Restore them on this single arch.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/virtio_check_params.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/virtio_check_params.py
index 87e6c839d14..fecf1c094b1 100644
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -42,6 +42,12 @@
 
 
 class VirtioMaxSegSettingsCheck(Test):
+    """
+    This test should be multi-arch, however only X86 is implemented.
+
+    :avocado: tags=arch:x86_64
+    """
+
     @staticmethod
     def make_pattern(props):
         pattern_items = ['{0} = \w+'.format(prop) for prop in props]
@@ -117,7 +123,6 @@ def seg_max_adjust_enabled(mt):
             return True
         return False
 
-    @skip("break multi-arch CI")
     def test_machine_types(self):
         # collect all machine types except 'none', 'isapc', 'microvm'
         with QEMUMachine(self.qemu_bin) as vm:
-- 
2.26.2


