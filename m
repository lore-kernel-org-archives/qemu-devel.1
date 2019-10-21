Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D5CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C5E20684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxorEaJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C5E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSjF-0003le-VG
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMSiX-0003Jr-G6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMSiW-0005mL-Co
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:07:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMSiW-0005ls-8k
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571645223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1R6phxmA9l+zKescKRTSrZ84ED3s62aeClKiRBjUo4=;
 b=cxorEaJukd9Z6l3PzkPOzuGRxIuTshNtPS2KXhX6EwMPNIQ8O5iKTezuQQkgqg+8R0o8D6
 yKUaNXYw5RS6Sw4916GhaHvGP2ZkILZn179zM/GujHJKCUezw72JLtwEq5zirLrKcBKVKQ
 QqN0+/atQ4+Rv2NjKMT9QdD1GNPZSsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Bq15LSsjMtK_AOJ09_Advg-1; Mon, 21 Oct 2019 04:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE2DF80183E;
 Mon, 21 Oct 2019 08:06:57 +0000 (UTC)
Received: from [10.36.116.198] (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92D8919C58;
 Mon, 21 Oct 2019 08:06:56 +0000 (UTC)
Subject: Re: [PATCH v1 5/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW
 INDICATION
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-6-david@redhat.com>
 <20ec7d6d-455b-2e6f-43fb-75884f580d34@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5bb5171f-46f0-23ce-99b0-57f07004cc7f@redhat.com>
Date: Mon, 21 Oct 2019 10:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20ec7d6d-455b-2e6f-43fb-75884f580d34@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Bq15LSsjMtK_AOJ09_Advg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.10.19 21:11, Richard Henderson wrote:
> On 10/18/19 9:10 AM, David Hildenbrand wrote:
>> Testing this, there seems to be something messed up. We are dealing with
>> unsigned numbers. "Each operand is treated as an unsigned binary integer=
."
>> Let's just implement as written in the PoP:
>>
>> "A subtraction is performed by adding the contents of
>>   the second operand with the bitwise complement of
>>   the third operand along with a borrow indication from
>>   the rightmost bit position of the fourth operand and
>>   the result is placed in the first operand."
>>
>> Fixes: 48390a7c2716 ("s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW I=
NDICATION")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   target/s390x/translate_vx.inc.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20

I'll convert this patch to

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 40bcc1604e..d9403a8163 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2207,13 +2207,13 @@ static void gen_sbi2_i64(TCGv_i64 dl, TCGv_i64 dh, =
TCGv_i64 al, TCGv_i64 ah,
                          TCGv_i64 bl, TCGv_i64 bh, TCGv_i64 cl, TCGv_i64 c=
h)
 {
     TCGv_i64 tl =3D tcg_temp_new_i64();
-    TCGv_i64 zero =3D tcg_const_i64(0);
+    TCGv_i64 th =3D tcg_temp_new_i64();
=20
-    tcg_gen_andi_i64(tl, cl, 1);
-    tcg_gen_sub2_i64(dl, dh, al, ah, bl, bh);
-    tcg_gen_sub2_i64(dl, dh, dl, dh, tl, zero);
+    tcg_gen_not_i64(tl, bl);
+    tcg_gen_not_i64(th, bh);
+    gen_ac2_i64(dl, dh, al, ah, tl, th, cl, ch);
     tcg_temp_free_i64(tl);
-    tcg_temp_free_i64(zero);
+    tcg_temp_free_i64(th);
 }



--=20

Thanks,

David / dhildenb


