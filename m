Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E321EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE26214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="m5NrBCNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE26214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuePO-00048G-0W
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXk-0005gC-Rf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXi-0003yc-Es
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:29:07 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:56820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iucXi-0003kj-5o; Thu, 23 Jan 2020 08:29:06 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id 9E46C96F5A;
 Thu, 23 Jan 2020 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579786124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A200JO54MkQoOmODnSQmBmwrO6FBHxiDZCez46fi7Ok=;
 b=m5NrBCNEOPYboPL4ZNKFvkInfbejDwCEnlOBu6lAfp0x3smJeyzS3ECzAejivgF4zpPRUl
 SSZlYneYssEw0LBCyKNgL9TqqYdPEj88N1i+HyooIzDwXkIXo3BOIzBF0RQCMJZAX5c6qX
 N3FabL5u5BT8PqWsh9iMkqROBx+WGvU=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/11] hw/s390x/ipl: replace deprecated qdev_reset_all
 registration
Date: Thu, 23 Jan 2020 14:28:23 +0100
Message-Id: <20200123132823.1117486-12-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123132823.1117486-1-damien.hedde@greensocs.com>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579786124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A200JO54MkQoOmODnSQmBmwrO6FBHxiDZCez46fi7Ok=;
 b=UEph34ehJKqhpqAm/A5rjlwQZIaXF5pf54BsudBTnF7IMGYzUi6ioqk/bV0yH+uStZE5In
 ZzjLiT36WsiC9MwESQ4a804xagLEidOBZdX1lPgg7raHGLHUM3zDvCYY0RCpnU4vECx1LE
 rywsP36UzhSDZea8umA8Ng/5sJiEoWM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579786124; a=rsa-sha256; cv=none;
 b=zt8PNBNLnpL9ca+KAPMUPOtAA5Hd0tyR5FaYGeXaVs4p/Zua2kY5XIvv7SqpEZ1ghkapTR
 vHhwWmLMHcfTIYjgdn4CXf8zVNFaUqSLNzRHyXUIAmOhgiagvErU/Xnqt0Kkk2Kf2o/oLW
 ZNfSX4bLHusQoe9xAxeHzNq6shCesoU=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace deprecated qdev_reset_all by resettable_cold_reset_fn for
the ipl registration in the main reset handlers.

This does not impact the behavior for the following reasons:
+ at this point resettable just call the old reset methods of devices
  and buses in the same order than qdev/qbus.
+ resettable handlers registered with qemu_register_reset are
  serialized; there is no interleaving.
+ eventual explicit calls to legacy reset API (device_reset or
  qdev/qbus_reset) inside this reset handler will not be masked out
  by resettable mechanism; they do not go through resettable api.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ca544d64c5..2689f7a017 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -237,7 +237,15 @@ static void s390_ipl_realize(DeviceState *dev, Error=
 **errp)
      */
     ipl->compat_start_addr =3D ipl->start_addr;
     ipl->compat_bios_start_addr =3D ipl->bios_start_addr;
-    qemu_register_reset(qdev_reset_all_fn, dev);
+    /*
+     * Because this Device is not on any bus in the qbus tree (it is
+     * not a sysbus device and it's not on some other bus like a PCI
+     * bus) it will not be automatically reset by the 'reset the
+     * sysbus' hook registered by vl.c like most devices. So we must
+     * manually register a reset hook for it.
+     * TODO: there should be a better way to do this.
+     */
+    qemu_register_reset(resettable_cold_reset_fn, dev);
 error:
     error_propagate(errp, err);
 }
--=20
2.24.1


