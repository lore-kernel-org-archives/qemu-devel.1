Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462E0C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118B420673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftPUYe1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118B420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwKG-0002os-2d
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwFb-0005bB-OI
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ipwFZ-0002IQ-Jg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ipwFZ-0002Fv-FU
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578670260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obMrkVtCtdPCwLwJLEkZRH18BrXhEH5BnwDxZkCY4C8=;
 b=ftPUYe1ABC78/vg1XS92GllAQBjSfCce0zqRnDNG39pGWuyShfhMY4fdZCrKZjT/lO0pd/
 n4FKnZX/5id/DdPw35Uv5No2DoeVZHqmxe/mgDPAXwSdRPMhQOpsvAjQL/tfeacv5YOJdQ
 ncBwPTbrNQiq7Ue5B/+yxL0tzn4q78g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-WL1GroHgOta28-96iRdZFg-1; Fri, 10 Jan 2020 10:30:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C531951296
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:30:58 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2602A7C3E9;
 Fri, 10 Jan 2020 15:30:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/26] object: add extra sanity checks
Date: Fri, 10 Jan 2020 19:30:14 +0400
Message-Id: <20200110153039.1379601-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WL1GroHgOta28-96iRdZFg-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Type system checked that children class_size >=3D parent class_size, but
not instances. Fix that.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/object.c b/qom/object.c
index 0d971ca897..8453e4ac91 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -303,6 +303,7 @@ static void type_initialize(TypeImpl *ti)
         int i;
=20
         g_assert(parent->class_size <=3D ti->class_size);
+        g_assert(parent->instance_size <=3D ti->instance_size);
         memcpy(ti->class, parent->class, parent->class_size);
         ti->class->interfaces =3D NULL;
         ti->class->properties =3D g_hash_table_new_full(
--=20
2.25.0.rc1.20.g2443f3f80d.dirty


