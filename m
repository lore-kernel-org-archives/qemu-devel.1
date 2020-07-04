Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD7A20720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdqT0s1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD7A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmzo-00035f-MU
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv3-0002hJ-SK
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv0-0001J8-Fz
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yJ2lEFwsgpUTZUMhX5VCO54V4eVVZ3IAAzP+xX7YP4=;
 b=hdqT0s1ESB8LOCWz1sfS40AKTwQ4cYDZu1ZwkkbZWsARC0cZqbmcjphgTOX6u7nLMLyoDU
 L5xneoRaM76GGbyhHxjpBwbIoFrdp27AuHmOsiLkDbssxRXepHa1qk+rAA7H5arh+qHZvn
 WAO/iFvUTFlhvE9JRwHWIZ9GbZJL3UE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354--rN_ny73M6CGXQXkuOk72w-1; Sat, 04 Jul 2020 14:29:39 -0400
X-MC-Unique: -rN_ny73M6CGXQXkuOk72w-1
Received: by mail-wr1-f69.google.com with SMTP id o12so36256124wrj.23
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6yJ2lEFwsgpUTZUMhX5VCO54V4eVVZ3IAAzP+xX7YP4=;
 b=iqJk2SItCcM2GwUPIP688on1koVyZ38Re2z2GgpLXAvXAsnA+hAae9x/4WPB1PIAXD
 87hdEBZcogYoycU6SCWqj0BHAW4td/5zavi9SdZOaxGE0fvQRvF8ocBentNZmZ1KE9//
 P7Ug0tdo7Apb+ky3+SQ3x7Gxi1mH5itn6Pzl0hg+MSUI60gJzGC0F1zJ973DldCXJGRP
 sKjIvwTuVa/8FE07GQXcf5iciHuS3s9HxFPlIwy/Zs13fgWcHeDNFd/voB+4UW/Dy0+8
 r4FggLvJUakRxeFy98Zs7htDYgV70m+de6nCj0WWm4diSFqHSVvOKEXI7FKlONJr86eK
 R6dw==
X-Gm-Message-State: AOAM532ZMKYahpjiDDJLRE7EHJBFRu/spMpn05pgMcGqdMaRA2irfZ9k
 VcodBR4uJOkLFl43a0fIhH6pvZx83FXZGKiExlrLmmQ5gbceKp2TvdjW4xzX7TYBswjtNXZJfUR
 FvsKcaOxdy7cuCPY=
X-Received: by 2002:a7b:c746:: with SMTP id w6mr44393278wmk.171.1593887378218; 
 Sat, 04 Jul 2020 11:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPsV7s2GgPV3zNqXqrsB08xVzuLtS6iRHigHlJueilVTU2MZ1qgmxHUXcaq5om/YnqA7Ycig==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr44393266wmk.171.1593887377987; 
 Sat, 04 Jul 2020 11:29:37 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 1sm17150745wmf.0.2020.07.04.11.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:37 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/41] exec: Introduce ram_block_discard_(disable|require)()
Message-ID: <20200704182750.1088103-6-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We want to replace qemu_balloon_inhibit() by something more generic.
Especially, we want to make sure that technologies that really rely on
RAM block discards to work reliably to run mutual exclusive with
technologies that effectively break it.

E.g., vfio will usually pin all guest memory, turning the virtio-balloon
basically useless and make the VM consume more memory than reported via
the balloon. While the balloon is special already (=> no guarantees, same
behavior possible afer reboots and with huge pages), this will be
different, especially, with virtio-mem.

Let's implement a way such that we can make both types of technology run
mutually exclusive. We'll convert existing balloon inhibitors in successive
patches and add some new ones. Add the check to
qemu_balloon_is_inhibited() for now. We might want to make
virtio-balloon an acutal inhibitor in the future - however, that
requires more thought to not break existing setups.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-3-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h | 41 ++++++++++++++++++++++++++++++++++
 balloon.c             |  3 ++-
 exec.c                | 52 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7207025bd4..38ec38b9a8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2472,6 +2472,47 @@ static inline MemOp devend_memop(enum device_endian end)
 }
 #endif
 
+/*
+ * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
+ * to manage the actual amount of memory consumed by the VM (then, the memory
+ * provided by RAM blocks might be bigger than the desired memory consumption).
+ * This *must* be set if:
+ * - Discarding parts of a RAM blocks does not result in the change being
+ *   reflected in the VM and the pages getting freed.
+ * - All memory in RAM blocks is pinned or duplicated, invaldiating any previous
+ *   discards blindly.
+ * - Discarding parts of a RAM blocks will result in integrity issues (e.g.,
+ *   encrypted VMs).
+ * Technologies that only temporarily pin the current working set of a
+ * driver are fine, because we don't expect such pages to be discarded
+ * (esp. based on guest action like balloon inflation).
+ *
+ * This is *not* to be used to protect from concurrent discards (esp.,
+ * postcopy).
+ *
+ * Returns 0 if successful. Returns -EBUSY if a technology that relies on
+ * discards to work reliably is active.
+ */
+int ram_block_discard_disable(bool state);
+
+/*
+ * Inhibit technologies that disable discarding of pages in RAM blocks.
+ *
+ * Returns 0 if successful. Returns -EBUSY if discards are already set to
+ * broken.
+ */
+int ram_block_discard_require(bool state);
+
+/*
+ * Test if discarding of memory in ram blocks is disabled.
+ */
+bool ram_block_discard_is_disabled(void);
+
+/*
+ * Test if discarding of memory in ram blocks is required to work reliably.
+ */
+bool ram_block_discard_is_required(void);
+
 #endif
 
 #endif
diff --git a/balloon.c b/balloon.c
index f104b42961..5fff79523a 100644
--- a/balloon.c
+++ b/balloon.c
@@ -40,7 +40,8 @@ static int balloon_inhibit_count;
 
 bool qemu_balloon_is_inhibited(void)
 {
-    return atomic_read(&balloon_inhibit_count) > 0;
+    return atomic_read(&balloon_inhibit_count) > 0 ||
+           ram_block_discard_is_disabled();
 }
 
 void qemu_balloon_inhibit(bool state)
diff --git a/exec.c b/exec.c
index 21926dc9c7..893636176e 100644
--- a/exec.c
+++ b/exec.c
@@ -4115,4 +4115,56 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
     }
 }
 
+/*
+ * If positive, discarding RAM is disabled. If negative, discarding RAM is
+ * required to work and cannot be disabled.
+ */
+static int ram_block_discard_disabled;
+
+int ram_block_discard_disable(bool state)
+{
+    int old;
+
+    if (!state) {
+        atomic_dec(&ram_block_discard_disabled);
+        return 0;
+    }
+
+    do {
+        old = atomic_read(&ram_block_discard_disabled);
+        if (old < 0) {
+            return -EBUSY;
+        }
+    } while (atomic_cmpxchg(&ram_block_discard_disabled, old, old + 1) != old);
+    return 0;
+}
+
+int ram_block_discard_require(bool state)
+{
+    int old;
+
+    if (!state) {
+        atomic_inc(&ram_block_discard_disabled);
+        return 0;
+    }
+
+    do {
+        old = atomic_read(&ram_block_discard_disabled);
+        if (old > 0) {
+            return -EBUSY;
+        }
+    } while (atomic_cmpxchg(&ram_block_discard_disabled, old, old - 1) != old);
+    return 0;
+}
+
+bool ram_block_discard_is_disabled(void)
+{
+    return atomic_read(&ram_block_discard_disabled) > 0;
+}
+
+bool ram_block_discard_is_required(void)
+{
+    return atomic_read(&ram_block_discard_disabled) < 0;
+}
+
 #endif
-- 
MST


