Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E2DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1629206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddAaqXMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1629206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd66-0001jR-Ti
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2N-0004C1-4J
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33458
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2M-0003uQ-85
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUXDmy3WOcwXjDaWqS3e5JUM21KIVuuEif55NSKeGcA=;
 b=ddAaqXMrGcRfju9epoZRLCreP3jtXQqLh6ww5gOX3R2OKMIaU6uG5IXHgsIzhZO7EqGQrn
 90N/49+MZYrXFgyYFYN7c7zK+RPCmfdcGG7iKkzBKN0tZYS4NEgFBl6nVvsBkEtGMTKDMD
 WettZAdhO50h2OgiF0N2CZ12ZSAExvg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-sC5DhmL8P1imd1h8dKxPQQ-1; Mon, 04 May 2020 11:29:40 -0400
X-MC-Unique: sC5DhmL8P1imd1h8dKxPQQ-1
Received: by mail-wm1-f69.google.com with SMTP id o26so3707741wmh.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=onx2YOkWfTdSzAWYbgwOOryDziIctG2Yv+O4LWjV+pg=;
 b=m72PithexWEVV1NwwHypd9FYkTGmQYz3wiTHQMlew01rEYNH3vquv/sEwjsNDU2eaD
 62heJARjWkAA8cYjD/sEe+4vFGzE83mTu7bkKjx1jkOps5JzXjzWqLPafKCSNBwcak4L
 qS9ILDTDyDaFV6lDv+scidBGjPVIQzJxJ4y/Yg/gH27yhKcY20k1oiOXL9FOJA+W7Xfi
 4yDI9Ql/+RmxGi3anY1h9W3fkz6iQAchrHRDLj4OF23i7R7FIHAKHaWLPrR3Kq4qgflH
 zMpm3leYcRGMRG/UDzb3pPcEOY+HZ6lAzI2K6qyPyfOsa29C3r5adaBpGTVXdFrzhoL/
 A6Zg==
X-Gm-Message-State: AGi0PuYfHRuePlFZsykqpW2owEnR7az3Mn6q1k6KbuyGUlBYkQYfH4Wf
 tPcA+wGQmFJw8Asr8VgPA8D7g/H2T/Oz0RxYrUezZ7lnM384VdHDnSvjJwRFcxU5ahK+AG5dGF7
 7CIC/sZK8O3LRU/U=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr9758530wmc.168.1588606178911; 
 Mon, 04 May 2020 08:29:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKiswUwQV6B4+74gAR9WPeC2k5Wg363PSUWRXIigZfvOEP6BnDuYZzURmulxZ+75CGXlIyQkQ==
X-Received: by 2002:a1c:f211:: with SMTP id s17mr9758498wmc.168.1588606178777; 
 Mon, 04 May 2020 08:29:38 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id q17sm13685124wmj.45.2020.05.04.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:29:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] tests/Makefile: Only display TCG-related tests when
 TCG is available
Date: Mon,  4 May 2020 17:29:13 +0200
Message-Id: <20200504152922.21365-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b60f6..6bc3d1096b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -12,8 +12,10 @@ check-help:
 =09@echo " $(MAKE) check-speed          Run qobject speed tests"
 =09@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
 =09@echo " $(MAKE) check-block          Run block tests"
+ifeq ($(CONFIG_TCG),y)
 =09@echo " $(MAKE) check-tcg            Run TCG tests"
 =09@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
+endif
 =09@echo " $(MAKE) check-acceptance     Run all acceptance (functional) te=
sts"
 =09@echo
 =09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test r=
eport"
--=20
2.21.3


