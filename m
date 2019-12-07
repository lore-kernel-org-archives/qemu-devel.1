Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F85DC43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 09:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1792173E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeZ48+1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1792173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idWiY-0006pZ-Uz
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 04:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idWhf-0006PU-Cp
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 04:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idWhc-00024G-Pd
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 04:48:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idWhc-0001wf-EZ
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 04:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575712119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Blvnwq27wjpnBA4Q91In3SnFVQvRkMdxsKDw8BShMLs=;
 b=SeZ48+1uOGJL6uHRoCK/Oz6wnLFqLNd28Z3anGaQbi8pD/ZlsEYdGLiZDE+/pgp5RPaLR2
 Ug9B3bvDsoHdwRT76omWRYR2a3sh42FBAEap1XJ5qyPOZ6rG3wLrj+Lv7ZzPlwUEbzIGG0
 R0EF3bHIXhRrfPxS9DQ2lC7MTr9vd9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-MUK34_rLPfmZ_mCT2jFREQ-1; Sat, 07 Dec 2019 04:48:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328D7107ACC4;
 Sat,  7 Dec 2019 09:48:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-72.brq.redhat.com [10.40.204.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3319DA4B8F;
 Sat,  7 Dec 2019 09:48:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/nmi: Fix the NMI() macro, based on INTERFACE_CHECK()
Date: Sat,  7 Dec 2019 10:48:23 +0100
Message-Id: <20191207094823.20707-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MUK34_rLPfmZ_mCT2jFREQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no declaration of the 'NMI' type. INTERFACE_CHECK()
returns an abstract type (see commit aa1b35b975d8). The abstract
type corresponding to the TYPE_NMI interface is 'NMIState'.

Fixes: 9cb805fd267
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/nmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index a1e128724e..fe37ce3ad8 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -31,7 +31,7 @@
 #define NMI_GET_CLASS(obj) \
     OBJECT_GET_CLASS(NMIClass, (obj), TYPE_NMI)
 #define NMI(obj) \
-     INTERFACE_CHECK(NMI, (obj), TYPE_NMI)
+     INTERFACE_CHECK(NMIState, (obj), TYPE_NMI)
=20
 typedef struct NMIState NMIState;
=20
--=20
2.21.0


