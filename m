Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A7DC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:15:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF712064C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJUc1j7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF712064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is1FI-0003cZ-Tl
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 04:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is1Db-00022x-S6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is1DY-0002Xv-2b
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:13:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is1DX-0002XW-VT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579166011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/UpAN3DhoJ3BUGURReP4AJ8K6hzzG8vCFofr0nVySu8=;
 b=QJUc1j7azezACEY2c/mf1ZdnvRBM+qhsEvjD6HlrEgG5BS8K4V92HazbZTFwFkVFEZo8We
 PMwUdDHPaENwnQ/LZg3sI2znV5knHwb57uqawMjfUNXOIBZwPERQApxsKDC1uX9mGqUdKI
 R/T3VJVPO46kARkgfzsqReqTg0UiM7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-WUlVjE-HM3WgwypU-RxD3w-1; Thu, 16 Jan 2020 04:13:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F29800A02;
 Thu, 16 Jan 2020 09:13:24 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-187.brq.redhat.com [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1B888894;
 Thu, 16 Jan 2020 09:13:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Makefile: Keep trace-events-subdirs ordered
Date: Thu, 16 Jan 2020 10:13:14 +0100
Message-Id: <20200116091314.25024-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WUlVjE-HM3WgwypU-RxD3w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ease review and reduce likelihood of merge failures (see [*]),
keep trace-events-subdirs ordered when possible, following eb7ccb3c0.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg671007.html
    Duplicate trace-events-subdirs entries generates duplicated
    symbols when using the LTTng Userspace Tracer library.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
"Fixes: 26b8e6dc & 8d5d515a0"

To be even safer we should use $(sort $(trace-events-subdirs))
---
 Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 7c1e50f9d6..d62f908965 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -142,8 +142,8 @@ trace-events-subdirs +=3D nbd
 trace-events-subdirs +=3D scsi
 endif
 ifeq ($(CONFIG_SOFTMMU),y)
-trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D audio
+trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D hw/9pfs
 trace-events-subdirs +=3D hw/acpi
 trace-events-subdirs +=3D hw/alpha
@@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
 trace-events-subdirs +=3D net
 trace-events-subdirs +=3D ui
 endif
+trace-events-subdirs +=3D hw/core
 trace-events-subdirs +=3D hw/display
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
@@ -203,7 +204,6 @@ trace-events-subdirs +=3D target/riscv
 trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/sparc
 trace-events-subdirs +=3D util
-trace-events-subdirs +=3D hw/core
=20
 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)
=20
--=20
2.21.1


