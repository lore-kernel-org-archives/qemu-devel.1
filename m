Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D2C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322A4214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOZSTBzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322A4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEXs-00025m-7r
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEWC-0000Nf-Rb
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEWB-0001aY-Hc
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEWB-0001X9-7e
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cebHdve3ZnvlZJWxH5a8KchlZuVrxNjKmx0NHd8T+o=;
 b=AOZSTBzPMR+g53eBKaMsby9yOBMukc9O+tFR5tZBwSq2cRuw1ceadAExwh6FLC3W5lLj7w
 DN7irXVhR6dGOUqXhvgvEozT5etBtJGVQ8iCoFh99xlMAKwUkaoUM7EPuM65P6ilquUWsA
 F8NeMDH5gmuGet5A4ATa4CGApKHsxL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-FmV6NzRAPFqS56q6qZWsiQ-1; Sat, 14 Dec 2019 10:58:07 -0500
X-MC-Unique: FmV6NzRAPFqS56q6qZWsiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DD11005502;
 Sat, 14 Dec 2019 15:58:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DCAF5D6A7;
 Sat, 14 Dec 2019 15:57:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] target/i386: Use memory_region_add_subregion() when
 priority is 0
Date: Sat, 14 Dec 2019 16:56:13 +0100
Message-Id: <20191214155614.19004-8-philmd@redhat.com>
In-Reply-To: <20191214155614.19004-1-philmd@redhat.com>
References: <20191214155614.19004-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to overlap a memory subregion with priority 0.
Use the simpler memory_region_add_subregion() function.

This patch was produced with the following spatch script:

    @@
    expression region;
    expression offset;
    expression subregion;
    @@
    -memory_region_add_subregion_overlap(region, offset, subregion, 0)
    +memory_region_add_subregion(region, offset, subregion)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/kvm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f518a21a..6131c62f9d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6483,7 +6483,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Err=
or **errp)
          */
         memory_region_init_alias(cpu->cpu_as_mem, OBJECT(cpu), "memory",
                                  get_system_memory(), 0, ~0ull);
-        memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->cp=
u_as_mem, 0);
+        memory_region_add_subregion(cpu->cpu_as_root, 0, cpu->cpu_as_mem=
);
         memory_region_set_enabled(cpu->cpu_as_mem, true);
=20
         cs->num_ases =3D 2;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 1d10046a6c..4e1ba9d474 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2081,7 +2081,7 @@ static void register_smram_listener(Notifier *n, vo=
id *unused)
      */
     memory_region_init_alias(&smram_as_mem, OBJECT(kvm_state), "mem-smra=
m",
                              get_system_memory(), 0, ~0ull);
-    memory_region_add_subregion_overlap(&smram_as_root, 0, &smram_as_mem=
, 0);
+    memory_region_add_subregion(&smram_as_root, 0, &smram_as_mem);
     memory_region_set_enabled(&smram_as_mem, true);
=20
     if (smram) {
--=20
2.21.0


