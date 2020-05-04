Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BE02063A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDWZk6EG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BE02063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdHH-0007ft-K8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd31-00057F-5u
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVd2w-0004Ah-3P
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588606217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHPd6DRGT3/QfAQv+8lMnqMpzhHq6WqmC6OekczJuuE=;
 b=YDWZk6EGVNZjBd8U5bz9Etz+Tz6vNcdyESJCWo2h65JPAakO/3jdR7weo4datuuY+HWJ0f
 De+M4jtT0TEZ371k4nVxrpa3ucKYbaUtF1APuEBqzAIBZw1y/ROm/Jfncbp84kskvY3zcO
 3PpSm3tVtEi1V1K+MW90yRLDL//cRa4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-5iqUCI8LOIyPy9WLMOp_mA-1; Mon, 04 May 2020 11:30:15 -0400
X-MC-Unique: 5iqUCI8LOIyPy9WLMOp_mA-1
Received: by mail-wr1-f69.google.com with SMTP id g10so2199466wrr.10
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 08:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m6+xvd3mxJRnG7uL+iwXoaJtRFRM8ce9ioU3VRg64KY=;
 b=h6gBXCusBslPlqXxBm6t9w4Izx6Bw+QSIQTbWyEPn2hGPY4hErFiC6EGQW+VKqK9NU
 TYNTNflId3N3Hsn28RJXVHTfRInkDkH8Y3hnrlSItmbRmG7rN/3wMYD21ZuwEU8py3QY
 n4R2a6Pt3CgWjaOkbVMrPx1q8LVD8mMxAmKruHBNwikrlK3wnxW92pbJmmGmCzrjiL2Q
 FTJMvBu76/65pOHy+mtOE/qAX+5rnkEKA1z5x0NbcDAYQlT5og+93YgqhxSs/QDx7K2p
 2hKdm18t9/XnUBRzECHYt7UWezv4R5F8aE5UhNkY7vi99bvTcgxHCAWoSQ9aEYZvt0M7
 HcSg==
X-Gm-Message-State: AGi0PuaS6m5H6Arth05bJqNvh30KgYZyC4pVVM2w/01kvnuNWTh5w5nt
 YD9w3ukP0sF2LI40d/FZq9l0fX9W2lOz96mVcwZP6P+YVUFARkoti3OlIgv8fV+fCYCHbZAxGST
 SiGMc5Cb+j1wEfUg=
X-Received: by 2002:a1c:9a81:: with SMTP id
 c123mr14483186wme.115.1588606213756; 
 Mon, 04 May 2020 08:30:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKKhIo4R9drORflRphaERuyEWB3jMraFT2J2xJgoK941gxMvAR6QyLJQsGX+UXNYqtQ/lF/nw==
X-Received: by 2002:a1c:9a81:: with SMTP id
 c123mr14483150wme.115.1588606213381; 
 Mon, 04 May 2020 08:30:13 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id s24sm14363792wmj.28.2020.05.04.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:30:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] target/i386: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Mon,  4 May 2020 17:29:20 +0200
Message-Id: <20200504152922.21365-11-philmd@redhat.com>
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c256ab159..eec1ac7cea 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6848,6 +6848,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU=
 *cpu,
     x86_cpu_register_bit_prop(cpu, name, w, bitnr);
 }
=20
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 {
     X86CPU *cpu =3D X86_CPU(cs);
@@ -6891,6 +6892,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, V=
isitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif /* !CONFIG_USER_ONLY */
=20
 static void x86_cpu_initfn(Object *obj)
 {
@@ -6937,8 +6939,10 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_unavailable_features,
                         NULL, NULL, NULL, &error_abort);
=20
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL=
);
+#endif
=20
     for (w =3D 0; w < FEATURE_WORDS; w++) {
         int bitnr;
@@ -7251,7 +7255,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
     cc->cpu_exec_interrupt =3D x86_cpu_exec_interrupt;
 #endif
     cc->dump_state =3D x86_cpu_dump_state;
-    cc->get_crash_info =3D x86_cpu_get_crash_info;
     cc->set_pc =3D x86_cpu_set_pc;
     cc->synchronize_from_tb =3D x86_cpu_synchronize_from_tb;
     cc->gdb_read_register =3D x86_cpu_gdb_read_register;
@@ -7262,6 +7265,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc=
, void *data)
     cc->asidx_from_attrs =3D x86_asidx_from_attrs;
     cc->get_memory_mapping =3D x86_cpu_get_memory_mapping;
     cc->get_phys_page_attrs_debug =3D x86_cpu_get_phys_page_attrs_debug;
+    cc->get_crash_info =3D x86_cpu_get_crash_info;
     cc->write_elf64_note =3D x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote =3D x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note =3D x86_cpu_write_elf32_note;
--=20
2.21.3


