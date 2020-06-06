Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7543AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B54A206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54A206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYq9-0000tU-I5
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgc-0007K6-AQ
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgX-0007fo-KR
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHGPA-1jlyWl00sS-00DINq; Sat, 06 Jun 2020 15:16:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 17/19] target/s390x: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Sat,  6 Jun 2020 15:16:05 +0200
Message-Id: <20200606131607.1250819-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oVVlg+zAD4r3gNfcMirAhifpwGVg/NT5rl3BdmGJXi43bsT5oCk
 Eoik894KLLIjRJYd1WZnV2tHbWMt7ECxSYBbhzbGt/WrFSTL72r8mh8UwpCFX/m1x8MBEr7
 RbC5xxuMb9k5qgtip0koSuT4dm7GcIfI6Kwxhq9vkf8wOV4OLce6oJ8DxSdHJn1I4aVWFVY
 MM734jyASbLPqOuhmASuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezPdbSSDJUE=:ohDBTnCLNUNVKnqsGXAdyo
 xuVRKZlh3mZo4VsZxeHsUfupQRyKhmPBHITdZXyrex4jRlc20veKCUAHbfY5fPP9U6++O6wdl
 1sQsDWJUvdjGtm7ks6Pxqb6hJY2df4fxJ424Lu3s+V6g4fJ4Qkt3PQEPOTJOuh7tFcRsmO1DD
 HlFvUx7YtyUoHFX9FfJWe2qT6vVRdKCoqn5nHfz37e23XZiT7rxp0MkVJyGImMNtl2RTEQS6J
 GqHpPmJvL115bjs47Pl5BESo7//yxcc9pnV/xDNF/3qdKeqiVqtUlmv9eN0/Wh845BEWBFwtV
 K8Bz1cfd48PqDLHWnsOjT97cy3joOYtbm7Lddh5Xlo/wda/sXPtMDgmNPonic/NKzIgjohZG0
 dsKmoovOX9I4u8J72OoldWzlLQ3kNsZnBBQBp3gZzxAswi6aJqcRjOHAWk8lrNXofUvbB/Tcy
 AV9Fh7EKlFy7ASyko4V/vnui7wLGEQPTkzqbCBOIKOjx6oCNbzJR6eFkRzuD1ol0HiyQF51Q+
 ady+WKy47MwIRaI0cTDTEXEAtp4jR+LdjK8gslgWIb1SjORVmOSvwgScV40z81vb3QWvq4gZf
 S+BXRGi46ZrSK5oGQTq0kFl550Ilq1d8qcUn508kdTRorPwNZECy4GYfBSBSMZQmp3waamLFy
 nVn2rw5gC56QPVYQjHmS/IFGRzg0Bk7DoAv0eXmwiE3AaBa64K8boirPoL6uRfTheCpgjs70l
 OKTUdzykEa610avDf1PJ05jqtszq8zIf+XyF4zq5niorKDtaX8Ec5Br3VadqyGUv2uhowXhCE
 RL87MgyLOH41wFDGHgRe8eblGkSuLmSYLYbiOjRnkK9rBkDskxx00Qwp+Ye/g8PFbM+dUBV
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-12-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/s390x/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ca50b7045198..08eb674d22b4 100644
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
2.26.2


