Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878B0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F1020756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz+nEBj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F1020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WeR-0006tt-9P
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k5Wcm-0005u1-27
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:55:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k5Wck-0005Sx-EC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597161337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMF9wCch3Vo3DZkmu3xNhNm/K1u/RMVm799+qfOigrE=;
 b=bz+nEBj7hwWbW9lbfaJIPxNbStdXiD3Z0la6U7Sltem/hQSC8q+lp2p9AknwDrmjpPcev0
 cBbjlEVtaVxNqa2CAZKxTRux9NFZVqmwZfzG/e8yxGvb/gJ++Z9S8268Z0ZNAipe8XrOfI
 rjbESkmhnHiacyffIDKF3X95C8ToCjE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-yO5Ml4A3N1WVw6QvTKrspw-1; Tue, 11 Aug 2020 11:54:27 -0400
X-MC-Unique: yO5Ml4A3N1WVw6QvTKrspw-1
Received: by mail-oi1-f199.google.com with SMTP id r62so7652390oif.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cMF9wCch3Vo3DZkmu3xNhNm/K1u/RMVm799+qfOigrE=;
 b=oMLn+Zh5zsiP1r1HgvTjIH+7CGanHSAIooXHxJB2+wAyHwTfwvinYmiqnAnA77vZ+9
 79MdsWuEHbts/3PUwVfRPm5lSJxGOROvHvl6cA8QjjC3lnH36nt4qyA58kPufPxjqmng
 9hdFTmE8kLEnDGb1olKlEHp5+e+wvwas5i2n6Mzc0SaWJmjSSxFdV7SW56WrG1r74tNp
 kAzGm1d537fZF0EZXGi5oD53bQhbLSRSB74FxBMLX/GlKn6LcNxYQJXsE6nGIiqxSgR5
 NPhJ0d/xrCuM4kKxZ4CaJ1xWEeQsok4J+K6er3dmK7lHgm6jyNdYEYZIheJL4qVFUida
 2RLA==
X-Gm-Message-State: AOAM533KRBO3/r2E3667byj9SGbBWxH4UplXX7ocGo93TNGFwukii/ER
 y7Wv7hLuGNG2xgDxYuPtgaBpSqk2kpxFjS5pbtV6y9vBdKcGsTWBnQ/75ANpGI5onz85iYp3/kW
 bQIjBJN719eCjsSAx7CoAClQulojdtgg=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr5571120otq.81.1597161265644;
 Tue, 11 Aug 2020 08:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1bXr2TKap/N/+Dz+7mr9dwfeze9j9EI0YH5LK4GhYesmi3ijZ+8M5GwCg65Mn2gTqh4gXQ56aAZ1N3t6Wflk=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr5571115otq.81.1597161265449;
 Tue, 11 Aug 2020 08:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200811080830.289136-1-mreitz@redhat.com>
In-Reply-To: <20200811080830.289136-1-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 11 Aug 2020 18:54:09 +0300
Message-ID: <CAMRbyytS0HZLjHVmr4aKC3of4_EDxZXOqOzAornC1WbnYoxN-Q@mail.gmail.com>
Subject: Re: [PATCH] iotests/259: Fix reference output
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e065cd05ac9c1588"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e065cd05ac9c1588
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 11, 2020 at 11:08 AM Max Reitz <mreitz@redhat.com> wrote:

> The error message has changed recently, breaking the test.  Fix it.
>
> Fixes: a2b333c01880f56056d50c238834d62e32001e54
>        ("block: nbd: Fix convert qcow2 compressed to nbd")
>

Thanks for fixing this. I thought that I ran all the tests when I submitted
the change.

Is this new test that was not available in master when I submitted this, or
maybe I
missed something when running the tests?

I think I ran the tests using:

    SPEED=thorough check-block.sh

Nir


> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/259.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
> index e27b9ff38d..1aaadfda4e 100644
> --- a/tests/qemu-iotests/259.out
> +++ b/tests/qemu-iotests/259.out
> @@ -10,5 +10,5 @@ disk size: unavailable
>
>  --- Testing creation for which the node would need to grow ---
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=qcow2 size=67108864
> preallocation=metadata
> -qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver
> does not support resize
> +qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Cannot grow NBD nodes
>  *** done
> --
> 2.26.2
>
>
>

--000000000000e065cd05ac9c1588
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Aug 11, 2020 at 11:08 AM Max Reit=
z &lt;<a href=3D"mailto:mreitz@redhat.com">mreitz@redhat.com</a>&gt; wrote:=
<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">The error message has changed recently, breaking the test.=C2=
=A0 Fix it.<br>
<br>
Fixes: a2b333c01880f56056d50c238834d62e32001e54<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0(&quot;block: nbd: Fix convert qcow2 compressed =
to nbd&quot;)<br></blockquote><div><br></div><div>Thanks for fixing this. I=
 thought that I ran all the tests when I submitted the change.</div><div><b=
r></div><div>Is this new test that was not available in master when I submi=
tted this, or maybe I=C2=A0</div><div>missed something=C2=A0when running=C2=
=A0the tests?</div><div><br></div><div>I think I ran the tests using:</div>=
<div><br></div><div>=C2=A0 =C2=A0 SPEED=3Dthorough=C2=A0check-block.sh</div=
><div><br></div><div>Nir</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
Signed-off-by: Max Reitz &lt;<a href=3D"mailto:mreitz@redhat.com" target=3D=
"_blank">mreitz@redhat.com</a>&gt;<br>
---<br>
=C2=A0tests/qemu-iotests/259.out | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out<br>
index e27b9ff38d..1aaadfda4e 100644<br>
--- a/tests/qemu-iotests/259.out<br>
+++ b/tests/qemu-iotests/259.out<br>
@@ -10,5 +10,5 @@ disk size: unavailable<br>
<br>
=C2=A0--- Testing creation for which the node would need to grow ---<br>
=C2=A0Formatting &#39;TEST_DIR/t.IMGFMT&#39;, fmt=3Dqcow2 size=3D67108864 p=
reallocation=3Dmetadata<br>
-qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver d=
oes not support resize<br>
+qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Cannot grow NBD nodes=
<br>
=C2=A0*** done<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div>

--000000000000e065cd05ac9c1588--


