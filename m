Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592E0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC23206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFyCVLbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC23206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdpz-0001Hf-6r
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdoq-0007DD-PI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdom-0002sg-S9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589562495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LWNrIr5sPkmnUIPfYOIlIROnAtcVQlofpnnefmhg9k=;
 b=RFyCVLbqlZkQeDOd3tc5rnSt1k486o35iBuDbBj+LBwdCRF7n4KFesisEiAClrSjclkX8D
 oKbR8bGFBTLG0jz9+gkKMxBV4L+jecYS8wZlIUEZHWtIj0Dzar91/TFHrNdVOybrgqKktb
 iVfKGhIIAhQ2J3eRIS7SNMn/SExwIV8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-8axsCJQUO1i9GW9EmpTDmg-1; Fri, 15 May 2020 13:08:14 -0400
X-MC-Unique: 8axsCJQUO1i9GW9EmpTDmg-1
Received: by mail-wm1-f70.google.com with SMTP id t23so1265249wmi.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1LWNrIr5sPkmnUIPfYOIlIROnAtcVQlofpnnefmhg9k=;
 b=m+n0O2ngLn+fETWy/3jBVAQ2Wd0VN0O0QRuvpb+z/2g6+6rbM/9shhIVEyeOtrMg/v
 2/4GZ/Kubx2TfIsJ5jGp6ceWytZXObk2XJuW9iu27ns7wLNdzmLOlMnJvxoWuAu8bgaW
 DC4eBZaXqAqj7ZqCSB887T6/sCegQwycg+hdOuQj2IVUEbs9P6EuVj4oBZm3PQHg+Cso
 U9pjsz395wubgzaQOnZBXjgljBiB3oRW1aSP08LslEWvVaVHniRjnEZ1NbmfVZ7EXw8b
 WwW663dnaRia1E0REfIqRJX3PgLTXGzJuSVOeafF+kurBPY2c/ljcJehhyANWnYPt9fx
 Wo1A==
X-Gm-Message-State: AOAM532f033nVLkGI5PYNzuA91cmodcjSXWTyTZg1doZze2CtO6qX0Dg
 FVWseGoGuFxpBLk3LJp0IYF5DE1B9JHcCrueue23nkhyRoek3IxS0qCtyQi8oA4HMQ5MNuGrLTR
 5GNp0kS9ovVHqu4k=
X-Received: by 2002:adf:94c2:: with SMTP id 60mr5228998wrr.366.1589562492974; 
 Fri, 15 May 2020 10:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQhEuJujjCxs1d9TdgDo4NpobJlCQ7OImNf+tSww2HIeI5aBGI6yByw8T+d0XBO6uWfNsFqA==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr5228966wrr.366.1589562492758; 
 Fri, 15 May 2020 10:08:12 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e22sm4742390wrc.41.2020.05.15.10.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:08:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] MAINTAINERS: Fix KVM path expansion glob
Date: Fri, 15 May 2020 19:07:55 +0200
Message-Id: <20200515170804.5707-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515170804.5707-1-philmd@redhat.com>
References: <20200515170804.5707-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47ef3139e6..fd88a3de49 100644
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


