Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD8C2206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmU3t9Aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8C2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdCb-0004Pc-RF
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2h-0004k6-AK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2g-00041v-50
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJEUowLb7RvCQfJQiY10vUGrOBr7KqqEEqIh+hFxUmw=;
 b=cmU3t9AqtA26hy+4rPk9vvxbOgOTNOehkU6Fw2z9q1tzoGItAcZxcH+uWvx3bMccU9xBX4
 Ykk1H372ix6t6782h6up8Y1YYN4RtMgh2+8C8xEkmpJ8+b2LvavdkA5HBfj0UdC7ZbC+Km
 MXGBYrbs872vg2jdKdGcdpIp5D3VSj0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-zsKZxagAPVO1STLB9BvTFA-1; Mon, 04 May 2020 11:30:00 -0400
X-MC-Unique: zsKZxagAPVO1STLB9BvTFA-1
Received: by mail-wm1-f69.google.com with SMTP id t62so5116091wma.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vOETN6PdLHy6NVEAy7zvorEiCPF47jtqFdmHbXoOmUs=;
 b=MRReYBRNVSJ72OfQkNKPPEgYYez+S1CpkoV7EHIArYL3lLUMef9PPWlglFKJQnIoya
 bKO0ba47WDs+KwC251PTEzfaxhOuBKj3eroVYSpmaw3zIxRT/mJ7GjFn+bRsrkmgL9Jw
 Po0tV5BWpHNHrlrFMWqLYycyW80YgjjTnCQLGDR9SAMtMcY7tnpOSVqnBwoyOqZhzYNk
 ze0HzHwA7jsQmQHuQlr6LY0b/bDaA4iEU+c2z6tWPejak7oxVYI7LFvYjQBxzgZ5Hmqt
 7DTHUxnu0KlrpbzhP7N3xpRcoXbZLulLPm5d5v/clAdIIQ8JSgE3M9NoiFmJ0NsdhVnv
 Q2Ew==
X-Gm-Message-State: AGi0PuZjuCRZJk9aMRep4bN6ZpqsCdUT7EIbI/e3wgtFtt2kA6SSPwcz
 2nL8H4BtM1e7VlP8NqXoA2VQURrocVkTjLZi8/eRiDfMXEw1lsRalGUEHI6TT/WlUrYz44WFqox
 oftljDkBhzmhs+oU=
X-Received: by 2002:a05:600c:2f88:: with SMTP id
 t8mr14763546wmn.46.1588606198544; 
 Mon, 04 May 2020 08:29:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpmk7YsxPrFWLliPrb8nTsxnanKnLEiwl5Wj5AHzpYnXRew0sOBcZ9G57iAgM8zv2R1wCVEg==
X-Received: by 2002:a05:600c:2f88:: with SMTP id
 t8mr14763507wmn.46.1588606198355; 
 Mon, 04 May 2020 08:29:58 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id t4sm13373338wri.54.2020.05.04.08.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:29:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] target/riscv/cpu: Restrict CPU migration to
 system-mode
Date: Mon,  4 May 2020 17:29:17 +0200
Message-Id: <20200504152922.21365-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504152922.21365-1-philmd@redhat.com>
References: <20200504152922.21365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/riscv/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..6c78337858 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,10 +485,12 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
=20
+#ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_riscv_cpu =3D {
     .name =3D "cpu",
     .unmigratable =3D 1,
 };
+#endif
=20
 static Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
@@ -544,13 +546,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void=
 *data)
     cc->do_transaction_failed =3D riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access =3D riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug =3D riscv_cpu_get_phys_page_debug;
+    /* For now, mark unmigratable: */
+    cc->vmsd =3D &vmstate_riscv_cpu;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_initialize =3D riscv_translate_init;
     cc->tlb_fill =3D riscv_cpu_tlb_fill;
 #endif
-    /* For now, mark unmigratable: */
-    cc->vmsd =3D &vmstate_riscv_cpu;
     device_class_set_props(dc, riscv_cpu_properties);
 }
=20
--=20
2.21.3


