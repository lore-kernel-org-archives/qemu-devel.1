Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28764C433E4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3EA2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ni1QFrYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3EA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9X0-0007fK-87
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Ut-0002z0-73
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9Us-0006Kw-BD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkwDt+W9ESNwveTOK/yAiRKQET7DW0sm3/z0Mc8iCTQ=;
 b=Ni1QFrYbS+5m4W5XoyOC1i9kxRLyQBom4FdOIRAOzmz+tGf4RKvYgWD+Eo559nxdYOiBIm
 QahqRq+6NT7+Fw5tKlDRksMiFFhYOTVRWNCAqqVf4FZw9WwIm5y3ph9Kkp5V44/AMxdvEv
 PKiUtyaF9fH+CnERpq89q0CQfoiH/yI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-hjhjUNQrNHCAKDLdy4znxA-1; Fri, 05 Jun 2020 06:22:44 -0400
X-MC-Unique: hjhjUNQrNHCAKDLdy4znxA-1
Received: by mail-wm1-f70.google.com with SMTP id s15so2842908wmc.8
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nkwDt+W9ESNwveTOK/yAiRKQET7DW0sm3/z0Mc8iCTQ=;
 b=Umxg9TuXPXwtyfCFNtHeTuP3uHCu/wQ+BrUFQlO1mw4norA+thkv7gA8JLatzg8ICZ
 mJl5qANe/b4y7HnoCC4iLz8ySqj5TeVshP4m1WFFxBgHvTMStR66y1ge0YrN4apNteDJ
 x2k0T+Y8nrbdbP+EzWDsERSxHfzA82oqOZhvIb1eML2KRv7gxjRAZmWPEy0MUMp/x4dB
 3pZbrhO1NHWB3v0J1w3/8CCkSiPlqi6PI6j3D8ZwnxDqyGkFm3OSinuTZCVDYotQ9i2O
 Qap1d7+VCajN8irmqwWGRUkXabA8hfkXxAvVH4Jp6ly8ReyoDlNxxXEoPZxBBG2jmGFR
 7Nqw==
X-Gm-Message-State: AOAM531vTZu4/5DYHKrFxfytdcqx1VdEE46sNMGc1fho36IMF4GV30+G
 QnUWRTlGwDSB6vr1ET82stQhR2su/vVGfy9p2ShtT2tpPZ6mXWlSSREXv03SCQJ5TfMTe8kTxxF
 sweQhFsk1PDCe/OQ=
X-Received: by 2002:a7b:c393:: with SMTP id s19mr1981672wmj.92.1591352562570; 
 Fri, 05 Jun 2020 03:22:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBf7Go/dbLXjGX+96h3/hmrHkVp9arWSr0CaxX1xQCTQ1b6imj9M/DZ8dDixF87Ac7Dhb0SQ==
X-Received: by 2002:a7b:c393:: with SMTP id s19mr1981658wmj.92.1591352562405; 
 Fri, 05 Jun 2020 03:22:42 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y19sm10506015wmi.6.2020.06.05.03.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:22:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/11] hw/sd/sdcard: Update coding style to make
 checkpatch.pl happy
Date: Fri,  5 Jun 2020 12:22:21 +0200
Message-Id: <20200605102230.21493-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make the next commit easier to review, clean this code first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/sd/sd.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3c06a0ac6d..f1b12b49db 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1154,8 +1154,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1170,8 +1171,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1216,12 +1218,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
@@ -1240,12 +1245,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
-- 
2.21.3


