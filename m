Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C090A2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXCrNnfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C090A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlufv-0001Fd-0a
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluW2-00005p-Bq
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jluW0-0005u8-FN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+O77/1VoIy5ZmKPNfruC/I0o10kheFBwNmfaZ48ahQ=;
 b=WXCrNnfvwOFtjL7zGdr9s55LGxYHjAYn5loNTkCS+ssBMHbDOwDVoCP9V95iEuOg8imapG
 QdToizC4Ie8XJCIKl9p8dkPKfWSidRYJ19sBDvGUALaR1yw6+d8lhP07c/K8nsWlcct98W
 0Hfvmstcz37HtGXPht5b1G8FMan6uFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-G4xE9hiGO4q87iNx3N9cTg-1; Thu, 18 Jun 2020 09:23:31 -0400
X-MC-Unique: G4xE9hiGO4q87iNx3N9cTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE4B1107ACCD;
 Thu, 18 Jun 2020 13:23:29 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-109.pek2.redhat.com
 [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 918645BAC1;
 Thu, 18 Jun 2020 13:23:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL V2 31/33] hw/net/e1000e: Do not abort() on invalid PSRCTL
 register value
Date: Thu, 18 Jun 2020 21:21:46 +0800
Message-Id: <1592486508-6135-32-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

libFuzzer found using 'qemu-system-i386 -M q35':

qemu: hardware error: e1000e: PSRCTL.BSIZE0 cannot be zero
CPU #0:
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000663
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
EFER=0000000000000000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000
==1988== ERROR: libFuzzer: deadly signal
    #6 0x7fae4d3ea894 in __GI_abort (/lib64/libc.so.6+0x22894)
    #7 0x563f4cc59a1d in hw_error (qemu-fuzz-i386+0xe8ca1d)
    #8 0x563f4d7c93f2 in e1000e_set_psrctl (qemu-fuzz-i386+0x19fc3f2)
    #9 0x563f4d7b798f in e1000e_core_write (qemu-fuzz-i386+0x19ea98f)
    #10 0x563f4d7afc46 in e1000e_mmio_write (qemu-fuzz-i386+0x19e2c46)
    #11 0x563f4cc9a0a7 in memory_region_write_accessor (qemu-fuzz-i386+0xecd0a7)
    #12 0x563f4cc99c13 in access_with_adjusted_size (qemu-fuzz-i386+0xeccc13)
    #13 0x563f4cc987b4 in memory_region_dispatch_write (qemu-fuzz-i386+0xecb7b4)

It simply sent the following 2 I/O command to the e1000e
PCI BAR #2 I/O region:

  writew 0x0100 0x0c00 # RCTL =   E1000_RCTL_DTYP_MASK
  writeb 0x2170 0x00   # PSRCTL = 0

2813 static void
2814 e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
2815 {
2816     if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
2817
2818         if ((val & E1000_PSRCTL_BSIZE0_MASK) == 0) {
2819             hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
2820         }

Instead of calling hw_error() which abort the process (it is
meant for CPU fatal error condition, not for device logging),
log the invalid request with qemu_log_mask(LOG_GUEST_ERROR)
and return, ignoring the request.

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d567687..bcd186c 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -34,9 +34,9 @@
 */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "sysemu/runstate.h"
@@ -2816,11 +2816,15 @@ e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
     if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
 
         if ((val & E1000_PSRCTL_BSIZE0_MASK) == 0) {
-            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "e1000e: PSRCTL.BSIZE0 cannot be zero");
+            return;
         }
 
         if ((val & E1000_PSRCTL_BSIZE1_MASK) == 0) {
-            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "e1000e: PSRCTL.BSIZE1 cannot be zero");
+            return;
         }
     }
 
-- 
2.5.0


