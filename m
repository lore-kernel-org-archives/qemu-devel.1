Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98246C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF6D205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi0cDb4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF6D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHGc-0004ga-Fo
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHFg-0003gS-9l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHFf-0008Nr-1h
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHFe-0008MD-U5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583755878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXgAGrtPhgvzRQUXqhGwMk2tMOYYjzi9xaVe5yS64Z0=;
 b=Pi0cDb4yQqy1Qi3wpBSrpfm2nq9wd89nhi14hNfl8GH6Srt6F3I+Q3wEZBkkFn4M7aSxls
 zrme7DoMisYj/FjAhj1c/SPRVXnUPESbt8YWu8ojMzrdxJk43qrfAkwaj//qJkgPwn/yxf
 n5TVVKFVrZ4/JZ10oZbTIvVM7rmZToA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-gdC24AESNpWBG2KJmuneIA-1; Mon, 09 Mar 2020 08:11:16 -0400
X-MC-Unique: gdC24AESNpWBG2KJmuneIA-1
Received: by mail-ed1-f72.google.com with SMTP id p17so2567028edt.20
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3ecVRP3opc1bGNljJ0SHMIFQGzksaL6md721N6NDR1Y=;
 b=h4Sz2mBcHnoataKZnPMgkz/2/iedAeymsrMBtiCd2h7j3ysyYDpFADngYDgmbUIQaM
 I6YZpQDoMZESxbrBhFEecnHzgRqFvvBq2qn7tbKDjr5hGymYw1oiQMGf/s+zFp8YOyZ0
 qzSVubM9s35QuRfUCU04e8+Tw4KOZaBvLCpyFq52DEX/d/w6/UJ3tRBZJDwBrFhgPKzQ
 tgBfrYwzJKVFcCIFqRaBKOn9hgXlJSwMxc0dNfuTsNNIu/HsmMqeN/eIulBIApbIoIJ2
 XMHaXUzLC6J8WJJXvnlxjG6VBMVRLK2JK1GUcinQ1G54O6//qoE8slXULRuZCpyRPqpO
 ZcDg==
X-Gm-Message-State: ANhLgQ0wlbq4h5Uuqj/S9SoXP6dDhjKdzrn8SW5uFJ22ZXbYl/WxUKZz
 gyeFJtLUbS00/jmVRE8Xnnj77+z4K7kRokpFONywzaF4C7OF26N7jq1siQsAMGjPKgl2abMmLwb
 wpugqqxp7LhB0njQ=
X-Received: by 2002:a50:ff09:: with SMTP id a9mr16288250edu.157.1583755873067; 
 Mon, 09 Mar 2020 05:11:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvyaYsutgc3cOXPbr+YH7cJP2+1avA+Vn46vBRKl6DXVkc7BvhXZ9bbg+5ZgN6fdlPIPzzXHg==
X-Received: by 2002:a50:ff09:: with SMTP id a9mr16288232edu.157.1583755872882; 
 Mon, 09 Mar 2020 05:11:12 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a22sm2771026edx.25.2020.03.09.05.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:11:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] cpu: Do not reset a vCPU before it is created
Date: Mon,  9 Mar 2020 13:11:02 +0100
Message-Id: <20200309121103.20234-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309121103.20234-1-philmd@redhat.com>
References: <20200309121103.20234-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cpu_reset() might modify architecture-specific fields allocated
by qemu_init_vcpu(). To avoid bugs similar to the one fixed in
commit 00d0f7cb66 when introducing new architectures, move the
cpu_reset() calls after qemu_init_vcpu().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/cris/cpu.c    | 2 +-
 target/lm32/cpu.c    | 3 +--
 target/m68k/cpu.c    | 2 +-
 target/mips/cpu.c    | 2 +-
 target/sh4/cpu.c     | 2 +-
 target/tilegx/cpu.c  | 2 +-
 target/tricore/cpu.c | 2 +-
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 17c6712e29..9b8b99840d 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -134,8 +134,8 @@ static void cris_cpu_realizefn(DeviceState *dev, Error =
**errp)
         return;
     }
=20
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     ccc->parent_realize(dev, errp);
 }
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 687bf35e65..56f7b97c8f 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -132,9 +132,8 @@ static void lm32_cpu_realizefn(DeviceState *dev, Error =
**errp)
         return;
     }
=20
-    cpu_reset(cs);
-
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     lcc->parent_realize(dev, errp);
 }
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f0653cda2f..51ca62694e 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -247,8 +247,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error =
**errp)
=20
     m68k_cpu_init_gdb(cpu);
=20
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 6cd6b9650b..553945005f 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -149,8 +149,8 @@ static void mips_cpu_realizefn(DeviceState *dev, Error =
**errp)
=20
     cpu_mips_realize_env(&cpu->env);
=20
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 70c8d8170f..2564436719 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -184,8 +184,8 @@ static void superh_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     scc->parent_realize(dev, errp);
 }
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index cd422a0467..7e9982197f 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -91,8 +91,8 @@ static void tilegx_cpu_realizefn(DeviceState *dev, Error =
**errp)
         return;
     }
=20
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     tcc->parent_realize(dev, errp);
 }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 85bc9f03a1..c5a5d54569 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -94,8 +94,8 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error=
 **errp)
     if (tricore_feature(env, TRICORE_FEATURE_131)) {
         set_feature(env, TRICORE_FEATURE_13);
     }
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
=20
     tcc->parent_realize(dev, errp);
 }
--=20
2.21.1


