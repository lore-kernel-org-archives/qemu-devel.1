Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069EBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C130B206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fovsmLAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C130B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdpm-0000dT-Qg
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdov-0007NQ-7R
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdos-0002te-4c
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589562501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtqBVDpcxzLSIYr46Mh7kdVW472e1QUV+XMsC1Vk51c=;
 b=fovsmLAqsKcuttUUSF8HXN1cOfhnVKOFnY5uyRRLsFjcdsEU/+rD7WX8N9LjuzmnaqufPe
 R/k2zUoqvexnQ99TmtcfcCS/oVK6klizCiRYHB0BFjHHUs4KknpFKvW9keYQOIGZUrT41H
 9qTQmOBwk9ajLfu6x9AhVxwNquHPS9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-v3E2A2ZHP_mwWUx6f8FJtw-1; Fri, 15 May 2020 13:08:20 -0400
X-MC-Unique: v3E2A2ZHP_mwWUx6f8FJtw-1
Received: by mail-wm1-f70.google.com with SMTP id t82so1165197wmf.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LtqBVDpcxzLSIYr46Mh7kdVW472e1QUV+XMsC1Vk51c=;
 b=bOA0QnXIwZgPH2vB3ni9xIBP1YuxI2/vpl+6OmhKx4ovyFHUALs5Ixou9Fj3rjOopZ
 AdulH/Dj1zu6Cyg1oVdm/C/RdTgCOZAnar1vzVuYSHVWQsulwESgiBNCshZQ3+hr6mRY
 Z1YqjYvUzAtBOipbaSev8z4AEPJ67jRWMu73UemxkIw7W7ysW8tOB5LsrRI8Hgk3+AIB
 Ufgam2Bd2eVIem9YZhGqpPOEmUqaalmvj8VqagnaQ0pAzHuED8acBcGDeWSkEeWqjQoR
 mSWMPzLTPHRueRNk72w6r0ChFIfvsZS3BDCrlqGjbgS0VUCBpeP62pgXQyjO0MUijP8r
 kFMQ==
X-Gm-Message-State: AOAM531g3jPL5oUz0dOfrGGMcNUFvboi0sQ8U54mS1YTVjJ5wbox6W6d
 gSpqHQAJYd0LlsxkxBX43zXPh4RsXHzRNpqkbWyyI4RwMhHw/AOr1ZTcoS3Oz563M47DbvUWLPW
 wK5bhmE8a8OGmhd4=
X-Received: by 2002:a7b:c086:: with SMTP id r6mr4873600wmh.29.1589562498424;
 Fri, 15 May 2020 10:08:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4umMWdgiN1Dgl83Lg9rVKE5hcBz1uRpI3ivnkOUtLlLFcj5d3xhgJtN7a/k/lJp/Ro/1N+A==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr4873567wmh.29.1589562498195;
 Fri, 15 May 2020 10:08:18 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id j1sm4416059wrm.40.2020.05.15.10.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:08:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/10] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Fri, 15 May 2020 19:07:56 +0200
Message-Id: <20200515170804.5707-3-philmd@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd88a3de49..659092eb43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -415,6 +415,15 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
+Guest CPU Cores (other accelerators)
+------------------------------------
+Overall
+M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: include/sysemu/accel.h
+F: accel/stubs/Makefile.objs
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


