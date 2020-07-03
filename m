Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C78C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F7207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO8zki5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F7207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHfx-0006yx-56
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbz-0006ol-Mk
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHbx-0004Ok-Ns
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ynQiUfJj9vMi7GVuuET1BQ3U6a6e7jBcQmv7JseED4=;
 b=bO8zki5YCD0ZywMd2brcPpjbBoJnjsYNhzIu1zittEgxtJbarz8i9efMNP1z79najZ0XXl
 Fomamq759QZ8IEtitL0sjB48QdKr2A6lu2q3NWMmvnfSzR6jVlVessJkF/k1x/NhEez8ye
 cVlG04tafywt52czobfPiag0vpIrOGo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-gLsxcn0rN-SY7XcV47nrSA-1; Fri, 03 Jul 2020 05:03:55 -0400
X-MC-Unique: gLsxcn0rN-SY7XcV47nrSA-1
Received: by mail-wr1-f71.google.com with SMTP id v3so1396879wrq.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6ynQiUfJj9vMi7GVuuET1BQ3U6a6e7jBcQmv7JseED4=;
 b=KVS9sBcPxFLp6roKOTRJe85FS/2cmN3cSpzWuFCSyjc14ByapgBzIpecn2r/UC4CmQ
 fTfge+8ddMYZ0bnmHoGbfZfEFowd+caDRav8mgvCc8KYXdU2Zued8HXiz1uhgcidHGkV
 j+K66BNjV9EaHADgyXEqQCIJvtNfz8pbpjAcsUaOp2I7vJI/i47l/8yYKG3/FHmxj6GD
 I/Azm6cEaDrdJbwOP4RH4znaa29QYTeBr3o0uqct1gYS0uY6jh4ZMeGqh2f/cP403U3w
 KE3UeLhqcbKg5qUhCI9BKzqNHHArolzmAN77F0/Ofq2ERf+m7YlcrvNuYTB3tiHYSIWR
 DRIA==
X-Gm-Message-State: AOAM5329QMMEKQoxKmofErC4S6uADvASp/YBZE2PZ8giRWEeH1qMoLpt
 TgAksgolbTM/g9YknJm5XSoSmCGToOdHufZFlaWICh82AR200aOairInpCGZ05SJFGaJTGEDBkd
 2juWzWKTmd99mMUY=
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr35289659wrw.111.1593767033827; 
 Fri, 03 Jul 2020 02:03:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxesfTVNtPHNhuPmoGIeyeHTT4TOp0oSZI8kjOLZmNGrO79bo3yF4jUZuNXO0WAqaehzPRmw==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr35289649wrw.111.1593767033680; 
 Fri, 03 Jul 2020 02:03:53 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 30sm14315670wrm.74.2020.07.03.02.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:53 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] s390x/pv: Convert to ram_block_discard_disable()
Message-ID: <20200703090252.368694-9-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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


