Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E849218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="E9B7PVev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E849218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIoE-0000j4-AQ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:23:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002aF-9o
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY2-0006hS-OE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:56 -0400
Received: from m12-14.163.com ([220.181.12.14]:54537)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY1-0006fH-8q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=BBctNjDbfh7h2nNE/V
	nZPLT9nVBtuY81kv5/qyNenhU=; b=E9B7PVevEE46QOVsoSuKAu2BWPUWTKmFIL
	KCs1c+wGZyuVOcecxS8LW/UjeuUIzzreCsRxcMIpGgVTa30lPO2z/unRoMK0XEHl
	rDzJCFqdZcj2LqLwBOJ7hUfuDYwb/8t0xPeb54vByUS/1rzR59DElpDGSy4ya0x+
	Ioa3xRn0w=
Received: from localhost.localdomain (unknown [115.200.201.0])
	by smtp10 (Coremail) with SMTP id DsCowAC3Ayl0bcBcrks9CA--.5531S5;
	Wed, 24 Apr 2019 22:06:51 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, thuth@redhat.com,
	lvivier@redhat.com, pbonzini@redhat.com
Date: Wed, 24 Apr 2019 07:06:41 -0700
Message-Id: <20190424140643.62457-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
References: <20190424140643.62457-1-liq3ea@163.com>
X-CM-TRANSID: DsCowAC3Ayl0bcBcrks9CA--.5531S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr45Wr1DZF17CFyxJr45Awb_yoWfCFc_uF
	W3Aw1rW3y7AwnFkF9YyF15Aw15Ka4UXF9Ikrn7KFyqy34UX39Fkw4Iqa9F9w1rWFWUCr9x
	Ca95Xr1DCa1v9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8IzuJUUUUU==
X-Originating-IP: [115.200.201.0]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLxWgbVUMI+dgjQAAsH
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH v2 3/5] fw_cfg: reboot: store reboot-timeout as
 little endian
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424140641.QY80v4LCpLQ6Y6P8Ku4ik1d_AczmZz8AplFHfa0RXfM@z>

So that if the guest and host endianess does not match it
can still work as expection.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/nvram/fw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 5c3a46ce6f..df4242fc9c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -178,6 +178,7 @@ static void fw_cfg_reboot(FWCfgState *s)
 {
     const char *reboot_timeout = NULL;
     int64_t rt_val = -1;
+    uint32_t rt_le32;
 
     /* get user configuration */
     QemuOptsList *plist = qemu_find_opts("boot-opts");
@@ -194,7 +195,8 @@ static void fw_cfg_reboot(FWCfgState *s)
         }
     }
 
-    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
+    rt_le32 = cpu_to_le32(rt_val);
+    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_le32, 4), 4);
 }
 
 static void fw_cfg_write(FWCfgState *s, uint8_t value)
-- 
2.17.1



