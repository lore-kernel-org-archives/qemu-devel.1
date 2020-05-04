Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BF320752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv+JBYKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BF320752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcGI-0007fh-3H
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVcFH-0005x1-KP
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:38:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVcFG-0003LH-3u
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588603136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H6YrDImHZnPxnhU2Gnx1G1rCpKwVZdPNBfoXlIT6i8g=;
 b=gv+JBYKHahHJfEYrBUnNAfZ6ss2AAc+0qGHDBBFhCHHnnwgpugLRIIRl8CRNr4uP/VlXpJ
 XQjC3KO9WdYcRkn7cs4zCbN+VSUxZ5NXCmrSE+3A3VXc7iZf/7bPJ49MRzAyLM+jPNlsWi
 M/xNKjp02UsMa+P4ruWhsREADMB7ogA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Av9AdGBlOyqRk-eXXJ0kCA-1; Mon, 04 May 2020 10:38:55 -0400
X-MC-Unique: Av9AdGBlOyqRk-eXXJ0kCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2574A8014D5
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 14:38:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E76465D9D5;
 Mon,  4 May 2020 14:38:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7973E11358BC; Mon,  4 May 2020 16:38:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
Date: Mon, 04 May 2020 16:38:52 +0200
Message-ID: <87tv0vzrwj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I stumbled over this while working on a feature branch.  Instead of
throwing the whole branch at you as a reproducer, I give you a mock up.

This is fdctrl_connect_drives():

        dev =3D qdev_create(&fdctrl->bus.bus, "floppy");
        qdev_prop_set_uint32(dev, "unit", i);
        qdev_prop_set_enum(dev, "drive-type", fdctrl->qdev_for_drives[i].ty=
pe);

        blk_ref(blk);
        blk_detach_dev(blk, fdc_dev);
        fdctrl->qdev_for_drives[i].blk =3D NULL;
        qdev_prop_set_drive(dev, "drive", blk, &local_err);
        blk_unref(blk);

        if (local_err) {
            error_propagate(errp, local_err);
            return;
        }

        object_property_set_bool(OBJECT(dev), true, "realized", &local_err)=
;
        if (local_err) {
            error_propagate(errp, local_err);
            return;
        }

What if qdev_prop_set_drive() fails?  I don't have a reproducer ready (I
do on my feature branch), so let's mock it, and also instrument the
place where things go wrong.  Patch appended.  To try it, run
qemu-system-x86_64 without arguments.

Turns out the failure bubbles up into device_set_realized() for the
isa-fdc, where the cleanup code calls object_unparent().  This unparents
children, and ends up in bus_unparent() for the isa-fdc's floppy-bus:

    #4  0x0000555555abdb7f in bus_unparent (obj=3D0x55555675a9f0)
        at /work/armbru/qemu/hw/core/bus.c:148
    #5  0x0000555555d2aea6 in object_finalize_child_property
        (obj=3D0x55555675a800, name=3D0x555557281230 "floppy-bus.0", opaque=
=3D0x55555675a9f0) at /work/armbru/qemu/qom/object.c:1672
    #6  0x0000555555d2872b in object_property_del_child
        (obj=3D0x55555675a800, child=3D0x55555675a9f0, errp=3D0x0)
        at /work/armbru/qemu/qom/object.c:628
    #7  0x0000555555d2880b in object_unparent (obj=3D0x55555675a9f0)
        at /work/armbru/qemu/qom/object.c:647
    #8  0x0000555555ab9e10 in device_unparent (obj=3D0x55555675a800)
        at /work/armbru/qemu/hw/core/qdev.c:1101

This loop there

    while ((kid =3D QTAILQ_FIRST(&bus->children)) !=3D NULL) {
        DeviceState *dev =3D kid->child;
        object_unparent(OBJECT(dev));
    }

makes no progreess because OBJECT(dev)->parent is still null, and
therefore object_unparent() does nothing.

Possible culprit: qdev_try_create() calls qdev_set_parent_bus(), which
adds the device to the bus, but leaves ->parent null.  If this isn't
wrong outright, it's at least a dangerous state.

Work-around: call qdev_set_id(dev, NULL) right after qdev_create().
This sets ->parent.


From 2554db096866138a85482d683e57a38166bb425b Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 4 May 2020 15:58:10 +0200
Subject: [PATCH] qdev: Hack to reproduce infinite loop in bus_unparent()

---
 hw/block/fdc.c | 4 ++++
 hw/core/bus.c  | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 9628cc171e..f57558eea4 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2523,7 +2523,11 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, De=
viceState *fdc_dev,
         blk_ref(blk);
         blk_detach_dev(blk, fdc_dev);
         fdctrl->qdev_for_drives[i].blk =3D NULL;
+#if 0
         qdev_prop_set_drive(dev, "drive", blk, &local_err);
+#else
+        error_setg(&local_err, "hack");
+#endif
         blk_unref(blk);
=20
         if (local_err) {
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 3dc0a825f0..3620a7be54 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -135,12 +135,17 @@ static void bus_unparent(Object *obj)
     BusState *bus =3D BUS(obj);
     BusChild *kid;
=20
+    printf("### %s bus=3D%p %s\n",
+           __func__, obj, object_get_typename(obj));
     /* Only the main system bus has no parent, and that bus is never freed=
 */
     assert(bus->parent);
=20
     while ((kid =3D QTAILQ_FIRST(&bus->children)) !=3D NULL) {
         DeviceState *dev =3D kid->child;
+        printf("### %s kid=3D%p %s\n",
+               __func__, OBJECT(dev), object_get_typename(OBJECT(dev)));
         object_unparent(OBJECT(dev));
+        assert(kid !=3D QTAILQ_FIRST(&bus->children));
     }
     QLIST_REMOVE(bus, sibling);
     bus->parent->num_child_bus--;
--=20
2.21.1


