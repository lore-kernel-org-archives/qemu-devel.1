Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C8C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB13524677
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFPtwBcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB13524677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ylP-0004gg-Pl
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ykF-0003BN-M5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ykE-0006zv-I9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:36:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ykE-0006z3-Ex
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581539784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T3ylHUH4ZoFjUTnyfUiMekT5X2Pd1nXmD9oE7o/4Elk=;
 b=ZFPtwBcVCnxCZx8VSnT9G/rg/TRf1ZgbhlLdCiRgWYPh5T2cKy0ndkAp1BeMlAvqre3fsd
 A3+EcqTfUwarztUdlTCbNSB3JasaFUm6eD0csVTdkItJH4cYByIu+4+HYv1Qc43tVCnyKV
 VZphzTGTSHDINsnSVwwmGjcOmio8MmI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-tTbXZwVZMk6i72IBcAMyGA-1; Wed, 12 Feb 2020 15:36:22 -0500
Received: by mail-wr1-f69.google.com with SMTP id v17so1295872wrm.17
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z3rfLLywh1BohS0upHcyh0haLkZZAmJBOAw7ZMtEqQs=;
 b=CK9yx5INtWVbJZ6Vi9NTh8rUzCr3LgoOXnksQh1+ea9Brl/oKU1f9ZQYBLk99EzJP4
 WqxINUSUnnRKvMZPAPMb7A6W9/4r+hagVSVtBPQbmEBVrtFbW4bPa5Y/WQiUukSkpI07
 ODBqf3j/o/TTkdmbVoeCvTNNDWyj1aPist8jXClXZIvs3Zr3CC/HElNhO0YUU8u4UwQA
 Q/dBFDhJg5zAXWmpjlqOXdelJoWML8ZicaFtf+BrPePV3hE7/yxL0vk9pvN1KX59IVwq
 syz/3QYex7tEec1YIRcDOR/8Mv/i2M0/7/GCWnWCIwOc4SVbx3iAQvx20cV/1nKugrBp
 i5RQ==
X-Gm-Message-State: APjAAAWLA3IgssvfM+astsSf6Q60XAxG0tI2S6Krao7oOLgjVCNe3lTO
 GBkHYK3nnc3M4B/mY6N4IcDPqpuhGiWIQ15NpkHMUncfV3yZbFrv4DLgSicQ75DkJCbnSxFE4Si
 mLbdVSigdk4QtuTQ=
X-Received: by 2002:a5d:6151:: with SMTP id y17mr16674385wrt.110.1581539781512; 
 Wed, 12 Feb 2020 12:36:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzq/RPJnOOsDlAp4yiE4m6wgW+jFQg6qnfCReO88HcemRyGkDAGt4MLqcjNROvVoBmY7gxMVw==
X-Received: by 2002:a5d:6151:: with SMTP id y17mr16674366wrt.110.1581539781237; 
 Wed, 12 Feb 2020 12:36:21 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d22sm2124184wmd.39.2020.02.12.12.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:36:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests/acceptance/machine_sparc_leon3: Do not run HelenOS
 test by default
Date: Wed, 12 Feb 2020 21:36:19 +0100
Message-Id: <20200212203619.16450-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: tTbXZwVZMk6i72IBcAMyGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The www.helenos.org server is slow and downloading the Leon3 binary
takes too long [*]. Do not include this test in the default suite.

Similarly to commit 471c97a69b:

  Currently the Avocado framework does not distinct the time spent
  downloading assets vs. the time spent running a test. With big
  assets (like a full VM image) the tests likely fail.

  This is a limitation known by the Avocado team.
  Until this issue get fixed, do not run this tests automatically.

  Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
  environment variable.

[*] https://travis-ci.org/stsquad/qemu/jobs/649599880#L4198

Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add missing staged hunk...
---
 tests/acceptance/machine_sparc_leon3.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/mac=
hine_sparc_leon3.py
index f77e210ccb..27e4717a51 100644
--- a/tests/acceptance/machine_sparc_leon3.py
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -5,6 +5,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
=20
+import os
+
+from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
=20
@@ -13,6 +16,7 @@ class Leon3Machine(Test):
=20
     timeout =3D 60
=20
+    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout=
')
     def test_leon3_helenos_uimage(self):
         """
         :avocado: tags=3Darch:sparc
--=20
2.21.1


