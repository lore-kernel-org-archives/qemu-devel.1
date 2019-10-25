Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56BECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F51E2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAd3IU88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F51E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyd7-0000rg-1I
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNyZu-0004L7-IW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNyZs-00077q-Qh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:20:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNyZs-00074p-Ge
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572006018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UtOlxxLC9wr8ci9nAuNj1V+Awze+pNkUfnE+5Efp9bk=;
 b=IAd3IU880iw6KVMzsPBTyept2cFW4c9Jgkc5LbKct0IjyxlvXerEWQwOUI82jsGfki5+lI
 Smybh/+z6skIxOoBgEd9Iieal6Zpqc48Pjdd2lk2DSqx8xYtiF+xmSQMITp69iaBY+Q4dV
 bSvFrvDc4NanQuniENPaIM2vOhl2uu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-p7P_iiXYPJKPxBH1Ux-mFw-1; Fri, 25 Oct 2019 08:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02C811800E00;
 Fri, 25 Oct 2019 12:20:13 +0000 (UTC)
Received: from localhost (ovpn-117-235.ams2.redhat.com [10.36.117.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB55917F85;
 Fri, 25 Oct 2019 12:19:58 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/11] pci: mark device having guest unplug request pending
Date: Fri, 25 Oct 2019 14:19:23 +0200
Message-Id: <20191025121930.6855-5-jfreimann@redhat.com>
In-Reply-To: <20191025121930.6855-1-jfreimann@redhat.com>
References: <20191025121930.6855-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: p7P_iiXYPJKPxBH1Ux-mFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, dgilbert@redhat.com,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set pending_deleted_event in DeviceState for failover
primary devices that were successfully unplugged by the Guest OS.

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/pci/pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 19363ff8ce..08718188bb 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -457,6 +457,7 @@ static void pcie_unplug_device(PCIBus *bus, PCIDevice *=
dev, void *opaque)
     HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(DEVICE(dev))=
;
=20
     if (dev->partially_hotplugged) {
+        dev->qdev.pending_deleted_event =3D false;
         return;
     }
     hotplug_handler_unplug(hotplug_ctrl, DEVICE(dev), &error_abort);
@@ -476,6 +477,8 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
         return;
     }
=20
+    dev->pending_deleted_event =3D true;
+
     /* In case user cancel the operation of multi-function hot-add,
      * remove the function that is unexposed to guest individually,
      * without interaction with guest.
--=20
2.21.0


