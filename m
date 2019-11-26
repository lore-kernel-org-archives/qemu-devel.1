Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D996C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FF5206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2+SQlCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FF5206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUvM-0006b3-BZ
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSur-0007V4-AV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSuq-0006Ms-Aw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:33 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:34491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZSuq-0006Mf-5g
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:57:32 -0500
Received: by mail-pj1-x1030.google.com with SMTP id bo14so7678172pjb.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 20:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zbpFoQ9pmAzeK1m7zYyUnpnyJGtnrHOzILjdn9dJmI4=;
 b=S2+SQlCL/J4Z8Zz5im9LzOumdEwk1/iEoyPLGs7GLwmwNL33VHt9PDZ5drrn6CodkT
 4LMaKJAEyhDrcqriwlHhP8APi+EIPyvqRIq40ByZeq4bg+JQ/tNHcDlrXCRxR/BTUD6A
 Mk+hwcXi3gC6dbOcwjhQSNhYesUV9zWyYeApxLmPpmO6IgNE2zFFYlwUd3uwEvdR7MS0
 dZ3e6MySOG/8/eRcOBZeR7vF4tWkrkMRiQXvNu4RDoQD5KdPHz4i5tM4YmopfwOP16bm
 zPtlbnteW8fErB/+6jxy6SGr5k9P1D8LRcoNlCSiXDoDAnxDBsSDonk8OK9iq4YXy2ku
 IiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zbpFoQ9pmAzeK1m7zYyUnpnyJGtnrHOzILjdn9dJmI4=;
 b=VTB+3AwP4EW7oKaiKPMldV/su73rQBh+58vUm96UME4bhOcqUmp7DyAdl57Ahingt3
 hhLRRHk/4yGOzBBr4jhK0C9kzjD0csXSb/PKCdqRNEgjhL+yNgylT5NhTPjqPIJpn5uE
 N3RRRaKUpetY/QkCo8/oGc0LzbtOqnP7SeQ/9eJpekpL3rpQWl9v7EUa09RLmwtAA/Bj
 9Lj9q1+I8zutNUBZuii6A/4AmN6mHe8+AQRaypwulrX79h0MhcnaWBFeb6yw8F7SLvJd
 Kgprnv2vDMZvPiYAqFIEPhsxGXUuL/WLrAvYeNK4n8ozLR5TkAxrDGbwhOvsAbbrxART
 6gNw==
X-Gm-Message-State: APjAAAUZ469x6zCyuOKpGX+vx0T9CtA85OEtrifyFo6iUH0Pf59RiovM
 0ZvwprTweM97oHCgrvpK4neIa09v1CMIOUTk
X-Google-Smtp-Source: APXvYqxmBU9d2W+tW9MGHTL2QYswxcjHxk7Z45tDd3bw/3dWkT2JS/3dqVU3l2iFfeeBT1/HRGi4BA==
X-Received: by 2002:a17:902:9687:: with SMTP id
 n7mr32826230plp.335.1574744250593; 
 Mon, 25 Nov 2019 20:57:30 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:1f7e:c8d0:6181:5329:cc21])
 by smtp.gmail.com with ESMTPSA id
 z1sm1081328pju.27.2019.11.25.20.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 20:57:29 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 3/8] R300 fixes
Date: Tue, 26 Nov 2019 10:26:16 +0530
Message-Id: <20191126045621.11344-4-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
References: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1030
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


