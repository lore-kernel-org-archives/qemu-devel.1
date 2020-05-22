Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8011206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYfUZ28m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8011206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBVa-0005SE-QU
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQz-000689-Jn
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQx-0002DH-TL
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/65hCauFJWnN1aX2rplyb0BxyGjWV4gUFeVpgMNSns=;
 b=KYfUZ28mcwGtVsvsxqV6rMzAnkVDM6ZkwipFXF3XevrLDvEYEaCTeCbluiXQ2b9U6Fasbn
 iG1sjhQ9RGt5VgLab0ndu5zoXqge8L4Zvr08cm/3KYcVVBGa+wtE0sSLZWhMVuccv7+L9M
 iSxDKc5Opr9bXWFEp5921Xwv3yjiMtg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-hd8Y9LOvPWSmHIsglsnWSw-1; Fri, 22 May 2020 13:26:09 -0400
X-MC-Unique: hd8Y9LOvPWSmHIsglsnWSw-1
Received: by mail-wm1-f70.google.com with SMTP id j132so2852564wma.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A/65hCauFJWnN1aX2rplyb0BxyGjWV4gUFeVpgMNSns=;
 b=gp8ZOLeviZp5HcO0PG48hBP8IRagvg8AIv6gxrcMSRXrr/IwjP+KTwP3m4sL5rLOIY
 2U370hASnMdWIdJgyAPoAvAIpet7/73G/m5QmVP7uypDlk775bme92JR3FL9kFLwOAkx
 SKTn/JhX2/I2KJ6yQvM8ULzihxNhTCpG9AuTRvESv4JOk64fRd0DMpXzDaXrmnGcC3ZK
 rxlqRYv9Q6Jd+qt1C24J8q8lU+gkK2Qru/VWG+j83pDxy1I17FcI0EWdeol895JsNcGQ
 x07gdM9YBjzzfA+ZCu4Xfo+nLqwbHUBPLvpEEAzqSLOs096SeAfigYYrBonezrLwyoaq
 VHYA==
X-Gm-Message-State: AOAM530V27MtnFkbs9l9yM+e3/mCyF9ANPXFju4lbqvodRbOKPf8/Te8
 hhPgzJgml88DAPHWRwD/z1AOu7BkfgHYAVKcubluwOxLepbZWpUZXQuTn93yuTpwiwJhPV1E+De
 eLLWj6RsPMRcE+vo=
X-Received: by 2002:a1c:3286:: with SMTP id
 y128mr14098687wmy.119.1590168366482; 
 Fri, 22 May 2020 10:26:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ2jn4vcc1lpzn1Jd/+BJJz7hF/aOi8fySzYENyWUQr32lYyvFDfORNkUcXHU0iv645P4A2w==
X-Received: by 2002:a1c:3286:: with SMTP id
 y128mr14098664wmy.119.1590168366319; 
 Fri, 22 May 2020 10:26:06 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t82sm10579255wmf.10.2020.05.22.10.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/13] target/s390x: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri, 22 May 2020 19:25:08 +0200
Message-Id: <20200522172510.25784-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/s390x/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ca50b70451..08eb674d22 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -247,6 +247,7 @@ out:
     error_propagate(errp, err);
 }
 
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
 {
     GuestPanicInformation *panic_info;
@@ -256,11 +257,7 @@ static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
     panic_info = g_malloc0(sizeof(GuestPanicInformation));
 
     panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
-#if !defined(CONFIG_USER_ONLY)
     panic_info->u.s390.core = cpu->env.core_id;
-#else
-    panic_info->u.s390.core = 0; /* sane default for non system emulation */
-#endif
     panic_info->u.s390.psw_mask = cpu->env.psw.mask;
     panic_info->u.s390.psw_addr = cpu->env.psw.addr;
     panic_info->u.s390.reason = cpu->env.crash_reason;
@@ -286,6 +283,7 @@ static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif
 
 static void s390_cpu_initfn(Object *obj)
 {
@@ -295,16 +293,16 @@ static void s390_cpu_initfn(Object *obj)
     cpu_set_cpustate_pointers(cpu);
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
-    s390_cpu_model_register_props(obj);
-#if !defined(CONFIG_USER_ONLY)
     cpu->env.tod_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     cpu->env.cpu_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
+    s390_cpu_model_register_props(obj);
 }
 
 static void s390_cpu_finalize(Object *obj)
@@ -488,13 +486,13 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
     cc->dump_state = s390_cpu_dump_state;
-    cc->get_crash_info = s390_cpu_get_crash_info;
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_s390_cpu;
+    cc->get_crash_info = s390_cpu_get_crash_info;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
 #ifdef CONFIG_TCG
     cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
-- 
2.21.3


