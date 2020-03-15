Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB5C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1847F205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwk83lO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1847F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDduL-0004Z4-Ta
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd9G-0003by-6v
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd9E-0001rc-QB
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd9E-0001mF-MD
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JmRVORiwtSJYoBeVoEmrby0Y//1T3rIJ9u2/7gHdTQ=;
 b=fwk83lO/KArHGu4feF0n0mX1Ygrf1lGxYD6jYvpEjWkI7xQlo7QWkO/ymB7BCQyAHS+yba
 /cpCvzcv7tzElVsmd6l5n4a4rQ3oLBU/2fVl8h1d8nYYrySdJLZuLYAm1DtFJz9KEPYhnD
 zq9LvfDt32u3B7z6yLp3vJV/rKwuiJ8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-YwJyPUERPmSiKtGhWkRfrQ-1; Sun, 15 Mar 2020 19:58:21 -0400
X-MC-Unique: YwJyPUERPmSiKtGhWkRfrQ-1
Received: by mail-wr1-f71.google.com with SMTP id t4so3827391wrr.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VzAQhG80aIS2pHeqGJ8SUFQpAwQC6Y9ca6wH6S2kkG8=;
 b=ZFpCdATelIIj8HY6cx4KQHI1fvoVePVBFNWBmQoW1RQhcOKb2TCRktPU0iS3rKfhvB
 0a0Ufu6JJ2v9s0dy03/xQV5TH8UG/1yHusQUThX/AhVe3BRYwFYMlkRRYxrh0FEfWfG5
 jN/HSx/54f+SwG5PrtbHcy8sO2n/JzvRUf25kSae91icZaUtQJRWDUpIHir0C2esNHIP
 LfuaYTkQ9E6hDU+K2o7bzEmgeP7Hl8gvm2FVc0domzHpTQfehtVeJx2HbI1LtTouW7uL
 4PiJVYqEawY/GsdNOUiQ6/aUrVpxDd7/MEmW9xaWvoBS7gGrqDJ3+8k0Pgv6/K48wsL9
 yZGw==
X-Gm-Message-State: ANhLgQ2P5eoF/Y+a17aNOTHq3MOvWWsI2tbgQ6VMwMkRDUG8WM/aVH8M
 P9+NBKKe/nfXOU+eU3t5iALTKuqCp0ed0pwhsBIZCHHNR9Hijvrs03VNiK9+tnmw3ZbXPV8dPSu
 Xh2mLnvTl23Sdxi4=
X-Received: by 2002:a5d:4388:: with SMTP id i8mr5029530wrq.216.1584316700446; 
 Sun, 15 Mar 2020 16:58:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtQXQGnsDnvfo8vXPLk0j7sOLWRgY/ZMyjsH25ihuzIAGUbzZQXVi5i2lHKb4KMCnPUimR/DA==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr5029512wrq.216.1584316700239; 
 Sun, 15 Mar 2020 16:58:20 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id s22sm25922805wmc.16.2020.03.15.16.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:58:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] target/s390x: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Mon, 16 Mar 2020 00:57:15 +0100
Message-Id: <20200315235716.28448-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/s390x/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3dd396e870..3b1377c20a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -237,6 +237,7 @@ out:
     error_propagate(errp, err);
 }
=20
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
 {
     GuestPanicInformation *panic_info;
@@ -246,11 +247,7 @@ static GuestPanicInformation *s390_cpu_get_crash_info(=
CPUState *cs)
     panic_info =3D g_malloc0(sizeof(GuestPanicInformation));
=20
     panic_info->type =3D GUEST_PANIC_INFORMATION_TYPE_S390;
-#if !defined(CONFIG_USER_ONLY)
     panic_info->u.s390.core =3D cpu->env.core_id;
-#else
-    panic_info->u.s390.core =3D 0; /* sane default for non system emulatio=
n */
-#endif
     panic_info->u.s390.psw_mask =3D cpu->env.psw.mask;
     panic_info->u.s390.psw_addr =3D cpu->env.psw.addr;
     panic_info->u.s390.reason =3D cpu->env.crash_reason;
@@ -276,6 +273,7 @@ static void s390_cpu_get_crash_info_qom(Object *obj, Vi=
sitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif
=20
 static void s390_cpu_initfn(Object *obj)
 {
@@ -285,16 +283,16 @@ static void s390_cpu_initfn(Object *obj)
     cpu_set_cpustate_pointers(cpu);
     cs->halted =3D 1;
     cs->exception_index =3D EXCP_HLT;
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NUL=
L);
-    s390_cpu_model_register_props(obj);
-#if !defined(CONFIG_USER_ONLY)
     cpu->env.tod_timer =3D
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     cpu->env.cpu_timer =3D
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
+    s390_cpu_model_register_props(obj);
 }
=20
 static void s390_cpu_finalize(Object *obj)
@@ -477,13 +475,13 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
     cc->do_interrupt =3D s390_cpu_do_interrupt;
 #endif
     cc->dump_state =3D s390_cpu_dump_state;
-    cc->get_crash_info =3D s390_cpu_get_crash_info;
     cc->set_pc =3D s390_cpu_set_pc;
     cc->gdb_read_register =3D s390_cpu_gdb_read_register;
     cc->gdb_write_register =3D s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug =3D s390_cpu_get_phys_page_debug;
     cc->vmsd =3D &vmstate_s390_cpu;
+    cc->get_crash_info =3D s390_cpu_get_crash_info;
     cc->write_elf64_note =3D s390_cpu_write_elf64_note;
 #ifdef CONFIG_TCG
     cc->cpu_exec_interrupt =3D s390_cpu_exec_interrupt;
--=20
2.21.1


