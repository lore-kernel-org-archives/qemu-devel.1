Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6606C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12AC2468C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 16:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyVQZTTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12AC2468C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isquD-0006QE-QE
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 11:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isqtH-0005W4-8A
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isqtE-0007Eu-Sh
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:24:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isqtE-0007E9-92
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 11:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579364639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LA0ayxYJMroSpQnrDtk2P6kxf1ntvP9Q/rvrsBUNc0s=;
 b=MyVQZTTWQGccEXiRnsYrXNHl/qxqCHKg93DuK9D1HWwHcIfAtwmSSvIB9mFzCRMHeMM0vf
 dewTuXaUDnZqAnzYA14j20I8CgCASpH4vaiUIgECqROvNUmR7bhwCKHVzQGXwRgtftmzwC
 zgc9QjjOsuC/tFq4jDhoo+sn6+6Rr6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-IIv0VbIsMEGhkOE694Ba3g-1; Sat, 18 Jan 2020 11:23:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B500800D41
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 16:23:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8201160BFB;
 Sat, 18 Jan 2020 16:23:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qom/object: Display more helpful message when an interface is
 missing
Date: Sat, 18 Jan 2020 17:23:48 +0100
Message-Id: <20200118162348.17823-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: IIv0VbIsMEGhkOE694Ba3g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When adding new devices implementing QOM interfaces, we might
forgot to add the Kconfig dependency that pulls the required
objects in when building.

Since QOM dependencies are resolved at runtime, we don't get any
link-time failures, and QEMU aborts while starting:

  $ qemu ...
  Segmentation fault (core dumped)

  (gdb) bt
  #0  0x00007ff6e96b1e35 in raise () from /lib64/libc.so.6
  #1  0x00007ff6e969c895 in abort () from /lib64/libc.so.6
  #2  0x00005572bc5051cf in type_initialize (ti=3D0x5572be6f1200) at qom/ob=
ject.c:323
  #3  0x00005572bc505074 in type_initialize (ti=3D0x5572be6f1800) at qom/ob=
ject.c:301
  #4  0x00005572bc505074 in type_initialize (ti=3D0x5572be6e48e0) at qom/ob=
ject.c:301
  #5  0x00005572bc506939 in object_class_by_name (typename=3D0x5572bc56109a=
) at qom/object.c:959
  #6  0x00005572bc503dd5 in cpu_class_by_name (typename=3D0x5572bc56109a, c=
pu_model=3D0x5572be6d9930) at hw/core/cpu.c:286

Since the caller has access to the qdev parent/interface names,
we can simply display them to avoid starting a debugger:

  $ qemu ...
  qemu: missing interface 'fancy-if' for object 'fancy-dev'
  Aborted (core dumped)

This commit is similar to e02bdf1cecd2 ("Display more helpful message
when an object type is missing").

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 0d971ca897..36123fb330 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -317,6 +317,11 @@ static void type_initialize(TypeImpl *ti)
=20
         for (i =3D 0; i < ti->num_interfaces; i++) {
             TypeImpl *t =3D type_get_by_name(ti->interfaces[i].typename);
+            if (!t) {
+                error_report("missing interface '%s' for object '%s'",
+                             ti->interfaces[i].typename, parent->name);
+                abort();
+            }
             for (e =3D ti->class->interfaces; e; e =3D e->next) {
                 TypeImpl *target_type =3D OBJECT_CLASS(e->data)->type;
=20
--=20
2.21.1


