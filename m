Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA87EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98E8206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY7SJ70F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98E8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBTD-0001sA-RC
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQZ-0004iI-Lc
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQX-0001zM-VG
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrUeOVZRWQD2Q/17xf0hHsrzF1l0TJ5a7ixoIuZeyV4=;
 b=cY7SJ70FLeXzlnQEoOPaXdR/LsiHyRRAgqWtIzgnw2VvEmDBSRFFVigQud7r17eXsFeSGJ
 bSK0fAb1G7ascqSDxxg7LcRFhPZLzL1tfFg/FjEu5Hyg1SaMkC3pegG6Qi1kMblXW/LyDJ
 O7/WgR80PLmrhP5PN/tStSJh0RiCORA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-ZJXGUWNVPCyH_NAc0Tezsw-1; Fri, 22 May 2020 13:25:43 -0400
X-MC-Unique: ZJXGUWNVPCyH_NAc0Tezsw-1
Received: by mail-wr1-f70.google.com with SMTP id c14so3493160wrm.15
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FrUeOVZRWQD2Q/17xf0hHsrzF1l0TJ5a7ixoIuZeyV4=;
 b=W7GchU5envNoMTbFgDqd/RiyuRzRXWFf0ZTGsV+xVb2vqXllwun+7IK1yXnW8cAcPz
 LL+w8LZo4DY7Y06ywTVnTj3DUssZY/uoUsrxVDu9W0DzdjG3fRPYZdBZcyaakOJnID0s
 wBo2hEYdW2U+IZcDKNRyRRs+NVgS5/Wp3rDgiS6axbmRlEM0F6Se8HeMub8I9skbLb3Y
 zntvij+VRSbtalShRMxpDAX3hoKnI9lWv2gnAOfdjt/NbxJ/3UE+Dbi1c+xoISeq2Tv/
 zqmvZ0KLH6K6gn6AO2ikmRuSSQR14wgX/FU6DbTtyoYh/mASyVgaq1wCG1WBEAqHKsNJ
 8tXw==
X-Gm-Message-State: AOAM533Rcc5pRi1XyGfd26aAllc6V5tr7p/X/S2Q5ANfhz8jjYpThRXw
 VNno3G+YhALR5nw6yrhXIJtVmTCzCatp4imJOujYBbDyGBeQZpUTLG6yKORayCilHeg2N4uViU8
 gTMmh7EQqTZZdJ48=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr4192171wrr.222.1590168342431; 
 Fri, 22 May 2020 10:25:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSKoTffoL8ceNaMvgQw3S4HplXtrTt9YsZNuD7EBVvg3A5Ji+eqpiL49H6nlpLWQHSuvRzrA==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr4192142wrr.222.1590168342074; 
 Fri, 22 May 2020 10:25:42 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z7sm10029724wrl.88.2020.05.22.10.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/13] stubs/Makefile: Reduce the user-mode object list
Date: Fri, 22 May 2020 19:25:03 +0200
Message-Id: <20200522172510.25784-7-philmd@redhat.com>
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

These stubs are not required when configured with --disable-system.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 stubs/Makefile.objs | 52 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 6a9e3135e8..f54125de31 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,47 +1,55 @@
-stub-obj-y += arch_type.o
-stub-obj-y += bdrv-next-monitor-owned.o
 stub-obj-y += blk-commit-all.o
-stub-obj-y += blockdev-close-all-bdrv-states.o
-stub-obj-y += clock-warp.o
 stub-obj-y += cpu-get-clock.o
 stub-obj-y += cpu-get-icount.o
 stub-obj-y += dump.o
 stub-obj-y += error-printf.o
 stub-obj-y += fdset.o
 stub-obj-y += gdbstub.o
-stub-obj-y += get-vm-name.o
-stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
-stub-obj-y += machine-init-done.o
-stub-obj-y += migr-blocker.o
-stub-obj-y += change-state-handler.o
-stub-obj-y += monitor.o
 stub-obj-y += monitor-core.o
 stub-obj-y += notify-event.o
+stub-obj-y += qmp_memory_device.o
 stub-obj-y += qtest.o
+stub-obj-y += ramfb.o
 stub-obj-y += replay.o
-stub-obj-y += replay-user.o
 stub-obj-y += runstate-check.o
+stub-obj-$(CONFIG_SOFTMMU) += semihost.o
 stub-obj-y += set-fd-handler.o
+stub-obj-y += vmgenid.o
 stub-obj-y += sysbus.o
 stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
-stub-obj-y += uuid.o
-stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-y += win32-kbd-hook.o
+
+#######################################################################
+# code used by both qemu system emulation and qemu-img
+
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
+
+stub-obj-y += arch_type.o
+stub-obj-y += bdrv-next-monitor-owned.o
+stub-obj-y += blockdev-close-all-bdrv-states.o
+stub-obj-y += change-state-handler.o
+stub-obj-y += clock-warp.o
 stub-obj-y += fd-register.o
-stub-obj-y += qmp_memory_device.o
-stub-obj-y += target-monitor-defs.o
-stub-obj-y += target-get-monitor-def.o
-stub-obj-y += vmgenid.o
-stub-obj-y += xen-common.o
-stub-obj-y += xen-hvm.o
+stub-obj-y += fw_cfg.o
+stub-obj-y += get-vm-name.o
+stub-obj-y += iothread.o
+stub-obj-y += machine-init-done.o
+stub-obj-y += migr-blocker.o
+stub-obj-y += monitor.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
-stub-obj-y += ramfb.o
-stub-obj-y += fw_cfg.o
-stub-obj-$(CONFIG_SOFTMMU) += semihost.o
+stub-obj-y += replay-user.o
+stub-obj-y += target-get-monitor-def.o
+stub-obj-y += target-monitor-defs.o
+stub-obj-y += uuid.o
+stub-obj-y += vm-stop.o
+stub-obj-y += xen-common.o
+stub-obj-y += xen-hvm.o
+
+endif # CONFIG_SOFTMMU || CONFIG_TOOLS
-- 
2.21.3


