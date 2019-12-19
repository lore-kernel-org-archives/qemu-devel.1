Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE16A222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5hplWzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE16A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihteQ-00065t-Md
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ihtZ5-0007Aa-Ti
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ihtZ4-00028C-AH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ihtZ3-00024I-Tv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 06:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576753313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsKlgFVaY90ZmdAuFQza/rRwJIEq8CzteF4gT9FMQ5M=;
 b=B5hplWzTXmW3F+upJC0aDUMTVFMVpMrcqVuEciRvXPqi+wkc32L1dLoN+2Aj2qotd+kosb
 z8+kq0uog/IamsoxhfX6TtAnhBQJvWKfciNMpJn6kMZ6CKCaTtJDAexLKfmrZhRlSIdGss
 GlsgOOZwK8WlegsavQpAPTdHpN1MhaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-5yEOigs-N6yhXwYy-pobyw-1; Thu, 19 Dec 2019 06:01:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AD871005510;
 Thu, 19 Dec 2019 11:01:48 +0000 (UTC)
Received: from localhost (ovpn-117-134.ams2.redhat.com [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE92D63B89;
 Thu, 19 Dec 2019 11:01:45 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 6/6] s390x: Properly fetch and test the short psw on diag308
 subc 0/1
Date: Thu, 19 Dec 2019 12:01:12 +0100
Message-Id: <20191219110112.8343-7-cohuck@redhat.com>
In-Reply-To: <20191219110112.8343-1-cohuck@redhat.com>
References: <20191219110112.8343-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5yEOigs-N6yhXwYy-pobyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

We need to actually fetch the cpu mask and set it. As we invert the
short psw indication in the mask, SIE will report a specification
exception, if it wasn't present in the reset psw.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191129142025.21453-2-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.c | 12 ++++++++++--
 target/s390x/cpu.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 99ea09085a30..625daeedd133 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -76,8 +76,16 @@ static bool s390_cpu_has_work(CPUState *cs)
 static void s390_cpu_load_normal(CPUState *s)
 {
     S390CPU *cpu =3D S390_CPU(s);
-    cpu->env.psw.addr =3D ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
-    cpu->env.psw.mask =3D PSW_MASK_32 | PSW_MASK_64;
+    uint64_t spsw =3D ldq_phys(s->as, 0);
+
+    cpu->env.psw.mask =3D spsw & 0xffffffff80000000ULL;
+    /*
+     * Invert short psw indication, so SIE will report a specification
+     * exception if it was not set.
+     */
+    cpu->env.psw.mask ^=3D PSW_MASK_SHORTPSW;
+    cpu->env.psw.addr =3D spsw & 0x7fffffffULL;
+
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index aa829e954cbf..e195e5c7c8bb 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -269,6 +269,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define PSW_MASK_EXT            0x0100000000000000ULL
 #define PSW_MASK_KEY            0x00F0000000000000ULL
 #define PSW_SHIFT_KEY           52
+#define PSW_MASK_SHORTPSW       0x0008000000000000ULL
 #define PSW_MASK_MCHECK         0x0004000000000000ULL
 #define PSW_MASK_WAIT           0x0002000000000000ULL
 #define PSW_MASK_PSTATE         0x0001000000000000ULL
--=20
2.21.0


