Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B61EC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE13208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn77KKue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE13208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4pK-0003Y0-0o
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WX-0002xp-8R
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WO-0002iv-AF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0X1TnjZlRdHw8tcCNGOF380Ublm92SUhVeJg2HrPl0Y=;
 b=Yn77KKue8KRhMWg7jHYzKSNtnetyh2w/CtNcj2qkBJjaLiWZ0/TAUSsPq+jY8zHmwHSgPL
 QRlibUrucTuoPh0ZKghOc3Ge/FK8gifzPWog9qbztRuHQ9/Q0dFsVDB5EFqJRFh3q5J8vK
 9+cArMHh/8boeGlyZ93B0E9v07hC9SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-HXM_RtvHP4GCS8Jsa9aVNw-1; Mon, 12 Oct 2020 16:34:11 -0400
X-MC-Unique: HXM_RtvHP4GCS8Jsa9aVNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DF18100F7BF
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:34:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3976EF59;
 Mon, 12 Oct 2020 20:34:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/38] device-core: use atomic_set on .realized property
Date: Mon, 12 Oct 2020 16:33:38 -0400
Message-Id: <20201012203343.1105018-34-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:33:53
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Some code might race with placement of new devices on a bus.
We currently first place a (unrealized) device on the bus
and then realize it.

As a workaround, users that scan the child device list, can
check the realized property to see if it is safe to access such a device.
Use an atomic write here too to aid with this.

A separate discussion is what to do with devices that are unrealized:
It looks like for this case we only call the hotplug handler's unplug
callback and its up to it to unrealize the device.
An atomic operation doesn't cause harm for this code path though.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-6-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201006123904.610658-10-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 19 ++++++++++++++++++-
 include/hw/qdev-core.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 59e5e710b7..fc4daa36fa 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -946,7 +946,25 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             }
        }
 
+       qatomic_store_release(&dev->realized, value);
+
     } else if (!value && dev->realized) {
+
+        /*
+         * Change the value so that any concurrent users are aware
+         * that the device is going to be unrealized
+         *
+         * TODO: change .realized property to enum that states
+         * each phase of the device realization/unrealization
+         */
+
+        qatomic_set(&dev->realized, value);
+        /*
+         * Ensure that concurrent users see this update prior to
+         * any other changes done by unrealize.
+         */
+        smp_wmb();
+
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
             qbus_unrealize(bus);
         }
@@ -961,7 +979,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     }
 
     assert(local_err == NULL);
-    dev->realized = value;
     return;
 
 child_realize_fail:
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2c6307e3ed..868973319e 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -163,6 +163,8 @@ struct NamedClockList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ *            When accessed outsize big qemu lock, must be accessed with
+ *            atomic_load_acquire()
  * @reset: ResettableState for the device; handled by Resettable interface.
  *
  * This structure should not be accessed directly.  We declare it here
-- 
2.26.2



