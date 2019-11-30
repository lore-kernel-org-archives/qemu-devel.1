Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895D7C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 20:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5297B20715
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 20:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRRBV4WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5297B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8vK-0002Ox-2n
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 15:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ib8dx-0006ZU-DQ
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ib8dv-0005Dz-5F
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:43:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ib8du-0005An-U7
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 14:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575142976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6r20tme1c3K1oItK55VjhZNP4i1wewMOCLwqCimvoE=;
 b=PRRBV4WR4pKNXKfHpcYILi1xHZ8qSIi9QKplOISlVIeX++2h/uAvNzntPdlXHHHvmiujLq
 bcE60AZ1OlvglGJ1Ys+Uq/x8dN/TJS/uiaiwEg1vu1ZZpsnMxshCKMkfXJtQljZygmOs8u
 SxqP+2CbhLZyD0z0+WOPEmkvCHWRNM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-tflcyL6LMEmznqfwm4cVFg-1; Sat, 30 Nov 2019 14:42:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66772DB21;
 Sat, 30 Nov 2019 19:42:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 354586608A;
 Sat, 30 Nov 2019 19:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 487DE1135A70; Sat, 30 Nov 2019 20:42:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/21] hw/intc/s390: Simplify error handling in
 kvm_s390_flic_realize()
Date: Sat, 30 Nov 2019 20:42:39 +0100
Message-Id: <20191130194240.10517-21-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tflcyL6LMEmznqfwm4cVFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, vsementsov@virtuozzo.com,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/intc/s390_flic_kvm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 30d50c2369..dddd33ea61 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -586,16 +586,17 @@ static void kvm_s390_flic_realize(DeviceState *dev, E=
rror **errp)
=20
     KVM_S390_FLIC_GET_CLASS(dev)->parent_realize(dev, &err);
     if (err) {
-        goto fail;
+        error_propagate(errp, err);
+        return;
     }
     flic_state->fd =3D -1;
=20
     cd.type =3D KVM_DEV_TYPE_FLIC;
     ret =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
     if (ret < 0) {
-        error_setg_errno(&err, errno, "Creating the KVM device failed");
+        error_setg_errno(errp, errno, "Creating the KVM device failed");
         trace_flic_create_device(errno);
-        goto fail;
+        return;
     }
     flic_state->fd =3D cd.fd;
=20
@@ -603,9 +604,6 @@ static void kvm_s390_flic_realize(DeviceState *dev, Err=
or **errp)
     test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
     flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
                                             KVM_HAS_DEVICE_ATTR, test_attr=
);
-    return;
-fail:
-    error_propagate(errp, err);
 }
=20
 static void kvm_s390_flic_reset(DeviceState *dev)
--=20
2.21.0


