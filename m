Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B46C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33777206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3NLwkeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33777206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpLt-00033c-AX
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpC0-0001Bh-Mr
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBz-0004lh-7x
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBz-0004kP-3j
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6kDoneuZrMhDVCRmujvDk3IfPp3E6PHImkHQw061IY=;
 b=N3NLwkeLsHolGeQ7T3a6eo35xVaOMqEnSRhIHXXBtV7e0grtkpd6taBiMaL9q6/81M1R3r
 aTgI4fUeevRetrPB4sVpYEZvQ7JOlrHIm+ALrrW1HCplM90uWRKGl/dpUiTjnvI8HjogJU
 EuZnqVAYipAROp6hfggn2TKXLQJEWGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-yTl5njkEMzGBHglAT7wzNg-1; Fri, 13 Mar 2020 14:37:53 -0400
X-MC-Unique: yTl5njkEMzGBHglAT7wzNg-1
Received: by mail-wm1-f71.google.com with SMTP id a11so1368629wmm.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iYsZ3FxrwnOLNhhBs5OQJLjNJeFk+YWQzk3XZ1uOqWs=;
 b=oH3qmI00m3mN3CK6VxRWDBhf2WdcAyIw+zMpP1pcPDDZJ52ybRb1cQJqcVz/SvalCB
 mWn+FR4dJLC6Ghfzeg39h+GbcNDQSgFf7xY9sbROuiMw0bveUnRd53cbr4weQMHit6o7
 +miNvgaDWUD7SA5BHVYi2ob4cotb/sOPmyDwYv5q3RXtrONWf3gQNxN/HtI0gjtdgiPa
 ShHNUrVd8KpdLeKEg9+qI+kchBUOid03Q/7jESDXzdFbUjVAYLl6YSMIc0spmtPIJJON
 mdpXQzdDAn4hsV45JDSLD5EqumKFNCNpPeGYalgbNUTciHMsceNPfAx9XXgyJ7KdUU+3
 X8QA==
X-Gm-Message-State: ANhLgQ2GMGCsZZTwJpPr0mYRYjFGqw1jFLi4gNIejhegUcXMIjYAdcXE
 uMYqa+TmUxnnc76GDDb1XTaCUIy5h8h0atQ5V1KqFGpzrH3YC7S+gVf1cytsjbP23JdXNYB5sg0
 hhWGwllzHR2YEj1w=
X-Received: by 2002:a5d:574e:: with SMTP id q14mr18374374wrw.330.1584124671736; 
 Fri, 13 Mar 2020 11:37:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuzB9FhPCxZc8c+0Bt5wwNy9uUOC87j76T5iMKQTrkMJKvPhtuZkOqXgFb/ot1hwBoMX14+LQ==
X-Received: by 2002:a5d:574e:: with SMTP id q14mr18374340wrw.330.1584124671486; 
 Fri, 13 Mar 2020 11:37:51 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g129sm19273217wmg.12.2020.03.13.11.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/14] target: Restrict write_elfXX_note() handlers to
 system-mode
Date: Fri, 13 Mar 2020 19:36:49 +0100
Message-Id: <20200313183652.10258-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.h                | 10 +++++-----
 target/i386/cpu.h               | 18 +++++++++---------
 target/ppc/cpu.h                |  2 --
 target/s390x/internal.h         |  3 ++-
 target/ppc/translate_init.inc.c |  2 --
 5 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ffd991b6f..8a22212521 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -958,6 +958,11 @@ void arm_cpu_post_init(Object *obj);
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
=20
 #ifndef CONFIG_USER_ONLY
+int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
+                             int cpuid, void *opaque);
+int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
+                             int cpuid, void *opaque);
+
 extern const VMStateDescription vmstate_arm_cpu;
 #endif
=20
@@ -982,11 +987,6 @@ int arm_gen_dynamic_xml(CPUState *cpu);
  */
 const char *arm_gdb_get_dynamic_xml(CPUState *cpu, const char *xmlname);
=20
-int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
-                             int cpuid, void *opaque);
-int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
-                             int cpuid, void *opaque);
-
 #ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbf..f25fe5fc7c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1738,6 +1738,15 @@ struct X86CPU {
=20
=20
 #ifndef CONFIG_USER_ONLY
+int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
+                             int cpuid, void *opaque);
+int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
+                             int cpuid, void *opaque);
+int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
+                                 void *opaque);
+int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
+                                 void *opaque);
+
 extern VMStateDescription vmstate_x86_cpu;
 #endif
=20
@@ -1749,15 +1758,6 @@ void x86_cpu_do_interrupt(CPUState *cpu);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
=20
-int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
-                             int cpuid, void *opaque);
-int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
-                             int cpuid, void *opaque);
-int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
-                                 void *opaque);
-int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
-                                 void *opaque);
-
 void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
=20
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b283042515..b9fb76d0b3 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1225,12 +1225,10 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cpu,=
 uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
 void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
 const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
-#endif
 int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
-#ifndef CONFIG_USER_ONLY
 void ppc_cpu_do_system_reset(CPUState *cs);
 extern const VMStateDescription vmstate_ppc_cpu;
 #endif
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index d37816104d..dcbd8d2065 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -226,9 +226,10 @@ static inline hwaddr decode_basedisp_s(CPUS390XState *=
env, uint32_t ipb,
 #define decode_basedisp_rs decode_basedisp_s
=20
 /* arch_dump.c */
+#if !defined(CONFIG_USER_ONLY)
 int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                               int cpuid, void *opaque);
-
+#endif
=20
 /* cc_helper.c */
 const char *cc_name(enum cc_op cc_op);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.in=
c.c
index 53995f62ea..768ec18a28 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10902,8 +10902,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, voi=
d *data)
 #ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug =3D ppc_cpu_get_phys_page_debug;
     cc->vmsd =3D &vmstate_ppc_cpu;
-#endif
-#if defined(CONFIG_SOFTMMU)
     cc->write_elf64_note =3D ppc64_cpu_write_elf64_note;
     cc->write_elf32_note =3D ppc32_cpu_write_elf32_note;
 #endif
--=20
2.21.1


