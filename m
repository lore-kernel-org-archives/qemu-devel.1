Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8C9C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EE0218FD
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 15:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EE0218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43329 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJJnW-0006Gm-F1
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 11:26:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJJkr-0004CI-91
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJJkp-0004Un-Sr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJJkp-0004TG-ME
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 11:24:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 062173148064;
	Wed, 24 Apr 2019 15:24:10 +0000 (UTC)
Received: from localhost (unknown [10.36.118.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97CC55D704;
	Wed, 24 Apr 2019 15:24:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 24 Apr 2019 16:24:01 +0100
Message-Id: <20190424152401.28304-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 24 Apr 2019 15:24:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] virtio: clarify VirtioPCIDeviceTypeInfo usage
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: sebastien.boeuf@intel.com, ehabkost@redhat.com,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424152401.FN3jAWEkmyjTndbA_2dCWCfTO63NusaLtM8u3zCLvnY@z>

How to use .base_name, .generic_name, .transitional_name, and
.non_transitional_name can be confusing.

Existing devices have .generic_name but its behavior is somewhat magic.

Devices added to new versions of the VIRTIO specification should forego
transitional mode completely and always operate in non-transitional mode
because there are no existing drivers for them that require backwards
compatibility.

This patch adds comments that hopefully make it easier for developers to
decide how to fill out VirtioPCIDeviceTypeInfo.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-pci.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 18581854ca..debdee28b3 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -209,7 +209,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
      * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONAL_=
PCI_DEVICE,
      * but PCI Express is supported only in non-transitional mode.
      *
-     * The only type implemented by QEMU 3.1 and older.
+     * The only type implemented by QEMU 3.1 and older.  This type is le=
ss
+     * explicit than the transitional and non-transitional device types.=
  Its
+     * behavior can be affected by machine type compat properties.
      */
     const char *generic_name;
     /*
@@ -222,6 +224,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
      * The non-transitional device type.  Optional.
      *
      * Implements INTERFACE_CONVENTIONAL_PCI_DEVICE only.
+     *
+     * New virtio device types should only define this and base_name, th=
ereby
+     * allowing only non-transitional mode.
      */
     const char *non_transitional_name;
=20
--=20
2.20.1


