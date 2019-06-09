Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6EC468BD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 16:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E35A20833
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 16:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E35A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37060 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha12Q-0002PP-Hf
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 12:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1ha10S-0000QF-5S
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:49:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ha10Q-0007Fx-Ou
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:49:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:62032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ha10Q-0007CA-FQ
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 12:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2019 09:49:11 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga005.jf.intel.com with ESMTP; 09 Jun 2019 09:49:09 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 10 Jun 2019 00:44:29 +0800
Message-Id: <20190609164433.5866-2-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <20190609164433.5866-1-chen.zhang@intel.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH V2 1/5] COLO-compare: Add new parameter to
 communicate with remote colo-frame
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

We add the "notify_dev=chardevID" parameter. After that colo-compare can connect with
remote(currently just for Xen, KVM-COLO didn't need it.) colo-frame through chardev socket,
it can notify remote(Xen) colo-frame to handle checkpoint event.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 21 +++++++++++++++++++++
 qemu-options.hx    | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index fcb491121b..21849748b6 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -83,6 +83,7 @@ typedef struct CompareState {
     char *pri_indev;
     char *sec_indev;
     char *outdev;
+    char *notify_dev;
     CharBackend chr_pri_in;
     CharBackend chr_sec_in;
     CharBackend chr_out;
@@ -897,6 +898,21 @@ static void compare_set_vnet_hdr(Object *obj,
     s->vnet_hdr = value;
 }
 
+static char *compare_get_notify_dev(Object *obj, Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    return g_strdup(s->notify_dev);
+}
+
+static void compare_set_notify_dev(Object *obj, const char *value, Error **errp)
+{
+    CompareState *s = COLO_COMPARE(obj);
+
+    g_free(s->notify_dev);
+    s->notify_dev = g_strdup(value);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s = container_of(pri_rs, CompareState, pri_rs);
@@ -1057,6 +1073,10 @@ static void colo_compare_init(Object *obj)
                             (Object **)&s->iothread,
                             object_property_allow_set_link,
                             OBJ_PROP_LINK_STRONG, NULL);
+    /* This parameter just for Xen COLO */
+    object_property_add_str(obj, "notify_dev",
+                            compare_get_notify_dev, compare_set_notify_dev,
+                            NULL);
 
     s->vnet_hdr = false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr,
@@ -1103,6 +1123,7 @@ static void colo_compare_finalize(Object *obj)
     g_free(s->pri_indev);
     g_free(s->sec_indev);
     g_free(s->outdev);
+    g_free(s->notify_dev);
 }
 
 static const TypeInfo colo_compare_info = {
diff --git a/qemu-options.hx b/qemu-options.hx
index 0d8beb4afd..c18b79099a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4477,7 +4477,7 @@ Dump the network traffic on netdev @var{dev} to the file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
-@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support]
+@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support][,notify_dev=@var{id}]
 
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
 secondary packet. If the packets are same, we will output primary
@@ -4486,11 +4486,15 @@ do checkpoint and send primary packet to outdev@var{chardevid}.
 In order to improve efficiency, we need to put the task of comparison
 in another thread. If it has the vnet_hdr_support flag, colo compare
 will send/recv packet with vnet_hdr_len.
+If you want to use Xen COLO, will need the notify_dev to notify Xen
+colo-frame to do checkpoint.
 
 we must use it with the help of filter-mirror and filter-redirector.
 
 @example
 
+KVM COLO
+
 primary:
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
 -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
@@ -4514,6 +4518,33 @@ secondary:
 -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
 -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
 
+
+Xen COLO
+
+primary:
+-netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
+-device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
+-chardev socket,id=mirror0,host=3.3.3.3,port=9003,server,nowait
+-chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait
+-chardev socket,id=compare0,host=3.3.3.3,port=9001,server,nowait
+-chardev socket,id=compare0-0,host=3.3.3.3,port=9001
+-chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
+-chardev socket,id=compare_out0,host=3.3.3.3,port=9005
+-chardev socket,id=notify_way,host=3.3.3.3,port=9009,server,nowait
+-object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
+-object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
+-object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
+-object iothread,id=iothread1
+-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,notify_dev=nofity_way,iothread=iothread1
+
+secondary:
+-netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+-device e1000,netdev=hn0,mac=52:a4:00:12:78:66
+-chardev socket,id=red0,host=3.3.3.3,port=9003
+-chardev socket,id=red1,host=3.3.3.3,port=9004
+-object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
+-object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
+
 @end example
 
 If you want to know the detail of above command line, you can read
-- 
2.17.GIT


