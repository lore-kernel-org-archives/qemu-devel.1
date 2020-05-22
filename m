Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C99DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD594206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrrW2ZTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD594206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBXb-0000oz-03
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBR3-0006BN-JM
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBR1-0002ES-Bx
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSd40Ze4XM2b/X382gY1wRiBudpttPKJ8TAR2241lwg=;
 b=XrrW2ZTx53ChDE4rH5U0AYqIjha9IS7skLPxYJMVvO/NaI7SLUmX8UFKXYeXj2nFPpHxSx
 LJ87UCRw57Bx+66cSVs7hQ1MWCYhm3kdO/MYVo57ZmkhDd9V4+h7nAdJIOEX7/TSjrLWSi
 85ygdirMWacumV+YJDuFW1aIYqO2YGA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-miXhT13iPMKWFFOo_ALjLw-1; Fri, 22 May 2020 13:26:12 -0400
X-MC-Unique: miXhT13iPMKWFFOo_ALjLw-1
Received: by mail-wr1-f69.google.com with SMTP id d6so508207wrn.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PSd40Ze4XM2b/X382gY1wRiBudpttPKJ8TAR2241lwg=;
 b=mEOHcs1vxTaMYXkBsTOIwYd/thipfOu58MYAYoU+xXCnQdGgf0PHMtXqXPZHSWkHCe
 KEo8wKGF3Vv9w+95ozO1qYqoWyB3cTvRcfWx9yP96T1ucjODTNV+9X+kVbaptGrN5GPT
 2Ya9UCcUKRHy6/XymwPpOx8DlO0YG7qEtbB/EakGH32fL7FSQ4pmpehkQeef1voVMso9
 BvHb72sWF7avHfOEhOVipqUlC35OMPp6fd3gnvJiP99p/khVyhNTBjEDG/soW6xbeIS+
 wOsVRHytVjzbFC+aJP3TE3m+dcGbix0hroq/0/MAg8hsEI12vjTo6AADyN4ONFIOGnsF
 3M7g==
X-Gm-Message-State: AOAM533hWutaB4KwckGLCpUktahIjMTBT5UkxNpaLPGzXPUB3unBwWjT
 a5IGLW+u6cWYpUtUvE0nIEWoR47rE0LFjs+Q9uPgPEaZIEGDgx0cHhRfMLWsHLY2HIQh/kftrxi
 0oyXHaHiLKiChY+Y=
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr4128502wru.407.1590168371239; 
 Fri, 22 May 2020 10:26:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSSDT7mWCRgue/lCKohrU0T76EdQPrGYzEKzkRdy9U4PMJfPXzqLgEz/ZvOl8yqx15fixuLA==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr4128478wru.407.1590168371036; 
 Fri, 22 May 2020 10:26:11 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v126sm11365914wma.9.2020.05.22.10.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:26:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/13] hw/core: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri, 22 May 2020 19:25:09 +0200
Message-Id: <20200522172510.25784-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/core/cpu.h | 7 ++++++-
 hw/core/cpu.c         | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 07f7698155..497600c49e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -490,6 +490,8 @@ bool cpu_paging_enabled(const CPUState *cpu);
 void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
 
+#if !defined(CONFIG_USER_ONLY)
+
 /**
  * cpu_write_elf64_note:
  * @f: pointer to a function that writes memory to a file
@@ -539,6 +541,8 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
 
+#endif /* !CONFIG_USER_ONLY */
+
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -632,7 +636,8 @@ static inline int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
     }
     return ret;
 }
-#endif
+
+#endif /* CONFIG_USER_ONLY */
 
 /**
  * cpu_list_add:
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 5284d384fb..f31ec48ee6 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -209,6 +209,7 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, int int_req)
     return false;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -219,6 +220,7 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
     }
     return res;
 }
+#endif
 
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
-- 
2.21.3


