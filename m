Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEFDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCA020748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HryFB8dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCA020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrMy-0006K8-Ab
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrLn-0004Ix-3n
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrLm-0008Iy-3K
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUH1OFbHNzJeZmlQ3HgF3hr2B5jV9dvRYR22rsqFyDE=;
 b=HryFB8dOxjx4A6Qjc4LHxjMzTp1PsVFqDuAYUP0yboPScWAMQXa1qrGwfB2O5+oOgp5jjE
 OmXXYMHsEnjFBX0EnqNPxAi/vnJ+WAwdxkrilgzJ95gvFiYPgojlKUCIKZDfaaTbO3wWb7
 gSSrx2Ia1rgRnyGN71ar4k+44Oaq3o4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ZHHqa774O4SYJ9dGILjanA-1; Thu, 21 May 2020 15:59:26 -0400
X-MC-Unique: ZHHqa774O4SYJ9dGILjanA-1
Received: by mail-wr1-f69.google.com with SMTP id q13so3369070wrn.14
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QUH1OFbHNzJeZmlQ3HgF3hr2B5jV9dvRYR22rsqFyDE=;
 b=fxiYBL1PPiDpNLEHNE8SbT4xUbFFMGGP3NI50GA5NmBVg7IE1VhgS2qe/U3XUEo/yy
 jWSE61oBK7RUM762BwxspMwiV+Ye7OJetz36cdxaX3do7Yzz4D5FN8Q04hB0MtcpPITn
 09k6SAjOGMWS86GiaVQcGWCHAQM63jhqNa7jgjT4sx5YaKi6IDryBzqRHS43RdJGVVbB
 sBh94+dIgXcWMDLbVTVW3lLIYOcV7wKRUGPCg0V8SpH07aeK7fhpSnTwPEb06aJLL7Dj
 h7DtT1J1dFkfN/bj23Px9ESWfOIqpTht5+MOK70k04CFpzAhLjvffmEAO/D/nMx8QGMI
 EMsA==
X-Gm-Message-State: AOAM530xIDe1g+6wrDZ1Mrez/eA4zD4SdatELHBcDv0JbXjPJ0iguIOk
 Es6C9+prOE24V/VkRbLScip8llcSBjIwkcHQbfaGZHuYi2JcN1ehkmOQlfpaM3wOi3hPUrbO+tS
 sC/U7U+uApODqqqk=
X-Received: by 2002:a5d:480a:: with SMTP id l10mr218931wrq.318.1590091165275; 
 Thu, 21 May 2020 12:59:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf2/5vizkFDODXCGechy4gRzEy5r6dl18xJAFAHaWHwEZBQajFYoXRzr3BwlgURU3Dng8wSw==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr218905wrq.318.1590091165117; 
 Thu, 21 May 2020 12:59:25 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s11sm7405424wrp.79.2020.05.21.12.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:59:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/11] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Thu, 21 May 2020 21:59:02 +0200
Message-Id: <20200521195911.19685-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200521195911.19685-1-philmd@redhat.com>
References: <20200521195911.19685-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>

v2: Cover accel/accel.c & accel/Makefile.objs (thuth)
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eebdcc6aa9..d7b98f9878 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -415,6 +415,17 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
+Guest CPU Cores (other accelerators)
+------------------------------------
+Overall
+M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: include/sysemu/accel.h
+F: accel/accel.c
+F: accel/Makefile.objs
+F: accel/stubs/Makefile.objs
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


