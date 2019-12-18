Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4884C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D2D2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExV/UGWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D2D2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUd5-0006in-2e
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUWU-0005zL-Ta
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUWT-0002V6-9u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUWS-0002S2-Kd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576657050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hO1UqZ0b1j8GIVSL9nVspdQXE4+Gtfy7HuRA1Jix1s=;
 b=ExV/UGWOPB++3MZ86Fu17MHFV34azC8uHmqn5HkOrhetfwZKqXPI78lEGBXsYGmU1S81Fm
 hH4EhYTYF8eTSfQyJu/5h2DDCXD26sKakfEizJfGhu+ag4OXG+yn/nZm7pTehEC3rRKFRD
 Hv2sKNu7HO6ROSkB5XFjg/PwHWCtEMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-BYfbTMKmMIyWbK3t4RbXPQ-1; Wed, 18 Dec 2019 03:17:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D242DDB21
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6A65C545;
 Wed, 18 Dec 2019 08:17:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BA1D11384D8; Wed, 18 Dec 2019 09:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/35] memory-device: Fix memory pre-plug error API
 violations
Date: Wed, 18 Dec 2019 09:16:57 +0100
Message-Id: <20191218081721.23520-12-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
References: <20191218081721.23520-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BYfbTMKmMIyWbK3t4RbXPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_device_get_free_addr() dereferences @errp when
memory_device_check_addable() fails.  That's wrong; see the big
comment in error.h.  Introduced in commit 1b6d6af21b "pc-dimm: factor
out capacity and slot checks into MemoryDevice".

No caller actually passes null.

Fix anyway: splice in a local Error *err, and error_propagate().

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191204093625.14836-11-armbru@redhat.com>
---
 hw/mem/memory-device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index aef148c1d7..4bc9cf0917 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -99,6 +99,7 @@ static uint64_t memory_device_get_free_addr(MachineState =
*ms,
                                             uint64_t align, uint64_t size,
                                             Error **errp)
 {
+    Error *err =3D NULL;
     GSList *list =3D NULL, *item;
     Range as, new =3D range_empty;
=20
@@ -123,8 +124,9 @@ static uint64_t memory_device_get_free_addr(MachineStat=
e *ms,
         return 0;
     }
=20
-    memory_device_check_addable(ms, size, errp);
-    if (*errp) {
+    memory_device_check_addable(ms, size, &err);
+    if (err) {
+        error_propagate(errp, err);
         return 0;
     }
=20
--=20
2.21.0


