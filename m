Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C1CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47F42074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCa9T1b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47F42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhETr-0002Ws-3T
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQG-0004n3-B7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQF-00022U-IX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591371498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MugtwhSa2UIARPD2RpJf6cOBr7a4c8tOBz0Sz8wV9m0=;
 b=QCa9T1b7IG/MGLRS1N9RUWuKxMT6cz1qL53JCt1X/1+jrLAClIyLH9sz/MqGy+pbtzeAfw
 XzAQRejkfCf/ba5CM3XXFIKlB3Zsygm1fl/6Gl7kGQ2RQLoFdXCBbqll2fey95kaA613vE
 YUsAf9xaAuv7fswJne6voAA37aNa/mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-CaiQivvuNfuzcVLdGb2MEw-1; Fri, 05 Jun 2020 11:38:16 -0400
X-MC-Unique: CaiQivvuNfuzcVLdGb2MEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64327A0C08;
 Fri,  5 Jun 2020 15:38:15 +0000 (UTC)
Received: from localhost (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ACF65D9DA;
 Fri,  5 Jun 2020 15:38:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/10] vfio-ccw: allow non-prefetch ORBs
Date: Fri,  5 Jun 2020 17:37:51 +0200
Message-Id: <20200605153756.392825-6-cohuck@redhat.com>
In-Reply-To: <20200605153756.392825-1-cohuck@redhat.com>
References: <20200605153756.392825-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jared Rossi <jrossi@linux.ibm.com>

Remove the explicit prefetch check when using vfio-ccw devices.
This check does not trigger in practice as all Linux channel programs
are intended to use prefetch.

Newer Linux kernel versions do not require to force the PFCH flag with
vfio-ccw devices anymore.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20200512181535.18630-2-jrossi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c8624943c177..63406184d226 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -74,16 +74,9 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
     struct ccw_io_region *region = vcdev->io_region;
     int ret;
 
-    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
-        if (!(vcdev->force_orb_pfch)) {
-            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
-            sch_gen_unit_exception(sch);
-            css_inject_io_interrupt(sch);
-            return IOINST_CC_EXPECTED;
-        } else {
-            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
-            warn_once_pfch(vcdev, sch, "PFCH flag forced");
-        }
+    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH) && vcdev->force_orb_pfch) {
+        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
+        warn_once_pfch(vcdev, sch, "PFCH flag forced");
     }
 
     QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
-- 
2.25.4


