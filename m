Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FFEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E6B2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqkq1l/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E6B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltmy-0000WL-7i
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltjv-00048j-Lz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:33:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltju-0004kE-48
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KXjr0V89kJqeQEnHRscG8gu4vbhven6ovSEsc9X8sQ=;
 b=Uqkq1l/co5Td8mEwTOdr5it2W7MAoqcu+U56i8jtQlsgPI/vCe3+YGqJ7QuyPWLulsMa0+
 DTndh+7DUmIROg6AkOj297Ze/3mtH/epxm1KF6cK0XnJ8RQ9BU1UGjJA+dbEGuo31UFQf7
 w2Wyv/LfkE4d49t5rSgjRteErMZkdmQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-hOJEz9EaNiOMNxtG3qyEvw-1; Thu, 18 Jun 2020 08:33:51 -0400
X-MC-Unique: hOJEz9EaNiOMNxtG3qyEvw-1
Received: by mail-wm1-f72.google.com with SMTP id v24so2533977wmh.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0KXjr0V89kJqeQEnHRscG8gu4vbhven6ovSEsc9X8sQ=;
 b=WMy/NiGa+waLOZiazQuKYbc4+TNME47eHTM21P646J/EaV3gTAFekIgsoygdc1x+9t
 uxRg+LKhncujwbr9khVAf8U4kFrPnanydqfm3Rz9wg4y5EeZbskmbVhkEbEFCG8OAcB1
 sC1wKahm5Www1LMBsPMtirX4FNlvFpz9Hst98AcjBua/GgV53CCy9eUq+jcbeyxxnddC
 0UaUxCXy0rCeKBbQL7dZRsgzfqiRsAG4JQuv3bGmpD6hN+02qhDh3hv8b3tMG5ZRfW4s
 sl3xRcWpOHoypn7F7sgvri2ESZSsAkO8jqoC6E9Ekg83LFY0/xmdZMrEbwPYXjV1+WE1
 Ve3A==
X-Gm-Message-State: AOAM533sFhE7Em+HMC+TOdfWjR+eFVE/GaGBmbx0998xKH7pqKQvsJZ7
 71PG362wP/Ftyq7xllvJwcInCodNrY4u/JWypwx7EVf6/y9q1x41BVntihvrLyzVaZt1SKWbUUb
 rnknkGjdHbxTM4Lk=
X-Received: by 2002:adf:fd49:: with SMTP id h9mr4531394wrs.67.1592483629958;
 Thu, 18 Jun 2020 05:33:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBTJQubJcUEZi82cDmqNxeBBRl/U9Ipq0sPBbmc4K/S7rV4nke1kxtB6cX2EA3NNsCy9yHzA==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr4531374wrs.67.1592483629798;
 Thu, 18 Jun 2020 05:33:49 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id b143sm3508187wme.20.2020.06.18.05.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:33:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 01/10] MAINTAINERS: Fix KVM path expansion glob
Date: Thu, 18 Jun 2020 14:33:33 +0200
Message-Id: <20200618123342.10693-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..5184cf46b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -362,7 +362,7 @@ Overall KVM CPUs
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


