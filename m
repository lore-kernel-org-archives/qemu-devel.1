Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE1C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027A12075A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKA8bi1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027A12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkBg-0001XT-5K
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFkA4-0007bS-VH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFkA3-00074n-5n
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599596651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPaSbBIU7l9bqFaxkwZYxiaYEyCWbc83GV5pYLgzi+4=;
 b=TKA8bi1RcDH0jA5tILnD+iB9WLwT/1v2s8Xhdfwt8GQbRkXZyfqIb8yDWlOx0OV/Ikj4g0
 At8A4uw8aO9SoiSAOnJfXSRK4Be35Tf0t6cBXtjyjqXVneSdii9O1GIVBOhm8Pnqv27JYU
 dZn04cdx31ONvqJsc/T/tCrdcOnxVYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Gu1kFTxmPfeANu9YM3bUyQ-1; Tue, 08 Sep 2020 16:24:07 -0400
X-MC-Unique: Gu1kFTxmPfeANu9YM3bUyQ-1
Received: by mail-wm1-f69.google.com with SMTP id l26so186483wmg.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OPaSbBIU7l9bqFaxkwZYxiaYEyCWbc83GV5pYLgzi+4=;
 b=CbswtftwosF7NoBJA+1Sai4MyrZP/ve/F/c1ckgYiNAPOgzbVsPEkkwKebCzaTsleg
 snITUL00j+M4tvG/+u4fl6Ajz3BNz6K7gARmEog+jxLp0Ss1F+T5Yf+QC+QS9nMdKBCp
 r30YGvG4YNvkRyCcxQUC0CduKwohS3Bdo/M3Xz7yxSAy/KAExnkdociHa/2qyZhDTfAe
 bS3uS0LieJWtj9xmXnHkB24KgmtsQpkMu+muLfMQru2bcNblxnnvxHFEDOsHe8EjKGFU
 8CbI4C90QUe+99YXVcwK90GD3OVaA+fQ5nLSdt5bRX3xytMVXF6HXYRpHuj4BI6DoOwf
 ewWg==
X-Gm-Message-State: AOAM5332Z919ea81onBdFc5+36fT2CgrQG+ci4Pm6rBJrmRiedEsWRPv
 p5mWFewlxu795QfoizzlP8eAoi/MVFd/4Ao+7Wo/ZQGlU0ADcadnJdcf2wR86YaAhRZMpxv4iqp
 HS72KQay1Aock3uk=
X-Received: by 2002:adf:f290:: with SMTP id k16mr416305wro.124.1599596646016; 
 Tue, 08 Sep 2020 13:24:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpoDgSrb4lwFGRMgGzQCPq0YVi8j0PttLJZHksyFfLYzkVp5vwBqNXEDjVQTGolu6vN2PRKw==
X-Received: by 2002:adf:f290:: with SMTP id k16mr416293wro.124.1599596645864; 
 Tue, 08 Sep 2020 13:24:05 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n11sm717776wrx.91.2020.09.08.13.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:24:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tests/acceptance: Add
 Test.fetch_asset(cancel_on_missing=True)
Date: Tue,  8 Sep 2020 22:23:52 +0200
Message-Id: <20200908202352.298506-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908202352.298506-1-philmd@redhat.com>
References: <20200908202352.298506-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Invert the default of avocado.Test.fetch_asset 'cancel_on_missing'
keyword: accept missing artefacts by default. If a test is certain
an artifact can't be missing, it will set cancel_on_missing=False.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index db9c0f5d79d..4cda0371879 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -192,3 +192,15 @@ def get_vm(self, *args, name=None):
     def tearDown(self):
         for vm in self._vms.values():
             vm.shutdown()
+
+    def fetch_asset(self, name,
+                    asset_hash=None, algorithm=None,
+                    locations=None, expire=None,
+                    find_only=False, cancel_on_missing=True):
+        return super(Test, self).fetch_asset(name,
+                        asset_hash=asset_hash,
+                        algorithm=algorithm,
+                        locations=locations,
+                        expire=expire,
+                        find_only=find_only,
+                        cancel_on_missing=cancel_on_missing)
-- 
2.26.2


