Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B31C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC0020728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EemRzCDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC0020728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS1Xv-000117-Di
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 12:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS1Wv-0008EN-QX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS1Wu-00010v-1J
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:21 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jS1Wt-0000uF-IC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:19 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t40so4099636pjb.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=r3DmuhsjF9XmFz6gfXOOjELEtTu/H+9BPOkgH77BTws=;
 b=EemRzCDbaKqy/dqcEAMINbh5h5JcMSn3eS9kMoP69WvnKQlJpjesk9oBwX34vwLKBx
 kcPopUunra27JbogMZ1tS3ivZr6EmxTAqMLIHzjJZM7PDznNlgQc616R/kx/A+u9EUhm
 slEd89EX2NjIsnj7nfcN18HNhVdsXg51YPqofjKmBvXiV483MwJ8ohhq0L9S/w1eBC30
 cdUIOgYAsq5Al0stzT0uQgPDmZtbPlKLWCm6svKOajMZ6UgWb1ADW6BvSXrAmwrmUG/Z
 77SkSv1YAmysTAIgsK1lP9G31TEcTBM5t57WP6mBpapq6oY/413h2wFCqtJKtJCMjjGO
 YsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=r3DmuhsjF9XmFz6gfXOOjELEtTu/H+9BPOkgH77BTws=;
 b=TjXG0L+VGD9fCb63G+ocJ/iF3CRUau+4/Q4ivthdP7OGMqCBtzA3FeKZ0wEuiO4Vd0
 sQ43d2cDPlOS1rEenAWx0RDstnpux8kgEOgIxt4qGpCMCY70mCE6KKl5g+ht9g+5VzyX
 yIAc4XJrRkcvWCtimee68AwcLtJxrzvKTClHNDXhF825cKYNc0/N00VMsd+JOAoq8UIa
 0u2UEP4F3eWXPesPQHWOrPAJ0u7WkzZOQGqpeLFsCsF69c/zWrhy4bDSUDKjKPCzVsVu
 XokRmWCP7UM5QOlQsB7FAeCP3znR8QfsmnehiNwO8Cu4IU/2ohgBS7NIm9HQ4lekgIJc
 51qA==
X-Gm-Message-State: AGi0PuYTxXSzA+R+NGnk68Vrt+YpYwYZA3IbW4mLiBVHJQUQOT981KTK
 XS9wwNyayWrOuTNGwwY143A=
X-Google-Smtp-Source: APiQypIszAxIZwIRFgdPQnOSjTPbv9Hloe/QAXMfuVF9EOxxavegxTGMkpzjcnluy4FMDbIfX1Be/Q==
X-Received: by 2002:a17:90a:7482:: with SMTP id
 p2mr7037094pjk.151.1587747016776; 
 Fri, 24 Apr 2020 09:50:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id v64sm6321768pfb.20.2020.04.24.09.50.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2020 09:50:16 -0700 (PDT)
Subject: [PATCH v22 QEMU 2/5] linux-headers: update to contain
 virito-balloon free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Fri, 24 Apr 2020 09:50:15 -0700
Message-ID: <20200424165015.10723.78092.stgit@localhost.localdomain>
In-Reply-To: <20200424164239.10723.58352.stgit@localhost.localdomain>
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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

Sync the latest upstream changes for free page reporting. To be
replaced by a full linux header sync.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/standard-headers/linux/virtio_balloon.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index af0a6b59dab2..af3b7a1fa263 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12


