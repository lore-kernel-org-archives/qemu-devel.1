Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F51AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F302077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMuoJDVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F302077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufj7-0001WA-Pp
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuct3-0007dq-5o
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuct2-0006pU-0x
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23262
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuct1-0006pF-Up
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFBdusjTRivI83sKM4ZWIopYtK/Kmoyuru1DkptNNaY=;
 b=LMuoJDVKWj2uWth4m4IBu3t374QWpaLquuX8G/hes2ggeOwNJeE8dXGRHYEQRTCvGvTOva
 NxcUQc13wWo9qwRDWy4FH4+tPV9MNgCLzULzKV9GaoWXeQvxRP9ZeFCDoB1VTJ/PhFZH/Q
 /X9FhdFQmv/3y9KfrvZNeZDkxd0YE1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-UMrelfzONwm7B1DJ6aXS6w-1; Thu, 23 Jan 2020 08:51:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9110C1800D48
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:03 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48A751CB;
 Thu, 23 Jan 2020 13:51:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/59] qom/object: Display more helpful message when an
 interface is missing
Date: Thu, 23 Jan 2020 14:49:55 +0100
Message-Id: <1579787449-27599-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: UMrelfzONwm7B1DJ6aXS6w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Message-Id: <20200118162348.17823-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 0d971ca..36123fb 100644
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
1.8.3.1



