Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9D2C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E25214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFOyT04N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E25214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEWI-00008k-FS
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEVM-0007ZF-Fz
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEVL-0007Bz-E2
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEVL-00078E-7a
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFyYhSJaR8h39Rbqagf85ifWXxR+w0L7k4hKSrlfago=;
 b=fFOyT04NXIGFh6MrBpyYxVtESBvmCSsEMcmq3FHJpXkR8amvdf1JEuzvJGBT+WFRvG65sB
 YVdpeKWcgpgbuQORCPUDVq/3pJfSATITb3BRnhZxFcRf8TG8kZMOZOOsyEvDSqlH9WRcUc
 j85ksL8/KnGcBvAknSFHUt6WgKde1Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-GKZmRrbXNv-VBjqVcGU-Mg-1; Sat, 14 Dec 2019 10:58:20 -0500
X-MC-Unique: GKZmRrbXNv-VBjqVcGU-Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AAA1801E74;
 Sat, 14 Dec 2019 15:58:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E18B066A1A;
 Sat, 14 Dec 2019 15:58:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/8] target/i386/cpu: Use 'mr' for MemoryRegion variables
Date: Sat, 14 Dec 2019 16:56:14 +0100
Message-Id: <20191214155614.19004-9-philmd@redhat.com>
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

The codebase use 'as' in variable names for AddressSpace objects,
and 'mr' for MemoryRegion objects. Since these variables are
MemoryRegion objects, rename them as 'mr' to avoid confusion with
AddressSpace objects.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/cpu.h |  2 +-
 target/i386/cpu.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cde2a16b94..1e5ded6e84 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1713,7 +1713,7 @@ struct X86CPU {
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct DeviceState *apic_state;
-    struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
+    MemoryRegion *cpu_mr_root, *cpu_mr_mem, *smram;
     Notifier machine_done;
=20
     struct kvm_msrs *kvm_msr_buf;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6131c62f9d..b5d22740b8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5983,7 +5983,7 @@ static void x86_cpu_machine_done(Notifier *n, void =
*unused)
         memory_region_init_alias(cpu->smram, OBJECT(cpu), "smram",
                                  smram, 0, 1ull << 32);
         memory_region_set_enabled(cpu->smram, true);
-        memory_region_add_subregion_overlap(cpu->cpu_as_root, 0, cpu->sm=
ram, 1);
+        memory_region_add_subregion_overlap(cpu->cpu_mr_root, 0, cpu->sm=
ram, 1);
     }
 }
 #else
@@ -6471,24 +6471,24 @@ static void x86_cpu_realizefn(DeviceState *dev, E=
rror **errp)
=20
 #ifndef CONFIG_USER_ONLY
     if (tcg_enabled()) {
-        cpu->cpu_as_mem =3D g_new(MemoryRegion, 1);
-        cpu->cpu_as_root =3D g_new(MemoryRegion, 1);
+        cpu->cpu_mr_mem =3D g_new(MemoryRegion, 1);
+        cpu->cpu_mr_root =3D g_new(MemoryRegion, 1);
=20
         /* Outer container... */
-        memory_region_init(cpu->cpu_as_root, OBJECT(cpu), "memory", ~0ul=
l);
-        memory_region_set_enabled(cpu->cpu_as_root, true);
+        memory_region_init(cpu->cpu_mr_root, OBJECT(cpu), "memory", ~0ul=
l);
+        memory_region_set_enabled(cpu->cpu_mr_root, true);
=20
         /* ... with two regions inside: normal system memory with low
          * priority, and...
          */
-        memory_region_init_alias(cpu->cpu_as_mem, OBJECT(cpu), "memory",
+        memory_region_init_alias(cpu->cpu_mr_mem, OBJECT(cpu), "memory",
                                  get_system_memory(), 0, ~0ull);
-        memory_region_add_subregion(cpu->cpu_as_root, 0, cpu->cpu_as_mem=
);
-        memory_region_set_enabled(cpu->cpu_as_mem, true);
+        memory_region_add_subregion(cpu->cpu_mr_root, 0, cpu->cpu_mr_mem=
);
+        memory_region_set_enabled(cpu->cpu_mr_mem, true);
=20
         cs->num_ases =3D 2;
         cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
-        cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_as_root);
+        cpu_address_space_init(cs, 1, "cpu-smm", cpu->cpu_mr_root);
=20
         /* ... SMRAM with higher priority, linked from /machine/smram.  =
*/
         cpu->machine_done.notify =3D x86_cpu_machine_done;
--=20
2.21.0


