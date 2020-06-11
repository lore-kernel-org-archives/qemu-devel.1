Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD692C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748A2206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV5GtGZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748A2206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPju-0001zz-K4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPg7-00069t-R6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPg6-0000qV-3G
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhYz6sKF2bPYiUHoKS1Jnt6TjZbsEwWbEop5lmusuaY=;
 b=YV5GtGZgjpTl/u/Qr4h6/WulBJR19Gyot7suambkiJxuXFbxRq52qUXCaEztnOypHW78Un
 l4P9+xV3tTMKWkVxqV2n1HXAq2wOGYvYARhMlZTegIzlnA7CmCCYsfrLJ+tBADnvx3UaV3
 UnDseKXCuIXGz+IJ/B8ttWeyNmxvYoU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-2AmmOEQxNlq9edjC317ahg-1; Thu, 11 Jun 2020 12:03:37 -0400
X-MC-Unique: 2AmmOEQxNlq9edjC317ahg-1
Received: by mail-wm1-f69.google.com with SMTP id t145so1494747wmt.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GhYz6sKF2bPYiUHoKS1Jnt6TjZbsEwWbEop5lmusuaY=;
 b=FQF1zp1OoB0s178JZMnpJeZpvP2PfstyRULDKhgsc24D2bbbpQe5rG1ldWuqd8R558
 x+7DAagsuVCp63WzGzx8QrjFjs2Jsg1bqDmII5mxRgmlrsk6BrjiM1PMaYpEqgEbrhJ2
 RzBnfYAMtIPijq9GOIakPUpY/0ex7afkVWDyQLOCrDLZxR42rZXiHnDkoT+c2Rz9hyOd
 D5u9x3DQu1uQBHVcHjJowMemP2187Xa7hsqTs5sJ4OVdKZ5M3YiMBEu+r/zMZoiNRDcV
 1crnfUIw0ZXds4HSthIf/JcPLD2gny09INTJ+Z7VJTFVjPdyGJyQpA2aauVJIz7SMJQi
 Lysw==
X-Gm-Message-State: AOAM5321Zz8VlZovxzlK8ZYhyJ22ac7Nl7oE6XjIv13CxiSw7+kLvhFi
 XeV3chZpq7KDcYPUY0knlD8zUg9Q9RY4JyxcT4xB2OhoSiMzyRnBUvc5As/HvMFrMwzxsXNlcku
 Kdr1TLNGjdBdmpj8=
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr9109441wmc.80.1591891416276; 
 Thu, 11 Jun 2020 09:03:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5f3Pj8z9aYJA0Iv+c9ytFLLmSgAJSptUJ5KizCrXLFDAKYeF/EjT5KOYlAweFzc0XNlc1Ig==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr9109398wmc.80.1591891415774; 
 Thu, 11 Jun 2020 09:03:35 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q8sm4429457wmq.1.2020.06.11.09.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/11] hw/tpm: Include missing 'qemu/option.h' header
Date: Thu, 11 Jun 2020 18:03:00 +0200
Message-Id: <20200611160306.2751-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
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


