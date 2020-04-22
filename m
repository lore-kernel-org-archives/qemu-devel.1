Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB84C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2E320882
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcTRMDXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2E320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK1G-0006Gt-IK
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzb-0004zl-RR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJza-0002AY-Ka
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:03 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRJza-00025w-6m
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:02 -0400
Received: by mail-qk1-x743.google.com with SMTP id l25so3486329qkk.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=XWQH+WqkRfp4wJIRuWJ29KttjuuuSpzbvrw8QWn/fPk=;
 b=rcTRMDXv+Yo4EYEAA4g+HOSJ0dnv6q0ciFXJ+MQ644VjZpT6QypWAuOY/+wgT97N7N
 Yp8dKW9oMDjS/5yBbcLLxEbti1AqK3vzZHpe1XjS/ypuh+n5o8HP3uUrUeS0j2HwDS8Y
 EycTrHVXfhs4DSdZmoE0E7u6K1ObKRNadh1VcrYwV3pli6h6sndfoKs3oT7HY1nyBBJ5
 XBd/Fa0DXMVsSCKMp+samnM84RSglmCPW56E5Y0k63zmpjy03uK2kgomWCQldVpeEh7R
 zaVbAoEFIBxyHJIyrWEtPBtJ183OYCChkhq6fYBKkxFOIfPVudRgfsYVEV5ZAuP/dL4j
 Hi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=XWQH+WqkRfp4wJIRuWJ29KttjuuuSpzbvrw8QWn/fPk=;
 b=S2u2NwwA3CuRAegr7CnXLWLgo++WnWw9TkB+s685FQLfluhf/V2mohzN+G31aNssFA
 x1HZkqZwv8lfrLaFFpPknq997FrBvCACTVtDhtYVyYDSkLULNcY91PTdtWkvmaAyr6Oj
 MEh5pA0AWNiTR1FmLhW8xE7ZGo5SOui6QlxDM36Pg+v6wlV5XxsyWzqAYhSBXgelY7Mb
 MzfvHc/cAqbzDJbi+Xyvx5uzuoPM3txJ3ER96REDQkcgm2lTlLASXtWq2V2ZzYWTY62H
 3yX1LPq/EAGaZCO+mOpPeXBgFVHMelMbfy0Jp1fAXbmCuNETnQ+SnJB7F+XA/PRbV5vR
 P0TQ==
X-Gm-Message-State: AGi0PuY/eJ8c+CihHRHjJSAMbv8tMTvvZY2YnBwMXqHKKFalfOvGUXDM
 cf+9DZor6bBVNSw9i2TjUFo=
X-Google-Smtp-Source: APiQypLqZngDSorZDDTmxZtWNAI+yVErrNWqoVWfjNQIlpiRc2olxCnd4Vf0ssdFKfdX9vkd1dX/PQ==
X-Received: by 2002:a37:6393:: with SMTP id
 x141mr26288222qkb.179.1587579661122; 
 Wed, 22 Apr 2020 11:21:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id q32sm641qta.13.2020.04.22.11.20.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2020 11:21:00 -0700 (PDT)
Subject: [PATCH v21 QEMU 1/5] linux-headers: Update to allow renaming of
 free_page_report_cmd_id
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 22 Apr 2020 11:20:58 -0700
Message-ID: <20200422182058.12258.52009.stgit@localhost.localdomain>
In-Reply-To: <20200422181649.12258.37077.stgit@localhost.localdomain>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::743
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


