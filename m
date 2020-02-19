Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702B2C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2632465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gu/UUlQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2632465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SBy-0002Fd-Cl
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rvy-0003OI-HE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rvw-0000uG-Dy
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rvw-0000u0-9i
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReBY8U178xkzXvJqk8y0GAqOdbm312oeVmdVRVGX7kc=;
 b=gu/UUlQSLBuYtB1CsXS1OkG/4siEMFEmZ6y/bmQzBfZDEXEPQOQ8CkBu8bW9gsQ+Zms8/r
 4Ossfh4stOzsO47fEeCQ9P7eWE/bkx76tOOErDIh25Ie7dZXAXJJDtJ/RbMTNrgNS9oshp
 3wzLr5+Nt2G9yHY5eMlB4wkmKSEWCEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-nbWkORBXM5K-hArJrU9TJQ-1; Wed, 19 Feb 2020 11:10:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EF68B0DF1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:10:41 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A4606E3EE;
 Wed, 19 Feb 2020 16:10:40 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 39/79] null-machine: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:13 -0500
Message-Id: <20200219160953.13771-40-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nbWkORBXM5K-hArJrU9TJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/null-machine.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 1aa0a9a01a..cb47d9d4f8 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -32,11 +32,8 @@ static void machine_none_init(MachineState *mch)
     }
=20
     /* RAM at address zero */
-    if (mch->ram_size) {
-        MemoryRegion *ram =3D g_new(MemoryRegion, 1);
-
-        memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_si=
ze);
-        memory_region_add_subregion(get_system_memory(), 0, ram);
+    if (mch->ram) {
+        memory_region_add_subregion(get_system_memory(), 0, mch->ram);
     }
=20
     if (mch->kernel_filename) {
@@ -52,6 +49,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->init =3D machine_none_init;
     mc->max_cpus =3D 1;
     mc->default_ram_size =3D 0;
+    mc->default_ram_id =3D "ram";
 }
=20
 DEFINE_MACHINE("none", machine_none_machine_init)
--=20
2.18.1


