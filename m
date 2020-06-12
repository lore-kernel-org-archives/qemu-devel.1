Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB07FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7306C206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1IpwiPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7306C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfVj-0002pG-Ng
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfT7-0005ZS-Ex
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfT5-0006z6-Cj
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhYz6sKF2bPYiUHoKS1Jnt6TjZbsEwWbEop5lmusuaY=;
 b=g1IpwiPXFF8hb4Vu2zJHUFApjKYhm5Tm4R6P1VPeo8PcLuzA4kV3hYZt+MCaO4SV/6C5q5
 o1wcYIvr7Fi/lAKwn/qruf+sF9xig4YYxudIPmod6wmyx+xjN3czklpeFY57irgt7YnD/9
 MXh3SeuMqjHxNSbtLSSsniHs069l6Kw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-0R3-TkmqOf-zmOvWSxEcjg-1; Fri, 12 Jun 2020 04:55:16 -0400
X-MC-Unique: 0R3-TkmqOf-zmOvWSxEcjg-1
Received: by mail-wm1-f71.google.com with SMTP id h25so3585359wmb.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GhYz6sKF2bPYiUHoKS1Jnt6TjZbsEwWbEop5lmusuaY=;
 b=MXdQzj2C1f7LhL5TTzN5V2vF4HSESq5DsOqNyFRJMh3KsSo1HYRTUMepZP+AIIQXo+
 Sji1dRYf5izGe9MU196eVo3jr5bjV8gp50xvNMPHtT5rLt6XkvAIhePo0MAMao9szMrI
 KHid4zNUcBZCXEFZG66eOt90t1xPhwa3maan7j9JaESL+wL6TrxrfWsVJSkycyDmG1fa
 aZoDJUOTsoZTzfPXCk5TEarz/ynYMFyFnz5Xkanibj3ihawGANZJ8whC0TTBWQ/s6+MD
 ol9ItC7qqYjPhNc/vic1V0lfRTnX+HbXh1Z3Rpl5WaDB8rvpH0Yf+qKA9msMzLuIZm1+
 g8pQ==
X-Gm-Message-State: AOAM532ISJaNGrwa/7ODarafnlorFLpvc9KIIuMUYtNOMEothi2PFzzp
 JJscrv/vv8VKI/NBQeB2GKXw37kX4YhlPWtxX4G19TKeDqRgaWu8qbw0CzpSpeA7pd6ZJfjZVwQ
 5N4EVatcOxfKQ/84=
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr11574009wmj.147.1591952114995; 
 Fri, 12 Jun 2020 01:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUvjv2ITtyGVOuRQGlp5Dy5oc6bi81ezaxeL9w6O2df3WzesCaq1aOnUAJafAqdYdFKVZI5w==
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr11573989wmj.147.1591952114785; 
 Fri, 12 Jun 2020 01:55:14 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id i10sm8920420wrw.51.2020.06.12.01.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/12] hw/tpm: Include missing 'qemu/option.h' header
Date: Fri, 12 Jun 2020 10:54:37 +0200
Message-Id: <20200612085444.8362-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:55:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Files using the TPM_STANDARD_CMDLINE_OPTS macro declared in
"tpm_int.h" will use QEMU_OPT_STRING definition declared in
"qemu/option.h".

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_int.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 3fb28a9d6c..fd5ebc6489 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -12,6 +12,8 @@
 #ifndef TPM_TPM_INT_H
 #define TPM_TPM_INT_H
 
+#include "qemu/option.h"
+
 #define TPM_STANDARD_CMDLINE_OPTS \
     { \
         .name = "type", \
-- 
2.21.3


