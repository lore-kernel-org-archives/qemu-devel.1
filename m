Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8AEC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FC72075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 07:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgVpOMfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FC72075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRsXj-0002jl-Aw
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 03:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRsVA-0006lB-V6
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRsV9-0001uQ-Mo
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:11:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRsV9-0001pT-AL
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 03:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587712314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQgMBQRmuraJ/Icikr6Y+eYuQvvDnaok6SjPFKfQgiE=;
 b=SgVpOMfRwkzJFt4JqN5wIMHWrjBiCKDMJkbzwWNhukyGqqzIajkKUwxx4KICYVwDBDVslk
 qbLkO2/28Fy1Rpaux3lr0jRBZamvHMhL+qzAU7CVRNnVBlP/BDuj3dQz+SIs0OxytsQmm+
 NjAcqDNbc2KsAkONr1Gf2dVOW4waFy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-3WFO5xvHMGSVgbDhrpqfvg-1; Fri, 24 Apr 2020 03:11:50 -0400
X-MC-Unique: 3WFO5xvHMGSVgbDhrpqfvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFF64800580;
 Fri, 24 Apr 2020 07:11:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96218100238A;
 Fri, 24 Apr 2020 07:11:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D7A011358BF; Fri, 24 Apr 2020 09:11:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] libqos: Give get_machine_allocator() internal linkage
Date: Fri, 24 Apr 2020 09:11:42 +0200
Message-Id: <20200424071142.3525-4-armbru@redhat.com>
In-Reply-To: <20200424071142.3525-1-armbru@redhat.com>
References: <20200424071142.3525-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: lvivier@redhat.com, thuth@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/libqos/qos_external.h | 2 --
 tests/qtest/libqos/qos_external.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_ext=
ernal.h
index f63388cb30..72d7f91707 100644
--- a/tests/qtest/libqos/qos_external.h
+++ b/tests/qtest/libqos/qos_external.h
@@ -18,7 +18,6 @@
=20
 #ifndef QOS_EXTERNAL_H
 #define QOS_EXTERNAL_H
-#include "libqos/qgraph.h"
=20
 #include "libqos/malloc.h"
 #include "qapi/qapi-types-machine.h"
@@ -26,7 +25,6 @@
=20
 void machines_apply_to_node(MachineInfoList *mach_info);
 void types_apply_to_node(ObjectTypeInfoList *type_info);
-QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
 void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **p_a=
lloc);
=20
 #endif
diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_ext=
ernal.c
index c707dac3b9..9f5180e18d 100644
--- a/tests/qtest/libqos/qos_external.c
+++ b/tests/qtest/libqos/qos_external.c
@@ -66,7 +66,7 @@ void types_apply_to_node(ObjectTypeInfoList *type_info)
     }
 }
=20
-QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
+static QGuestAllocator *get_machine_allocator(QOSGraphObject *obj)
 {
     return obj->get_driver(obj, "memory");
 }
--=20
2.21.1


