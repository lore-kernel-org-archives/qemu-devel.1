Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E6C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE1220738
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyxqXN0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE1220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENQR-0002h8-KM
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLl-0004Y6-Nk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLk-0002eS-DO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLk-0002Zi-90
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXPYI74UUQLKfuswF4jeS8KuX070oe1Vo0knYTlRAvE=;
 b=LyxqXN0Nj67FLzIBZk2QAxIFJrQXL0zhKTdwv8ygCvZVLw530R/meXBw1ZX9v3H8kQToMJ
 +diGLIKClB4epmJ/iEgaeL8pHxYl9Oe5oCx/yStLDfoAYOmHhC0T4X0OWMIPPhvxPk5U0w
 UD/qdLuaRYHCkzNBRga91aXfku2wkCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-bu98x6YYO9-7J4_KFYQlSw-1; Tue, 17 Mar 2020 21:18:18 -0400
X-MC-Unique: bu98x6YYO9-7J4_KFYQlSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95431DB60;
 Wed, 18 Mar 2020 01:18:17 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79BCC19C58;
 Wed, 18 Mar 2020 01:18:14 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/13] machine: Add SMP Sockets in CpuTopology
Date: Tue, 17 Mar 2020 21:17:45 -0400
Message-Id: <20200318011748.2104336-11-ehabkost@redhat.com>
In-Reply-To: <20200318011748.2104336-1-ehabkost@redhat.com>
References: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

Store the  smp sockets in CpuTopology. The socket information required to
build the apic id in EPYC mode. Right now socket information is not passed
to down when decoding the apic id. Add the socket information here.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <158396718647.58170.2278448323151215741.stgit@naples-babu.amd.c=
om>
---
 hw/core/machine.c   | 1 +
 hw/i386/pc.c        | 1 +
 include/hw/boards.h | 2 ++
 softmmu/vl.c        | 1 +
 4 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4778bc6b08..b958cd1b99 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -757,6 +757,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus =3D cpus;
         ms->smp.cores =3D cores;
         ms->smp.threads =3D threads;
+        ms->smp.sockets =3D sockets;
     }
=20
     if (ms->smp.cpus > 1) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 662abb549d..05e7f1090f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -781,6 +781,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus =3D cpus;
         ms->smp.cores =3D cores;
         ms->smp.threads =3D threads;
+        ms->smp.sockets =3D sockets;
         x86ms->smp_dies =3D dies;
     }
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index c96120d15f..236d239c19 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -236,12 +236,14 @@ typedef struct DeviceMemoryState {
  * @cpus: the number of present logical processors on the machine
  * @cores: the number of cores in one package
  * @threads: the number of threads in one core
+ * @sockets: the number of sockets on the machine
  * @max_cpus: the maximum number of logical processors on the machine
  */
 typedef struct CpuTopology {
     unsigned int cpus;
     unsigned int cores;
     unsigned int threads;
+    unsigned int sockets;
     unsigned int max_cpus;
 } CpuTopology;
=20
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 6a285925b3..1d33a28340 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3946,6 +3946,7 @@ void qemu_init(int argc, char **argv, char **envp)
     current_machine->smp.max_cpus =3D machine_class->default_cpus;
     current_machine->smp.cores =3D 1;
     current_machine->smp.threads =3D 1;
+    current_machine->smp.sockets =3D 1;
=20
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
--=20
2.24.1


