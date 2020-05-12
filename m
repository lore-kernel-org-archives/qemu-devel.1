Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5595C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47D9206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aekZJm/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47D9206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSFh-00019O-PJ
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDr-00072c-Te
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:33:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDr-0007Y5-9c
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589279594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eW6bfQ4PBPfgnbJADVXdHyk1e9elM2KC/4eDs8BhUVc=;
 b=aekZJm/RSMV6zYUAI3D82F9PQRsdxQAqlop/UIAnBsEz090tMhoTFGafStnN4wEEDikpf1
 gSUG8g5G7T5+gQ8GG9MdSJoyE45qejWLbdtty4AnAsOaG2xyPCAJybKfWP+9w86k2cz7Cm
 jHgqQ4jaqozwTpS/A7jz3B5STdJERdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-tVDQmIWMOXGiqwb4lNYmJw-1; Tue, 12 May 2020 06:33:10 -0400
X-MC-Unique: tVDQmIWMOXGiqwb4lNYmJw-1
Received: by mail-wr1-f71.google.com with SMTP id 90so6661902wrg.23
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 03:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eW6bfQ4PBPfgnbJADVXdHyk1e9elM2KC/4eDs8BhUVc=;
 b=E5k23rUJrCox/5josG+bd+UDA/wAvp+Tkx635wt9JEinQE47F+nA0jj1rpUgWma3Q+
 x8Twfl/PTFucyDqLo8Q5qG/b//Ymw11MAFXGKfPDV3XbP6POY9jQ4WT3E6fGLVKNiSO/
 hpB+ItK4Xmj6dQVexapZEMHjI8MAKwPWRIkmMRY0VKUnUL1s9uY6tqhwxYIg0ySLefY6
 6UmP9l1F2eahcbn2TfdMzXLbWqepBHgUg2jN5S9pkxVB4lQiDX1DF4feqQ3lRn6MgIi9
 vzMDSGs41gv/5wWdgSZEoKopHx5a4JFvX649eVoe8fOyNib3HWX/lHZ0RCnmAeiZjvUz
 YEkA==
X-Gm-Message-State: AGi0Puayh/058QK/+dhO5hPlkOV5IQWdwmutLVNiGvcMMV1iysBnWflB
 glRUHOXv8Tbt3l0vB5Jj+S8X/zgTRLDXbs9daVonSeQy38EFQelx7/Zgktb9q2U9xXfgkx0CGyT
 ZYtYjJaJTGZ9uKXA=
X-Received: by 2002:a5d:526f:: with SMTP id l15mr23961466wrc.367.1589279589597; 
 Tue, 12 May 2020 03:33:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAy4y1dqGWaojxWwDczmxiyvjplmoiyIK4YplpgxZqaLOv7U32GRAJXJeKUMX6KRAwfFepYQ==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr23961434wrc.367.1589279589392; 
 Tue, 12 May 2020 03:33:09 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y3sm21421190wrt.87.2020.05.12.03.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 03:33:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/6] tests/migration/guestperf: Use Python 3 interpreter
Date: Tue, 12 May 2020 12:32:38 +0200
Message-Id: <20200512103238.7078-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512103238.7078-1-philmd@redhat.com>
References: <20200512103238.7078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
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
Cc: Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/migration/guestperf-batch.py | 2 +-
 tests/migration/guestperf-plot.py  | 2 +-
 tests/migration/guestperf.py       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/migration/guestperf-batch.py b/tests/migration/guestperf-batch.py
index cb150ce804..f1e900908d 100755
--- a/tests/migration/guestperf-batch.py
+++ b/tests/migration/guestperf-batch.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Migration test batch comparison invokation
 #
diff --git a/tests/migration/guestperf-plot.py b/tests/migration/guestperf-plot.py
index d70bb7a557..907151011a 100755
--- a/tests/migration/guestperf-plot.py
+++ b/tests/migration/guestperf-plot.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Migration test graph plotting command
 #
diff --git a/tests/migration/guestperf.py b/tests/migration/guestperf.py
index 99b027e8ba..ba1c4bc4ca 100755
--- a/tests/migration/guestperf.py
+++ b/tests/migration/guestperf.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Migration test direct invokation command
 #
-- 
2.21.3


