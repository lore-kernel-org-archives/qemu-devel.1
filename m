Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD61AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64F024125
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+LJDLSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64F024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrQT-0002LL-BU
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itrLA-0003Wd-4W
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itrL6-0002bY-Gm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:05:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itrL6-0002bG-Cj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ea1a/sRDFxUcqC42bdgwDPTcMkjiHzUbs2lKdEFCTMo=;
 b=G+LJDLSNRLj7ZROSq7MttakiRrldUXmybCFa9lO7pQBSMIOsCWO+TtYdz/99FpOxStHAus
 TmnA8k3gOFvyjRR/JcnYWzXO6GiP31CABuWmxeCwVNS8xfTcEh2MbR4ipHWwlW6OtVoTtL
 QOUpFo1y60VazqfHcTr/nZ0vqs54jlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-0FJY1TuUOrOL2stsHOrGTw-1; Tue, 21 Jan 2020 06:04:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F968DBA5;
 Tue, 21 Jan 2020 11:04:53 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-38.brq.redhat.com [10.40.205.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C1C811F8;
 Tue, 21 Jan 2020 11:04:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] target/s390x: Remove duplicated ifdef macro
Date: Tue, 21 Jan 2020 12:03:44 +0100
Message-Id: <20200121110349.25842-6-philmd@redhat.com>
In-Reply-To: <20200121110349.25842-1-philmd@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0FJY1TuUOrOL2stsHOrGTw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ae71ed8610 replaced the use of global max_cpus variable
with a machine property, but introduced a unnecessary ifdef, as
this block is already in the 'not CONFIG_USER_ONLY' branch part:

   86 #if defined(CONFIG_USER_ONLY)
   87
  ...
  106 #else /* !CONFIG_USER_ONLY */
  107
  ...
  292 static void do_ext_interrupt(CPUS390XState *env)
  293 {
  ...
  313 #ifndef CONFIG_USER_ONLY
  314         MachineState *ms =3D MACHINE(qdev_get_machine());
  315         unsigned int max_cpus =3D ms->smp.max_cpus;
  316 #endif

To ease code review, remove the duplicated preprocessor macro,
and move the declarations at the beginning of the statement.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: New patch
Cc: Like Xu <like.xu@linux.intel.com>
---
 target/s390x/excp_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index e70c20d363..1e9d6f20c1 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -305,15 +305,14 @@ static void do_ext_interrupt(CPUS390XState *env)
=20
     if ((env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) &&
         (env->cregs[0] & CR0_EMERGENCY_SIGNAL_SC)) {
+        MachineState *ms =3D MACHINE(qdev_get_machine());
+        unsigned int max_cpus =3D ms->smp.max_cpus;
+
         lowcore->ext_int_code =3D cpu_to_be16(EXT_EMERGENCY);
         cpu_addr =3D find_first_bit(env->emergency_signals, S390_MAX_CPUS)=
;
         g_assert(cpu_addr < S390_MAX_CPUS);
         lowcore->cpu_addr =3D cpu_to_be16(cpu_addr);
         clear_bit(cpu_addr, env->emergency_signals);
-#ifndef CONFIG_USER_ONLY
-        MachineState *ms =3D MACHINE(qdev_get_machine());
-        unsigned int max_cpus =3D ms->smp.max_cpus;
-#endif
         if (bitmap_empty(env->emergency_signals, max_cpus)) {
             env->pending_int &=3D ~INTERRUPT_EMERGENCY_SIGNAL;
         }
--=20
2.21.1


