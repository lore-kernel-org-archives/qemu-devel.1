Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C466CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FE72089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 08:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/DSS++N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FE72089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMSf3-0002TQ-Gg
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 04:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMSeH-00020e-J8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMSeF-0004Sb-H6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:02:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMSeF-0004SN-59
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 04:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571644957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hr1OHG39UCy98R1Ots7wf1qgjwemodVLj0DIZKtrV1w=;
 b=Y/DSS++NmSgW2yviJKad86GQ8ojts5QAO3QpCkKLyfpVvZYXpgVVdmHxAuU9ri7L5uJkwA
 duFEaB99OYNMXL+a+njYeU8tR33XXPsjQxULYXJezCBkdbjasHbtjz9wlzzsozdBnDeyvk
 0ZLTHmpltahbhwLK5dRFB8KQCbtyKzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-19dR9FbCMF20apAtS0vYeA-1; Mon, 21 Oct 2019 04:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 037691800E03;
 Mon, 21 Oct 2019 08:02:33 +0000 (UTC)
Received: from [10.36.116.198] (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4F425D717;
 Mon, 21 Oct 2019 08:02:31 +0000 (UTC)
Subject: Re: [PATCH v1 6/6] s390x/tcg: Fix VECTOR SUBTRACT WITH BORROW COMPUTE
 BORROW INDICATION
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191018161044.6983-1-david@redhat.com>
 <20191018161044.6983-7-david@redhat.com>
 <2761c05e-3189-244d-3fd5-b7090f94796a@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <afc9e2ca-17b7-abd5-4ac2-a65b6c88037f@redhat.com>
Date: Mon, 21 Oct 2019 10:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2761c05e-3189-244d-3fd5-b7090f94796a@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 19dR9FbCMF20apAtS0vYeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Ivan Warren <ivan@vmfacility.fr>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.10.19 20:55, Richard Henderson wrote:
> On 10/18/19 9:10 AM, David Hildenbrand wrote:
>> +    /* Isolate the carry to the next doubleword */
>>       tcg_gen_andi_i64(dl, th, 1);
>=20
> You can remove this now, since the only possible results are 0/1; it was =
only
> our subtract implementation that produced -1/0.
>=20
>=20
> r~
>=20

Right, we can simply reuse the VACCC implementation now:

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 87b5790db4..49f9916c37 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2240,20 +2240,13 @@ static void gen_sbcbi2_i64(TCGv_i64 dl, TCGv_i64 dh=
, TCGv_i64 al, TCGv_i64 ah,
 {
     TCGv_i64 th =3D tcg_temp_new_i64();
     TCGv_i64 tl =3D tcg_temp_new_i64();
-    TCGv_i64 zero =3D tcg_const_i64(0);
=20
-    tcg_gen_andi_i64(tl, cl, 1);
-    tcg_gen_sub2_i64(tl, th, al, zero, tl, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bl, zero);
-    tcg_gen_andi_i64(th, th, 1);
-    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
-    tcg_gen_andi_i64(dl, th, 1);
-    tcg_gen_mov_i64(dh, zero);
+    tcg_gen_not_i64(tl, bl);
+    tcg_gen_not_i64(th, bh);
+    gen_accc2_i64(dl, dh, al, ah, tl, th, cl, ch);
=20
     tcg_temp_free_i64(tl);
     tcg_temp_free_i64(th);
-    tcg_temp_free_i64(zero);
 }

This works as we only have to compute the bitwise complement.

--=20

Thanks,

David / dhildenb


