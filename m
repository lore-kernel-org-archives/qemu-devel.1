Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F6024125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsXn88rG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F6024125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifnzy-0001fv-BB
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 11:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ifnfE-0000WC-2G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ifnfC-0001hO-T5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ifnfC-0001gi-P5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 11:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576253974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LjIPDCpWRkfw5wVp11KGA8s6SR+qMeIEMfDWf9vzM4=;
 b=XsXn88rGbGj0Zee98sLU+/PNjoNn5sfIqmFtYa54AZJecKhV4TLManbqiDuxBVau1qX3nh
 L4bxhNzTDIBaclIe4GSbeCmA/SdAdVRYWG67FGPnVbhUl+ssMyh6GqB7DW0LcpkDAUIdk0
 NyZe0HJB9a7tMkqjec+THj5STnq4CA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-JQysbnDTOtGb0N6BNXfyeQ-1; Fri, 13 Dec 2019 11:19:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995C58024F9;
 Fri, 13 Dec 2019 16:19:30 +0000 (UTC)
Received: from localhost (ovpn-116-226.ams2.redhat.com [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D28E5100164D;
 Fri, 13 Dec 2019 16:19:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/16] s390x: kvm: Make kvm_sclp_service_call void
Date: Fri, 13 Dec 2019 17:18:43 +0100
Message-Id: <20191213161851.24687-9-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
References: <20191213161851.24687-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: JQysbnDTOtGb0N6BNXfyeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

It defaults to returning 0 anyway and that return value is not
necessary, as 0 is also the default rc that the caller would return.

While doing that we can simplify the logic a bit and return early if
we inject a PGM exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191129091713.4582-1-frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0c9d14b4b115..ad6e38c8761b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1159,13 +1159,13 @@ void kvm_s390_access_exception(S390CPU *cpu, uint16=
_t code, uint64_t te_code)
     kvm_s390_vcpu_interrupt(cpu, &irq);
 }
=20
-static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
+static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
                                  uint16_t ipbh0)
 {
     CPUS390XState *env =3D &cpu->env;
     uint64_t sccb;
     uint32_t code;
-    int r =3D 0;
+    int r;
=20
     sccb =3D env->regs[ipbh0 & 0xf];
     code =3D env->regs[(ipbh0 & 0xf0) >> 4];
@@ -1173,11 +1173,9 @@ static int kvm_sclp_service_call(S390CPU *cpu, struc=
t kvm_run *run,
     r =3D sclp_service_call(env, sccb, code);
     if (r < 0) {
         kvm_s390_program_interrupt(cpu, -r);
-    } else {
-        setcc(cpu, r);
+        return;
     }
-
-    return 0;
+    setcc(cpu, r);
 }
=20
 static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
@@ -1240,7 +1238,7 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *ru=
n, uint8_t ipa1)
         setcc(cpu, 3);
         break;
     case PRIV_B2_SCLP_CALL:
-        rc =3D kvm_sclp_service_call(cpu, run, ipbh0);
+        kvm_sclp_service_call(cpu, run, ipbh0);
         break;
     default:
         rc =3D -1;
--=20
2.21.0


