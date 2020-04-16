Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D1C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCF621744
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goWnYVxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCF621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAhn-000611-LO
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgb-0004dV-A3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAga-0000Lo-Bh
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:33 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jPAga-0000LV-5A
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:32 -0400
Received: by mail-pl1-x641.google.com with SMTP id z6so14972plk.10
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 13:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=XWQH+WqkRfp4wJIRuWJ29KttjuuuSpzbvrw8QWn/fPk=;
 b=goWnYVxhjX5vHde8S++Gnuxwje6qW154GE0dmSzDliq6YxGxVQ9RpyFHJkPXpG4abj
 NJ2kWUkxLCdoNOLdCqZfneVhJkzww7lOKlL/o5o1Sqak4/X+CkbY1TUKi5X+9b6IxZYb
 jq2CHT3sRjya2WIBXyD1+P9YSgoyMqVurMGWuzDNg9SgViieAV7b+D9K2drevedDLLGl
 hXO+FHN+v0dF+q9TtETUMAWj09M2ZOspWYCN7YpA4/aoG5KmaAOYjNBeAJTqE8gEUrV3
 9N+/xw/6mWDiT6JlxBeXyFmClh8RCmAF55zidTM8uo7RJVq2+ivC4j0vaaFpPTZPocJ7
 JAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=XWQH+WqkRfp4wJIRuWJ29KttjuuuSpzbvrw8QWn/fPk=;
 b=JcE0iJgpZblt/Mvu+uyqGsl4wbpRPGO0HwkgZQp2Oc7KdSM6l2RbQzhPuaRBKWYodH
 wZ2rrqsD8bYWeqsCYahNts6ON4jiftkYL3CbZ0+2pEUdjVoUUE54G2LVpnCyTsoMdeRO
 evW6wDvilM4Rl6brvJ873vFeSRjkLd/79s+QFD+bt+4LwLv6o8I4O1bb+nRYfmoHQTAL
 mGrA+IbBwKb+wKNwUawEtbvSiKXMAgU9YyP+2Ts1wT90MnItl+3e3swYOmCmf10ihE3q
 jiUWmBinZcMMQGGN5zIsME1M4YkrV2d2a6KJxk3AgYaLUnmVuX2E5YAs7gl0SVGwVS0V
 oz5A==
X-Gm-Message-State: AGi0PuYkB+9bInejWi7pvPlHovr+0qKYVcBS6v1ImWXfUwsbRfB13rqn
 OZl45tr4qRHNEyi4tLsi7U8=
X-Google-Smtp-Source: APiQypIMQmN6sXFtDrPrUQmCQBmH/xUeksrL0cfeLaWTFOv9duU4Oc6XQnkGvpuX/LhPozMEAm9nqQ==
X-Received: by 2002:a17:902:8d86:: with SMTP id
 v6mr11689175plo.57.1587067230717; 
 Thu, 16 Apr 2020 13:00:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id v202sm1210185pgb.46.2020.04.16.13.00.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 13:00:29 -0700 (PDT)
Subject: [PATCH v20 QEMU 1/5] linux-headers: Update to allow renaming of
 free_page_report_cmd_id
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Thu, 16 Apr 2020 13:00:29 -0700
Message-ID: <20200416200029.13144.8957.stgit@localhost.localdomain>
In-Reply-To: <20200416195641.13144.16955.stgit@localhost.localdomain>
References: <20200416195641.13144.16955.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Sync to the latest upstream changes for free page hinting. To be
replaced by a full linux header sync.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/standard-headers/linux/virtio_balloon.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2a70de..af0a6b59dab2 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -47,8 +47,15 @@ struct virtio_balloon_config {
 	uint32_t num_pages;
 	/* Number of pages we've actually got in balloon. */
 	uint32_t actual;
-	/* Free page report command id, readonly by guest */
-	uint32_t free_page_report_cmd_id;
+	/*
+	 * Free page hint command id, readonly by guest.
+	 * Was previously name free_page_report_cmd_id so we
+	 * need to carry that name for legacy support.
+	 */
+	union {
+		uint32_t free_page_hint_cmd_id;
+		uint32_t free_page_report_cmd_id;	/* deprecated */
+	};
 	/* Stores PAGE_POISON if page poisoning is in use */
 	uint32_t poison_val;
 };


