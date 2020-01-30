Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79096C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444392083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG2QfK9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444392083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHZP-00078I-Ff
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHWI-0002G4-Fk
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHWH-0000js-7V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHWH-0000ia-3K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5I3Td1QdEAZSEZF4gwact89ja48eL8CsMNkahbAyUg=;
 b=GG2QfK9YMy+b4YBrJg3tvi3sfEeTs0Z5zpIcdvEsAO2adO9WeWe1QlrvtcH9PB7F6X9qqA
 HidM0Vy6lzohw3xLuBUauII4U9l3tcooKC6fkHvg2FOAfurop+OYkKiuXm5BxG/e9AroE7
 Of48ehFwtLrG8Zv/MKmq6VFmKCXD5Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-vNHtgLZ9MEyZb4hdSnIHdA-1; Thu, 30 Jan 2020 16:38:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C50635F9;
 Thu, 30 Jan 2020 21:38:30 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C9BA5C1B2;
 Thu, 30 Jan 2020 21:38:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] Makefile: Keep trace-events-subdirs ordered
Date: Thu, 30 Jan 2020 21:38:10 +0000
Message-Id: <20200130213814.334195-2-stefanha@redhat.com>
In-Reply-To: <20200130213814.334195-1-stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vNHtgLZ9MEyZb4hdSnIHdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Adding the same directory multiple times to trace-events-subdirs
might trigger build failures, in particular when using the LTTng
Userspace Tracer library as backend.

For example when using two times the hw/core/ directory:

    $ ./configure --enable-trace-backends=3Dust && make
   [...]
     CC      trace-ust-all.o
   In file included from trace-ust-all.h:13,
                    from trace-ust-all.c:13:
   trace-ust-all.h:35151:1: error: redefinition of =E2=80=98__tracepoint_cb=
_qemu___loader_write_rom=E2=80=99
   35151 | TRACEPOINT_EVENT(
         | ^~~~~~~~~~~~~~~~
   trace-ust-all.h:31791:1: note: previous definition of =E2=80=98__tracepo=
int_cb_qemu___loader_write_rom=E2=80=99 was here
   31791 | TRACEPOINT_EVENT(
         | ^~~~~~~~~~~~~~~~

To ease review and reduce likelihood of merge failures (see [*]),
keep trace-events-subdirs ordered when possible, following eb7ccb3c0.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg671007.html
    Duplicate trace-events-subdirs entries generates duplicated
    symbols when using the LTTng Userspace Tracer library.

Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200116114339.30670-1-philmd@redhat.com
Message-Id: <20200116114339.30670-1-philmd@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.objs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index f2da7241fc..26b9cff954 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -132,8 +132,8 @@ trace-events-subdirs +=3D nbd
 trace-events-subdirs +=3D scsi
 endif
 ifeq ($(CONFIG_SOFTMMU),y)
-trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D audio
+trace-events-subdirs +=3D chardev
 trace-events-subdirs +=3D hw/9pfs
 trace-events-subdirs +=3D hw/acpi
 trace-events-subdirs +=3D hw/alpha
@@ -181,6 +181,7 @@ trace-events-subdirs +=3D migration
 trace-events-subdirs +=3D net
 trace-events-subdirs +=3D ui
 endif
+trace-events-subdirs +=3D hw/core
 trace-events-subdirs +=3D hw/display
 trace-events-subdirs +=3D qapi
 trace-events-subdirs +=3D qom
@@ -193,7 +194,6 @@ trace-events-subdirs +=3D target/riscv
 trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/sparc
 trace-events-subdirs +=3D util
-trace-events-subdirs +=3D hw/core
=20
 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)
=20
--=20
2.24.1


