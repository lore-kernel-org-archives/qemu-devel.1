Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E40C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59CB20729
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPlB5hcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59CB20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWUk-0001DK-SJ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYWTb-0000je-Sl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kYWTY-0001vW-WC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604072280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jauPRIkZdoN+DuZgLe3UIVdytdb2EoyDvX5nzVlCcDw=;
 b=WPlB5hcpqesqdYyvqV8DZK0qCrXAD4C60J1XWU0lr4xX+CgTqLhoQ1/2/W52CpLXJfTH5Y
 zqV3TvwWv8/o3n4NdB2OWYyTUtR+fHzarOQs+tv8K8lCvk/Jcu2B5ngfKUzSQZQujoADve
 Un7JgGibWqFKJGro8wuoz0vMIVlNBBY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188--Cms7wgyOwG0MEkMh6EzBg-1; Fri, 30 Oct 2020 11:37:57 -0400
X-MC-Unique: -Cms7wgyOwG0MEkMh6EzBg-1
Received: by mail-wr1-f70.google.com with SMTP id q15so2796169wrw.8
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jauPRIkZdoN+DuZgLe3UIVdytdb2EoyDvX5nzVlCcDw=;
 b=ip7fjeW4W6ZllvDc5b+gaTHqSSuPvbMyyTMAzBcq5fR34ksT2pwBs/sptbqHa+PG9Y
 m+UK/TjxQpKcoNItbU94jGyc60BTsToaKDV9I9cOBiKh4Xe3q8zy3gWhbRIKg3DOTe/4
 K8sVGYUGqCSu0bJ2j1EGe6aN2iFFmDmVU9Jxxc7zcD981LUa7zQnq1UyVjhnmIndI3F7
 o8XaYFTslI+nsit+2zQPAZE/R1sIgTjg4XlIFYluhFQf+NP0bw9dXnS9kliQZytdq3wH
 mr1Br+MB1PtGdjMJjgOOFzKzMdjaU08N3waMTRc8IEYLdNOuhSZ9fJVGLrHfYoXQ5n84
 0M9Q==
X-Gm-Message-State: AOAM533vZJYNeA5X68JyiY5ASbdAeUHObCtJlPIlMlXCiDDzJolw+e9F
 D0S+pJPiU/H/7eq4a43G8jHjGjz93NVd59k3ZW5cW5/PxKZgDjmQUjgjsYyINGfUhMdREVGCzar
 Gq5RHV6eskCBnqGA=
X-Received: by 2002:a5d:694b:: with SMTP id r11mr4021366wrw.104.1604072275346; 
 Fri, 30 Oct 2020 08:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywnjZdkRnkBCV/sr6LGEeofC9vZfMu4xqnu9Itdfy5gWjEh87xpD0+t3IhSX+lV9QDOd7t3w==
X-Received: by 2002:a5d:694b:: with SMTP id r11mr4021350wrw.104.1604072275164; 
 Fri, 30 Oct 2020 08:37:55 -0700 (PDT)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f6sm3990108wml.5.2020.10.30.08.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 08:37:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2] exec: Remove dead code (CID 1432876)
Date: Fri, 30 Oct 2020 16:37:52 +0100
Message-Id: <20201030153752.1557776-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We removed the global_locking field in commit 4174495408a,
leaving dead code around the 'unlocked' variable. Remove it
to fix the DEADCODE issue reported by Coverity (CID 1432876).

Fixes: 4174495408a ("exec: Remove MemoryRegion::global_locking field")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 softmmu/physmem.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index a9adedb9f82..0b31be29282 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2723,22 +2723,14 @@ static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
 
 static bool prepare_mmio_access(MemoryRegion *mr)
 {
-    bool unlocked = !qemu_mutex_iothread_locked();
     bool release_lock = false;
 
-    if (unlocked) {
+    if (!qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
-        unlocked = false;
         release_lock = true;
     }
     if (mr->flush_coalesced_mmio) {
-        if (unlocked) {
-            qemu_mutex_lock_iothread();
-        }
         qemu_flush_coalesced_mmio_buffer();
-        if (unlocked) {
-            qemu_mutex_unlock_iothread();
-        }
     }
 
     return release_lock;
-- 
2.26.2


