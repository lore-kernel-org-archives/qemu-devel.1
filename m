Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7405EC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A3120700
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnV0MCwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A3120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig46k-0004Sh-8S
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig400-0004qU-5J
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig3zy-0005as-U2
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig3zy-0005Yy-Ou
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576316766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LjIPDCpWRkfw5wVp11KGA8s6SR+qMeIEMfDWf9vzM4=;
 b=AnV0MCwYX5Oz4F9WtenpAXIqHP+Ku0rS75Izq09IvYCY2AsiXqvaHkShmI74zqGgEaUviG
 iaDSc+yObgyGmEMSX03fze3zeflSmBVsI3y5DUD+vG72e2Id6fFCzd04GgjKolvt4NCzwe
 exEqCC3TPmu9nwLOEKoQof9noVkd52Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-cAJkG9n5Ooad7a7BY5a0lA-1; Sat, 14 Dec 2019 04:46:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F1F1800D63;
 Sat, 14 Dec 2019 09:46:01 +0000 (UTC)
Received: from localhost (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06A505D9C9;
 Sat, 14 Dec 2019 09:45:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 08/16] s390x: kvm: Make kvm_sclp_service_call void
Date: Sat, 14 Dec 2019 10:45:18 +0100
Message-Id: <20191214094526.8698-9-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
References: <20191214094526.8698-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: cAJkG9n5Ooad7a7BY5a0lA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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


