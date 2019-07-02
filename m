Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE209C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61C821841
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61C821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiABU-0000Xy-Tm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aR-00058O-Rr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aQ-0003kM-Gc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aQ-0003jz-7q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AE7630BBE9B;
 Tue,  2 Jul 2019 02:32:01 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC67868405;
 Tue,  2 Jul 2019 02:31:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:25 +0800
Message-Id: <1562034689-6539-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 02 Jul 2019 02:32:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/17] COLO-compare: Add new parameter to
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

We add the "notify_dev=chardevID" parameter. After that colo-compare can connect with
remote(currently just for Xen, KVM-COLO didn't need it.) colo-frame through chardev socket,
it can notify remote(Xen) colo-frame to handle checkpoint event.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 21 +++++++++++++++++++++
 qemu-options.hx    | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 103297b..10fae2b 100644
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
index 0d8beb4..c18b790 100644
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
2.5.0


