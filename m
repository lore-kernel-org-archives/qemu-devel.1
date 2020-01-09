Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E348C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2BE20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsuRFMXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2BE20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZii-0005TS-OJ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZdi-00073v-DI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZdh-00044K-6P
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZdh-00042A-14
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578583344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rw8jmxMoDMD+mDmAS1YaT70WlRmZEqpVqIIhKc3uSz0=;
 b=NsuRFMXw10c27DpYwdMjuaE75U4GUzN8t4rl2J/5J/TVusKNblW9i1/iH2uRF3jOpSM56d
 3cJysVQFCK2CtWzhdnhN1KAOfTazUYxyAF6U0YSSZMhoddf5NmfIyuQMb3I2eA1QEby7DX
 hY2C+30sT8hLEH5Kb8dSXMb4kogupaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-7u9vL7X1MXy5Q1TcHaePyA-1; Thu, 09 Jan 2020 10:22:21 -0500
X-MC-Unique: 7u9vL7X1MXy5Q1TcHaePyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE915477;
 Thu,  9 Jan 2020 15:22:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5EAA1CB;
 Thu,  9 Jan 2020 15:22:13 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/15] hw/ppc/spapr_rtas: Restrict variables scope to single
 switch case
Date: Thu,  9 Jan 2020 16:21:22 +0100
Message-Id: <20200109152133.23649-5-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-1-philmd@redhat.com>
References: <20200109152133.23649-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

We only access these variables in RTAS_SYSPARM_SPLPAR_CHARACTERISTICS
case, restrict their scope to avoid unnecessary initialization.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_rtas.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 6f06e9d7fe..7237e5ebf2 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -267,8 +267,6 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
                                           uint32_t nret, target_ulong re=
ts)
 {
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    MachineState *ms =3D MACHINE(spapr);
-    unsigned int max_cpus =3D ms->smp.max_cpus;
     target_ulong parameter =3D rtas_ld(args, 0);
     target_ulong buffer =3D rtas_ld(args, 1);
     target_ulong length =3D rtas_ld(args, 2);
@@ -276,6 +274,8 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
=20
     switch (parameter) {
     case RTAS_SYSPARM_SPLPAR_CHARACTERISTICS: {
+        MachineState *ms =3D MACHINE(spapr);
+        unsigned int max_cpus =3D ms->smp.max_cpus;
         char *param_val =3D g_strdup_printf("MaxEntCap=3D%d,"
                                           "DesMem=3D%" PRIu64 ","
                                           "DesProcs=3D%d,"
--=20
2.21.1


