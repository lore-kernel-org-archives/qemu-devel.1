Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947EA206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWgnCDlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947EA206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcL8-0007E3-KK
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc76-000782-NV
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc75-0006tb-KF
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2IEAQ+0EQH/fG7yIDUY2FKAPmMX0mmGOTISpiAaTt4=;
 b=dWgnCDlhVly8YuRhod17Qy9k6swlr4Pb6F2AJo2LfgC0ld/lD0nFUvhG2Jq2Z0pHSVAaed
 9qHjOJahisuN0OSHI5jC8C5gb9GvkVUDMbMNtvya/0G+i9NfTcRtyC9YrnBNHnzOC/e/h+
 HZVFVpXp8gq2J01T+jl/YJEEOOC4GUY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-mRp4laPVOMuBC-OXVdpCXA-1; Mon, 04 May 2020 10:30:27 -0400
X-MC-Unique: mRp4laPVOMuBC-OXVdpCXA-1
Received: by mail-wr1-f71.google.com with SMTP id y4so5804854wrt.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=iRZZD2N2OQSu+hWDfRiZjbT+riutHWRlj7teaB4WBBY=;
 b=hgcyPfIdDVfSdJpqVuBOpLbssRCGYyCESv6EwtSYngkIFDzTBhZFoJNcFuyK/d67SS
 EeZWjKAK0qPzDLPAyP8NDLgyyz4N3rYvSb1zBBDeSgHadoecrhsgvYiYQEhoN4bHKw6Y
 6jSu4tPqKqK8+MsSINcqGeDoUeszO+HcAyqyg/CP0bNLjhCiXzSN5z0HswYyDuqTQpgk
 59any2lfnanTIQ6RRhcU4y4sLkXbAYk3tD2ElRRcvASc2fZsPpGn3nXxjgV8PaVICF/w
 vTFGbl1tjmjU5mxMQRXPOvBMkdyUX3YXxkIA8mn7v+vLhr3bFXUVeLRXR/bII0joENS1
 cq8Q==
X-Gm-Message-State: AGi0PuZOvkdvVjC8QRF0OoFerHAsjYtCNsfg7/VezOIycOd5HuX828oQ
 jDYWs3qHhVHudMNdhRq7ek4imWfRWb6zK2rC3vi1FOuAfGwDDE6Bb3XpCsUWdVCFUbdZDdQGNGZ
 V9+tYlsjjF7IHtGk=
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr5633238wrn.137.1588602625708; 
 Mon, 04 May 2020 07:30:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKjJ/b1Q+SZbPlR95AFFlbRwkHssNVaYtt23eKWoX73RyqQVc/dJEkkQxmn2V+hTwQJZ4wbaQ==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr5633195wrn.137.1588602625294; 
 Mon, 04 May 2020 07:30:25 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 q17sm13422759wmj.45.2020.05.04.07.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:24 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] hw/i386: Make vmmouse helpers static
Message-ID: <20200504142814.157589-30-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The vmmouse helpers are only used in hw/i386/vmmouse.c,
make them static.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200504083342.24273-5-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  4 ----
 hw/i386/vmmouse.c    | 22 +++++++++++++++++++++-
 hw/i386/vmport.c     | 23 +----------------------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index de49a57506..05e19455bb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -129,10 +129,6 @@ typedef struct PCMachineClass {
=20
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
=20
-/* vmport.c */
-void vmmouse_get_data(uint32_t *data);
-void vmmouse_set_data(const uint32_t *data);
-
 /* pc.c */
 extern int fd_bootchk;
=20
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 78b36f6f5d..b3aef41327 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -25,11 +25,11 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "ui/console.h"
-#include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "vmport.h"
+#include "cpu.h"
=20
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
@@ -71,6 +71,26 @@ typedef struct VMMouseState
     ISAKBDState *i8042;
 } VMMouseState;
=20
+static void vmmouse_get_data(uint32_t *data)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    CPUX86State *env =3D &cpu->env;
+
+    data[0] =3D env->regs[R_EAX]; data[1] =3D env->regs[R_EBX];
+    data[2] =3D env->regs[R_ECX]; data[3] =3D env->regs[R_EDX];
+    data[4] =3D env->regs[R_ESI]; data[5] =3D env->regs[R_EDI];
+}
+
+static void vmmouse_set_data(const uint32_t *data)
+{
+    X86CPU *cpu =3D X86_CPU(current_cpu);
+    CPUX86State *env =3D &cpu->env;
+
+    env->regs[R_EAX] =3D data[0]; env->regs[R_EBX] =3D data[1];
+    env->regs[R_ECX] =3D data[2]; env->regs[R_EDX] =3D data[3];
+    env->regs[R_ESI] =3D data[4]; env->regs[R_EDI] =3D data[5];
+}
+
 static uint32_t vmmouse_get_status(VMMouseState *s)
 {
     DPRINTF("vmmouse_get_status()\n");
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 00d47e0c4c..1aaaab691a 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -23,10 +23,10 @@
  */
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/i386/pc.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "vmport.h"
+#include "cpu.h"
 #include "trace.h"
=20
 #define VMPORT_CMD_GETVERSION 0x0a
@@ -109,27 +109,6 @@ static uint32_t vmport_cmd_ram_size(void *opaque, uint=
32_t addr)
     return ram_size;
 }
=20
-/* vmmouse helpers */
-void vmmouse_get_data(uint32_t *data)
-{
-    X86CPU *cpu =3D X86_CPU(current_cpu);
-    CPUX86State *env =3D &cpu->env;
-
-    data[0] =3D env->regs[R_EAX]; data[1] =3D env->regs[R_EBX];
-    data[2] =3D env->regs[R_ECX]; data[3] =3D env->regs[R_EDX];
-    data[4] =3D env->regs[R_ESI]; data[5] =3D env->regs[R_EDI];
-}
-
-void vmmouse_set_data(const uint32_t *data)
-{
-    X86CPU *cpu =3D X86_CPU(current_cpu);
-    CPUX86State *env =3D &cpu->env;
-
-    env->regs[R_EAX] =3D data[0]; env->regs[R_EBX] =3D data[1];
-    env->regs[R_ECX] =3D data[2]; env->regs[R_EDX] =3D data[3];
-    env->regs[R_ESI] =3D data[4]; env->regs[R_EDI] =3D data[5];
-}
-
 static const MemoryRegionOps vmport_ops =3D {
     .read =3D vmport_ioport_read,
     .write =3D vmport_ioport_write,
--=20
MST


