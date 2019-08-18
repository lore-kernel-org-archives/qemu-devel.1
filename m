Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B8C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A79021852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A79021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUIM-000814-3b
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzU5i-0001vv-92
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 18:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzU5g-0000CZ-A2
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 18:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58166)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzU5f-0000C2-IU
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 18:55:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0B59A2890A;
 Sun, 18 Aug 2019 22:55:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-33.brq.redhat.com [10.40.204.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 673A51D1;
 Sun, 18 Aug 2019 22:55:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 00:54:11 +0200
Message-Id: <20190818225414.22590-13-philmd@redhat.com>
In-Reply-To: <20190818225414.22590-1-philmd@redhat.com>
References: <20190818225414.22590-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Sun, 18 Aug 2019 22:55:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 12/15] hw/i386/pc: Let
 pc_build_feature_control() take a FWCfgState argument
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass the FWCfgState object by argument, this will
allow us to remove the PCMachineState argument later.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e11ba7efce..460f55fd09 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1608,7 +1608,8 @@ void pc_cpus_init(PCMachineState *pcms)
     }
 }
=20
-static void pc_build_feature_control_file(PCMachineState *pcms)
+static void pc_build_feature_control_file(PCMachineState *pcms,
+                                          FWCfgState *fw_cfg)
 {
     MachineState *ms =3D MACHINE(pcms);
     X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
@@ -1634,7 +1635,7 @@ static void pc_build_feature_control_file(PCMachine=
State *pcms)
=20
     val =3D g_malloc(sizeof(*val));
     *val =3D cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
-    fw_cfg_add_file(pcms->fw_cfg, "etc/msr_feature_control", val, sizeof=
(*val));
+    fw_cfg_add_file(fw_cfg, "etc/msr_feature_control", val, sizeof(*val)=
);
 }
=20
 static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
@@ -1680,7 +1681,7 @@ void pc_machine_done(Notifier *notifier, void *data=
)
     acpi_setup();
     if (pcms->fw_cfg) {
         fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        pc_build_feature_control_file(pcms);
+        pc_build_feature_control_file(pcms, pcms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus)=
;
     }
--=20
2.20.1


