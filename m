Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8FC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4EE247CC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTVoSs2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4EE247CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXomJ-0002fT-Hf
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoYZ-0001va-LK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoYX-0001Zv-Vr
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1pTJYrQcWoNUCvyzp4rJ9qbcRwtZ2fTZovZ/x+ugX04=;
 b=hTVoSs2t3EO7BDKLzCsvxc99t4PfiTxMc/MOpgJjqkfH1mK5FN61QpS+M2km+D9ZXl7dqR
 MLViB2mgydy+eD0RrcTpuI3m3bo4a/SdmQauiw0PzCDouVMd8nOEwQ9tvMvnldhsDtYO8+
 NisTS+LMBS67JorQRPDh/bzGuVfF4FI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-3uBREUK0O36uEI9rcoL5Rg-1; Wed, 28 Oct 2020 12:44:10 -0400
X-MC-Unique: 3uBREUK0O36uEI9rcoL5Rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2F4856ADE;
 Wed, 28 Oct 2020 16:44:09 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AD3A5DA30;
 Wed, 28 Oct 2020 16:44:06 +0000 (UTC)
Subject: [PULL v2 31/32] hw/vfio: Use lock guard macros
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 10:44:06 -0600
Message-ID: <160390344593.12234.9382008267007884387.stgit@gimli.home>
In-Reply-To: <160390309510.12234.8858324597971641979.stgit@gimli.home>
References: <160390309510.12234.8858324597971641979.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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


