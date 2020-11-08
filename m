Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C1C4741F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207E4206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRaFPNY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207E4206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt3Q-0007Gn-8S
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2A-0005ns-Oo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt29-000256-9M
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604873976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jje+QkM8EIIDX196QXsItz5lUhUXvc2nsiwvd/KOGGQ=;
 b=aRaFPNY2Bhbc7xc3E5w+02ZtcJO3Ol5oSdqQQuDHT2RyqYwol1HNpS95CUTzM3flWlXSEd
 GiD/KttXot6C2FHoCGYFfbpHZtrsdgFwMKMrB5YIA1apiiUzerZFh4uhOieCU9Lfve0RiW
 vvCE2UK2fDkNjAxo84rbLx6No3LoEF8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-IwYHELhnMDCgbfQtpTgjyQ-1; Sun, 08 Nov 2020 17:19:34 -0500
X-MC-Unique: IwYHELhnMDCgbfQtpTgjyQ-1
Received: by mail-wr1-f71.google.com with SMTP id x16so3451661wrg.7
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jje+QkM8EIIDX196QXsItz5lUhUXvc2nsiwvd/KOGGQ=;
 b=Iqx1700IE156AKwgqCb2cdd0S1kApDtJrcSY3mnH7J5CZxXp0913U8bpCqmwOaorzo
 jortt0xQnjsuJuFHyy3QnoguP18spPfz84N3f4wnVgU3gCaiSF5TpQp1j7F/Ea4cceGI
 ALSUdWFvq1KbjH2RRgNrbY6HaSTyhvl7bzBL6NF68azFORiVVZDk2sZ+dGSVleHdBL6C
 1IpVwgCp5upExMd0Ov9/zepkCbW6Qw3yDZKkDNcxFdL6wQUcngi4jaRmIJVkhkGcQy+d
 mIFfLrV4f13oUtHA79uqZe2OrBdpanuCJ7o80hLlcl/YdhAWbjMxXnlCYzZ9bK20Nd31
 aqzA==
X-Gm-Message-State: AOAM532TiSKH1wuzkaTW4Gq9q8KIXMOsVoXfkaQMxHkTqw2AEibjDwZO
 EmB7d9rKfKN489DHi/C2uEE1O7srFVr0fUikDsGhPfvq2L/jlKDHX4cBKEBrJFMgkBjdTkIARYt
 h5pKRudblIDDcRZE=
X-Received: by 2002:a1c:97:: with SMTP id 145mr10961972wma.72.1604873972926;
 Sun, 08 Nov 2020 14:19:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3WPOTPx39UY6bBlDIjG81oA9Q+iyhbmk6P7uLuBowaVY/MFR426y1bws7wEEb+LYnBK6RSQ==
X-Received: by 2002:a1c:97:: with SMTP id 145mr10961962wma.72.1604873972820;
 Sun, 08 Nov 2020 14:19:32 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f8sm10735494wrt.88.2020.11.08.14.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:19:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/11] gitlab-ci: Drop generic cache rule
Date: Sun,  8 Nov 2020 23:19:15 +0100
Message-Id: <20201108221925.2344515-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108221925.2344515-1-philmd@redhat.com>
References: <20201108221925.2344515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This cache rule is meant for Avocado artifacts, but affects
all jobs. Moreover the 'acceptance_template' template already
include a more detailled rule to cache artifacts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b15ae5c302..5763318d375 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -7,12 +7,6 @@ stages:
   - build
   - test
 
-# We assume GitLab has it's own caching set up for RPM/APT repositories so we
-# just take care of avocado assets here.
-cache:
-  paths:
-    - $HOME/avocado/data/cache
-
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
-- 
2.26.2


