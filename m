Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950EC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C0C22CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C0C22CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5P8Q-0007Ho-5n
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i5P7e-0006pw-TI
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i5P7d-00054e-Px
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:50:30 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:49520
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i5P7d-00052p-JK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:50:29 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.92.1) (envelope-from <johannes@sipsolutions.net>)
 id 1i5P7X-0007vs-TB; Wed, 04 Sep 2019 08:50:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 09:50:21 +0300
Message-Id: <20190904065021.1360-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: [Qemu-devel] [PATCH] libvhost-user: introduce and use
 vu_has_protocol_feature()
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Johannes Berg <johannes.berg@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

This simplifies the various has_feature() checks, we already
have vu_has_feature() but it checks features, not protocol
features.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 contrib/libvhost-user/libvhost-user.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index fcf4a8a00ed2..fba291c13db4 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -94,6 +94,11 @@ bool vu_has_feature(VuDev *dev,
     return has_feature(dev->features, fbit);
 }
 
+static inline bool vu_has_protocol_feature(VuDev *dev, unsigned int fbit)
+{
+    return has_feature(dev->protocol_features, fbit);
+}
+
 static const char *
 vu_request_to_string(unsigned int req)
 {
@@ -951,8 +956,7 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
 {
     int i = 0;
 
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -1097,8 +1101,7 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
 
     vmsg.fd_num = fd_num;
 
-    if (!has_feature(dev->protocol_features,
-                     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) {
         return false;
     }
 
@@ -2199,8 +2202,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
 static int
 vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
 {
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2217,8 +2219,7 @@ vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
 static int
 vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
 {
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
@@ -2234,8 +2235,7 @@ vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
 static int
 vu_queue_inflight_post_put(VuDev *dev, VuVirtq *vq, int desc_idx)
 {
-    if (!has_feature(dev->protocol_features,
-        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
+    if (!vu_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
         return 0;
     }
 
-- 
2.23.0


