Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A75820801
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrO/dgaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A75820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitio-0006Ni-D3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMb-0005ad-JC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMI-0003wU-Ay
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOUMUrmnjDBD5zfjtG6TcbKhQI9VLK8rPdn8OpUkib4=;
 b=OrO/dgaz+EpVuwvEK7Cvg9hVDmxAX85+0o5mQg/jK0YtSuaTkUJRN/tEgIHXAWkWRfDvRY
 HyaKSmIeyyBCjiTZGR9LS/2pYDyG+fOoTgDdXAS3iXADF/lLTrKkEsS/O/jGvjqd6CNFke
 ajyPgq5WRqf4rW63UvoLM5bcvL5bJ2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-y84_1mVWPI-uUZWseEcYUQ-1; Wed, 10 Jun 2020 01:33:02 -0400
X-MC-Unique: y84_1mVWPI-uUZWseEcYUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3D18107BEF5;
 Wed, 10 Jun 2020 05:33:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C681A5C1D2;
 Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BE04113848B; Wed, 10 Jun 2020 07:32:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 53/58] s390x/event-facility: Simplify creation of
 SCLP event devices
Date: Wed, 10 Jun 2020 07:32:42 +0200
Message-Id: <20200610053247.1583243-54-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

init_event_facility() creates the SCLP events bus with two SCLP event
devices (sclpquiesce and sclp-cpu-hotplug).  It leaves the devices
unrealized.  A comment explains they will be realized "via the bus".

The bus's realize method sclp_events_bus_realize() indeed realizes all
unrealized devices on this bus.  It carries a TODO comment claiming
this "has to be done in common code".  No other bus realize method
realizes its devices.

The common code in question is bus_set_realized(), which has a TODO
comment asking for recursive realization.  It's been asking for years.

The only devices sclp_events_bus_realize() will ever realize are the
two init_event_facility() puts there.

Simplify as follows:

* Make the devices members of the event facility instance struct, just
  like the bus.  object_initialize_child() is simpler than
  object_property_add_child() and object_unref().

* Realize them in the event facility realize method.

This is in line with how such things are done elsewhere.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/s390x/event-facility.c | 64 ++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 35 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 97a4f0b1f5..164b1fd295 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -39,6 +39,7 @@ typedef struct SCLPEventsBus {
 struct SCLPEventFacility {
     SysBusDevice parent_obj;
     SCLPEventsBus sbus;
+    SCLPEvent quiesce, cpu_hotplug;
     /* guest's receive mask */
     union {
         uint32_t receive_mask_pieces[2];
@@ -328,34 +329,9 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
 
 #define TYPE_SCLP_EVENTS_BUS "s390-sclp-events-bus"
 
-static void sclp_events_bus_realize(BusState *bus, Error **errp)
-{
-    Error *err = NULL;
-    BusChild *kid;
-
-    /* TODO: recursive realization has to be done in common code */
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        DeviceState *dev = kid->child;
-
-        object_property_set_bool(OBJECT(dev), true, "realized", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
-    }
-}
-
-static void sclp_events_bus_class_init(ObjectClass *klass, void *data)
-{
-    BusClass *bc = BUS_CLASS(klass);
-
-    bc->realize = sclp_events_bus_realize;
-}
-
 static const TypeInfo sclp_events_bus_info = {
     .name = TYPE_SCLP_EVENTS_BUS,
     .parent = TYPE_BUS,
-    .class_init = sclp_events_bus_class_init,
 };
 
 static void command_handler(SCLPEventFacility *ef, SCCB *sccb, uint64_t code)
@@ -443,27 +419,44 @@ static void init_event_facility(Object *obj)
 {
     SCLPEventFacility *event_facility = EVENT_FACILITY(obj);
     DeviceState *sdev = DEVICE(obj);
-    Object *new;
 
     event_facility->mask_length = 4;
     event_facility->allow_all_mask_sizes = true;
     object_property_add_bool(obj, "allow_all_mask_sizes",
                              sclp_event_get_allow_all_mask_sizes,
                              sclp_event_set_allow_all_mask_sizes);
+
     /* Spawn a new bus for SCLP events */
     qbus_create_inplace(&event_facility->sbus, sizeof(event_facility->sbus),
                         TYPE_SCLP_EVENTS_BUS, sdev, NULL);
 
-    new = object_new(TYPE_SCLP_QUIESCE);
-    object_property_add_child(obj, TYPE_SCLP_QUIESCE, new);
-    object_unref(new);
-    qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
+    object_initialize_child(obj, TYPE_SCLP_QUIESCE,
+                            &event_facility->quiesce,
+                            TYPE_SCLP_QUIESCE);
 
-    new = object_new(TYPE_SCLP_CPU_HOTPLUG);
-    object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new);
-    object_unref(new);
-    qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
-    /* the facility will automatically realize the devices via the bus */
+    object_initialize_child(obj, TYPE_SCLP_CPU_HOTPLUG,
+                            &event_facility->cpu_hotplug,
+                            TYPE_SCLP_CPU_HOTPLUG);
+}
+
+static void realize_event_facility(DeviceState *dev, Error **errp)
+{
+    SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
+    Error *local_err = NULL;
+
+    qdev_realize(DEVICE(&event_facility->quiesce),
+                 BUS(&event_facility->sbus), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
+                 BUS(&event_facility->sbus), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        qdev_unrealize(DEVICE(&event_facility->quiesce));
+        return;
+    }
 }
 
 static void reset_event_facility(DeviceState *dev)
@@ -479,6 +472,7 @@ static void init_event_facility_class(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(sbdc);
     SCLPEventFacilityClass *k = EVENT_FACILITY_CLASS(dc);
 
+    dc->realize = realize_event_facility;
     dc->reset = reset_event_facility;
     dc->vmsd = &vmstate_event_facility;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.26.2


