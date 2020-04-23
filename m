Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C50C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2267205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="egp/1Uxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2267205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgnd-0003RW-Jm
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgm2-0001Bz-CN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgm0-00048y-Sd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:33 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:50932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jRglv-00041N-3k; Thu, 23 Apr 2020 14:40:28 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 6C43D2E1586;
 Thu, 23 Apr 2020 21:40:23 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 giirV3zZcH-eKQes9BR; Thu, 23 Apr 2020 21:40:23 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587667223; bh=JRPA2qRfYLHHvtZ6OpHLn9WZva7jBBpSVFlB6entX5Y=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=egp/1UxuO06glmcXb+S5IRXikEW/vosv7gz24c8OCQWXGyqMJFGdNmIT7NjPP/53f
 jr3wA2MWyZFJ4YHYK0Gkiod6TrfpwMDRMtaqs9V5YV3QjXk9HPvVxx9HlZckHjK2X9
 rNttMD3WRlADluHQB5IuKmYrquHt7oFKveHNWeaU=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1313::1:e])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 7hClKENKMK-eKXe8ef2; Thu, 23 Apr 2020 21:40:20 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 1/7] contrib/vhost-user-blk: add option to simulate
 disconnect on init
Date: Thu, 23 Apr 2020 21:39:32 +0300
Message-Id: <52a4ae2d18ee0d810355d84ab83623a2e9ffa405.1587667007.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:6b8:0:1a2d::193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, arei.gonglei@huawei.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add "--simulate-disconnect-stage" option for the testing purposes.
This option can be used to test the vhost-user reconnect functionality:
  ./vhost-user-blk ... --simulate-disconnect-stage=<CASENUM>
In this case the daemon will "crash" in the middle of the VHOST comands
communication. Case nums are as follows:
  1 - make assert in the handler of the SET_VRING_CALL command
  2 - make assert in the handler of the SET_VRING_NUM command
Main purpose is to test QEMU reconnect functionality. Such fail
injection should not lead to QEMU crash and should be handled
successfully.
Also update the "GOptionEntry entries" definition with the final NULL
item according to API.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 contrib/libvhost-user/libvhost-user.c   | 30 ++++++++++++++++++++++++++++++
 contrib/libvhost-user/libvhost-user.h   | 13 +++++++++++++
 contrib/vhost-user-blk/vhost-user-blk.c | 14 +++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3bca996..5215214 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -73,6 +73,14 @@
 #define VHOST_USER_VERSION 1
 #define LIBVHOST_USER_DEBUG 0
 
+/*
+ * Inject fail in different places in daemon. This will trigger different
+ * paths in QEMU. Main purpose is to test the reconnect functionality
+ * during vhost initialization step.
+ */
+#define VHOST_SDISCONNECT_SET_VRING_CALL 1
+#define VHOST_SDISCONNECT_SET_VRING_NUM 2
+
 #define DPRINT(...)                             \
     do {                                        \
         if (LIBVHOST_USER_DEBUG) {              \
@@ -861,6 +869,11 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("State.index: %d\n", index);
     DPRINT("State.num:   %d\n", num);
     dev->vq[index].vring.num = num;
+    if (dev->simulate_init_disconnect == VHOST_SDISCONNECT_SET_VRING_NUM) {
+        DPRINT("Simulate vhost daemon crash during initialization.\n");
+        assert(0);
+        return false;
+    }
 
     return false;
 }
@@ -1161,6 +1174,13 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
 
+    /* Simulate crash during initialization. */
+    if (dev->simulate_init_disconnect == VHOST_SDISCONNECT_SET_VRING_CALL) {
+        DPRINT("Simulate vhost daemon crash during initialization.\n");
+        assert(0);
+        return false;
+    }
+
     if (!vu_check_queue_msg_file(dev, vmsg)) {
         return false;
     }
@@ -2073,6 +2093,16 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
     return vring_avail_idx(vq) == vq->last_avail_idx;
 }
 
+/*
+ * Set the flag to simulate the vhost-user daemon crash during
+ * initialization. This is used to test reconnect functionality.
+ */
+void
+vu_simulate_init_disconnect(VuDev *dev, int should_simulate)
+{
+    dev->simulate_init_disconnect = should_simulate;
+}
+
 static bool
 vring_notify(VuDev *dev, VuVirtq *vq)
 {
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index f30394f..9f75e86 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -388,6 +388,9 @@ struct VuDev {
     /* Postcopy data */
     int postcopy_ufd;
     bool postcopy_listening;
+
+    /* Fields to simulate test cases. */
+    int simulate_init_disconnect;
 };
 
 typedef struct VuVirtqElement {
@@ -645,4 +648,14 @@ void vu_queue_get_avail_bytes(VuDev *vdev, VuVirtq *vq, unsigned int *in_bytes,
 bool vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
                           unsigned int out_bytes);
 
+/**
+ * vu_simulate_init_disconnect:
+ * @dev: a VuDev context
+ * @should_simulate: expected simulation behaviour (true or false)
+ *
+ * Set the flag to simulate the vhost-user daemon crash during
+ * initialization. This is used to test reconnect functionality.
+ */
+void vu_simulate_init_disconnect(VuDev *dev, int should_simulate);
+
 #endif /* LIBVHOST_USER_H */
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 6fd91c7..6ac37ca 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -581,6 +581,7 @@ static char *opt_socket_path;
 static char *opt_blk_file;
 static gboolean opt_print_caps;
 static gboolean opt_read_only;
+static gboolean opt_simulate_disconnect;
 
 static GOptionEntry entries[] = {
     { "print-capabilities", 'c', 0, G_OPTION_ARG_NONE, &opt_print_caps,
@@ -592,7 +593,14 @@ static GOptionEntry entries[] = {
     {"blk-file", 'b', 0, G_OPTION_ARG_FILENAME, &opt_blk_file,
      "block device or file path", "PATH"},
     { "read-only", 'r', 0, G_OPTION_ARG_NONE, &opt_read_only,
-      "Enable read-only", NULL }
+      "Enable read-only", NULL },
+    { "simulate-disconnect-stage", 0, 0, G_OPTION_ARG_INT,
+      &opt_simulate_disconnect,
+      "Simulate disconnect during initialization for the testing purposes.\n"
+      "\t1 - make assert in the handler of the SET_VRING_CALL command\n"
+      "\t2 - make assert in the handler of the SET_VRING_NUM command\n",
+      "CASENUM" },
+    { NULL },
 };
 
 int main(int argc, char **argv)
@@ -656,6 +664,10 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
+    /* Set testing flags. */
+    vu_simulate_init_disconnect(&vdev_blk->parent.parent,
+            opt_simulate_disconnect);
+
     g_main_loop_run(vdev_blk->loop);
     g_main_loop_unref(vdev_blk->loop);
     g_option_context_free(context);
-- 
2.7.4


