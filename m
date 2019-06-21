Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E9CC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696FF208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaCWdHW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696FF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heI9B-0004tj-Kr
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkc-0000jn-B1
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkY-0005gX-FB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkY-0005d5-8c
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id k11so6260972wrl.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pHLIgPBm+zklyrM5916BeOxRgjfHZTPjTZ6RZlLuMzk=;
 b=IaCWdHW4IV7dCwDpC1hZplAfSnDdD3bV0VCJPYoqJvcllvjhgIoQtNZdxdVVXl23FS
 A9iX/Yq7snHAxu38V1kkoDNnfqIt/Y8XgliYs0DTgtsVS4ot8mJqeeQYiiKXwaQNBfij
 Rm/uXkENuWIZoI9NTNIZ1NpMFWkUTmp/M7XofDld6Bh+xawDFGAFoqpaFOyqRN4+3gOL
 HdrSg7u7mNAutQMAY92UcKrwMRGfbOdiVVQTAbc4AF9W0csLZoohpcR9yappuc7Ex1Qt
 1BZqQHsq5hnf576gTEU/mieRmRujgaYD440VYwzRQ8tjzkGMPneu1MAMVMtNHp+1JbHf
 p12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=pHLIgPBm+zklyrM5916BeOxRgjfHZTPjTZ6RZlLuMzk=;
 b=QHeO+mktBC59GYSYNHWk9Kc2T8WzWIwDkepwjq+KtGpvDj5BBxa7VZE0/Gz0K1yVih
 wOojEXx9weF55uIigGnddI7rTY+6HiRNYM0/ad4R99XK6QX8MmlMCqdYJKikUqBNoRz5
 07kke+2cZYP1f2FKKg90T+09sW9C4sfLdGLa4BAdgYsiUhuAuhAMs6m0l458yq+9q5zC
 CN6ZZaJXePyougz3gVUMNRIFamzdJW/YTqaTbxWFsoyQteqpAPOERSdGeiE3s8jVPUTP
 7MCWFWjAj+Zw5euZB8aHeovMmlmWah4v8wBVnzuuPJo43/bDe8d7Q4ND08hVafdT4MvO
 wFZw==
X-Gm-Message-State: APjAAAXjD8c6737hpTZtczDwLOvOtiB8GEEior088kSv1vl4Iurli9tv
 zy2lHOqeN6vCH6VIDsMVAgUMN7E9
X-Google-Smtp-Source: APXvYqzWBcfNvKlZG8fV0mRlLqUDMHOENXFgGIjkemHT8hsIkXcTLSVOsiLoEZ38qFA647kQgxppJw==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr79007378wrr.5.1561116632584;
 Fri, 21 Jun 2019 04:30:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:05 +0200
Message-Id: <1561116620-22245-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 10/25] i386/kvm: hv-evmcs requires hv-vapic
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Enlightened VMCS is enabled by writing to a field in VP assist page and
these require virtual APIC.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-9-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 1dfa282..86de510 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -790,7 +790,8 @@ static struct {
         .flags = {
             {.fw = FEAT_HV_RECOMM_EAX,
              .bits = HV_ENLIGHTENED_VMCS_RECOMMENDED}
-        }
+        },
+        .dependencies = BIT(HYPERV_FEAT_VAPIC)
     },
     [HYPERV_FEAT_IPI] = {
         .desc = "paravirtualized IPI (hv-ipi)",
-- 
1.8.3.1



