Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5922C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2346A20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2GgTnIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2346A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAc5-0001WQ-Uw
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIAZL-0008Gy-FP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:00:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIAZH-0005xa-8i
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MiqWmfo9obq9THM9dx2n99YXGugXv0XtHCg9e9fzYKE=;
 b=P2GgTnIs0+ybRxHttZXIl2MOdgyg08RVfpVaqxzwkVPR9p52uO63KahWP4/nIENU5EjIi0
 x+aMzvCFU+zR7Sw94fAOasrUvlai1SlWWsC836+54Cj3UPJaazvyenJcdFeShKWgR0DDYh
 pOmSq1zhAhAcbMXvuBv5+FDZG7wNMvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-uJvMcD26M3iDB1frWVQctg-1; Tue, 15 Sep 2020 09:00:13 -0400
X-MC-Unique: uJvMcD26M3iDB1frWVQctg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D9A2ADC11;
 Tue, 15 Sep 2020 13:00:12 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-120.ams2.redhat.com
 [10.36.114.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0047EB97;
 Tue, 15 Sep 2020 13:00:01 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: skip legacy support check on machine types less than
 5.1
Date: Tue, 15 Sep 2020 15:00:00 +0200
Message-Id: <20200915130000.78334-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
on") added a check that returns an error if legacy support is on, but the
device is not legacy.

Unfortunately some devices were wrongly declared legacy even if they
were not (e.g vhost-vsock).

To avoid migration issues, we disable this error for machine types < 5.1,
but we print a warning.

Cc: qemu-stable@nongnu.org
Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Suggested-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/hw/virtio/virtio.h |  1 +
 hw/core/machine.c          |  1 +
 hw/virtio/virtio.c         | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 807280451b..ed7cee348b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -103,6 +103,7 @@ struct VirtIODevice
     bool use_started;
     bool started;
     bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
+    bool disable_legacy_check;
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d61237..b686eab798 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
     { "vmport", "x-signal-unsupported-cmd", "off" },
     { "vmport", "x-report-vmx-type", "off" },
     { "vmport", "x-cmds-v2", "off" },
+    { "virtio-device", "x-disable-legacy-check", "true" },
 };
 const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e983025217..30ccc43b8c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3287,6 +3287,8 @@ void virtio_init(VirtIODevice *vdev, const char *name,
  */
 bool virtio_legacy_allowed(VirtIODevice *vdev)
 {
+    bool ret = false;
+
     switch (vdev->device_id) {
     case VIRTIO_ID_NET:
     case VIRTIO_ID_BLOCK:
@@ -3298,10 +3300,20 @@ bool virtio_legacy_allowed(VirtIODevice *vdev)
     case VIRTIO_ID_9P:
     case VIRTIO_ID_RPROC_SERIAL:
     case VIRTIO_ID_CAIF:
+        ret = true;
+    }
+
+    /*
+     * For backward compatibility, we allow legacy mode with old machine types
+     * to get the migration working.
+     */
+    if (!ret && vdev->disable_legacy_check) {
+        warn_report("device is modern-only, but for backward compatibility "
+                    "legacy is allowed");
         return true;
-    default:
-        return false;
     }
+
+    return ret;
 }
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
@@ -3713,6 +3725,8 @@ static Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
+    DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
+                     disable_legacy_check, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2


