Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2507EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA04120658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIYSYisv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA04120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpOQ-00073Y-5Z
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpCB-0001ZN-DM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpC9-0005Bd-5S
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpC9-0005B1-0v
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MOJ97Mg3uK0x1VWiafJ67lfSZFLwR4mry93M3PzeTE=;
 b=XIYSYisvM95Af3fWw7nYZzTplHxmjkStADU3uyEILCsJyyExYyqMRsbSzvf/VGJBXNtkW8
 2/rRdAsC+DKYRDptOH92jKggvnC4jJxrrI4IDqlpCIFeivkUT2Bm+a4St/A5h8XsoUWSo8
 9J26HPLTeUS3W1pmwiYBM7h4aLjZsLE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-SCnl8dbQPguVEOyLSponvQ-1; Fri, 13 Mar 2020 14:38:03 -0400
X-MC-Unique: SCnl8dbQPguVEOyLSponvQ-1
Received: by mail-wr1-f71.google.com with SMTP id c16so4757762wrt.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bmLIgnK8nZe09V5xRPW03+txWxMqC+nMqZrcX0UoUn8=;
 b=XcYfVBgeLYuJqdDUhTbM4eJ8eMy0pQZGX2TwBChdAChtpxOMxcjAy2os7hIriOJyq+
 uzz3tni42NvtvhDf2sFPj3UzHlJazxRKWsLdYT28RE9OvYOhpscTwz/jxvJQS/8QPyNt
 s82n+6RMdW9KEqzPLJxV/ZaDlVPj+IEudwMArjMSCR8DI8ohDI9VAw7iN9WTSJneMSxF
 TPRANdOubcXL8SRsB1Cvznqaj8k/X45+THJOuttHJgwjZALycFmur7508kzs7hyxVO8L
 4WqvWjLDhQzek/NzCdmfWjMWJe6AAxJzAgFOgPaFkCSwSaPg+y89eE+AhPC4FrI2GAzN
 EP4g==
X-Gm-Message-State: ANhLgQ1uGMnG9j0EuigQNGcwFQy5X8NTUXaz12nL6ZE35sXZ+9yBnrnI
 zgSSsZJXRhfJclLHGeBebfrU+fYf0TJKldbddr6m8ZeNNXi+1MLMB0WNtRJw77FdS1zir1oUtxx
 R+ic8ux99LiCiDt8=
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr12077999wme.30.1584124681700; 
 Fri, 13 Mar 2020 11:38:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtclmKmGWDITHGPwMFiNasidZXEOeI/Khix6i2umLsjJPJ2oehdsOA5I9WH66oYsI9Bk4vE/A==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr12077972wme.30.1584124681479; 
 Fri, 13 Mar 2020 11:38:01 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q4sm36337983wro.56.2020.03.13.11.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:38:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/14] target/s390x: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri, 13 Mar 2020 19:36:51 +0100
Message-Id: <20200313183652.10258-14-philmd@redhat.com>
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


