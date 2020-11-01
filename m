Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76432C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70FC207C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0BRoGYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70FC207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZKlN-0006lg-1u
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 16:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVl-0000Sq-9c
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kZKVj-0005ca-00
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 16:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604264614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pTJYrQcWoNUCvyzp4rJ9qbcRwtZ2fTZovZ/x+ugX04=;
 b=K0BRoGYOehmZkMB9y9qW6NC2J+59NdNuc9T6RHhiTgBS8rabEKQDaNGDcU4Q9KvlHFIZGx
 tzXop4xFvWqFQh0dkbjpkw76FP1j3JNstEGWQqWVJGNEQyHAX+Cf7MQMSfnb4SulMo6vo3
 HUw+YKMLTpkMtuE8DMa9Vj6eeFosaCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-gBvNgj6CNCm9w7iiDWXxFQ-1; Sun, 01 Nov 2020 16:03:31 -0500
X-MC-Unique: gBvNgj6CNCm9w7iiDWXxFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC8ED57050;
 Sun,  1 Nov 2020 21:03:30 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B48DB55776;
 Sun,  1 Nov 2020 21:03:27 +0000 (UTC)
Subject: [PULL v3 31/32] hw/vfio: Use lock guard macros
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 01 Nov 2020 14:03:27 -0700
Message-ID: <160426460736.24886.752943316593613476.stgit@gimli.home>
In-Reply-To: <160426371498.24886.12193840637250368669.stgit@gimli.home>
References: <160426371498.24886.12193840637250368669.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 15:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Amey Narkhede <ameynarkhede03@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Amey Narkhede <ameynarkhede03@gmail.com>

Use qemu LOCK_GUARD macros in hw/vfio.
Saves manual unlock calls

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/platform.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 869ed2c39dcd..cc3f66f7e44c 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -166,7 +166,7 @@ static void vfio_intp_mmap_enable(void *opaque)
     VFIOINTp *tmp;
     VFIOPlatformDevice *vdev = (VFIOPlatformDevice *)opaque;
 
-    qemu_mutex_lock(&vdev->intp_mutex);
+    QEMU_LOCK_GUARD(&vdev->intp_mutex);
     QLIST_FOREACH(tmp, &vdev->intp_list, next) {
         if (tmp->state == VFIO_IRQ_ACTIVE) {
             trace_vfio_platform_intp_mmap_enable(tmp->pin);
@@ -174,12 +174,10 @@ static void vfio_intp_mmap_enable(void *opaque)
             timer_mod(vdev->mmap_timer,
                       qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
                           vdev->mmap_timeout);
-            qemu_mutex_unlock(&vdev->intp_mutex);
             return;
         }
     }
     vfio_mmap_set_enabled(vdev, true);
-    qemu_mutex_unlock(&vdev->intp_mutex);
 }
 
 /**
@@ -289,7 +287,7 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
     VFIOPlatformDevice *vdev =
         container_of(vbasedev, VFIOPlatformDevice, vbasedev);
 
-    qemu_mutex_lock(&vdev->intp_mutex);
+    QEMU_LOCK_GUARD(&vdev->intp_mutex);
     QLIST_FOREACH(intp, &vdev->intp_list, next) {
         if (intp->state == VFIO_IRQ_ACTIVE) {
             trace_vfio_platform_eoi(intp->pin,
@@ -314,7 +312,6 @@ static void vfio_platform_eoi(VFIODevice *vbasedev)
         vfio_intp_inject_pending_lockheld(intp);
         QSIMPLEQ_REMOVE_HEAD(&vdev->pending_intp_queue, pqnext);
     }
-    qemu_mutex_unlock(&vdev->intp_mutex);
 }
 
 /**


