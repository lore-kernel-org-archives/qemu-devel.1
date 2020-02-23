Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6272FC35675
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 21:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1BB206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 21:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1BB206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5yTj-00055e-D1
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 16:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j5ySv-0004Eg-JF
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 16:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j5ySu-0001gD-9M
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 16:07:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:59521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j5ySt-0001fh-WF
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 16:07:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Feb 2020 13:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,477,1574150400"; d="scan'208";a="230945808"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2020 13:06:59 -0800
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] net/colo-compare.c: Expose "compare_timeout" to user
Date: Mon, 24 Feb 2020 04:58:04 +0800
Message-Id: <20200223205805.26412-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200223205805.26412-1-chen.zhang@intel.com>
References: <20200223205805.26412-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: Daniel Cho <danielcho@qnap.com>, Zhang Chen <chen.zhang@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

The "compare_timeout" determines the max time to hold the primary net packet.
This patch expose the "compare_timeout", make user can
adjest this value according to the specific application scenario.

QMP command demo:
    { "execute": "qom-get",
         "arguments": { "path": "/objects/comp0",
                        "property": "compare_timeout" } }

    { "execute": "qom-set",
         "arguments": { "path": "/objects/comp0",
                        "property": "compare_timeout",
                        "value": 5000} }

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 47 ++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx    |  5 +++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ee17f2cf8..ec09b2a524 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -50,6 +50,7 @@ static NotifierList colo_compare_notifiers =
 
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
+#define DEFAULT_TIME_OUT_MS 3000
 
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
@@ -92,6 +93,7 @@ typedef struct CompareState {
     SocketReadState sec_rs;
     SocketReadState notify_rs;
     bool vnet_hdr;
+    uint32_t compare_timeout;
 
     /*
      * Record the connection that through the NIC
@@ -607,10 +609,9 @@ static int colo_old_packet_check_one_conn(Connection *conn,
                                           CompareState *s)
 {
     GList *result = NULL;
-    int64_t check_time = REGULAR_PACKET_CHECK_MS;
 
     result = g_queue_find_custom(&conn->primary_list,
-                                 &check_time,
+                                 &s->compare_timeout,
                                  (GCompareFunc)colo_old_packet_check_one);
 
     if (result) {
@@ -984,6 +985,39 @@ static void compare_set_notify_dev(Object *obj, const char *value, Error **errp)
     s->notify_dev = g_strdup(value);
 }
 
+static void compare_get_timeout(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+    uint32_t value = s->compare_timeout;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void compare_set_timeout(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+    Error *local_err = NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    s->compare_timeout = value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -1090,6 +1124,11 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (!s->compare_timeout) {
+        /* Set default value to 3000 MS */
+        s->compare_timeout = DEFAULT_TIME_OUT_MS;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1185,6 +1224,10 @@ static void colo_compare_init(Object *obj)
                             compare_get_notify_dev, compare_set_notify_dev,
                             NULL);
 
+    object_property_add(obj, "compare_timeout", "uint32",
+                        compare_get_timeout,
+                        compare_set_timeout, NULL, NULL, NULL);
+
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
                              compare_set_vnet_hdr, NULL);
diff --git a/qemu-options.hx b/qemu-options.hx
index ac315c1ac4..3832d0ae8a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4598,7 +4598,7 @@ Dump the network traffic on netdev @var{dev} to the file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
-@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support][,notify_dev=@var{id}]
+@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support][,notify_dev=@var{id}][,compare_timeout=@var{ms}]
 
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
 secondary packet. If the packets are same, we will output primary
@@ -4606,7 +4606,8 @@ packet to outdev@var{chardevid}, else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
 In order to improve efficiency, we need to put the task of comparison
 in another thread. If it has the vnet_hdr_support flag, colo compare
-will send/recv packet with vnet_hdr_len.
+will send/recv packet with vnet_hdr_len. The compare_timeout=@var{ms}
+determines the maximum time colo-compare wait for primary packet.
 If you want to use Xen COLO, will need the notify_dev to notify Xen
 colo-frame to do checkpoint.
 
-- 
2.17.1


