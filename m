Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604BFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFD020776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL9M+sYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFD020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVR3-0002X5-0p
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdVQV-00025K-PW
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:59:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34556
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdVQU-0005Gp-Rj
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590483549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z9lWCbcCVDqv0hzZUrx0pg1ZlESurs6AsvZJ4Eqjf2E=;
 b=BL9M+sYX8Nly9+lxiM3jrZYxVdTo0QBY1CnVYuhe60b2Ku3NIw0A5bGM2bBxgyJgK8pZo+
 0pp5LRrQAvf7y8p0xHLLjLuxERYWd+ji+TuA6FeDopPBFRFtANJfhZpe5y7UVvJYzFf4pw
 +3/rG+R9j767FrNjEbP5unVT9Y0vEbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-TkKTXq4BNXyptlxteb15vA-1; Tue, 26 May 2020 04:59:07 -0400
X-MC-Unique: TkKTXq4BNXyptlxteb15vA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DC5107ACF4;
 Tue, 26 May 2020 08:59:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C164D10013DB;
 Tue, 26 May 2020 08:59:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47322113864A; Tue, 26 May 2020 10:59:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 50/55] s390x/event-facility: Simplify creation of SCLP
 event devices
References: <5c6028bd-0bab-6c78-90fe-f00e23ab71b9@redhat.com>
 <03AEEA41-0543-4097-8FFB-9E41038F31EE@redhat.com>
 <87k110fqgl.fsf@dusky.pond.sub.org>
 <1c4c75af-a02b-e86f-23b3-a047809988bb@redhat.com>
 <87o8qb9po2.fsf@dusky.pond.sub.org>
 <f956d514-b051-04ac-f555-4deb6065cc1c@redhat.com>
Date: Tue, 26 May 2020 10:59:02 +0200
In-Reply-To: <f956d514-b051-04ac-f555-4deb6065cc1c@redhat.com> (Paolo
 Bonzini's message of "Tue, 26 May 2020 09:51:57 +0200")
Message-ID: <87v9kj3wdl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/05/20 08:27, Markus Armbruster wrote:
>>> It cannot happen, because a device must be unparented before it's
>>> destroyed and unparenting takes care of unrealizing the device.
>> 
>> I can't see where unparenting takes care of unrealizing.  Can you help
>> me?
>
> Hidden in plain sight:
>
> static void device_unparent(Object *obj)
> {
>     DeviceState *dev = DEVICE(obj);
>     BusState *bus;
>
>     if (dev->realized) {
>         object_property_set_bool(obj, false, "realized", NULL);
>     }
>     ...
> }
>
> and the call stack is object_unparent -> object_property_del_child ->
> object_finalize_child_property (via prop->release) -> class->unparent.

Aha.

My attempt to trigger automatic unrealize of a child device after the
parent device's realize failed was unsuccessful.  I tried with
pci-serial-2x, hacked up to make it fail as if the second child's
realize failed, and hacked up some more to make it rely on automatic
unrealize.  No dice:

    $ qemu-system-x86_64 -S -nodefaults -display none -monitor stdio
    QEMU 5.0.50 monitor - type 'help' for more information
    (qemu) device_add pci-serial-2x
    ### serial_realize
    Error: mock error
    (qemu) q

Even though it doesn't really matter here, as David pointed out, it's
something I'd like to understand.


diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 5f9ccfcc93..433b5caefc 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -56,7 +56,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
 
     for (i = 0; i < pci->ports; i++) {
         s = pci->state + i;
-        object_property_set_bool(OBJECT(s), false, "realized", &error_abort);
+//        object_property_set_bool(OBJECT(s), false, "realized", &error_abort);
         memory_region_del_subregion(&pci->iobar, &s->io);
         g_free(pci->name[i]);
     }
@@ -106,6 +106,9 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
+        if (i)
+            error_setg(errp, "mock error");
+        else
         object_property_set_bool(OBJECT(s), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 7d74694587..55b0bbd8b0 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -938,6 +938,8 @@ static void serial_realize(DeviceState *dev, Error **errp)
 {
     SerialState *s = SERIAL(dev);
 
+    printf("### %s\n", __func__);
+
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
@@ -954,6 +956,8 @@ static void serial_unrealize(DeviceState *dev)
 {
     SerialState *s = SERIAL(dev);
 
+    printf("### %s\n", __func__);
+
     qemu_chr_fe_deinit(&s->chr, false);
 
     timer_del(s->modem_status_poll);


