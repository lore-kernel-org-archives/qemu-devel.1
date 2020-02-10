Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD45C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 23:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BF2206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 23:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YB6OBazV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BF2206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1I7m-0005RW-Sf
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 18:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1I77-0004wF-TS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 18:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1I75-0004Lq-P1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 18:05:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1I75-0004J5-IP
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 18:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581375908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OrIMTtWZiZqZe2COzIrX8VpCatS2QNZy2+vdNdDKUzA=;
 b=YB6OBazVWa7ae6vLVdKnMv+cJRHtCJ2lc5ombYvEi4OriUcObvEGf1smg22Gf5+BHekvj7
 dBx9N8cjcl4mt7iJYmhADoBXpczsAX2OBgBda4An5C38w4ZVKOHwCgaVwDRCoiyfnPvRib
 cfyWTEgYjgl71sUgxaa/6wd/NvPut3c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-iTJyqstEOm-mThwBnfuFUg-1; Mon, 10 Feb 2020 18:05:04 -0500
Received: by mail-qt1-f199.google.com with SMTP id b5so5512195qtt.10
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 15:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OHW+3onH4Mvb+QWTgDGx2jcbHumMAbkUinbMBB0hGok=;
 b=Co3ZU8dgjCihtbzRNuVdjxJrOfaIeqa4xoiRnpQVmQINqYEUPTMfuGFjAW8EUa4GLO
 HWYUebg7C8En2ePj/sxm55fGPvkuTnuC4ol7MY/70ctDKOaC6G73lubcSwCs6ICp3PdX
 s+WVolVumPwLoTFDqfABFuRsJgkwdHac15ugwBdrStDPDRlIi3GnsNkxVATVnw51plr+
 2ZqjWYI6RbOW8oJUwS3CM7tUMiSQjhhAQfVGzO6lQ3ch4bwjK35j6mUwToUdeNThEzxB
 IKAHBRRzw4SAO+YHuMNcSi0Q89s4zoaQPov69Jtcq3zQBMa5DTO05QabLbHmYVT6BZd6
 rjyQ==
X-Gm-Message-State: APjAAAUim5aO3y0ar84WN25cXmubJyVOdn1vSESfm3MfCgHcOITGuM0h
 ZZSLtSacUD3FIOfnPKH/eOe/kPAFbDHoVLxzrbiIyvThHyYK3uPeC1ID9QKRQomgoPOYy8GQRpS
 N6SRf6TGXJjHSYic=
X-Received: by 2002:aed:35e4:: with SMTP id d33mr12164493qte.389.1581375903930; 
 Mon, 10 Feb 2020 15:05:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyz24pqoSw4D20Lk5xJ7Wif2bicbIeKrmrJAbNzSN/QlbvFvM+EX63eQVZ7vk/I7YAmu9FaNQ==
X-Received: by 2002:aed:35e4:: with SMTP id d33mr12164465qte.389.1581375903672; 
 Mon, 10 Feb 2020 15:05:03 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id d18sm908640qke.75.2020.02.10.15.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 15:05:02 -0800 (PST)
Date: Mon, 10 Feb 2020 18:05:00 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] tests/migration: Add some slack to auto converge
Message-ID: <20200210230500.GD984290@xz-x1>
References: <20200210195731.177595-1-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200210195731.177595-1-dgilbert@redhat.com>
X-MC-Unique: iTJyqstEOm-mThwBnfuFUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, thuth@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 07:57:31PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> There's an assert in autoconverge that checks that we quit the
> iteration when we go below the expected threshold.  Philippe
> saw a case where this assert fired with the measured value
> slightly over the threshold. (about 3k out of a few million).
>=20
> I can think of two reasons:
>   a) Rounding errors

Yes, I feel like we're having approximate values here and there in
migration code. One simple example is that we calculate bandwidth
using sent bytes and timestamps, however our sent bytes should in most
cases increase with target page size only (4096 on x86), and then to
divide an ~100ms value which changes too from time to time, then
everything comes out of these inaccurate numbers could be inaccurate..

>   b) That after we make the decision to quit iteration we do one
>     more sync and that sees a few more dirty pages.

True..  I also didn't see how to guarantee the extra 1% will cover
this case either...

>=20
> So add 1% slack to the assertion, that should cover a and
> most cases of b, probably all we'll see for the test.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

... But if what we see are always 3K or around then maybe we only need
to fixup that special value.  Assuming this is for sure going to
unbreak tests:

Reviewed-by: Peter Xu <peterx@redhat.com>

(PS: I would probably remove this check as a whole :)

> ---
>  tests/qtest/migration-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index cf27ebbc9d..a78ac0c7da 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -1237,7 +1237,8 @@ static void test_migrate_auto_converge(void)
>      g_assert_cmpint(percentage, <=3D, max_pct);
> =20
>      remaining =3D read_ram_property_int(from, "remaining");
> -    g_assert_cmpint(remaining, <, expected_threshold);
> +    g_assert_cmpint(remaining, <,
> +                    (expected_threshold + expected_threshold / 100));
> =20
>      migrate_continue(from, "pre-switchover");
> =20
> --=20
> 2.24.1
>=20

--=20
Peter Xu


