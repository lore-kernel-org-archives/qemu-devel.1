Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F05C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3AC206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBZ6hjpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3AC206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWaj-0001Zn-7f
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWXO-0007yM-Jj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWTl-0003UG-0T
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:09:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWTk-0003Kb-Be
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588104314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Eo4r6u5SYM1WZ9PfvYPN2Ms1+i0Op+LVgOGKasP7MU=;
 b=GBZ6hjpBBd6mh/LuFmv9/RuAVLh/2lDsva762lVhKFJIeoNj3JuvZ3UgrPwxO4fT9BznAy
 2uhscJV8T3QlNVG+aUGFzL0fEfbhfPHi/hoEaFRSAOM8AM5xUDiI956t86b/dJzvnHVVoz
 UuXsj8SfpGCyPlfYjvXQaVwO/prcX5Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-1cQA5VYKOqKgQwAqQnA9sg-1; Tue, 28 Apr 2020 16:05:13 -0400
X-MC-Unique: 1cQA5VYKOqKgQwAqQnA9sg-1
Received: by mail-qv1-f69.google.com with SMTP id c89so23127772qva.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wCJFXyhmyRTeYnNgNSFP3nGZV6uKvSfUmf8nDeG988w=;
 b=Gzx6LwGXe+UN8EBmfIzTPCGkALrS5ZkKOmJ+EApmu9HFN8PGGhPjb3/IUSZD429Eh4
 xB7hNubkm13iQvpUIf858MQjoQKHkgtfSJ+iKLwrHAmHI6HHlRs7JgBDY3ePor+tUf7k
 0kr7MHyG4Cf3OL6CIW0Vx77fvXbmTOPcMe/gAkEYKTnFq9EwpBH90hcTKKtaFIgjKTS1
 ob/Hi8ImxRuczXHVNbVeuI7WOmtzAyDtK3Qpamm/QoI7y0bZn29JZAo/lM+OzYscnl7g
 f9Su7UApdxqVWvgFjikeialgfs9JfduorYeDISwajs1hcG9PodG9IN0kv4O71kj4kjCe
 Btpg==
X-Gm-Message-State: AGi0PuYa7g1gtAXu+rs0A/dTnh6D1Q3xLPBsZL5jl7Oi+6o7HFMTRWsO
 rf52SHjkWemWrFccJ0DjKyhXO2ePr8q1cn27/fOruhB2x5BBPJXkhgxK5bEOsJ+deHr3R5tedid
 SMMdWBL2L5xjYKgM=
X-Received: by 2002:ac8:3844:: with SMTP id r4mr29502507qtb.32.1588104312201; 
 Tue, 28 Apr 2020 13:05:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIM2aZOSVuI2kcKN1DseMpwgNmpU391VOAikAbuGAb5n1d6rmkgC6htMuARMNPfMcrEult0g==
X-Received: by 2002:ac8:3844:: with SMTP id r4mr29502436qtb.32.1588104311486; 
 Tue, 28 Apr 2020 13:05:11 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k127sm14106585qkb.35.2020.04.28.13.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:05:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v2 3/9] memory: Introduce log_sync_global() to memory
 listener
Date: Tue, 28 Apr 2020 16:05:03 -0400
Message-Id: <20200428200509.13150-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428195707.11980-1-peterx@redhat.com>
References: <20200428195707.11980-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Peter Xu <peterx@redhat.com>
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
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *sectio=
n);
=20
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
index 357f7276ee..2a704996c2 100644
--- a/memory.c
+++ b/memory.c
@@ -2047,6 +2047,10 @@ void memory_region_set_dirty(MemoryRegion *mr, hwadd=
r addr,
                                         memory_region_get_dirty_log_mask(m=
r));
 }
=20
+/*
+ * If memory region `mr' is NULL, do global sync.  Otherwise, sync
+ * dirty bitmap for the specified memory region.
+ */
 static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
 {
     MemoryListener *listener;
@@ -2060,18 +2064,24 @@ static void memory_region_sync_dirty_bitmap(MemoryR=
egion *mr)
      * address space once.
      */
     QTAILQ_FOREACH(listener, &memory_listeners, link) {
-        if (!listener->log_sync) {
-            continue;
-        }
-        as =3D listener->address_space;
-        view =3D address_space_get_flatview(as);
-        FOR_EACH_FLAT_RANGE(fr, view) {
-            if (fr->dirty_log_mask && (!mr || fr->mr =3D=3D mr)) {
-                MemoryRegionSection mrs =3D section_from_flat_range(fr, vi=
ew);
-                listener->log_sync(listener, &mrs);
+        if (listener->log_sync) {
+            as =3D listener->address_space;
+            view =3D address_space_get_flatview(as);
+            FOR_EACH_FLAT_RANGE(fr, view) {
+                if (fr->dirty_log_mask && (!mr || fr->mr =3D=3D mr)) {
+                    MemoryRegionSection mrs =3D section_from_flat_range(fr=
, view);
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
=20
@@ -2758,6 +2768,9 @@ void memory_listener_register(MemoryListener *listene=
r, AddressSpace *as)
 {
     MemoryListener *other =3D NULL;
=20
+    /* Only one of them can be defined for a listener */
+    assert(!(listener->log_sync && listener->log_sync_global));
+
     listener->address_space =3D as;
     if (QTAILQ_EMPTY(&memory_listeners)
         || listener->priority >=3D QTAILQ_LAST(&memory_listeners)->priorit=
y) {
--=20
2.24.1


