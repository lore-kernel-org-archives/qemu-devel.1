Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2BEC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42937205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIUmWShy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42937205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHFs-0001uC-Qc
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBl-00051Y-Ns
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBk-00021B-J3
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBk-0001yc-DZ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGqdvn7buDB8RghzPlzajbceMCPjK2kLFsrPx6rAyXU=;
 b=LIUmWShyEjWPk9/b5+H0sn0vO3vjbVS9mSyasE0gc9aAS8Zq8ZpAybRhKbNFIRT4f3ZfaL
 wR+cooDNFAAPUusxtBZMVKyUVJ/WkVyX+UtC4pWR/sQZGn/k9BP9VK+eo8cN0kDe5SNVN9
 9kYYRRGHTVeQ+rqwNFHvkW7CnUeT1sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-5cI-dhUGOGCyfWeoRCpxyA-1; Tue, 31 Dec 2019 08:03:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAAEDB64
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12DEC620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:52 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/86] machine: introduce ram-memdev property
Date: Tue, 31 Dec 2019 14:02:48 +0100
Message-Id: <1577797450-88458-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5cI-dhUGOGCyfWeoRCpxyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Property will contain link to memory backend that will be
used for backing initial RAM.
Follow up commit will alias -mem-path and -mem-prealloc
CLI options into memory backend options to make memory
handling consistent (using only hostmem backend family
for guest RAM allocation).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h | 2 ++
 hw/core/machine.c   | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 61f8bb8..8e2bf2b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -4,6 +4,7 @@
 #define HW_BOARDS_H
=20
 #include "exec/memory.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
 #include "qapi/qapi-types-machine.h"
@@ -288,6 +289,7 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
+    HostMemoryBackend *ram_memdev;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 73bf1f8..4a5cd0d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -847,6 +847,15 @@ static void machine_initfn(Object *obj)
         ms->numa_state =3D g_new0(NumaState, 1);
     }
=20
+    object_property_add_link(obj, "ram-memdev", TYPE_MEMORY_BACKEND,
+                             (Object **)&ms->ram_memdev,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_STRONG, &error_abort);
+    object_property_set_description(obj, "ram-memdev",
+                                    "Set RAM backend"
+                                    "Valid value is ID of hostmem based ba=
ckend",
+                                     &error_abort);
+
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
     qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);
--=20
2.7.4


