Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4869C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85E3206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85E3206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYox-0006Bb-UK
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgX-0007Hg-J0
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgW-0007fc-CV
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:29 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8GdE-1iv6vP2Pdg-014A1G; Sat, 06 Jun 2020 15:16:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 18/19] hw/core: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Sat,  6 Jun 2020 15:16:06 +0200
Message-Id: <20200606131607.1250819-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GZZSYLrSs7M0urx3dC04OAdGxc8HgaFQr1CphinUO/x2RDeOx0+
 MkPLmNUo0Y/dy625VBsoMyasAAwcnWuTmmcwttTdtcZFeXumfB3wYbmW3JlFzPIwsk//40I
 ZUUmDEuRzMgFNNFKrHveVQ/pFZgY96d0ngKNimcwI+BpmLdWHJGtKaZkvgPzqM7mSUJ6I1R
 XJeesQzSpnXbF63sgSFqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XZdTX8sJvSs=:c4b8xpKfWx0os2crdNivhZ
 lMVAIGkJT4EG7AdnDiLYyPAilzlovKSaaIqPJrduHwNOiVbVpGZp8qYcYT2ylvMFJK7SbAegk
 duI6EPn1+wyKD46prq9N6ml07JXAWzOWehnRtUWJtjS6uHNpMIExwSx4iHmnW2YSFUiePsqB4
 Ax73pa5qS1sRik34eg32AX9sRE39VgukKhvSTO9to06U+gBI1rn7JaGv0cbSHcdlQ9aNRLzvF
 d7f88+Z8kPmyAfKkmCJao+KUWYNfx9F+cbcbOR3qug7vESU0xkpGbO9aCQs8On8UJGmXfuocu
 /6rMyRmVw025W0sKByHwrSnHYy+0pfA+7VieyDI0xxUXcpodJHeooIp5LWUzd5BD+QrasdeU6
 9VKgDkMvFsNBpsIvQPd5YhUOSm30mvt7sQMC4YQWcL/3m7IWDcCBaQwQzr7DS+GMB+wlBiGtS
 MoKwQB4hV5gYgYSFLxsawzQQu/USWH7L1vlUsk2fzDQCVyc5hp89om2swywpIr/nYXf9bUduW
 KEOeKKOP9r02+q/VguVlNkMyfpSSEBnIun85VNdHqZaEL9HVhPGUwv6i78sLdsg7WJvYnDTvW
 uBufT6UowOeGfsK2jPXqy4YJfB7ZKMYLPUsH6G2Rbc/faS/z0kimWWF53ieFIzsTTpeB9aofQ
 tEIySvqiuqfUcQDmb3qt5Czroax3Cy3qK3ZGEWBc0vqGMFdLuzcOfaCipkadJlsbJG2yk/T9e
 QbZzSKW5UhmxigvOur3oTrf51+mZOlujM4OHxRJy401Z6LqygMhGciGxFDWDMHxD1d0fdrAFU
 8kd1WwZw/2QuAisb1F9Lnlm53ITJDNm4PwiUhaZEPw8vD/sLbMf5N6/45OYVOwkoaqMM2OD
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-13-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/cpu.c         | 2 ++
 include/hw/core/cpu.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 5284d384fb6b..f31ec48ee61e 100644
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
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 07f769815502..497600c49efa 100644
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
-- 
2.26.2


