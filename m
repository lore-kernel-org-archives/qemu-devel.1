Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E08C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1208520679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCFe26G5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1208520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDt4D-0007ny-69
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsGp-0004Gm-RV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsGo-00012G-PZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46771)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsGo-0000y2-Kc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yx+2IyWJnz1cKAJOo8cGVs9d/ga02LGh5bedgLQz1Rc=;
 b=fCFe26G5ukrvsFodtoKddSJi0ijLxfDTdthG7C3jXHgasHc+jyhk8csgPb7lCoyA6yqt+h
 wLjNmDx1/IzYD+j2pCVFOOfKv4TOt0DxIOtdmrUDIuV2rmgXb8iYcwXrqdx82S7Ukoq/BH
 cIFqPiTbUIIFWq6khNefda0ihGx8Ddk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-imvQ3ASVMAKZBsYHPJjGrw-1; Mon, 16 Mar 2020 12:07:12 -0400
X-MC-Unique: imvQ3ASVMAKZBsYHPJjGrw-1
Received: by mail-wr1-f70.google.com with SMTP id p2so6715001wrw.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yxNTHu0Y9BXexKmUFsNlCCh8LSzlOCW9yO82fm58I4s=;
 b=Gpn1fIzmNKu5EQPn2A2OR4KPACCU1fC+uV+n86BDoOzcyuFjR4UCxHnOxLxYThBQtC
 TVxj4keYWLWFraCriz8nGSik/mlz2kxvg/1ZEahoIavpYwkuxP+oVR4rtIhaOK27JF4A
 qm/SV85zAWL7n8UgX30jwkyGZG+CMwMICUpfYQrTXH0q56o6m9kSablV+fKRre2lUecS
 qsb0WvSTJFnG7+3tLU9mHB+GErivLep61Svr8ETubMOFowaWVTcckB8nLbWIuWwuWQZx
 pYCvu+UAAw0MfOrdFfe7Ayh6wsaJ7Uuli8YlQbTjCdKsVnCO/3BIGzUV1rOv7qT007ie
 l5Gg==
X-Gm-Message-State: ANhLgQ3eCyhV/xYFgrk6cuAsQJFYi8OlXaRpV+E5IqO2OF8aCOG+Zqq4
 d/P85H2L9gHFgpTn2oFrvOzwxxXmrlt3poQJ/A44YmPEzzeUyID2HIL1qCRsLZaVjAhqa8ba3X6
 /03oRtgQ15GR7xo4=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr28456591wmk.172.1584374830945; 
 Mon, 16 Mar 2020 09:07:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7IJfPb/lnQB6VsT1fXs4khiy3iYFUFjrhDCacWI//Wr03P/OMBnlYg0XoQf+8TAXToOGQKQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr28456569wmk.172.1584374830787; 
 Mon, 16 Mar 2020 09:07:10 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id p8sm552349wrw.19.2020.03.16.09.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/19] target/arm: Move Makefile variable restricted to
 CONFIG_TCG
Date: Mon, 16 Mar 2020 17:06:21 +0100
Message-Id: <20200316160634.3386-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simple code movement which simplifies next commits.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/Makefile.objs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index cf26c16f5f..0c6f8c248d 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,4 +1,3 @@
-obj-$(CONFIG_TCG) +=3D arm-semi.o
 obj-y +=3D helper.o vfp_helper.o
 obj-y +=3D cpu.o gdbstub.o
 obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
@@ -56,6 +55,12 @@ target/arm/translate.o: target/arm/decode-a32-uncond.inc=
.c
 target/arm/translate.o: target/arm/decode-t32.inc.c
 target/arm/translate.o: target/arm/decode-t16.inc.c
=20
+ifeq ($(CONFIG_TCG),y)
+
+obj-y +=3D arm-semi.o
+
+endif # CONFIG_TCG
+
 obj-y +=3D tlb_helper.o debug_helper.o
 obj-y +=3D translate.o op_helper.o
 obj-y +=3D crypto_helper.o
--=20
2.21.1


