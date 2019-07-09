Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA0C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC68B21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKUcxsKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC68B21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkrIn-0006he-16
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 10:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkrHR-000567-3b
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkrHL-0000bU-QB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:39:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkrHJ-0000UG-OC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:39:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id p17so10151681wrf.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iAbNxK9f4lkz6dU2zy38fJVIP/bjB5B1QuO7iWshhXY=;
 b=HKUcxsKFMc030lAegtqLfHQuHMH2YuM/3ZR63iqOltueU34Eubh1+dmZ0aHqR9swXs
 yzRQmvaHcRdg4Xahz5I7ZdQO+H1uvXUWN47UQUkvd+PUnxsnMRlWQ9FvZ+gE5ICGSJp2
 a2ud6Thp2yzpaXHms7VADdlqGwUJCTWrX7hZv3FNdXgQx4MBtpJX011oJztftH7Eg5VP
 JgBY+PCu8y3okm27sSVmlG/n19eNFoo2dinCbgiBpcW9u10cItfJYsDLPHmWHbo1/ARO
 6DRgcFkxVEwZYuKc3YIHB+6X1zyGSKXbFN2v9UiRJAaZFG5KgS6Iy1pT3zGJiiV3bvW9
 Vtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iAbNxK9f4lkz6dU2zy38fJVIP/bjB5B1QuO7iWshhXY=;
 b=C8zggCsbbg/bqplLvkuKgZWFGff21NQxg5eLCuKX2O6sNjPHVnBp5AeZ20b9NM6uc2
 MRM+TmKwA6/ya8WfwsIwo4s4anccAT7euaDJrczPnmqREhngd7T1gAmvMjVX1Gp0qjD1
 JCWuvTsO5JU8TQIUpEgqb1eDNVF0lsPeKSbbCusyIftPCCGzrB5j1VfnQ/bzXZKj1ZHj
 Xtr7cN5zdPPMM15KVBEe1j3LOtBn2rMW1a/0+AmXlB/Y+W5IQDeyybiFO0I9NoojZafk
 tqTUj2lyeVjPlCwxgsMEo7inV0L+CWzDQKsyKHJubIOj8Y8KU1ZiJzl6L9pyJTDXUEnr
 keAg==
X-Gm-Message-State: APjAAAWjC5VoXxF0psnXDZFjV7BQed6q95QNhafx6FbhdnYCsr6jEiFn
 SgzZCqzu+lBV/AEaqxbiHVZkSg==
X-Google-Smtp-Source: APXvYqzqyC0oqNC9uhXk1UF4nzUcNR+TcC0Ft8hQkQ0QjIXU/QrOSjro3BYdg+N90pM7kVyg/nWXRA==
X-Received: by 2002:adf:ca0f:: with SMTP id o15mr25764697wrh.135.1562683154678; 
 Tue, 09 Jul 2019 07:39:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o4sm2940122wmh.35.2019.07.09.07.39.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 07:39:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 15:39:12 +0100
Message-Id: <20190709143912.28905-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH for-4.1] pl031: Correctly migrate state when
 using -rtc clock=host
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Russell King <rmk@armlinux.org.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PL031 RTC tracks the difference between the guest RTC
and the host RTC using a tick_offset field. For migration,
however, we currently always migrate the offset between
the guest and the vm_clock, even if the RTC clock is not
the same as the vm_clock; this was an attempt to retain
migration backwards compatibility.

Unfortunately this results in the RTC behaving oddly across
a VM state save and restore -- since the VM clock stands still
across save-then-restore, regardless of how much real world
time has elapsed, the guest RTC ends up out of sync with the
host RTC in the restored VM.

Fix this by migrating the raw tick_offset. To retain migration
compatibility as far as possible, we have a new property
migrate-tick-offset; by default this is 'true' and we will
migrate the true tick offset in a new subsection; if the
incoming data has no subsection we fall back to the old
vm_clock-based offset information, so old->new migration
compatibility is preserved. For complete new->old migration
compatibility, the property is set to 'false' for 4.0 and
earlier machine types (this will only affect 'virt-4.0'
and below, as none of the other pl031-using machines are
versioned).

Reported-by: Russell King <rmk@armlinux.org.uk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I think this is correct, and it makes the "rtc clock should
not stay still across a save/reload" work, but I feel like
there might be some subtlety I've missed here. Review
definitely needed...

 include/hw/timer/pl031.h |  2 +
 hw/core/machine.c        |  1 +
 hw/timer/pl031.c         | 92 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/pl031.h b/include/hw/timer/pl031.h
index 8857c24ca5d..8c3f555ee28 100644
--- a/include/hw/timer/pl031.h
+++ b/include/hw/timer/pl031.h
@@ -33,6 +33,8 @@ typedef struct PL031State {
      */
     uint32_t tick_offset_vmstate;
     uint32_t tick_offset;
+    bool tick_offset_migrated;
+    bool migrate_tick_offset;
 
     uint32_t mr;
     uint32_t lr;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2be19ec0cd5..37a1111da1d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@ GlobalProperty hw_compat_4_0[] = {
     { "virtio-vga",     "edid", "false" },
     { "virtio-gpu-pci", "edid", "false" },
     { "virtio-device", "use-started", "false" },
+    { "pl031", "migrate-tick-offset", "false" },
 };
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 3378084f4a8..1a7e2ee06b3 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -199,29 +199,94 @@ static int pl031_pre_save(void *opaque)
 {
     PL031State *s = opaque;
 
-    /* tick_offset is base_time - rtc_clock base time.  Instead, we want to
-     * store the base time relative to the QEMU_CLOCK_VIRTUAL for backwards-compatibility.  */
+    /*
+     * The PL031 device model code uses the tick_offset field, which is
+     * the offset between what the guest RTC should read and what the
+     * QEMU rtc_clock reads:
+     *  guest_rtc = rtc_clock + tick_offset
+     * and so
+     *  tick_offset = guest_rtc - rtc_clock
+     *
+     * We want to migrate this offset, which sounds straightforward.
+     * Unfortunately older versions of QEMU migrated a conversion of this
+     * offset into an offset from the vm_clock. (This was in turn an
+     * attempt to be compatible with even older QEMU versions, but it
+     * has incorrect behaviour if the rtc_clock is not the same as the
+     * vm_clock.) So we put the actual tick_offset into a migration
+     * subsection, and the backwards-compatible time-relative-to-vm_clock
+     * in the main migration state.
+     *
+     * Calculate base time relative to QEMU_CLOCK_VIRTUAL:
+     */
     int64_t delta = qemu_clock_get_ns(rtc_clock) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     s->tick_offset_vmstate = s->tick_offset + delta / NANOSECONDS_PER_SECOND;
 
     return 0;
 }
 
+static int pl031_pre_load(void *opaque)
+{
+    PL031State *s = opaque;
+
+    s->tick_offset_migrated = false;
+    return 0;
+}
+
 static int pl031_post_load(void *opaque, int version_id)
 {
     PL031State *s = opaque;
 
-    int64_t delta = qemu_clock_get_ns(rtc_clock) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    s->tick_offset = s->tick_offset_vmstate - delta / NANOSECONDS_PER_SECOND;
+    /*
+     * If we got the tick_offset subsection, then we can just use
+     * the value in that. Otherwise the source is an older QEMU and
+     * has given us the offset from the vm_clock; convert it back to
+     * an offset from the rtc_clock. This will cause time to incorrectly
+     * go backwards compared to the host RTC, but this is unavoidable.
+     */
+
+    if (!s->tick_offset_migrated) {
+        int64_t delta = qemu_clock_get_ns(rtc_clock) -
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        s->tick_offset = s->tick_offset_vmstate -
+            delta / NANOSECONDS_PER_SECOND;
+    }
     pl031_set_alarm(s);
     return 0;
 }
 
+static int pl031_tick_offset_post_load(void *opaque, int version_id)
+{
+    PL031State *s = opaque;
+
+    s->tick_offset_migrated = true;
+    return 0;
+}
+
+static bool pl031_tick_offset_needed(void *opaque)
+{
+    PL031State *s = opaque;
+
+    return s->migrate_tick_offset;
+}
+
+static const VMStateDescription vmstate_pl031_tick_offset = {
+    .name = "pl031/tick-offset",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pl031_tick_offset_needed,
+    .post_load = pl031_tick_offset_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(tick_offset, PL031State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_pl031 = {
     .name = "pl031",
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_save = pl031_pre_save,
+    .pre_load = pl031_pre_load,
     .post_load = pl031_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(tick_offset_vmstate, PL031State),
@@ -231,14 +296,33 @@ static const VMStateDescription vmstate_pl031 = {
         VMSTATE_UINT32(im, PL031State),
         VMSTATE_UINT32(is, PL031State),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_pl031_tick_offset,
+        NULL
     }
 };
 
+static Property pl031_properties[] = {
+    /*
+     * True to correctly migrate the tick offset of the RTC. False to
+     * obtain backward migration compatibility with older QEMU versions,
+     * at the expense of the guest RTC going backwards compared with the
+     * host RTC when the VM is saved/restored if using -rtc host.
+     * (Even if set to 'true' older QEMU can migrate forward to newer QEMU;
+     * 'false' also permits newer QEMU to migrate to older QEMU.)
+     */
+    DEFINE_PROP_BOOL("migrate-tick-offset",
+                     PL031State, migrate_tick_offset, true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void pl031_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_pl031;
+    dc->props = pl031_properties;
 }
 
 static const TypeInfo pl031_info = {
-- 
2.20.1


