Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDAEC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C2D205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWKGwimc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C2D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDpDn-0004u1-MX
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 08:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDoQe-0004hN-HR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDoQZ-0005R3-ER
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDoQZ-00057D-7E
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584360061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8vO7MDRs1OXf6aQv+GuNVJsaZT4plPQtpjK320MGtI=;
 b=PWKGwimc0vlRvNZNSDP2RcXR6GB6mimFOj0BFxjRLuO0HLXk/OS8YmK11X7BTHAYqNoK11
 lq9eFN3dTk08zN1YaTuZVceNFALUz37qilzMDld6MuwmTNEXVePWQ9LO8SVPofCNFob4+A
 7wdHYC26LIy0yWKWLlH1mZpCZb11sZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-REkyYw8XNlSkp2JwvgDhZw-1; Mon, 16 Mar 2020 08:00:59 -0400
X-MC-Unique: REkyYw8XNlSkp2JwvgDhZw-1
Received: by mail-wr1-f70.google.com with SMTP id u12so6481430wrw.10
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GXkCSWy953nAJcbcxuxSnFkdz12K0AJQYC1tw+khQ2Y=;
 b=D1KVUlNCmauObIlZ6SEwFHXkD+/yKpLFcxrDS1C/v71ip/AXS+U6oCFnvynIWVs/2d
 f1QOq6eGIsSgryJlw+W0EDcef9spcxJu3cfXRwGgfGeI5R1zURTGiS8v2tkdL0lzgu22
 TJlVqOLKjaFGMbgebdIJILfiK+tkq22bY1rdNsSKeH0yqKjk++fzqjvqEbBHgmXUfyNe
 bnLnljZll7A2tnnx2ww9qM86lNyIPKFIdXw/Z/TyqnsOrIkO5r+qmAD7ObyLiGNcwjv9
 fdHMVAVTVw7ER68lHxZwedC7s1escaQM83M2B8KvlLRXIpedn51k25qYDkg2PyRbJfxo
 56wg==
X-Gm-Message-State: ANhLgQ3Q9Fyy+p0dZqRF1bp1qBlE3pooeOo9XrOy4lz6P1U+Tf5O90sY
 TBs+B0zEeCtS/vDjpSEenlU9OduJAYc8fdjuRWE6Cq5eIwbxp0JOYQq3mT8REVHwClgIHRWGXnj
 UmPtxChcGlh4RJbk=
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr28258911wmg.41.1584360058346; 
 Mon, 16 Mar 2020 05:00:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtyvmh6Al5+WZMP2hIIdJoHRsPB/JxSCe5bN7wK+xpRhi81dNq+4NX2s1P2lUmg69P93qTaKw==
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr28258888wmg.41.1584360058173; 
 Mon, 16 Mar 2020 05:00:58 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id l5sm28690021wml.3.2020.03.16.05.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:00:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/11] MAINTAINERS: Fix KVM path expansion glob
Date: Mon, 16 Mar 2020 13:00:39 +0100
Message-Id: <20200316120049.11225-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316120049.11225-1-philmd@redhat.com>
References: <20200316120049.11225-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM files has been moved from target-ARCH to the target/ARCH/
folder in commit fcf5ef2a. Fix the pathname expansion.

Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..7898e338f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -353,7 +353,7 @@ Overall KVM CPUs
 M: Paolo Bonzini <pbonzini@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: */kvm.*
+F: */*/kvm*
 F: accel/kvm/
 F: accel/stubs/kvm-stub.c
 F: include/hw/kvm/
--=20
2.21.1


