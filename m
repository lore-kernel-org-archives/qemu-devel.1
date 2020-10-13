Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20A3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E898208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT46lMBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E898208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSPch-00043l-UH
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 15:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSPbq-0003Wi-I7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:05:18 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:39722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kSPbn-0005V1-Tb
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 15:05:18 -0400
Received: by mail-io1-xd41.google.com with SMTP id q9so883322iow.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NlAURjkMShpO6CROxGAWX/5rLBekEJFkEIs/xx5Bfko=;
 b=TT46lMBgHTOXGcVlM3V/MO0l6ssKdR4I26NDwURKfAxnQzoGUwXnGhN5I1Ely1aW8t
 W+jsoej02F9xCAXi4L8lsRrv6ucl9PXNI7o4GJqFR/FBEh9agkzS7wo7PIeOJE6bUpfh
 wKuIJW5659FDPaVI++tDqjVY0T612XRtJBEbY+YWOUhZXmwf+htFB36qhxlqqJhxcq2/
 piyPTKJnmnIlrII20x4rRbBPQM2IHBomwVPlBSoxvfIBgtpxLksPLN8vPRaDGyl23cTG
 3BFDTnINYIDTxvGIcSsh02UGydv5T/X7zmADnYh3Zjux4NBXwdr2lfytcZXjb6RcLKJ1
 vl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NlAURjkMShpO6CROxGAWX/5rLBekEJFkEIs/xx5Bfko=;
 b=N5Ybaac4R1WktKKC5k2jBStHM7BjHoM0XHTxCWgCrks7OvRY+kC17s+C6gz/QYsf8C
 BxEptq/M6UHYFFlslHjE332ncOX917fJegjtNEl3wX8gzjTsE3UsQUmNj6QIHXJm7udL
 nMEUhhpGO3lNlXAq/j5vvGgjYKSdUinVMCIGuRUykrMur1fY9Vw5a1ulDw1H4DUm2j5y
 y0Dv8PcVoTWVztXOvOQOp3Hug89JhHk5EPSHKQaBR8yrl0cIsUuSsVpKAe0hPRvZGgLl
 CG2B2Eovn4k0f3vViHoBNm/UXIQLHThQ9N5z0uY3UKBy1h7hRpaJbdhE8NPxsSseRoXG
 nH7A==
X-Gm-Message-State: AOAM532Lc5vHPIIs3K7LaAmo8mrFxgMzJTQo8AQYbuO31xM/GXV95ulu
 X1j7El0T+bJ+42QtV3DNm4BbXeEa3hc=
X-Google-Smtp-Source: ABdhPJxb4KRaKlOzqd6+8N5whHfIAxDnwNVcj+ARqU7kD7qL4UzCUhJs8it/CfhVVefdCuTSH6zT5Q==
X-Received: by 2002:a6b:d214:: with SMTP id q20mr237841iob.23.1602615913834;
 Tue, 13 Oct 2020 12:05:13 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:2d14:a347:ac28:26f2])
 by smtp.gmail.com with ESMTPSA id s23sm653518iol.23.2020.10.13.12.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 12:05:12 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/xen: Set suppress-vmdesc for Xen machines
Date: Tue, 13 Oct 2020 15:05:06 -0400
Message-Id: <20201013190506.3325-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=jandryuk@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sstabellini@kernel.org, Eduardo Habkost <ehabkost@redhat.com>,
 Jason Andryuk <jandryuk@gmail.com>, paul@xen.org, dgilbert@redhat.com,
 =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, anthony.perard@citrix.com,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

xen-save-devices-state doesn't currently generate a vmdesc, so restore
always triggers "Expected vmdescription section, but got 0".  This is
not a problem when restore comes from a file.  However, when QEMU runs
in a linux stubdom and comes over a console, EOF is not received.  This
causes a delay restoring - though it does restore.

Setting suppress-vmdesc skips looking for the vmdesc during restore and
avoids the wait.

The other approach would be generate a vmdesc in qemu_save_device_state.
Since COLO shared that function, and the vmdesc is just discarded on
restore, we choose to skip it.

Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3c2ae0612b..0cf22a57ad 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -987,7 +987,7 @@ static void xenfv_4_2_machine_options(MachineClass *m)
     pc_i440fx_4_2_machine_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
-    m->default_machine_opts = "accel=xen";
+    m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
@@ -999,7 +999,7 @@ static void xenfv_3_1_machine_options(MachineClass *m)
     m->desc = "Xen Fully-virtualized PC";
     m->alias = "xenfv";
     m->max_cpus = HVM_MAX_VCPUS;
-    m->default_machine_opts = "accel=xen";
+    m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-- 
2.25.1


