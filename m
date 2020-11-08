Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08032C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DA7206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bM51iAJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DA7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrc7-0005Vg-DU
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbraw-0004B3-1L
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrau-0000Ul-I6
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HUr0fHdfhDho2cZoSnJ/oforGStCZUlBsw7H/7cVds=;
 b=bM51iAJSCdjc4lA1AlirFybc9OctYg86urgJqyvtPKJAnjkL3yKjbSv3E1e0D4ngCbjb5r
 4AQUxcD6MsG0ldInbELyRfUy/mNcBbVB/s+PLfp5Fb58JQODbEPfrZJYKOg6HNB7YryBw9
 6v/+ExypthfGrINrxDSNm/zJq+euPoA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-J96fONz9M6iNNG5lh6Dr2w-1; Sun, 08 Nov 2020 15:47:19 -0500
X-MC-Unique: J96fONz9M6iNNG5lh6Dr2w-1
Received: by mail-wr1-f71.google.com with SMTP id e18so3366885wrs.23
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8HUr0fHdfhDho2cZoSnJ/oforGStCZUlBsw7H/7cVds=;
 b=S/D9rXKcwqB1drAzim/zFZrS794IXIQEXIi5PoKohDrmYAwEVax2zHhV314kQpnYad
 ObiTHPRDiVurVMlOnzelf1sSAMeYHnpdP7CO1cdjQK86aQPpF3TFJLPegebvpNeDo+B/
 N0W6GNqgK7zRdgH3EwaQbJMAcq+GHrp0hUe4gJxDCcl8Y1Qnq7spSgZ/ukjwWKmecoPr
 fvALvprGX6k9yi6zL8j1w4QKReFD81lNvisEdJGKc+Y3gv+K0SEn6aZ0Jsj7xXSDbKIA
 CU7p2AL757Gqv2LVnmV/zBh2Mk0OMiEQ8T77o09+zz+sbu11DWTEIo6hJCPlD3Gc5cdF
 IPIQ==
X-Gm-Message-State: AOAM532njLr4BsMTTU9WlnUlOvhqrg/8Jvz7DVFF8CpuxR6p2TaKZxkm
 xLwCfTLRNoIKnuwJ75qNVt5eQvriocSU+s39Szp7vnCB2pIiJIEpuXXi13+4rkWXfaJ6QBGUSLI
 Ff+rTgYWLh4xYNFg=
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr5660619wrx.367.1604868438344; 
 Sun, 08 Nov 2020 12:47:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycRbzTbqlxadnxp7JzfBmKZZ1kdhhofRPP+MS5g8ZgvveHrG+IAX6tV5khhtCVa9f1VT92Lg==
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr5660601wrx.367.1604868438178; 
 Sun, 08 Nov 2020 12:47:18 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g11sm1965792wrq.7.2020.11.08.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 04/17] MAINTAINERS: Add gitlab-pipeline-status
 script to GitLab CI section
Date: Sun,  8 Nov 2020 21:45:22 +0100
Message-Id: <20201108204535.2319870-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not let the gitlab-pipeline-status script unmaintained,
add it to the 'GitLab Continuous Integration' section.

Fixes: c02b2eac55e ("GitLab Gating CI: introduce pipeline-status contrib script")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Cleber Rosa <crosa@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63223e1183d..817c7c93f91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3146,6 +3146,7 @@ S: Maintained
 F: .gitlab-ci.yml
 F: .gitlab-ci.d/crossbuilds.yml
 F: .gitlab-ci.d/*py
+F: scripts/ci/gitlab-pipeline-status
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.26.2


