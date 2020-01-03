Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D7C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0147021734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 07:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV2cgMW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0147021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inHbu-0003o8-4R
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 02:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inHZm-0000U0-Pu
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1inHZk-0000Bt-Bg
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:40:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1inHZj-0000Am-VN
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 02:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578037251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RDsPGHVtFp+WeQ9UsInlf29HklykiZojApywSGS4Hs=;
 b=LV2cgMW1tnAQF0+SFhMiriGmww69D8//wf7NFhfxxhFmOlM11oyf5zW6J6+45EPPUOdpBr
 +nfuYNNdjFlpSNGHAdP7jkXJX0tFxI2nYUSAzNAJmLaPaL1rscv0TsqjFqAZSHkyeSCKHf
 Sa1GjEWKv60n7gU79DuHh0HnLs1bUD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-vKdZ6XIvO821G4_5dZ_HBQ-1; Fri, 03 Jan 2020 02:40:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52DD91801253;
 Fri,  3 Jan 2020 07:40:49 +0000 (UTC)
Received: from localhost (ovpn-112-30.ams2.redhat.com [10.36.112.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCC67D54C;
 Fri,  3 Jan 2020 07:40:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] savevm: check RAM is pagesize aligned
Date: Fri,  3 Jan 2020 11:40:00 +0400
Message-Id: <20200103074000.1006389-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
References: <20200103074000.1006389-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vKdZ6XIvO821G4_5dZ_HBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check the host pointer is correctly aligned, otherwise we may fail
during migration in ram_block_discard_range().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 migration/savevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index a71b930b91..bbb7e89682 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2910,6 +2910,11 @@ err_drain:
=20
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 {
+    RAMBlock *rb =3D mr->ram_block;
+
+    assert(QEMU_PTR_IS_ALIGNED(qemu_ram_get_host_addr(rb),
+                               qemu_ram_pagesize(rb)));
+
     qemu_ram_set_idstr(mr->ram_block,
                        memory_region_name(mr), dev);
     qemu_ram_set_migratable(mr->ram_block);
--=20
2.24.0.308.g228f53135a


