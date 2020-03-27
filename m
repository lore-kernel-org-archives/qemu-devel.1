Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4094820675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZyarX6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4094820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmzS-0005yC-D7
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwh-0001FA-3M
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwf-00027r-OA
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwf-00026Z-Jr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMenIUGdDmBnzKf4+9eU1fy5NRzIpPIs/nd9clirI9A=;
 b=SZyarX6oU0bz0JxoE+hOcKoL/ERZF1zgJY/CMwDiH6zF80y2X+n5QpigxUBy0RT5xqGNn4
 vSqAI4hmKL4sAERR22nnmHRtv/lTFTAyK1eq2QnZweFXcvKnUhlvchgmGhlAgj9veiV2TV
 dxfk2MmpiPcvGW2wkoQeGBmT1VH/wqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-h2k1udPwMdyiFdT7T0jyfQ-1; Fri, 27 Mar 2020 07:14:35 -0400
X-MC-Unique: h2k1udPwMdyiFdT7T0jyfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A94D107ACC4;
 Fri, 27 Mar 2020 11:14:33 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B7F25E01F;
 Fri, 27 Mar 2020 11:14:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 10/13] net/colo-compare.c: Expose "compare_timeout" to users
Date: Fri, 27 Mar 2020 19:14:04 +0800
Message-Id: <1585307647-24456-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
References: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

The "compare_timeout" determines the maximum time to hold the primary net p=
acket.
This patch expose the "compare_timeout", make user have ability to
adjest the value according to application scenarios.

QMP command demo:
    { "execute": "qom-get",
         "arguments": { "path": "/objects/comp0",
                        "property": "compare_timeout" } }

    { "execute": "qom-set",
         "arguments": { "path": "/objects/comp0",
                        "property": "compare_timeout",
                        "value": 5000} }

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx    |  8 +++++---
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ee17f2..ec09b2a 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -50,6 +50,7 @@ static NotifierList colo_compare_notifiers =3D
=20
 /* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
+#define DEFAULT_TIME_OUT_MS 3000
=20
 static QemuMutex event_mtx;
 static QemuCond event_complete_cond;
@@ -92,6 +93,7 @@ typedef struct CompareState {
     SocketReadState sec_rs;
     SocketReadState notify_rs;
     bool vnet_hdr;
+    uint32_t compare_timeout;
=20
     /*
      * Record the connection that through the NIC
@@ -607,10 +609,9 @@ static int colo_old_packet_check_one_conn(Connection *=
conn,
                                           CompareState *s)
 {
     GList *result =3D NULL;
-    int64_t check_time =3D REGULAR_PACKET_CHECK_MS;
=20
     result =3D g_queue_find_custom(&conn->primary_list,
-                                 &check_time,
+                                 &s->compare_timeout,
                                  (GCompareFunc)colo_old_packet_check_one);
=20
     if (result) {
@@ -984,6 +985,39 @@ static void compare_set_notify_dev(Object *obj, const =
char *value, Error **errp)
     s->notify_dev =3D g_strdup(value);
 }
=20
+static void compare_get_timeout(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
+{
+    CompareState *s =3D COLO_COMPARE(obj);
+    uint32_t value =3D s->compare_timeout;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void compare_set_timeout(Object *obj, Visitor *v,
+                                const char *name, void *opaque,
+                                Error **errp)
+{
+    CompareState *s =3D COLO_COMPARE(obj);
+    Error *local_err =3D NULL;
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    if (!value) {
+        error_setg(&local_err, "Property '%s.%s' requires a positive value=
",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    s->compare_timeout =3D value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
@@ -1090,6 +1124,11 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
         return;
     }
=20
+    if (!s->compare_timeout) {
+        /* Set default value to 3000 MS */
+        s->compare_timeout =3D DEFAULT_TIME_OUT_MS;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1185,6 +1224,10 @@ static void colo_compare_init(Object *obj)
                             compare_get_notify_dev, compare_set_notify_dev=
,
                             NULL);
=20
+    object_property_add(obj, "compare_timeout", "uint32",
+                        compare_get_timeout,
+                        compare_set_timeout, NULL, NULL, NULL);
+
     s->vnet_hdr =3D false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr=
,
                              compare_set_vnet_hdr, NULL);
diff --git a/qemu-options.hx b/qemu-options.hx
index 962a5eb..9e48e13 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4615,7 +4615,7 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
=20
-    ``-object colo-compare,id=3Did,primary_in=3Dchardevid,secondary_in=3Dc=
hardevid,outdev=3Dchardevid,iothread=3Did[,vnet_hdr_support][,notify_dev=3D=
id]``
+    ``-object colo-compare,id=3Did,primary_in=3Dchardevid,secondary_in=3Dc=
hardevid,outdev=3Dchardevid,iothread=3Did[,vnet_hdr_support][,notify_dev=3D=
id][,compare_timeout=3D@var{ms}]``
         Colo-compare gets packet from primary\_inchardevid and
         secondary\_inchardevid, than compare primary packet with
         secondary packet. If the packets are same, we will output
@@ -4624,8 +4624,10 @@ SRST
         outdevchardevid. In order to improve efficiency, we need to put
         the task of comparison in another thread. If it has the
         vnet\_hdr\_support flag, colo compare will send/recv packet with
-        vnet\_hdr\_len. If you want to use Xen COLO, will need the
-        notify\_dev to notify Xen colo-frame to do checkpoint.
+        vnet\_hdr\_len. Then compare\_timeout=3D@var{ms} determines the
+        maximum delay colo-compare wait for the packet.
+        If you want to use Xen COLO, will need the notify\_dev to
+        notify Xen colo-frame to do checkpoint.
=20
         we must use it with the help of filter-mirror and
         filter-redirector.
--=20
2.5.0


