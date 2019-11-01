Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73445CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D61F2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 09:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0tRb9cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D61F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSq8-00050s-C6
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 05:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSez-0001BZ-AU
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSey-0000cW-7Z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSey-0000YI-1U
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e6so7115071wrw.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rrO+qwPM4Kmir6VZyxAXUgGXFxnOGGraCt67S9SJoFU=;
 b=j0tRb9cYn0tON9ckOzHCr5Ts/qCfHuQDrbSQ+54FfC2KjXdrQAfyjZJPdXoWPDBVOC
 uSRshks7jQNS9WqrhPbWGfxOaTSwCx7KRrrlKOMHb41WLfh0e31Y1hGmcJ6g6DLOtM5B
 /bqnZyyj6kvY/UPqt4JHwl8GfDR01RlmKRAeT8xbR1qTsbwrMdhqvkVhSJZGNx3s3y2q
 twEyPw7+yBv90QJl7JMnSfpJ2wlIIzDQbvL76og+s0rVTEjKcJGgjQmQOMnmNDmf5dxi
 Qgi3PCqk5FVt7pz3xFxi9BpnlS4EfvcLpVXaWcxVtl2lqUZXsvnVU867iVlFZyj8Eiy3
 LngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rrO+qwPM4Kmir6VZyxAXUgGXFxnOGGraCt67S9SJoFU=;
 b=RIJdYeJB5/HbTWT+xF/xC67V4GoSk+1ITVUdyqwGajSseYZId6+RHfQOIm3rXSnm13
 iAeA5tP21MsWp7FsEERwGUeRB325en4GcT2f/s+1ACMlCu7mdoCmhgbODd97GwEe8pE+
 sVEyx7IZzEvvUwV4W6Qtz23WmDSNcqTYXUPdAMGMLVhtm3ilRu747c69cg+eATKICu81
 q6sauiIZQS17P7FwhTRkwDFLKn/rvvfCi66cZw+C1z/gMK5GGKgMJDy29R4mDdlDHi4a
 i5lJ2gS7GTMXSx4kGA7ivW6Frc4SWvnxoEltKzDBOTz6Vb5FsvBMgSPE19+UJCWYTqGr
 CtwQ==
X-Gm-Message-State: APjAAAXMDAw6iV32LqooNDUZ+MpJ6D7/Q67bGIAh54PRRGyimrQEyeJS
 z0TlkDMVKxOAMTiqe6OPugb8fnPvRj02hSLD
X-Google-Smtp-Source: APXvYqyqsqAOnRR4X+DdEQqZjgbkMzsM31C8nQvGGSwkwDv3x2CozhGP9xrbYwVIkbkXT3VUj44JuQ==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr607945wrr.98.1572598314758;
 Fri, 01 Nov 2019 01:51:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw/arm/boot: Rebuild hflags when modifying CPUState at
 boot
Date: Fri,  1 Nov 2019 08:51:39 +0000
Message-Id: <20191101085140.5205-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Rebuild hflags when modifying CPUState at boot.

Fixes: e979972a6a
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20191031040830.18800-2-edgar.iglesias@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c264864c11d..ef6724960c0 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -786,6 +786,7 @@ static void do_cpu_reset(void *opaque)
                 info->secondary_cpu_reset_hook(cpu, info);
             }
         }
+        arm_rebuild_hflags(env);
     }
 }
 
-- 
2.20.1


