Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EB9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C342B2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 06:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+31myNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C342B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ7VY-0004pY-S8
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 01:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZ7UK-00040P-NV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZ7UI-0006Ep-Mw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:04:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZ7UI-0006ES-JP
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 01:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574661881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ot0NJdWkQNmsmox6r+YbvvtibIqJK4VygzoFGdX+ng=;
 b=g+31myNZjMQfBx0mIllK/0Zpc4YJkBM8wdcPLtUT/S8NE9Y0GsUrDrY8ENveYPtE1SJoNk
 mYXzK0CO0ORQM2GAE5m9f9OaNBojo0l3O6AI77yXXokhuUlGmhjdQUrb7Noqh9/eJxd4sF
 sNPcTC1LeEFySuwjSvJHvndSDoLUmdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-LlPSZyZTP4ijNBP_fpYB1w-1; Mon, 25 Nov 2019 01:04:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554571883525;
 Mon, 25 Nov 2019 06:04:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD191001281;
 Mon, 25 Nov 2019 06:04:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82DB811385C7; Mon, 25 Nov 2019 07:04:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] util/cutils: Fix incorrect integer->float conversion
 caught by clang
Date: Mon, 25 Nov 2019 07:04:34 +0100
Message-Id: <20191125060434.22997-2-armbru@redhat.com>
In-Reply-To: <20191125060434.22997-1-armbru@redhat.com>
References: <20191125060434.22997-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: LlPSZyZTP4ijNBP_fpYB1w-1
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
Cc: Fangrui Song <i@maskray.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fangrui Song <i@maskray.me>

Clang does not like do_strtosz()'s code to guard against overflow:

    qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned lo=
ng' to 'double' changes value from 18446744073709550592 to 1844674407370955=
1616 [-Werror,-Wimplicit-int-float-conversion]

The warning will be enabled by default in clang 10. It is not
available for clang <=3D 9.

val * mul >=3D 0xfffffffffffffc00 is indeed wrong.  0xfffffffffffffc00
is not representable exactly as double.  It's half-way between the
representable values 0xfffffffffffff800 and 0x10000000000000000.
Which one we get is implementation-defined.  Bad.

We want val * mul > (the largest uint64_t exactly representable as
double).  That's 0xfffffffffffff800.  Write it as nextafter(0x1p64, 0)
with a suitable comment.

Signed-off-by: Fangrui Song <i@maskray.me>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Patch split, commit message improved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191122080039.12771-3-armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 util/cutils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index fd591cadf0..77acadc70a 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -239,10 +239,12 @@ static int do_strtosz(const char *nptr, const char **=
end,
         goto out;
     }
     /*
-     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their trip
-     * through double (53 bits of precision).
+     * Values near UINT64_MAX overflow to 2**64 when converting to double
+     * precision.  Compare against the maximum representable double precis=
ion
+     * value below 2**64, computed as "the next value after 2**64 (0x1p64)=
 in
+     * the direction of 0".
      */
-    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {
+    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
         retval =3D -ERANGE;
         goto out;
     }
--=20
2.21.0


