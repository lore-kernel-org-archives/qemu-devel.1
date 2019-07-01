Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53500C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9032089C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9032089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuUj-00019P-8e
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43504)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hhuKA-0006YL-3y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hhuK3-0000sT-P7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hhuK3-0000Gj-EW; Mon, 01 Jul 2019 07:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6342C30B4B5E;
 Mon,  1 Jul 2019 11:17:34 +0000 (UTC)
Received: from localhost (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F15017CD9;
 Mon,  1 Jul 2019 11:17:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  1 Jul 2019 13:17:17 +0200
Message-Id: <20190701111722.32068-2-cohuck@redhat.com>
In-Reply-To: <20190701111722.32068-1-cohuck@redhat.com>
References: <20190701111722.32068-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 01 Jul 2019 11:17:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/6] tests/tcg/s390x: Fix alignment of csst
 parameter list
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

From: Richard Henderson <richard.henderson@linaro.org>

The parameter list given in general register 1 shall be aligned
on a quadword boundary.  This test currently succeeds or fails
depending on the compiler version used and the accidential layout
of the function's stack frame.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tests/tcg/s390x/csst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/s390x/csst.c b/tests/tcg/s390x/csst.c
index 1dae9071fbd5..084d80af49f3 100644
--- a/tests/tcg/s390x/csst.c
+++ b/tests/tcg/s390x/csst.c
@@ -3,7 +3,7 @@
=20
 int main(void)
 {
-    uint64_t parmlist[] =3D {
+    uint64_t parmlist[] __attribute__((aligned(16))) =3D {
         0xfedcba9876543210ull,
         0,
         0x7777777777777777ull,
--=20
2.20.1


