Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AAEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC37820772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDBDlMkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC37820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIWQ-0002cz-Ts
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtHzK-00041g-6j
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:52:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtHzI-0005G8-CK
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibC8VBxKDigT75V4r6cBk01+W7vG9M45onQMHCdIq18=;
 b=ZDBDlMkpTPavJ51JXUkMzoDcqksIBQsVEJe8jwxyVN3F/hHWUM+4wy79q5u90cHzfT13lG
 NnwvbeVnJagCs9+0LzRAkHGN9XkMiiVsJeO+xkXk/QjIJz7LOqOG93xUYtCE3XKkud4y5z
 64s6SJmNfD+t4Zc/0ynPQUHBXVt70/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-TTI4SnaMMM6CVVsPbzBsLg-1; Wed, 08 Jul 2020 14:51:56 -0400
X-MC-Unique: TTI4SnaMMM6CVVsPbzBsLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32918015F5;
 Wed,  8 Jul 2020 18:51:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C49EA7554B;
 Wed,  8 Jul 2020 18:51:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 1/5] s390x: move setting of maximum ram size to machine
 init
Date: Wed,  8 Jul 2020 20:51:31 +0200
Message-Id: <20200708185135.46694-2-david@redhat.com>
In-Reply-To: <20200708185135.46694-1-david@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we no longer fixup the maximum ram size in sclp code, let's move
setting the maximum ram size to ccw_init()->s390_memory_init(), which
now looks like a better fit.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 19 ++++++++++++++++---
 hw/s390x/sclp.c            | 20 +-------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 023fd25f2b..2e6d292c23 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -160,13 +160,26 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
-static void s390_memory_init(MemoryRegion *ram)
+static void s390_memory_init(MachineState *machine)
 {
     MemoryRegion *sysmem = get_system_memory();
     Error *local_err = NULL;
+    uint64_t hw_limit;
+    int ret;
+
+    /* We have to set the memory limit before adding any regions to sysmem. */
+    ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
+    if (ret == -E2BIG) {
+        error_report("host supports a maximum of %" PRIu64 " GB",
+                     hw_limit / GiB);
+        exit(EXIT_FAILURE);
+    } else if (ret) {
+        error_report("setting the guest size failed");
+        exit(EXIT_FAILURE);
+    }
 
     /* allocate RAM for core */
-    memory_region_add_subregion(sysmem, 0, ram);
+    memory_region_add_subregion(sysmem, 0, machine->ram);
 
     /*
      * Configure the maximum page size. As no memory devices were created
@@ -249,7 +262,7 @@ static void ccw_init(MachineState *machine)
 
     s390_sclp_init();
     /* init memory + setup max page size. Required for the CPU model */
-    s390_memory_init(machine->ram);
+    s390_memory_init(machine);
 
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index d39f6d7785..f59195e15a 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -327,32 +327,14 @@ void s390_sclp_init(void)
 
 static void sclp_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     SCLPDevice *sclp = SCLP(dev);
-    Error *err = NULL;
-    uint64_t hw_limit;
-    int ret;
 
     /*
      * qdev_device_add searches the sysbus for TYPE_SCLP_EVENTS_BUS. As long
      * as we can't find a fitting bus via the qom tree, we have to add the
      * event facility to the sysbus, so e.g. a sclp console can be created.
      */
-    sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), &err);
-    if (err) {
-        goto out;
-    }
-
-    ret = s390_set_memory_limit(machine->maxram_size, &hw_limit);
-    if (ret == -E2BIG) {
-        error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
-                   hw_limit / GiB);
-    } else if (ret) {
-        error_setg(&err, "setting the guest size failed");
-    }
-
-out:
-    error_propagate(errp, err);
+    sysbus_realize(SYS_BUS_DEVICE(sclp->event_facility), errp);
 }
 
 static void sclp_memory_init(SCLPDevice *sclp)
-- 
2.26.2


