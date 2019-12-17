Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5243C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05FF21739
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDegCd5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05FF21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6Qf-0001AE-5x
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jx-0000iM-9G
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jv-0000wr-VO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jv-0000tJ-Ro
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hO1UqZ0b1j8GIVSL9nVspdQXE4+Gtfy7HuRA1Jix1s=;
 b=FDegCd5SiOqnTHlqYLMbDXWBmiGKHE6WWLPIDOXFkFVsWrzyPOMtxM9hRNgXu1ggp28zrd
 G2AvLWWUD/knxGhKOdr+uwdghUerSzze4SockXsadS1szQfyYmYE6vFdewNtLAkBtwKBG4
 NdbhEpqnKOd2DaG5f2pQPi0zbDqtILo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ejzsBx3GP-OehbjnzVHqXg-1; Tue, 17 Dec 2019 01:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1FFF1883520
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:26:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EEC75D9C9;
 Tue, 17 Dec 2019 06:26:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6851611384D8; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/34] memory-device: Fix memory pre-plug error API violations
Date: Tue, 17 Dec 2019 07:26:28 +0100
Message-Id: <20191217062651.9687-12-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ejzsBx3GP-OehbjnzVHqXg-1
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


