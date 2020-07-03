Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBFFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578A1207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSIv/mBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578A1207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHfm-0006cH-Jl
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbr-0006iD-Sb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbp-0004NX-31
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yJ2lEFwsgpUTZUMhX5VCO54V4eVVZ3IAAzP+xX7YP4=;
 b=dSIv/mBQGHJkmTZutoDj9ts/0HNGFiJHgIiO9lAsYhYR6RJP3tjNeQITjXJJO4yQuZes8U
 eQDgmmW1DfQFqcPgT+8MLlsOPSE2DPebSR6r6Th+leq4Z1a3kfHHzmSMeifnNWkhBVTg61
 vrM69+jd5w/5Jot1agkkkbNtfICm2AI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-Q02zI4SXPrCm-dtkPa0u8w-1; Fri, 03 Jul 2020 05:03:46 -0400
X-MC-Unique: Q02zI4SXPrCm-dtkPa0u8w-1
Received: by mail-wm1-f71.google.com with SMTP id v24so34593230wmh.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6yJ2lEFwsgpUTZUMhX5VCO54V4eVVZ3IAAzP+xX7YP4=;
 b=R8Kz5nAVCXWFLP3dmoJMgQPUNC1vLCjklEPzinRDHKxe267+FafABG7v0wnU4pJ0sb
 Q14jABRBfDkG5LHNReif4WgxXZ8TaYQfjGxQiAS6zH9r9Hvr2ZNnAd23xAz2XzC7OTt2
 ciWsj0rCFQAdbiqQwbkYTfdeX2MmkzNAoSvbBtgjDjY7+wJgr0F7R1UDlRlIKLRC894z
 QyfqmtTVOOaZN6pR4UqXqOiFb61KMb2PMQ00qLkR/xtcIisICCkH2g9J0+jiH46ttMp1
 5gsJkpQCk3mSbgNpmdvS1Mcy6ypKiCwqWIe1dggT1TzU/s1rijOAXz9cTzXu8groSfox
 05hw==
X-Gm-Message-State: AOAM530lo8cyq5nxZF1Zcxe0MW0sFhnVgVcnV5+s9ksgIkgxkIqwMVFo
 dv/mfiwIOe9Tlc87Ej2P8mJoHH9ur6mq0GmRi/aReBSr29bS0GGsCr8GVYsCYLHotZAzigDesRg
 S2oR0w9HoWoSb3Oo=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr20899705wmk.34.1593767025436; 
 Fri, 03 Jul 2020 02:03:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweeRo12c2BXZNh5i8Tzc97T+IRHVG3vUM5YjbssAXsdK0BhKK4oSD6Kwubo6WQzaEv6ZgmHg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr20899692wmk.34.1593767025254; 
 Fri, 03 Jul 2020 02:03:45 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 f14sm14495181wro.90.2020.07.03.02.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:44 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] exec: Introduce ram_block_discard_(disable|require)()
Message-ID: <20200703090252.368694-6-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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


