Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C241C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AAAC20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJR30WFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAAC20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdEo-0007ZZ-GV
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihd0v-0000Ay-3Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihd0t-0002q4-Ge
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27502
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihd0s-0002hM-0B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576689689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlWpvWjMvO4W7C89QvDgz4j9AkXk/8NNuObfmzICgyo=;
 b=FJR30WFaE5C8lyRNvBIraEoT0WVl0h+RQH1X5Hb7idc5XjJg36H9TIbABjdKWlgFQVcE9V
 2Prv47IGgo4Ol1HS+v/b2iQCrezjurngSmJMOGEm1PJXiYQ1MgynV8s80jLYO2pgsB2NEO
 K1FVuY9sL4oJanaY0dRXsZUIrQzcCxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-MfL1FuuHMLmkfoL4u8Fepg-1; Wed, 18 Dec 2019 12:21:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E441801E6C
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 17:21:27 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 177631000322;
 Wed, 18 Dec 2019 17:21:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 13/14] chardev/char: Explicit we ignore some
 QEMUChrEvent in IOEventHandler
Date: Wed, 18 Dec 2019 18:20:08 +0100
Message-Id: <20191218172009.8868-14-philmd@redhat.com>
In-Reply-To: <20191218172009.8868-1-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MfL1FuuHMLmkfoL4u8Fepg-1
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit all the events ignored by this frontend, to silent the
following GCC warning:

  chardev/char.c: In function =E2=80=98qemu_chr_be_event=E2=80=99:
  chardev/char.c:65:5: error: enumeration value =E2=80=98CHR_EVENT_BREAK=E2=
=80=99 not handled in switch [-Werror=3Dswitch]
     65 |     switch (event) {
        |     ^~~~~~
  chardev/char.c:65:5: error: enumeration value =E2=80=98CHR_EVENT_MUX_IN=
=E2=80=99 not handled in switch [-Werror=3Dswitch]
  chardev/char.c:65:5: error: enumeration value =E2=80=98CHR_EVENT_MUX_OUT=
=E2=80=99 not handled in switch [-Werror=3Dswitch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add all missing enums

Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 7b6b2cb123..739da1155b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -69,6 +69,11 @@ void qemu_chr_be_event(Chardev *s, int event)
         case CHR_EVENT_CLOSED:
             s->be_open =3D 0;
             break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
=20
     CHARDEV_GET_CLASS(s)->chr_be_event(s, event);
--=20
2.21.0


