Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B88C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D2D246AE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wm14D99/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D2D246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7mpj-0003Ey-9W
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7moE-0000xU-1R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7moD-0005EV-3Z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7moC-0005EE-W7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582923872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5SbYjgtI2uGgWzkFXzp2xmZLMIvWFJ0c3sXX+8zipE=;
 b=Wm14D99/Q0t/cMuzIHSBxvVz80lYLXhOV3ybtwem+KfRVMvM1f18SfXVclot4E3ncHUt9x
 T5Dy/j8gDdj6LqnEgYnkBkBdV8qpx2Z6+V+Z4QSKjyg2Jj0lxQeFvku3PkUQfc//+qmj3y
 gr7FSqox79ih+4ysOF1FQEo1VdHNu7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-kr05VG7eM6mYPeVSbe6EFg-1; Fri, 28 Feb 2020 16:04:30 -0500
X-MC-Unique: kr05VG7eM6mYPeVSbe6EFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91C19800D5B;
 Fri, 28 Feb 2020 21:04:29 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 604DC101D4A5;
 Fri, 28 Feb 2020 21:04:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/nmi: Fix the NMI() macro, based on INTERFACE_CHECK()
Date: Fri, 28 Feb 2020 16:04:24 -0500
Message-Id: <20200228210427.474606-2-ehabkost@redhat.com>
In-Reply-To: <20200228210427.474606-1-ehabkost@redhat.com>
References: <20200228210427.474606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

There is no declaration of the 'NMI' type. INTERFACE_CHECK()
returns an abstract type (see commit aa1b35b975d8). The abstract
type corresponding to the TYPE_NMI interface is 'NMIState'.

Fixes: 9cb805fd267
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191207094823.20707-1-philmd@redhat.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
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
2.24.1


