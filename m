Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A1AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316BF20720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it+IWp4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316BF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmyy-0000ry-CZ
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvB-0002jw-Fg
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmv9-0001Ky-4W
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ynQiUfJj9vMi7GVuuET1BQ3U6a6e7jBcQmv7JseED4=;
 b=it+IWp4vB7m8o3Fd6Ez2R12rgf8zBn28ObzOD0+IMLVcJmP67Qs7uf5vKWafjIHVUDad9D
 H3ZB5P4AHG21DmvLtOJ7TU/gEzq2tTQ0g17CAc5Vj7BY6zKhUQRQjYqcHBU7WGEoli+cz1
 q3x1VOqCTu0w8Jixc08kJtistOP333w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-L3g7IEKvNCCCTXinbbrQ-g-1; Sat, 04 Jul 2020 14:29:48 -0400
X-MC-Unique: L3g7IEKvNCCCTXinbbrQ-g-1
Received: by mail-wm1-f69.google.com with SMTP id h25so23405252wmb.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6ynQiUfJj9vMi7GVuuET1BQ3U6a6e7jBcQmv7JseED4=;
 b=H909GIh8/b51CPbIvpwE8I/ZxNorxyeccPyj4LDIjGCQxxEuS5MUKDGMx4MrYMzPVV
 lRlBiTMPA7Mb12A4/uH5Jpd8DkypZUki6eNkt/AYVxEwdS+OTqxulQhdYk6pFBYjPNwy
 nub5TPcIlfCWgqZPs9GRltZ4UBbbVdb6zi6yiSi+2J9s9C+eZyhQiqs8lBtEcMC21tzO
 VbVp8ZSVkAEqyzQuW1O/qSR274tzqzZzrRHe7XJsFx+Yl5AJ4YkYIlSAL0WjZRa5N32n
 zKIGSLPx4FJ2leO4i5HxvlecGt7FUYkPC4mKAkOY82wRykQIBDNpuKYjd7rXw4uBnAvX
 Xpyg==
X-Gm-Message-State: AOAM531+uUS4YhxyzcdNAaAcm5QZ/KDelsjIFhCr5SZz1mZLQU0yVslJ
 q9hGtv7ZISb0gE4AtzL8ynWEEy7AQgicGLOO/pQVuZJ61tE65J7zkeJVTWMa0MOP9JbO7jUbUsX
 rATSnAVQ6XMTQ38s=
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr42131137wrs.275.1593887386765; 
 Sat, 04 Jul 2020 11:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWE1YvwHxLR+3QiabWhv24SvHlyQQj/sIBg07ej0B0o0dKvLd0mH1ao7gKBvpzFaOCynl98w==
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr42131125wrs.275.1593887386561; 
 Sat, 04 Jul 2020 11:29:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 e4sm17310270wrt.97.2020.07.04.11.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:45 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/41] s390x/pv: Convert to ram_block_discard_disable()
Message-ID: <20200704182750.1088103-9-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Discarding RAM does not work as expected with protected VMs. Let's
switch to ram_block_discard_disable() for now, as we want to get rid
of qemu_balloon_inhibit(). Note that it will currently never fail, but
might fail in the future with new technologies (e.g., virtio-mem).

Acked-by: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-6-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b111406d56..023fd25f2b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -43,7 +43,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/balloon.h"
 #include "hw/s390x/pv.h"
 #include "migration/blocker.h"
 
@@ -329,7 +328,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
     ms->pv = false;
     migrate_del_blocker(pv_mig_blocker);
     error_free_or_abort(&pv_mig_blocker);
-    qemu_balloon_inhibit(false);
+    ram_block_discard_disable(false);
 }
 
 static int s390_machine_protect(S390CcwMachineState *ms)
@@ -338,17 +337,22 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     int rc;
 
    /*
-    * Ballooning on protected VMs needs support in the guest for
-    * sharing and unsharing balloon pages. Block ballooning for
-    * now, until we have a solution to make at least Linux guests
-    * either support it or fail gracefully.
+    * Discarding of memory in RAM blocks does not work as expected with
+    * protected VMs. Sharing and unsharing pages would be required. Disable
+    * it for now, until until we have a solution to make at least Linux
+    * guests either support it (e.g., virtio-balloon) or fail gracefully.
     */
-    qemu_balloon_inhibit(true);
+    rc = ram_block_discard_disable(true);
+    if (rc) {
+        error_report("protected VMs: cannot disable RAM discard");
+        return rc;
+    }
+
     error_setg(&pv_mig_blocker,
                "protected VMs are currently not migrateable.");
     rc = migrate_add_blocker(pv_mig_blocker, &local_err);
     if (rc) {
-        qemu_balloon_inhibit(false);
+        ram_block_discard_disable(false);
         error_report_err(local_err);
         error_free_or_abort(&pv_mig_blocker);
         return rc;
@@ -357,7 +361,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
     /* Create SE VM */
     rc = s390_pv_vm_enable();
     if (rc) {
-        qemu_balloon_inhibit(false);
+        ram_block_discard_disable(false);
         migrate_del_blocker(pv_mig_blocker);
         error_free_or_abort(&pv_mig_blocker);
         return rc;
-- 
MST


