Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91785C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8E820735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZHzwRL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8E820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdSW-00008a-C8
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRe-0006sU-Lp
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57447
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRd-0000Ow-MS
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Kvi6xzK9MWs5xCm4IUNKTRO2aVL0Wwl9B3a3YZXML8=;
 b=iZHzwRL5hLE+M9pUAI8ObeMeyFyCIdcrSk5gln10SfcyiTT8gAtbU7XN82GnAQSKzRj4C4
 NIvuss3LR+Lrr+3WCZcnq7z4WuIbW9hTrUF3GqRloPngiR8MZXO3whD86tIcJD2BYGhEZo
 pedAIXWBdEqAc4qNlzqu1jnP23YvW9g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-10Paq6OFMhWdwIzcGiw_MA-1; Sat, 23 May 2020 19:20:43 -0400
X-MC-Unique: 10Paq6OFMhWdwIzcGiw_MA-1
Received: by mail-qt1-f200.google.com with SMTP id o16so15947879qto.12
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Kvi6xzK9MWs5xCm4IUNKTRO2aVL0Wwl9B3a3YZXML8=;
 b=tMZ26sOg9zGdXVHREK3f3FLa+tUjBJsXe92v/Lo+HS6QX9/ISgz5ktPuLMuj6FU8Zw
 Q/MLT4GvLabHusOWAviHnQyn8KPpmgTzFZqEiLBVlHJYAg1u6ROIsztlR3u2ZbzbdVlk
 eTGNGVkB44V3ytzLa7qYV9X6zY5fq/dl2BIwY7J53CblEqz64LmxP3p8xC4LqsFDEUuj
 StvJxmo5IqDSJPSiW+C+qisnA/tTpnRQnlNGyWQ8wi6rwU08epGZJIiG+pa/vWRJftDy
 Tj0itH2fknU0j8lSBniOnpysJg0NntyGGAZypcDqd0sR9SnwrywmGNN+fpxpwZkUtM/O
 xMzw==
X-Gm-Message-State: AOAM531HhjlhAdUEK1cUbh4Ei1f1xsfm5hz+SI2N3+A1oLDVrIxhJmnV
 ZtDb3wFqqvQl/o61WdahEXfscd81ICSQdnpxkzyP3Ott4Il3NBZ9YRlxPCK3EJHjg6J1MHYH1jd
 1NLAIBu53kbnv+qA=
X-Received: by 2002:aed:3009:: with SMTP id 9mr22069073qte.191.1590276042202; 
 Sat, 23 May 2020 16:20:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWRrzStb2z+qPHYVXam3uw39Xic1d5lduo5dqWB5YefEOq6B+ogqyKtb3yeYFp/cj3VE21ZQ==
X-Received: by 2002:aed:3009:: with SMTP id 9mr22069057qte.191.1590276041921; 
 Sat, 23 May 2020 16:20:41 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 02/11] memory: Introduce log_sync_global() to memory
 listener
Date: Sat, 23 May 2020 19:20:26 -0400
Message-Id: <20200523232035.1029349-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 19:20:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the memory listener may want to do log synchronization without
being able to specify a range of memory to sync but always globally.
Such a memory listener should provide this new method instead of the
log_sync() method.

Obviously we can also achieve similar thing when we put the global
sync logic into a log_sync() handler. However that's not efficient
enough because otherwise memory_global_dirty_log_sync() may do the
global sync N times, where N is the number of flat ranges in the
address space.

Make this new method be exclusive to log_sync().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 12 ++++++++++++
 memory.c              | 33 +++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..c0c6155ca0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -533,6 +533,18 @@ struct MemoryListener {
      */
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *section);
 
+    /**
+     * @log_sync_global:
+     *
+     * This is the global version of @log_sync when the listener does
+     * not have a way to synchronize the log with finer granularity.
+     * When the listener registers with @log_sync_global defined, then
+     * its @log_sync must be NULL.  Vice versa.
+     *
+     * @listener: The #MemoryListener.
+     */
+    void (*log_sync_global)(MemoryListener *listener);
+
     /**
      * @log_clear:
      *
diff --git a/memory.c b/memory.c
index 92fb8b80d7..a77c884e8e 100644
--- a/memory.c
+++ b/memory.c
@@ -2047,6 +2047,10 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                                         memory_region_get_dirty_log_mask(mr));
 }
 
+/*
+ * If memory region `mr' is NULL, do global sync.  Otherwise, sync
+ * dirty bitmap for the specified memory region.
+ */
 static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
 {
     MemoryListener *listener;
@@ -2060,18 +2064,24 @@ static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
      * address space once.
      */
     QTAILQ_FOREACH(listener, &memory_listeners, link) {
-        if (!listener->log_sync) {
-            continue;
-        }
-        as = listener->address_space;
-        view = address_space_get_flatview(as);
-        FOR_EACH_FLAT_RANGE(fr, view) {
-            if (fr->dirty_log_mask && (!mr || fr->mr == mr)) {
-                MemoryRegionSection mrs = section_from_flat_range(fr, view);
-                listener->log_sync(listener, &mrs);
+        if (listener->log_sync) {
+            as = listener->address_space;
+            view = address_space_get_flatview(as);
+            FOR_EACH_FLAT_RANGE(fr, view) {
+                if (fr->dirty_log_mask && (!mr || fr->mr == mr)) {
+                    MemoryRegionSection mrs = section_from_flat_range(fr, view);
+                    listener->log_sync(listener, &mrs);
+                }
             }
+            flatview_unref(view);
+        } else if (listener->log_sync_global) {
+            /*
+             * No matter whether MR is specified, what we can do here
+             * is to do a global sync, because we are not capable to
+             * sync in a finer granularity.
+             */
+            listener->log_sync_global(listener);
         }
-        flatview_unref(view);
     }
 }
 
@@ -2758,6 +2768,9 @@ void memory_listener_register(MemoryListener *listener, AddressSpace *as)
 {
     MemoryListener *other = NULL;
 
+    /* Only one of them can be defined for a listener */
+    assert(!(listener->log_sync && listener->log_sync_global));
+
     listener->address_space = as;
     if (QTAILQ_EMPTY(&memory_listeners)
         || listener->priority >= QTAILQ_LAST(&memory_listeners)->priority) {
-- 
2.26.2


