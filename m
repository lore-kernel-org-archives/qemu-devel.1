Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3BC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0252070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiD1UQQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0252070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs0cF-0005ni-DS
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41942)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hs0b8-00048H-IR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hs0b7-0006DK-Kw
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:01:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hs0b7-0006Cg-F2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:01:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id y15so27603735pfn.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=FoQXJ5qQTi3p24A9fozZ2RVCDQjx8oTJ1oBTH1twvYw=;
 b=IiD1UQQtVt0z2XjhzKu9rvUaLJtu0/G5tr97sts5CJ2rj+Ch0Wcx2N1ET8jOT/OKd6
 FBO1OR6yP5aSda+SmgeOOSUvsPWLBkpvLjnWPX5KF9fqzIrf3+2vPwcrxLBz+p9pM4jd
 Lv07Lb24uZJLRSiwjC5yicJXzqB6pxxD+sMEXDeQLYtCgA1yGjVPuR0JGktFEjTW560L
 QbOZ0mVb0ROP8/yQOxrMpD1kwNDr6qw29zF/Razpb16zVWBq/OLZeH5DtqkL9KYOyOw0
 z6ZwZlGZgQgqM6/vmNewe/swHyFPtl+bWV5HALaoKQ9PepPY/xG0IPQK4oWJV/xeyVw0
 g00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=FoQXJ5qQTi3p24A9fozZ2RVCDQjx8oTJ1oBTH1twvYw=;
 b=BF7v6Sf3qdR99Ca+Z49LpheEkiw+ZF9PhVyzkIHIBhtsAHTC8asA7nQbx4YzIvwW0i
 oLilN9aFCCMVi1k0lTKhQCOXITupOb0CWphdJ5KlPGH4MBoVSg/uLs17baxppDXPcqeO
 m3TRSgJguZ0MqjWl/oTIHZ/QjySrS0RME8pwJNOY6FPnLgIzk95A3SvH1ZRK69IyuEWj
 sX5ThlR4xuShD0HElWRfuIxPYA9vXN0ZWTOAgp47+j1InWrhXLtjP9zK8EPXsNoe3Iej
 KIbD1E9H+D1qQK8+hN8tWyrSwrCvX0wgjmsTQQpUYswIedieFd4puVrEi10OAZjdv46L
 qZ6g==
X-Gm-Message-State: APjAAAV221jzLiyZJ/GsSNxRIVjPDimeuYGE6QwVVogGuaSnMcds1t1M
 O/i8B41Rm7SDayE9ILOzwDJeUMI6UE4XZA==
X-Google-Smtp-Source: APXvYqx9Q37agfd6Z7hoUXtZCivulxpitndCAFDgdXHis2uICmt/aKJ2hBFXtzMzuAoWIVPkQ3wftQ==
X-Received: by 2002:a17:90a:21ac:: with SMTP id
 q41mr112772605pjc.31.1564387292669; 
 Mon, 29 Jul 2019 01:01:32 -0700 (PDT)
Received: from VM_85_204_centos.localdomain ([129.226.55.250])
 by smtp.gmail.com with ESMTPSA id l6sm61237035pga.72.2019.07.29.01.01.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 01:01:32 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Mon, 29 Jul 2019 16:01:21 +0800
Message-Id: <1564387281-12321-4-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564387281-12321-1-git-send-email-ivanren@tencent.com>
References: <1564387281-12321-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] [PATCH v2 3/3] migration: update ram_counters for
 multifd sync packet
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Multifd sync will send MULTIFD_FLAG_SYNC flag info to destination, add
these bytes to ram_counters record.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 88ddd2bbe2..20b6eebb7c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1085,6 +1085,8 @@ static void multifd_send_sync_main(RAMState *rs)
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
         qemu_file_update_transfer(rs->f, p->packet_len);
+        ram_counters.multifd_bytes += p->packet_len;
+        ram_counters.transferred += p->packet_len;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
-- 
2.17.2 (Apple Git-113)


