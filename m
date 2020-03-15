Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B34C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B711206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnBHgvM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B711206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdKI-0006xz-8K
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd9i-0003oH-Hi
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd9f-00045a-BM
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd9f-00043b-6n
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIpLs9OctqCuKos7ZiUUzN2VPTQfmDm1r4MzNZjOnFQ=;
 b=YnBHgvM5k64AoOpqfTBJRQTWy8sYp96qEOVsYs7pOfEGhI/d7l3snQ92C1AQ33s7WPzd+p
 vrgaO6r6L03xgavih1A6c36zr8eHyN76Rmu2yPezglMdkvH4PQNoATwGkzqNyULtMQ9+b9
 gomih7Gs+063d90VWytck6MgGMjzAKE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-UK6YRZgBP-iVjpdHgUNKVw-1; Sun, 15 Mar 2020 19:58:27 -0400
X-MC-Unique: UK6YRZgBP-iVjpdHgUNKVw-1
Received: by mail-wm1-f69.google.com with SMTP id a23so5014557wmm.8
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uY3oKl3eAdfHR0fz6PQrp/bV3LAJ2aY0H7iSeuB//0A=;
 b=YmS9XcQVI41JENx9F0fxM6nCQNaqfde5vJNub4XbsfYGYyjEIWCYTZP6slD0qQNlsO
 Sjzqmvdb6t7D/CQlm+cX3YZOZSQulXMOBseoaxW2L+X0NEHCgboIn/IVOPJLS0jv1g66
 WqCn8qt832iEvDVaRRoRARpkT9utkvOsu3jUDsOMjmO53zK/oZXwslZq2XmzVyvBul6e
 DJNZCfypScvtJoO1bV74aGpC34jP4GmZtOl7tGRbpuhJUw+6sTgZtPIoibv44lyawy/B
 nhtY8Z1a1ndvluZdjMPfekLl/kRRHyuPdmEp+ebiVT58gCZ7qW7pcURBMUfJEFQmNwGO
 Jm4A==
X-Gm-Message-State: ANhLgQ2AgZMQtBi53d1Q20w0quK9hSmcrwAAEzH50l9hNyY3UAP92Kio
 Idr+PfkcPTipY/Y0DH6X0l9vMFQZfgByxoLpHzapd3n1Gc3ITqF3EWg1v9ppxY2IyRyhhUJN1s5
 z3zlqkPcH5DATazc=
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr9850983wmd.16.1584316706062; 
 Sun, 15 Mar 2020 16:58:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFSZ8a1xPKoAUJpUTBbcg8KqBFak+jSDu0iodws8OyRXOif1AhfUVCzYL+udH7kIdblowc1w==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr9850950wmd.16.1584316705755; 
 Sun, 15 Mar 2020 16:58:25 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id p10sm90850559wrx.81.2020.03.15.16.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] hw/core: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Mon, 16 Mar 2020 00:57:16 +0100
Message-Id: <20200315235716.28448-13-philmd@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
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
 include/hw/core/cpu.h | 7 ++++++-
 hw/core/cpu.c         | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73e9a869a4..48ab5ec3ed 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -492,6 +492,8 @@ bool cpu_paging_enabled(const CPUState *cpu);
 void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
=20
+#if !defined(CONFIG_USER_ONLY)
+
 /**
  * cpu_write_elf64_note:
  * @f: pointer to a function that writes memory to a file
@@ -541,6 +543,8 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, C=
PUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
=20
+#endif /* !CONFIG_USER_ONLY */
+
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -634,7 +638,8 @@ static inline int cpu_asidx_from_attrs(CPUState *cpu, M=
emTxAttrs attrs)
     }
     return ret;
 }
-#endif
+
+#endif /* CONFIG_USER_ONLY */
=20
 /**
  * cpu_list_add:
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index fe65ca62ac..debdd7e670 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -209,6 +209,7 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, in=
t int_req)
     return false;
 }
=20
+#if !defined(CONFIG_USER_ONLY)
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
@@ -219,6 +220,7 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu=
)
     }
     return res;
 }
+#endif
=20
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
--=20
2.21.1


