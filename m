Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5FBC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0AB20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3xixPyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0AB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSc6H-00058w-Nm
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSc39-0000U4-UO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSc36-0007cj-5H
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602663735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uuJppHX+C4z8kNnV/PTvBxvxulI+CAK/tNaO7ZCrtiU=;
 b=J3xixPyzoTY1/WC0BCg6ZrwyZgGDSiZj5Vv3qhpo/mfXrWiDjJt3KieL5Uwl15S45yeJiH
 QSSpQrf8UeFAubHWU4fXvjAYsNMypplENUR24miJ/vx6t27zWSLE2NhV9TiNROSPFLZcAC
 dlNxPd28VJHnPV8qoZpDvcMT7BLjMC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Merc3OLVNHqo4cDoyyGb0w-1; Wed, 14 Oct 2020 04:22:13 -0400
X-MC-Unique: Merc3OLVNHqo4cDoyyGb0w-1
Received: by mail-wr1-f71.google.com with SMTP id 47so956290wrc.19
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 01:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uuJppHX+C4z8kNnV/PTvBxvxulI+CAK/tNaO7ZCrtiU=;
 b=NLR561nDp2jo5A7F3jQTdol1+ja/rj+HGUp7gYGmPZwlHSQEdr3mcVojtmoJ1fkmj3
 R4lyfjcYQZSw281m9X+mjqLchoM21X9CAa64CI6jf9D8bW7oVZkZoZlZOPBRRLzHAQiN
 KXiBUGH9/7ugbKs31nfv3Jyp+s9PQfmVT3RzIuHMdfYmw7l5E5HxYIhweOUFYEwnsVjr
 X0CpR6462M4FksU8hqtI0NouXYJ6tk+mhbLEYZVTZ/jvCbZoQ7rVz4CWuZBa6gfIPMBA
 OyTj0Ys3DCB8TDyo6doEcmglS6HptFQ+k+w2VIplNGpq1/tRg+iddyLLpUKnVbE6H0TS
 zopQ==
X-Gm-Message-State: AOAM53267tauQED79cVWxCB3ZMBXV6SgjYWzE95w8bC3wDcasy0LV6Mc
 gahmoLzODj6ZaseP5WaJ0Mf3d1vHmD9Nyhs/rpzqqHZ0iGdLPFzhlzFMAkmF/gyMFgjyq4nQRGO
 R6gdwdSPEWn5tbJI=
X-Received: by 2002:adf:bbca:: with SMTP id z10mr4329827wrg.403.1602663731766; 
 Wed, 14 Oct 2020 01:22:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxy7c6kVKxNkSYE9n3ECqdxhMH6e5mO3f2Twcvri5oyjB3JBqQHQeKmEDKmsMD5AQ3eJUs7Q==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr4329810wrg.403.1602663731576; 
 Wed, 14 Oct 2020 01:22:11 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 30sm3713287wrr.35.2020.10.14.01.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 01:22:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] buildsys: Help git-diff adding .gitattributes config file
Date: Wed, 14 Oct 2020 10:22:09 +0200
Message-Id: <20201014082209.3712625-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commits 0979ed017f0 ("meson: rename .inc.h files to .h.inc")
and 139c1837db7 ("meson: rename included C source files to .c.inc")
'git-diff --function-context' stopped displaying C function context
correctly.
We can help git-diff by providing attributes to the .[ch].inc path
names. See:
https://git-scm.com/docs/gitattributes#_generating_diff_text

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitattributes | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 00000000000..3d2fe2ecda8
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,2 @@
+*.c.inc         diff=c
+*.h.inc         diff=c
-- 
2.26.2


