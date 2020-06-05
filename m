Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DF9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11FB207D3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwbXzoIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11FB207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh703-0006D1-0a
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 03:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xU-0001g7-Cl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh6xT-0004uq-ME
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 03:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591342806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttjV0syfgjbLAzbS9wNPqlHp/5sYrehPP++5NBowujA=;
 b=hwbXzoITTj8avz3pTq8iIJGwGYux/RyMY/hGwS8WlDq/MSwBCn9TBbnyjY0azSZxp+fHx5
 Chh9qp6duTPuzBDJNVdOucVBEbWGznVoQPs27iGip4idiwUND4Ny0gPqHL/ncyAyAWsfcG
 P615iYkW8p6O5jB0MdLSHrn52+iWHuw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Vkd872U-NzKQS0B_gTVbRQ-1; Fri, 05 Jun 2020 03:40:02 -0400
X-MC-Unique: Vkd872U-NzKQS0B_gTVbRQ-1
Received: by mail-wr1-f69.google.com with SMTP id a4so3415209wrp.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 00:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttjV0syfgjbLAzbS9wNPqlHp/5sYrehPP++5NBowujA=;
 b=RECun9GwYdRCsrMVI+T50aKTg/e3LoDIdpRsd7jLNmcxNK15IOVEydzQ8ZpCpTP3CK
 NDOxkYv6qLodr1ypRpPeSmO5hS5fxqDjTat20I8G86fCUm+s9OTuwLwST/U67cyJprSB
 gRHChY62kBFipSRnNOiaUPPZC6aPkd7AYqoUzJEQWj7EyQPPCrM4Up8bUB+UQH8W+eeI
 iYdvw7GTg5ykUzk2oYry6KQAJCDvLzMkEZ4ytCZ9ENbQCWuDh6vxMTun9SPWJm7RtE/p
 +QLF4Pzg9Js+Rw8YC2U1wWdaEwFBOkQcektT2QlXuCNH9zhmwupjrCzHTeV4sXNSVGyq
 EVJg==
X-Gm-Message-State: AOAM5313zKJkvK/n0ptCIqDVOHVVMNP4eCW5pd/N9+ujLadUnqphSCPS
 GQSz5xdfcNWuNIuK+CDE7jPEBxjEgYkfg0CUUR5evgtUGqj82iYF6VtlMcQ6O8iSCXMYRLxFh7u
 g1scoKrYlySOv1sE=
X-Received: by 2002:adf:fe07:: with SMTP id n7mr7940254wrr.240.1591342800968; 
 Fri, 05 Jun 2020 00:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSpkqZxtH9GgfG3xxOVwydp/+mRMQL4vPxGRIEfqWwqh90nEhYZvvVmoIHQqSNYHV3+dqDSQ==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr7940242wrr.240.1591342800825; 
 Fri, 05 Jun 2020 00:40:00 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id j5sm10886895wrq.39.2020.06.05.00.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 00:40:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/11] MAINTAINERS: Fix KVM path expansion glob
Date: Fri,  5 Jun 2020 09:39:43 +0200
Message-Id: <20200605073953.19268-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605073953.19268-1-philmd@redhat.com>
References: <20200605073953.19268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7d9cb0a5..948790b433 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -361,7 +361,7 @@ Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: */kvm.*
+F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
 F: include/hw/kvm/
-- 
2.21.3


