Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41997C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155DE20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deRGTC/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155DE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vsF-0005Lx-8h
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpq-0000Aa-Br
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpn-0004eE-EM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=71WK5m2UGgsTb5U5cRnwPBsZj+xQc69N5Hieb7QL39o=;
 b=deRGTC/eDKRzAreMjw5qbmgLXUAhRYRRGZMTTG1vh0Azu7WeI2tAwX6+wg83UCaPTMMv0e
 UIv5AkemoJCYE0vdRjk9jmiEUOmXcN2HtLmxQGHNuskXnfvG6upzoZa1R/X83+2fJWsHHb
 TjkQ1GiWOHLibV4npAszHWh+9D+B/40=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Z-Eh6c-CN96WzLzFiDM-PA-1; Wed, 12 Aug 2020 14:50:45 -0400
X-MC-Unique: Z-Eh6c-CN96WzLzFiDM-PA-1
Received: by mail-wm1-f69.google.com with SMTP id t26so1215676wmn.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=71WK5m2UGgsTb5U5cRnwPBsZj+xQc69N5Hieb7QL39o=;
 b=NdM7Tr+uxHM2zzkXxiQCZFcFBApWSQCv4ATNkUpZBE+fiQvVv04pro7M8mC7XNN08s
 aYolrd71LnGHOYtn651zp+sIzZCrKdI8FKQiNzI/g9x4Aba0GvQCUIpXJZiKdD7JEkeJ
 OGfu91duVkoJOy7+lrfErPXGSLKnEruqwl3EXrRcPqOdB3xp1PoDf0IMCuD5x7BWglHZ
 VeLtRqp7m5aHASPBk5ri3vZ+AAyfGc8j6Srxb88KHI6XXIrz9EwWqZLo7Jz9qBDe8Wrt
 9XZKmh6GgnJW1e6HwULrw/jlWuDs8G/2Gn7p3WV6QRbJgpVdjT03mYZoSUr1k3G5NPYj
 bjFw==
X-Gm-Message-State: AOAM532qX+WFVEBsot0WvCWYlp1hDE588lP+Akq+nICsx89UBa158ruQ
 6jTMFTwHpOg6avHesPa+nAraq4vX7eC4OhIE9E39ELBjsGblcc/kYEWB2ttHriUclBAkMFYl2gh
 Nr9dbZ9Nfg4e7sGc=
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr945807wmf.160.1597258243732; 
 Wed, 12 Aug 2020 11:50:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy31jM0MK7FpH/uTHJr4pw3hAg4AYBhayL4jruWNynCXTj4uSO4fnVQ9MMh7ATPMgyObRWMnw==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr945788wmf.160.1597258243529; 
 Wed, 12 Aug 2020 11:50:43 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 3sm4830336wms.36.2020.08.12.11.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/14] block/nvme: Improve error message when IO queue
 creation failed
Date: Wed, 12 Aug 2020 20:50:05 +0200
Message-Id: <20200812185014.18267-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 14:50:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use the same error message for different failures.
Display a different error whether it is the CQ or the SQ.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 003809fbd8..53448b7d23 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -648,7 +648,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
@@ -659,7 +659,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
-- 
2.21.3


