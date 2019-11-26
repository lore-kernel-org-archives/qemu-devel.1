Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF30C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962DA206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYf+Z1XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962DA206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUv6-0006OI-FW
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSvG-0007Wf-QD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSvE-0006cC-Se
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:42530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZSvC-0006bC-Ut
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id j12so7544767plt.9
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 20:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zbpFoQ9pmAzeK1m7zYyUnpnyJGtnrHOzILjdn9dJmI4=;
 b=gYf+Z1XWMWTeScvbWgXh7H/UBsXKQV3PnVc/HcUYxq2z9o3c8XFERPdm/q7ciBfYot
 omx5AF717xfhF4HgrZfMie2pl1hW6kEUTioUeGKLM05GNqzBW2QNtOmKWb620Ipy6TBN
 6t+7ivAVDu0kayAkvl9LFOFvrjstLeIljo/PtK3J3+eS44KmQroy88FVkpkTVqC0vcKi
 JWDd6NM7WVA3z4Dsl89PUQhxXSq2qVEHmKJ1FIGZEPDqjASIL+cPb6DSWIAM2e9VcUIh
 ei01S/FoCiOLsO8lE88hVrdmbc78u7lAo3ijcfMTxtPSaaIMABTKEhLSm2FyA7MfIo/q
 ELHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zbpFoQ9pmAzeK1m7zYyUnpnyJGtnrHOzILjdn9dJmI4=;
 b=IG1HNrDpsztMAg4Qcp+DUGFwXPCUCUx6+qRk49mAQaJEFDfhVu2VHtFAOBRRCZXL6Q
 oEYUfdseqIaBlIjSDJenu54qIUN3zKnIotPO7hm04eP0U6xdCEoch0cuNU/i6aotUMo9
 9ui2F3WhnxWuUO4uLN/JvWnQa/B3280V6JLqgcUTT5F5b4SvO9E4AvHn2XDwmvY0aDaT
 dSrAjOVKJdb5zYxprZ8ejXY7tvCU9LRo8/6Q6dp6X3eI47YEdy9nm+SzGdXAr0Nf+YCM
 tDg1bIdnI+mCuK2g8fsnPScufSCiavCUyPIwG5tjTxyPLhBo+NmXMQbmy7S+CCUsOPyS
 54pA==
X-Gm-Message-State: APjAAAX7HsInlvWwA/DYOxx9smYZzHDNH6B9/Kyhhpd2KkT+70639MKm
 6Zl3dKmuvUVjwVje5l01/2akNhgasw7LMyMd
X-Google-Smtp-Source: APXvYqxEs+gRgjFghxz58Ae0u3oqNcjdJzdTj+ghYe3DojqXINDj6rlWS2KfRxJw/4geoUlr1Lv7gw==
X-Received: by 2002:a17:902:7287:: with SMTP id
 d7mr32943035pll.333.1574744273246; 
 Mon, 25 Nov 2019 20:57:53 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:1f7e:c8d0:6181:5329:cc21])
 by smtp.gmail.com with ESMTPSA id
 z1sm1081328pju.27.2019.11.25.20.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 20:57:52 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 7/8] R300 fixes
Date: Tue, 26 Nov 2019 10:26:20 +0530
Message-Id: <20191126045621.11344-8-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
References: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
X-Mailman-Approved-At: Tue, 26 Nov 2019 02:04:16 -0500
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/r300.c | 9 +++++++++
 hw/display/r300.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/display/r300.c b/hw/display/r300.c
index 653474c3aa..074dbf5b2d 100644
--- a/hw/display/r300.c
+++ b/hw/display/r300.c
@@ -878,6 +878,15 @@ static void r300_mm_write(void *opaque, hwaddr addr,
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
         break;
+    case R300_GB_ENABLE:
+        s->regs.r300_gb_enable = data;
+        break;
+    case R300_GB_TILE_CONFIG:
+            s->regs.r300_gb_tile_config = data;
+            break;
+    case R300_GB_FIFO_SIZE:
+            s->regs.r300_gb_fifo_size = data;
+            break;
     default:
         break;
     }
diff --git a/hw/display/r300.h b/hw/display/r300.h
index a9e1db32be..19e3d97f8a 100644
--- a/hw/display/r300.h
+++ b/hw/display/r300.h
@@ -83,6 +83,12 @@ typedef struct RADVGARegs{
   uint32_t default_sc_bottom_right;
   uint32_t mc_status;
 
+  //R300 GB Registers
+  uint32_t r300_gb_enable;
+  uint32_t r300_gb_tile_config;
+  uint32_t r300_gb_fifo_size;
+
+
 //Color Buffer RB3D
   uint32_t r300_rb3d_aaresolve_ctl;
   uint32_t r300_rb3d_aaresolve_offset;
-- 
2.24.0


