Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6023C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854CD20721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+6R538t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854CD20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZqk-0007xl-FM
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZeM-0007wl-Rs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZeJ-0006Ra-Mp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZeJ-0006PA-Ft
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzr8Edx5jAryfh/huxiAkUz4zCXuFwzT7om8QEdCtyk=;
 b=C+6R538tDUSlBZEE7nrT6P9s3jlyEutfO1g38dDT/PTqgTKT+y6wWQG51jRT2ucriHHgww
 3KZBVI3WjSYswOTiulbnn5gvKBihqRVDmgls9ZNti2MJHV0MYTcsjoIv94HiwKaFgUs+JM
 Wd8jqtzLX3OjySffPMp8T1VjP5jckcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-_7PA0sDLPwqBnL2Z-1DRkA-1; Thu, 09 Jan 2020 10:22:59 -0500
X-MC-Unique: _7PA0sDLPwqBnL2Z-1DRkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18ED985EE6A;
 Thu,  9 Jan 2020 15:22:58 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FD0280608;
 Thu,  9 Jan 2020 15:22:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/15] device_tree: Replace current_machine by
 qdev_get_machine()
Date: Thu,  9 Jan 2020 16:21:27 +0100
Message-Id: <20200109152133.23649-10-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to remove the global current_machine,
replace 'current_machine' by MACHINE(qdev_get_machine()).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 device_tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index f8b46b3c73..665ea2f586 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -466,7 +466,9 @@ uint32_t qemu_fdt_alloc_phandle(void *fdt)
      * which phandle id to start allocating phandles.
      */
     if (!phandle) {
-        phandle =3D machine_phandle_start(current_machine);
+        MachineState *ms =3D MACHINE(qdev_get_machine());
+
+        phandle =3D machine_phandle_start(ms);
     }
=20
     if (!phandle) {
--=20
2.21.1


