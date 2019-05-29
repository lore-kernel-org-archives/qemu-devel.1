Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FEAC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BF5208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BF5208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVt35-0000W9-OO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:30:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hVt02-0006e4-Bo
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hVt00-00085c-SM
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:27:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hVszz-000857-MY; Wed, 29 May 2019 03:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5C9785528;
	Wed, 29 May 2019 07:27:46 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-110.ams2.redhat.com [10.36.116.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB3315B681;
	Wed, 29 May 2019 07:27:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:27:25 +0200
Message-Id: <20190529072726.7875-2-david@redhat.com>
In-Reply-To: <20190529072726.7875-1-david@redhat.com>
References: <20190529072726.7875-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 29 May 2019 07:27:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 1/2] s390x: Align vector registers to 16
 bytes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11e2bfef7990 ("tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store")
revealed that the vregs are not aligned to 16 bytes. Align them to
16 bytes, to avoid segfault'ing on x86.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7305cacc7b..1bed12b6c3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -66,7 +66,7 @@ struct CPUS390XState {
      * The floating point registers are part of the vector registers.
      * vregs[0][0] -> vregs[15][0] are 16 floating point registers
      */
-    CPU_DoubleU vregs[32][2];  /* vector registers */
+    CPU_DoubleU vregs[32][2] QEMU_ALIGNED(16);  /* vector registers */
     uint32_t aregs[16];    /* access registers */
     uint8_t riccb[64];     /* runtime instrumentation control */
     uint64_t gscb[4];      /* guarded storage control */
--=20
2.20.1


