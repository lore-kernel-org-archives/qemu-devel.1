Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DDAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EE820716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il60KtVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EE820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44685 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlYu-0004W4-9C
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwlXv-0003r9-3r
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwlXt-0006QN-2k
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:30:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41387
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwlXs-0006NI-Vm
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580297406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9vA2Gw92gXfzqmk4aDzT/TiikK1Fjy6BnvJ6wVpHazo=;
 b=Il60KtVte2UyiPhUfs6x2XFK+8qViUTUG3hCbKRIftZda2cra72H7YyKiPTvotl7lEOdy+
 +E9IU6Lz5lfedBwflY8oV4ie8F1CqtT6K6knOTk79HJK6iLHU948e4vWyh3zoX9D0qVSX6
 85PVIGAreiFoX1OzREvHnpkTQsRYtGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-U284RoYDOfmVICkyz6tWhA-1; Wed, 29 Jan 2020 06:30:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB5D31800D41;
 Wed, 29 Jan 2020 11:30:01 +0000 (UTC)
Received: from thuth.com (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5563687041;
 Wed, 29 Jan 2020 11:29:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S . Tsirkin " <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] hw/i386/vmmouse: Fix crash when using the vmmouse on a
 machine without vmport
Date: Wed, 29 Jan 2020 12:29:54 +0100
Message-Id: <20200129112954.4282-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: U284RoYDOfmVICkyz6tWhA-1
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU currently crashes when the user tries to use the "vmmouse" on a
machine without vmport, e.g.:

 $ x86_64-softmmu/qemu-system-x86_64 -machine microvm -device vmmouse
 Segmentation fault (core dumped)

or:

 $ x86_64-softmmu/qemu-system-x86_64 -device vmmouse -M pc,vmport=3Doff
 Segmentation fault (core dumped)

Let's avoid the crash by checking for the vmport device first.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/vmmouse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 7c2a375527..e8e62bd96b 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
@@ -269,6 +270,11 @@ static void vmmouse_realizefn(DeviceState *dev, Error =
**errp)
=20
     DPRINTF("vmmouse_init\n");
=20
+    if (!object_resolve_path_type("", TYPE_VMPORT, NULL)) {
+        error_setg(errp, "vmmouse needs a machine with vmport");
+        return;
+    }
+
     vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
     vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
     vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
--=20
2.18.1


