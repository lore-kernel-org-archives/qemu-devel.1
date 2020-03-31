Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9643020772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfJ6M8f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9643020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGtF-00059M-OD
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqT-0000aW-Uv
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqS-0005uN-Iz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqS-0005tb-EK
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MxJPowySKOhY+nUVAcYVxWerfqWXbqkq59mtjxRxZg=;
 b=DfJ6M8f/Dijtppd3BPfA5UjUfI2UwlSoKJfKHiDhtZl6VQR8ZoYyinHQ1wCRJLkZ00CCbq
 HfWctaCxG9bUVMukZJMAHMA/TFZSoSWMfxb9GoOv/+t75oj7mf+2qXhS5SyMZ7Ih3v5MYn
 IwdWc3Vw1BFlcjYvoetw3e+uiqE/ypc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-LvkfC5nXMOCUdW2IIYVysA-1; Tue, 31 Mar 2020 09:22:15 -0400
X-MC-Unique: LvkfC5nXMOCUdW2IIYVysA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E55618FF660;
 Tue, 31 Mar 2020 13:22:14 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD0A1001B28;
 Tue, 31 Mar 2020 13:22:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 11/14] net/colo-compare.c: Expose "expired_scan_cycle" to
 users
Date: Tue, 31 Mar 2020 21:21:36 +0800
Message-Id: <1585660899-11228-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The "expired_scan_cycle" determines period of scanning expired
primary node net packets.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 qemu-options.hx    |  4 +++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ec09b2a..10c0239 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -48,7 +48,6 @@ static NotifierList colo_compare_notifiers =3D
 #define COLO_COMPARE_FREE_PRIMARY     0x01
 #define COLO_COMPARE_FREE_SECONDARY   0x02
=20
-/* TODO: Should be configurable */
 #define REGULAR_PACKET_CHECK_MS 3000
 #define DEFAULT_TIME_OUT_MS 3000
=20
@@ -94,6 +93,7 @@ typedef struct CompareState {
     SocketReadState notify_rs;
     bool vnet_hdr;
     uint32_t compare_timeout;
+    uint32_t expired_scan_cycle;
=20
     /*
      * Record the connection that through the NIC
@@ -823,7 +823,7 @@ static void check_old_packet_regular(void *opaque)
     /* if have old packet we will notify checkpoint */
     colo_old_packet_check(s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)=
 +
-                REGULAR_PACKET_CHECK_MS);
+              s->expired_scan_cycle);
 }
=20
 /* Public API, Used for COLO frame to notify compare event */
@@ -853,7 +853,7 @@ static void colo_compare_timer_init(CompareState *s)
                                 SCALE_MS, check_old_packet_regular,
                                 s);
     timer_mod(s->packet_check_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL)=
 +
-                    REGULAR_PACKET_CHECK_MS);
+              s->expired_scan_cycle);
 }
=20
 static void colo_compare_timer_del(CompareState *s)
@@ -1018,6 +1018,39 @@ out:
     error_propagate(errp, local_err);
 }
=20
+static void compare_get_expired_scan_cycle(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
+{
+    CompareState *s =3D COLO_COMPARE(obj);
+    uint32_t value =3D s->expired_scan_cycle;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void compare_set_expired_scan_cycle(Object *obj, Visitor *v,
+                                           const char *name, void *opaque,
+                                           Error **errp)
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
+    s->expired_scan_cycle =3D value;
+
+out:
+    error_propagate(errp, local_err);
+}
+
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
 {
     CompareState *s =3D container_of(pri_rs, CompareState, pri_rs);
@@ -1129,6 +1162,11 @@ static void colo_compare_complete(UserCreatable *uc,=
 Error **errp)
         s->compare_timeout =3D DEFAULT_TIME_OUT_MS;
     }
=20
+    if (!s->expired_scan_cycle) {
+        /* Set default value to 3000 MS */
+        s->expired_scan_cycle =3D REGULAR_PACKET_CHECK_MS;
+    }
+
     if (find_and_check_chardev(&chr, s->pri_indev, errp) ||
         !qemu_chr_fe_init(&s->chr_pri_in, chr, errp)) {
         return;
@@ -1228,6 +1266,10 @@ static void colo_compare_init(Object *obj)
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL, NULL);
=20
+    object_property_add(obj, "expired_scan_cycle", "uint32",
+                        compare_get_expired_scan_cycle,
+                        compare_set_expired_scan_cycle, NULL, NULL, NULL);
+
     s->vnet_hdr =3D false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr=
,
                              compare_set_vnet_hdr, NULL);
diff --git a/qemu-options.hx b/qemu-options.hx
index 9e48e13..16debd0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4615,7 +4615,7 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
=20
-    ``-object colo-compare,id=3Did,primary_in=3Dchardevid,secondary_in=3Dc=
hardevid,outdev=3Dchardevid,iothread=3Did[,vnet_hdr_support][,notify_dev=3D=
id][,compare_timeout=3D@var{ms}]``
+    ``-object colo-compare,id=3Did,primary_in=3Dchardevid,secondary_in=3Dc=
hardevid,outdev=3Dchardevid,iothread=3Did[,vnet_hdr_support][,notify_dev=3D=
id][,compare_timeout=3D@var{ms}][,expired_scan_cycle=3D@var{ms}``
         Colo-compare gets packet from primary\_inchardevid and
         secondary\_inchardevid, than compare primary packet with
         secondary packet. If the packets are same, we will output
@@ -4626,6 +4626,8 @@ SRST
         vnet\_hdr\_support flag, colo compare will send/recv packet with
         vnet\_hdr\_len. Then compare\_timeout=3D@var{ms} determines the
         maximum delay colo-compare wait for the packet.
+        The expired\_scan\_cycle=3D@var{ms} to set the period of scanning
+        expired primary node network packets.
         If you want to use Xen COLO, will need the notify\_dev to
         notify Xen colo-frame to do checkpoint.
=20
--=20
2.5.0


