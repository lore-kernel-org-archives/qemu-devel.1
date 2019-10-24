Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E64CA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C1420679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 02:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7PvY7Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C1420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTDr-0005WX-JA
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 22:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNT9G-0003I6-IQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNT9F-0005xv-Ao
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNT9F-0005xa-5g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 22:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571885208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwsIntaK93+/QfigO4uKILcu/rtNTqqyJGji00Oz8JM=;
 b=B7PvY7WpzCx2Pn6tbYnIL5F0fxsRtswOSuuw7SWakNp3zVE6Ralb+BnJqluW9IHPvYKgIA
 XFEAAz/1n0gtfpWOpeY+cxRxvpOkeg3YUhOX94322My7iGJTVvNXPQsGOHSnKadvGQCx3k
 EnKMxCPMGBu9ScsYN2utnm2zaihD5bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-KM-bTz0gOzCyOzwkHY3R9A-1; Wed, 23 Oct 2019 22:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89AE780183E;
 Thu, 24 Oct 2019 02:46:43 +0000 (UTC)
Received: from localhost (ovpn-116-56.gru2.redhat.com [10.97.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB7960BF1;
 Thu, 24 Oct 2019 02:46:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 4/4] hppa: drop usage of memory_region_allocate_system_memory()
 for ROM
Date: Wed, 23 Oct 2019 23:46:23 -0300
Message-Id: <20191024024623.18848-5-ehabkost@redhat.com>
In-Reply-To: <20191024024623.18848-1-ehabkost@redhat.com>
References: <20191024024623.18848-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: KM-bTz0gOzCyOzwkHY3R9A-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

machine_hppa_init() violates memory_region_allocate_system_memory() contrac=
t
by calling it multiple times which could break with -mem-path. Replace
the second usage (for 'rom') with memory_region_init_ram() instead.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20191008113318.7012-4-imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/hppa/machine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 7e23675429..953d454f48 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -161,9 +161,8 @@ static void machine_hppa_init(MachineState *machine)
     g_free(firmware_filename);
=20
     rom_region =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(rom_region, OBJECT(machine),
-                                         "firmware",
-                                         (FIRMWARE_END - FIRMWARE_START));
+    memory_region_init_ram(rom_region, NULL, "firmware",
+                           (FIRMWARE_END - FIRMWARE_START), &error_fatal);
     memory_region_add_subregion(addr_space, FIRMWARE_START, rom_region);
=20
     /* Load kernel */
--=20
2.21.0


