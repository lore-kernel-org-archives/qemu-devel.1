Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD82C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30D821556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG217sFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30D821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YnJ-0005eG-UQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkC-0000D7-0y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0005gu-0U
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk7-0005QP-GW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id a6so2846293wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PyEBmNQ59C7RUBA+p2Y8A9PNvZoLzmNnw5ksrQ9oivE=;
 b=MG217sFA8qa5s8VmZmkNj44c4XUoTy0RSBamEM0jxXJs+N1/GFXEM2tKDjAIr7QqsY
 OcD0isldBiF2s7630RceHgoVAd7YeAYsMJ8g+4YXYVq4prGsOnk7JrpyPSO/3pWwwMWU
 urp64AO935a2QPFQKdCKz4Emp8wlqn8BtbGdaEse1vG+nX0kGh95t1Blp/FDxEJzCQip
 uzWBAPjUxjdDIPEdSR04L0H1hgm7l7RJdi7kXY61TGgtyZi858Td38VIJ0KOYChHrXEl
 ml3mQtgDRKcPEYK4DVMcVWVwZL3TGwl4U3SudapgV30ImpxJXwqB+M3u286as3fcQb+g
 Nuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=PyEBmNQ59C7RUBA+p2Y8A9PNvZoLzmNnw5ksrQ9oivE=;
 b=o50gONqrEJL3uydYKCovqFzq49RhBc9e+JBcQkNgmuj7BE7e4aQsT9nuM54fcpvx7E
 ZJFUZYwXdoPRS7tyDNoqFbdUaimvm9gsj7uepdboPgyhyoJ11Fq9yxGrFNruoXJJ8zXB
 ERPRnNp5Hp/Z64cZf5zZAtdjffzXHnQY+IUc3yhVkjpqTt4h+QtrkbmrYEAKfNaK4kDz
 OPw/3YWTrT8sXL6upI+KX3vfFaGHuIlErRKLS4UlWMftPN7ziUzcriq3XhMvbTmTE1jM
 lU8tEVJB5xc5EI8X1n1vTkJSpPRcLRsNZDn6LdS0ys+saAjVI0F5/6IXBLZHIbw34fRw
 yLjw==
X-Gm-Message-State: APjAAAX9A6B/cwBqeEXLeFC3Fj22AdjO3AGBjB+N6R5gXSugpVM89hgy
 NWHk+OGn9zGGoEgCnPGzTtkiDC5y
X-Google-Smtp-Source: APXvYqyl5kZYZstSDtdD2dPmRrOYJjW8CHVBph6wSOvJCe7743il+M40+lqhYvXvfOuVtzuipiwNmQ==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr5067438wmi.116.1582631472993; 
 Tue, 25 Feb 2020 03:51:12 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 007/136] vl.c: ensure that ram_size matches size of
 machine.memory-backend
Date: Tue, 25 Feb 2020 12:48:57 +0100
Message-Id: <1582631466-13880-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Extend set_memory_options() to check that size specified by -m
matches the size of backend pointed by memory-backend.
And in case of -m was omitted adjust ram_size to match that
of explicitly provided backend.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200219160953.13771-8-imammedo@redhat.com>
---
 vl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/vl.c b/vl.c
index 72ffc06..a7edcba 100644
--- a/vl.c
+++ b/vl.c
@@ -2655,6 +2655,21 @@ static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
         exit(EXIT_FAILURE);
     }
 
+    if (current_machine->ram_memdev_id) {
+        Object *backend;
+        ram_addr_t backend_size;
+
+        backend = object_resolve_path_type(current_machine->ram_memdev_id,
+                                           TYPE_MEMORY_BACKEND, NULL);
+        backend_size = object_property_get_uint(backend, "size",  &error_abort);
+        if (mem_str && backend_size != ram_size) {
+                error_report("Size specified by -m option must match size of "
+                             "explicitly specified 'memory-backend' property");
+                exit(EXIT_FAILURE);
+        }
+        ram_size = backend_size;
+    }
+
     if (!xen_enabled()) {
         /* On 32-bit hosts, QEMU is limited by virtual address space */
         if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
-- 
1.8.3.1



