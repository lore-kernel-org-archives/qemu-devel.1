Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE04C2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C98206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMPmkYeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C98206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMkYx-0002lN-Qd
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 23:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMkY1-0001Jh-6W
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMkY0-0007pi-8t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:41:41 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMkY0-0007pJ-4a
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:41:40 -0400
Received: by mail-qk1-x743.google.com with SMTP id j4so999777qkc.11
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 20:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=lZ1k9L4/vo7grjJ1SStQcHrbDBEPT6Fdb+m3NWYJLWQ=;
 b=bMPmkYeDfxI/O53Y15m08QwjUaGEnfQxFnmDS6/11jflvv6ko9TRsbG58rEMoB6+BA
 UEZslL0ssQ/WaEuS3p+b4y1o2Hv8LmYiW/fqKe4FyYk0qUXsI22dpGfR/5uwgqgLrWNo
 oKdA7vbzLejvrYMvGfwfP8bZHMTBhxGov1fuDuPXX9FHubZlo4Cbzz0jQNmjTXTuTcQZ
 wCnq/MKfZpZS/ORZ3OQuOBQpH2+0b7VIPpNepbu8acF1D7XBK+4X8tDlZzNlfabeQw7h
 eFVH7r2k3WBUIoSP0gV+FHx4tTqyy5SG1scPs4YPSs/Rj/fTJ5whLRdHakcByNusrfAb
 jhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=lZ1k9L4/vo7grjJ1SStQcHrbDBEPT6Fdb+m3NWYJLWQ=;
 b=h9nQHHj5QnjeK8Z86zJMxWAnGgtNgx6hJ9gHIxrsrzr04Ea5Ad+BkIzWg0jEbaJCGk
 N+cSIVE0FlSmBm2Yn1F2Q9negyN0efv/wfUP80kEPUINIvLs3zWfzOPss5yIWfBj57mv
 QHd12hSdym+8dYAmTrIXVx5R0UpLZ0dtDhJwZFUXwyUgF6oDIJmnTOZ/7kmx+Y8t/fxj
 V7e6iahIl6rXflJ+rkUELQGSIiUUcV3NDjsrZyct7V2IW6hX9a4GRv/59Db/9NOcULIV
 4F1a9CQ1wAA/2pdHryGwzRWfaO2TzULoGDuxekoqzbxqDSCI3KEGHrTN3IyoVXe4L1bs
 F5VQ==
X-Gm-Message-State: AGi0PuaoDsMD7TQoNz0MhxSkdN5dmoamJcjoBpClpmURtDkd1gXuxmXv
 oucogyrz5IA0G/eP/C3p7s4b3sq60os=
X-Google-Smtp-Source: APiQypIXPuhGMK4aU6UJW6jMUHSDHyM1J592zRULTpFxhR6Pwof3dIgfINnJ4+WwOhNeZijhhnR/HQ==
X-Received: by 2002:a37:62d7:: with SMTP id w206mr2077384qkb.406.1586490098342; 
 Thu, 09 Apr 2020 20:41:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id h11sm709573qtr.38.2020.04.09.20.41.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Apr 2020 20:41:37 -0700 (PDT)
Subject: [PATCH v19 QEMU 2/4] linux-headers: update to contain
 virito-balloon free page reporting
From: Alexander Duyck <alexander.duyck@gmail.com>
To: pbonzini@redhat.com, david@redhat.com, mst@redhat.com
Date: Thu, 09 Apr 2020 20:41:36 -0700
Message-ID: <20200410034136.24738.52188.stgit@localhost.localdomain>
In-Reply-To: <20200410033729.24738.22879.stgit@localhost.localdomain>
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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

Sync the latest upstream changes for free page reporting. To be
replaced by a full linux header sync.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/standard-headers/linux/virtio_balloon.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9375ca2a70de..1c5f6d6f2de6 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12


