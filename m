Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD737CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A245C21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOKx1Usj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A245C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdrl-0000GF-O5
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj7-00088U-EB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj6-0007pH-8F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj6-0007ou-28
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id r141so2732743wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ikbis2EmZPHbVV90StLUr/aGwCPiufobBGQ1XGXra5o=;
 b=ZOKx1UsjF2cFt8CIG5BAL16XIvQuYeg4o8U9slre8HF0mLBLNnpMkj5OWudygv+Q6H
 UyZUQGimyF16DZNrqpe+f7bwU4Ze8vWrtLCkhUkhEFTdSDw7B7emLSAGFB+HjTjhBbMn
 2eL+mqCQGEbu837ebU0LuJku7f98sPME9GWFspGB/EBNcEoz7mF/TbEBEN8CZpU8zW20
 aUharQQlq8x01p5v0EmecD2LbmoVFVTryMuAHQDeV/rjGjrR7nKW0JWbKjTJZOXkBXZ8
 0RdksorNxEYPQziot4Y/18k4rxLdZVsMKBlfTzstFmT7wzzeDn191CSyXMrftIkwooO/
 IMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ikbis2EmZPHbVV90StLUr/aGwCPiufobBGQ1XGXra5o=;
 b=OlWTq6GvzZfgrlHh1ZN5qvDNrr0AjkpeuLXpmQDkA3Iv96RWYVWIP9AH9SS9cPg/CQ
 5pSTjxazVGd0NZiXESITWHTS6DmXT+1Amac5k/WZKCnibCQ83QoK2ML4YWWYxtZ8OGmZ
 LaI4rp+F1wTxS5rhzrBcxCLsolG27EMZWkNGy1PC/0qBOx4ZM2iG4JyjJevsXfa+x2Fv
 RhlBEdTRC3Pn71oBW+LQ42bR07Ie0u9eFElBZm57udmMSBMVb7EqKwdbyIETZBsH++ev
 ikLpOpIZNd/qAIqZG9MCBySlwQH/K+9Ovp7SyZhz5RRySzCDe/c+fhSJAAIDVcTCu/Ub
 xKLw==
X-Gm-Message-State: APjAAAWylEOePBGiRPTj5H1THzDPempIZDthabkpfFrUDRNFn0K8R9IN
 YJArJBHUTPS77oPblqJoFupIaZyU
X-Google-Smtp-Source: APXvYqwWNh1KZRI3lvx9Z6vzN5xOr8jBaOerQ0dJf5ON01ofGkvv2hdtzX9ZUNNGCpV18Du2MZNARA==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr5087014wmc.30.1571925870752; 
 Thu, 24 Oct 2019 07:04:30 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/39] hw/i386/pc: Remove kvm_i386.h include
Date: Thu, 24 Oct 2019 16:03:46 +0200
Message-Id: <1571925835-31930-31-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

By extracting pc_gsi_create() and pc_i8259_create() we removed
the access to "kvm_i386.h" from the machine code. We can now
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191015162705.28087-25-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 648dc9a..3a4a64a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -57,7 +57,6 @@
 #endif
 #include "migration/global_state.h"
 #include "migration/misc.h"
-#include "kvm_i386.h"
 #include "sysemu/numa.h"
 
 #define MAX_IDE_BUS 2
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 157d1da..def3bc2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -36,7 +36,6 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
-#include "kvm_i386.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
-- 
1.8.3.1



