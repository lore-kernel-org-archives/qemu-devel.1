Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D52C83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B2F2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxFs0X3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B2F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTEWV-0000Xb-4J
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 20:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVR-0007CM-KK
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVR-0006rp-28
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:53:49 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jTEVQ-0006rg-Kj
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:53:48 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a32so371951pje.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=XWQH+WqkRfp4wJIRuWJ29KttjuuuSpzbvrw8QWn/fPk=;
 b=GxFs0X3XZme5IomZ99ooY9/c9kRD8U100og5CsVy/rSU4jCn8Ln+UPhSln9jvVRLSR
 P4j3hTi0gAnMFOJypepYk8A2zwyhBO1boGC+9EtrhhFqJAGulSEVCbSmfzbHU9tkOlCI
 j75RT19Nj3s4OZT0YbQ6db9R018MAPDQ92WX+OhT9g6Iq66iKU+Mq0YRy4zr9pNwlo+7
 QEFjJ/zZ/xuZjscFk5VQPkSCkVrEOJoUx220beZceIeg/pbp3FMdDdI8lWV2KbnbDugJ
 Z6BsGmYHV6W6tlSL/XCeiwwkSlWnAa0APJsHngjVZ7V/DTyYuWICvvqiCNLa8jlyxHr2
 AYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=XWQH+WqkRfp4wJIRuWJ29KttjuuuSpzbvrw8QWn/fPk=;
 b=MyVMFr/xKLzfIc74cO9DTklzCtNlMrBgGaFjL0VjbdIthJbR/dBbCVQsJgq/1nXCFX
 dqw1z10Cyh7LAkPWm+2SfRrVZGzKB+JFsY/1oZ6cfjAaGihqK0JeTaffZ8PAGLU6+uyA
 mGH5GyIFpIu9P996lZC6WAqKaHqtuhSCJMBwmh2ujEU0X2X20ea9MjJeVXXJTZ6lIVGp
 UGjBSQmiy/AwCZFcKeA31Sg/DrWhnuqwO5rQDNVN+A8UrOWaSSjGMHK9lL3NgFo3dYAo
 o/OIVQXcdWa4nqxMwZJH+Vb1nJR3+6igLnP9h49p4PGP78alVFUUXfGEta24JQ4de3/7
 uEXw==
X-Gm-Message-State: AGi0PuaBN7RQXnU6XdynDbqaOXxRiEnutU85lvqw6daprOGGbM5vfMS1
 itQYEnyU0vvIyos5hKQn6xc=
X-Google-Smtp-Source: APiQypLeZPzZ5OKMKU0qQr5r1HwbCnMpVGuz8DZlc02RJUpubo5hpCjNhgOlLiDdPmBpKO7G+9PiBg==
X-Received: by 2002:a17:902:a586:: with SMTP id
 az6mr9889237plb.201.1588035227098; 
 Mon, 27 Apr 2020 17:53:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id r128sm14127101pfc.141.2020.04.27.17.53.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 17:53:46 -0700 (PDT)
Subject: [PATCH v23 QEMU 1/5] linux-headers: Update to allow renaming of
 free_page_report_cmd_id
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 27 Apr 2020 17:53:45 -0700
Message-ID: <20200428005345.6158.57376.stgit@localhost.localdomain>
In-Reply-To: <20200428005134.6158.88521.stgit@localhost.localdomain>
References: <20200428005134.6158.88521.stgit@localhost.localdomain>
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


