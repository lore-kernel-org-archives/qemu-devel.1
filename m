Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F4F2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/A3ea93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F4F2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTKr-00025s-Ix
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJQ-0000QC-VQ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJL-0004YW-Uo
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KOJiRNNgCKXxXF3PAojUBMhMfHmXxvQ94Tix5b7+Js=;
 b=R/A3ea93+FwISTxZVqFOq65GnTZ4Kl5jo0Y0wAmvVLTcXkoRjcKRRFo1d6aVWvokrb5UYU
 gE8BnCiax6+gwh4NdMCDp6LN2H4TpZbnUnOH1vgvAy9VHBRbWTxg3eCRppZNRvKGb2ZyDh
 cQTGIran13IqKF3JRz31NCh1wqduwWw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-REd_f3inPm6Lk3IcPssU6A-1; Tue, 14 Jul 2020 18:21:59 -0400
X-MC-Unique: REd_f3inPm6Lk3IcPssU6A-1
Received: by mail-wm1-f70.google.com with SMTP id c124so105702wme.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5KOJiRNNgCKXxXF3PAojUBMhMfHmXxvQ94Tix5b7+Js=;
 b=UCZvluu8BM/ha9Vh1JwEbsBHjez1AeuloBWnQ4eJvMECWpcSz6LqVie+eiliG4lrYQ
 VspNmtnDiKK4XmrAOTXFxYwqUWh3LB/5GptAV7ZpCWqDpNvpffg0pJ7ikNJl4AHPHnEB
 IAhYDxNl9NMlYDrRgR7sgrcxDXvOVJRS8zRcPIi/AQyfZ+l+lxaDGbHBZRgcupoIrsRA
 uVIXpO5NoT5WeVYfllw01txYHmnZuU4RM3/Yjwny5mrS/PpEy5cgagH7elnc8BVq5Qkl
 Y0mLKBrUzNhbXgiSA+9S+wUqwYhGDgYZCGEgothorE0xF9ggU6IHQCg9YEN7VUWEnhRX
 yZ5Q==
X-Gm-Message-State: AOAM5301O3xzJJHTEENZbF/aqQ+f3/v7LkyiTNdMpnB8MkGjMAHBNVhP
 CKj2OFIJ4PF9P+mi0SbHotdizbb3Y5ZErn0rHzF22g2vaPGmXh+07JJKmhGyVFCOF2ARquiJiGW
 Q6SsoZh1N3KJJe4w=
X-Received: by 2002:a5d:554d:: with SMTP id g13mr7730002wrw.98.1594765318138; 
 Tue, 14 Jul 2020 15:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIl8VT+T+TJSXcjMJX3LIWDdwurgfpY6HH5UdPHk5kiuwk0HdcZ1OVeT6zU3JEJIr4Aa5Vnw==
X-Received: by 2002:a5d:554d:: with SMTP id g13mr7729983wrw.98.1594765317930; 
 Tue, 14 Jul 2020 15:21:57 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f12sm177045wrw.53.2020.07.14.15.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:21:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/19] python/machine.py: Perform early cleanup for wait()
 calls, too
Date: Wed, 15 Jul 2020 00:21:18 +0200
Message-Id: <20200714222132.10815-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This is primarily for consistency, and is a step towards wait() and
shutdown() sharing the same implementation so that the two cleanup paths
cannot diverge.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-5-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 127926b276..63e40879e2 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -380,6 +380,7 @@ def wait(self):
         """
         Wait for the VM to power off
         """
+        self._early_cleanup()
         self._popen.wait()
         self._post_shutdown()
 
-- 
2.21.3


