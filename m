Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B6C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CC226B2E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CC226B2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWj0w-0005Z5-Jm
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:00:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWixL-0002hL-Tk
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWixK-0004ZJ-NC
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:56:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hWixK-0004UX-FD; Fri, 31 May 2019 10:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AFC26EB9A;
	Fri, 31 May 2019 14:56:17 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E418917C2D;
	Fri, 31 May 2019 14:56:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 16:56:07 +0200
Message-Id: <20190531145608.28183-2-david@redhat.com>
In-Reply-To: <20190531145608.28183-1-david@redhat.com>
References: <20190531145608.28183-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 31 May 2019 14:56:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 1/2] s390x/tcg: Fix max_byte detection for
 stfle
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

used_stfl_bytes() is 0, before initialized via prepare_stfl() on the
first invocation. We have to move the calculation of max_bytes after
prepare_stfl().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index ee67c1fa0c..34476134a4 100644
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


