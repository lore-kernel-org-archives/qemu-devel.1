Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B42C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B682076D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 16:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B682076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNIaR-00063J-19
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 12:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kNIWo-00039P-Fb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:30:58 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:57147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kNIWm-0003x8-TU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 12:30:58 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-I2UtjzlUPB67qVbSA7NVdQ-1; Tue, 29 Sep 2020 12:30:51 -0400
X-MC-Unique: I2UtjzlUPB67qVbSA7NVdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446DD188C127;
 Tue, 29 Sep 2020 16:30:50 +0000 (UTC)
Received: from bahia.lan (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4125D9CA;
 Tue, 29 Sep 2020 16:30:45 +0000 (UTC)
Subject: [PATCH v2 2/2] vhost: Don't call log_access_ok() when using IOTLB
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Sep 2020 18:30:44 +0200
Message-ID: <160139704424.162128.7839027287942194310.stgit@bahia.lan>
In-Reply-To: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 12:30:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the IOTLB device is enabled, the log_guest_addr that is passed by
userspace to the VHOST_SET_VRING_ADDR ioctl, and which is then written
to vq->log_addr, is a GIOVA. All writes to this address are translated
by log_user() to writes to an HVA, and then ultimately logged through
the corresponding GPAs in log_write_hva(). No logging will ever occur
with vq->log_addr in this case. It is thus wrong to pass vq->log_addr
and log_guest_addr to log_access_vq() which assumes they are actual
GPAs.

Introduce a new vq_log_used_access_ok() helper that only checks accesses
to the log for the used structure when there isn't an IOTLB device around.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 drivers/vhost/vhost.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c3b49975dc28..5996e32fa818 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1370,6 +1370,20 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_log_access_ok);
=20
+static bool vq_log_used_access_ok(struct vhost_virtqueue *vq,
+=09=09=09=09  void __user *log_base,
+=09=09=09=09  bool log_used,
+=09=09=09=09  u64 log_addr,
+=09=09=09=09  size_t log_size)
+{
+=09/* If an IOTLB device is present, log_addr is a GIOVA that
+=09 * will never be logged by log_used(). */
+=09if (vq->iotlb)
+=09=09return true;
+
+=09return !log_used || log_access_ok(log_base, log_addr, log_size);
+}
+
 /* Verify access for write logging. */
 /* Caller should have vq mutex and device mutex */
 static bool vq_log_access_ok(struct vhost_virtqueue *vq,
@@ -1377,8 +1391,8 @@ static bool vq_log_access_ok(struct vhost_virtqueue *=
vq,
 {
 =09return vq_memory_access_ok(log_base, vq->umem,
 =09=09=09=09   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
-=09=09(!vq->log_used || log_access_ok(log_base, vq->log_addr,
-=09=09=09=09  vhost_get_used_size(vq, vq->num)));
+=09=09vq_log_used_access_ok(vq, log_base, vq->log_used, vq->log_addr,
+=09=09=09=09      vhost_get_used_size(vq, vq->num));
 }
=20
 /* Can we start vq? */
@@ -1517,8 +1531,9 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
 =09=09=09return -EINVAL;
=20
 =09=09/* Also validate log access for used ring if enabled. */
-=09=09if ((a.flags & (0x1 << VHOST_VRING_F_LOG)) &&
-=09=09=09!log_access_ok(vq->log_base, a.log_guest_addr,
+=09=09if (!vq_log_used_access_ok(vq, vq->log_base,
+=09=09=09=09a.flags & (0x1 << VHOST_VRING_F_LOG),
+=09=09=09=09a.log_guest_addr,
 =09=09=09=09sizeof *vq->used +
 =09=09=09=09vq->num * sizeof *vq->used->ring))
 =09=09=09return -EINVAL;



