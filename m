Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F27C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400952080C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400952080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCkX-0006Gi-JG
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54702)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hZBYd-0001wU-6I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hZBYc-00016R-6y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hZBYb-00013X-4I; Fri, 07 Jun 2019 05:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8B5BA00F9;
 Fri,  7 Jun 2019 09:53:07 +0000 (UTC)
Received: from localhost (dhcp-192-191.str.redhat.com [10.33.192.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 921F15BBC3;
 Fri,  7 Jun 2019 09:53:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  7 Jun 2019 11:52:12 +0200
Message-Id: <20190607095237.11364-11-cohuck@redhat.com>
In-Reply-To: <20190607095237.11364-1-cohuck@redhat.com>
References: <20190607095237.11364-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 07 Jun 2019 09:53:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/35] s390x/tcg: Fix max_byte detection for
 stfle
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
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

used_stfl_bytes is 0, before initialized via prepare_stfl() on the
first invocation. We have to move the calculation of max_bytes after
prepare_stfl().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index ee67c1fa0c51..34476134a407 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -669,7 +669,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t a=
ddr)
 {
     const uintptr_t ra =3D GETPC();
     const int count_bytes =3D ((env->regs[0] & 0xff) + 1) * 8;
-    const int max_bytes =3D ROUND_UP(used_stfl_bytes, 8);
+    int max_bytes;
     int i;
=20
     if (addr & 0x7) {
@@ -677,6 +677,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t a=
ddr)
     }
=20
     prepare_stfl();
+    max_bytes =3D ROUND_UP(used_stfl_bytes, 8);
     for (i =3D 0; i < count_bytes; ++i) {
         cpu_stb_data_ra(env, addr + i, stfl_bytes[i], ra);
     }
--=20
2.20.1


