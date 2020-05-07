Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C96FC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4927B206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpnjK5SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjIy-0006Yf-EL
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWjIK-000683-2R
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:22:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWjIJ-0004gZ-6P
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588868561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o3y71Cat0VccCpOoWbD9gh7BWGgglfLgnIkIYCt+VnQ=;
 b=cpnjK5SVcmDlA3yqcQN7o1JJifADMcxYF0nHsGFmjZ1ZnLAKMT3v7gK6jC6eW/C1wV+RzV
 aHqT5u/jIuAjHnxoHsfB2KAlaAyiyXOOB0aVe2MAKPLFU8sGebalPz+uQUZiUMlkQTWakN
 xByVoSzDK0eRoc2dU/d5pWSuFG3J69k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-1iJG0dyHNHSb1vTMEz1dkg-1; Thu, 07 May 2020 12:22:40 -0400
X-MC-Unique: 1iJG0dyHNHSb1vTMEz1dkg-1
Received: by mail-wr1-f72.google.com with SMTP id d16so2743463wrv.18
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 09:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5oB5CNbQPT5bUQNYOJqzGAde3gZgDdx/4Hkvz34qJLE=;
 b=Z1rMY7FjZMeuJprF0egE2OuAjEjzCUtEp9YNSGO7P+6rFGnp5cGXN6BfVyfj2FosfG
 UPUhZTu0rV3MyVKC/qS6320tnhgagqXBq737T0t+TNDFDfIw20f5QiUQs72Z4vhHXWjG
 tqKJnp9ULdfj4XhS8nXOr+GWB0eMYilWBCt1WQGyI/ZB+ogL1a53D4sB3lvHzi+ZlMK8
 OwtWB4Q4AgUETizGpdvoypnJW+8i61dMEcw9CTJ1Q2hjOlOkB8aJnPrCxGbtn0DIjkUK
 HiUK46Ps75TURXGIxsQemHEBDzhvfoDIxmMP6bqprRTbo8cEtLonxEKpqO0kYUGrDYGa
 oPmw==
X-Gm-Message-State: AGi0PuYQ4DUornTb7+M3Hv7VeFf2dsaEJb2EdGyQLeNbLzNZ7mi6Y6I6
 uwkBx5vypmIFEa148WMa9TTmk8XcER7alJpFfaaT1g1e5ksK2rhgQKaLusAxuwO6cV+Mr4If7ZB
 JyTAQZXExBuXP+yI=
X-Received: by 2002:a5d:688f:: with SMTP id h15mr16586929wru.352.1588868558538; 
 Thu, 07 May 2020 09:22:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypLYavILjbeJEdSqBXit58u14SbXA2FvJRH33x6h0AeHrzKXuyd0NxFDVmdLjfXxiXOvnXnYXQ==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr16586899wru.352.1588868558108; 
 Thu, 07 May 2020 09:22:38 -0700 (PDT)
Received: from localhost.localdomain (187.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.187])
 by smtp.gmail.com with ESMTPSA id q8sm8530108wmg.22.2020.05.07.09.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 09:22:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt' machine
 TCG test
Date: Thu,  7 May 2020 18:22:35 +0200
Message-Id: <20200507162235.1790-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BootLinuxAarch64.test_virt_tcg is reported to take >7min to run.
Add a possibility to users to skip this particular test, by setting
the AVOCADO_SKIP_SLOW_TESTS environment variable:

  $ AVOCADO_SKIP_SLOW_TESTS=3Dplease make check-acceptance
  ...
    (05/88) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: =
SKIP: Test takes >7min
  ...

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/boot_linux.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.p=
y
index 075a386300..a8df50d769 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -15,6 +15,7 @@
 from qemu.accel import kvm_available
 from qemu.accel import tcg_available
=20
+from avocado import skipIf
 from avocado.utils import cloudinit
 from avocado.utils import network
 from avocado.utils import vmimage
@@ -159,6 +160,7 @@ def add_common_args(self):
         self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
         self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/dev/=
urandom')
=20
+    @skipIf(os.getenv('AVOCADO_SKIP_SLOW_TESTS'), 'Test takes >7min')
     def test_virt_tcg(self):
         """
         :avocado: tags=3Daccel:tcg
--=20
2.21.3


