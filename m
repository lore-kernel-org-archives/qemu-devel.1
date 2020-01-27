Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C87206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0Sx+A09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C87206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3TJ-0001Zr-Ql
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nn-00009A-H7
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nm-0006iP-HU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3Nm-0006iE-EM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8y9fXBUdPTW7NOsPKa6f8zca8IFTfYpujeh3gvINECI=;
 b=X0Sx+A09SJZ2CPOv3sIqs12CmAn6h91fWDHnO0Irzr0vobyNt1dAkVKOki0R83e4oqEeIr
 xWBn4VoJr6UNwjEDQ1SYd7Ds5JcssCdL+ENahnt4rXmGzlSc+AtaOfzyZBwxveXKrFjVs7
 Wr3VuMqrSmweYKHZSzoEgkT2FCVdKuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-GzH27D7PM5yL0oug7la0uA-1; Mon, 27 Jan 2020 07:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC59C8017CC;
 Mon, 27 Jan 2020 12:20:40 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDDF98702B;
 Mon, 27 Jan 2020 12:20:37 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/15] target/s390x: Remove duplicated ifdef macro
Date: Mon, 27 Jan 2020 13:20:07 +0100
Message-Id: <20200127122016.18752-7-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: GzH27D7PM5yL0oug7la0uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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
Message-Id: <20200121110349.25842-6-philmd@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index e70c20d363a4..1e9d6f20c188 100644
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


