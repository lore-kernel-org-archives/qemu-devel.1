Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69149C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3398320675
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIzOuQ/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3398320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHn3b-0003py-8e
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jHmwk-0001Ne-HC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jHmwj-0002Ge-53
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jHmwj-0002D6-0n
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585307679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MxJPowySKOhY+nUVAcYVxWerfqWXbqkq59mtjxRxZg=;
 b=ZIzOuQ/3b1zLFXq1mmsE09CT6N4umQs+AgEbTf4Zi7lLHBMB6Ktwfg5Amzc9rQB4mMbYDl
 I4ddd4GHH1TfSHVw1shchJsHboCiwOvnMyDj2VWm/AaoCX2TXTyuMhiC12vUG+XEu9uxrp
 VqrSyVTKqkVThjUqFqwQHnOYUoY0Hhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-6EBbNfLNPoWJGN2TObTrwQ-1; Fri, 27 Mar 2020 07:14:37 -0400
X-MC-Unique: 6EBbNfLNPoWJGN2TObTrwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EEF8189F760;
 Fri, 27 Mar 2020 11:14:36 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-77.pek2.redhat.com
 [10.72.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 994065E036;
 Fri, 27 Mar 2020 11:14:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 11/13] net/colo-compare.c: Expose "expired_scan_cycle" to users
Date: Fri, 27 Mar 2020 19:14:05 +0800
Message-Id: <1585307647-24456-12-git-send-email-jasowang@redhat.com>
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


