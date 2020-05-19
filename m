Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F79620825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="js7Qt+IM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F79620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1Oj-000066-6P
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1Jc-00007i-Q5
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:48 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:4900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1Ja-0003A7-KC
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=90KP3EWUzYVQheSsrDuXWYxs8cTzEfUWVMG7tdurO8M=;
 b=js7Qt+IM2gsSyvrf6oBTonq0/OVWBBBPPZoWkH6UgVW6zXf4Tw87BTlINM1+uUkToG1J
 tsgGpztBEodwD/Xa+ZqyQeTW24EYTeGoDIru6XDwvjvrwK8LHYDd8L9ztgoY3BF+G6R02H
 FuulaGxWTANFN5/PaysDGnxA1wmPXy+hE=
Received: by filterdrecv-p3iad2-8ddf98858-285bn with SMTP id
 filterdrecv-p3iad2-8ddf98858-285bn-19-5EC3D048-34
 2020-05-19 12:25:44.519383699 +0000 UTC m=+4706301.117816697
Received: from localhost.localdomain.com (unknown)
 by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
 id G680gN3wQ9W3_f_jVtNxnQ Tue, 19 May 2020 12:25:44.195 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v3 07/10] Support ram slot configuration in libvhost-user
Date: Tue, 19 May 2020 12:25:44 +0000 (UTC)
Message-Id: <1588473683-27067-8-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zZAOlOQ5K2aYmNCGV?=
 =?us-ascii?Q?cgrofc9=2F0eECZ2Gf+YHBzQF+WfrGUAbOYLFMlQt?=
 =?us-ascii?Q?GMTyM9eCwQkqdvHQB8hLpNIbLtD0OrySWOUtwpl?=
 =?us-ascii?Q?K=2FsrryN1twq=2Fxi+4BKIcfgWcq4EuG0nSUqTxcsb?=
 =?us-ascii?Q?Zrw9Vc9h3ixycTLtgyR8B9ZHQxLVCjg+H0ps7QR?=
 =?us-ascii?Q?aueeFAk7qW7PsYYoWPFhA=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:25:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: raphael.s.norwitz@gmail.com, marcandre.lureau@gmail.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VHOST_USER_GET_MAX_MEM_SLOTS message allows a vhost-user backend to
specify a maximum number of ram slots it is willing to support. This
change adds support for libvhost-user to process this message. For now
the backend will reply with 8 as the maximum number of regions
supported.

libvhost-user does not yet support the vhost-user protocol feature
VHOST_USER_PROTOCOL_F_CONFIGIRE_MEM_SLOTS, so qemu should never
send the VHOST_USER_GET_MAX_MEM_SLOTS message. Therefore this new
functionality is not currently used.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 contrib/libvhost-user/libvhost-user.c | 19 +++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index cccfa22..9f039b7 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -137,6 +137,7 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_SET_INFLIGHT_FD),
         REQ(VHOST_USER_GPU_SET_SOCKET),
         REQ(VHOST_USER_VRING_KICK),
+        REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -1565,6 +1566,22 @@ vu_handle_vring_kick(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
 
+static bool vu_handle_get_max_memslots(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg->flags = VHOST_USER_REPLY_MASK | VHOST_USER_VERSION;
+    vmsg->size  = sizeof(vmsg->payload.u64);
+    vmsg->payload.u64 = VHOST_MEMORY_MAX_NREGIONS;
+    vmsg->fd_num = 0;
+
+    if (!vu_message_write(dev, dev->sock, vmsg)) {
+        vu_panic(dev, "Failed to send max ram slots: %s\n", strerror(errno));
+    }
+
+    DPRINT("u64: 0x%016"PRIx64"\n", (uint64_t) VHOST_MEMORY_MAX_NREGIONS);
+
+    return false;
+}
+
 static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1649,6 +1666,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_inflight_fd(dev, vmsg);
     case VHOST_USER_VRING_KICK:
         return vu_handle_vring_kick(dev, vmsg);
+    case VHOST_USER_GET_MAX_MEM_SLOTS:
+        return vu_handle_get_max_memslots(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index f30394f..88ef40d 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -97,6 +97,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_INFLIGHT_FD = 32,
     VHOST_USER_GPU_SET_SOCKET = 33,
     VHOST_USER_VRING_KICK = 35,
+    VHOST_USER_GET_MAX_MEM_SLOTS = 36,
     VHOST_USER_MAX
 } VhostUserRequest;
 
-- 
1.8.3.1


