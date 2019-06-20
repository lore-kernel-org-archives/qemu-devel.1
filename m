Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6BDC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 02:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAD62084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 02:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LcQnOJqC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ds1+IoOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAD62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdmbr-0001wO-Mf
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 22:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrew@aj.id.au>) id 1hdmZ4-00007l-BW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1hdmSq-0008Lp-Vx
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 22:06:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57171)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1hdmSh-00085V-Jr; Wed, 19 Jun 2019 22:06:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 359A22249A;
 Wed, 19 Jun 2019 22:05:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
 by compute4.internal (MEProxy); Wed, 19 Jun 2019 22:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type:content-transfer-encoding; s=fm3; bh=dmXgs
 LKzLmN5l4CutmavbHQ/3yEEP1xxqzMR0WF1HMg=; b=LcQnOJqCyn1m+W7KY4y2K
 UjdU6QGkIGp+BZ+fxLLdn+Zhfr7XTvQ2UXs5aaAiuYsjjaaYkiY8++zqpf6WDRRY
 PLg8CSG4ITuP6dn6PZrEgOhw958dRCx5Jv6yckqPEwWj8YTzi+4wUoRA2epOGnsC
 n1usSQx5BKDe8YNQtnnehSRoHefbpZ10/e9oSJNy4MqCAdUUbbLYTWPkH68IY/zq
 pvavqMoMfc7Pw1mQM8/3pX0stBbcFeNCSS8sPWAiJXKx1Eq5biLhgWb/slY1exFJ
 sAFEKhEoMq5rLDwYlwmXoNgzUoLjZtj4fEJyFAC2IOuFnWZVoV0cqYsMyrsP5NqW
 A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=dmXgsLKzLmN5l4CutmavbHQ/3yEEP1xxqzMR0WF1H
 Mg=; b=ds1+IoOVkEgM8nmYi9O6fG8kJI828ZFC6FzLa3x3tysYevqeWJVnD07LS
 J4Ergv72kS+mKz2Exy9W4sL6CZgOs47Pps+e2Lg7KiRwXBYpFEnA6xoVxGaCn7dI
 YyUNW8/1A8bKPHGrak4poA3juKYZiy97hhhRk4kNz9HXuxRJwGGLc8DAnAezFYO7
 5g6unonY+kB0aYfau6fCIinSL9GzNpuxrbCALCQ0gw6n1hAY75ulN/TgKGPlh3HM
 ayOuIZfhhzefGPG3crrGU+YgCKipAdH60a51Acs2h1esQwfNizbDK0zHBINQF4pA
 Hy+cAzvrqmBLyydGK9T6Cy0OdhaEQ==
X-ME-Sender: <xms:_ekKXQlFT9BiZqPSA5IOvElFCI3B-IHJjsSv_cCpfIVT13ayrZa5CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrtdefgdehfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
 rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
 grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
 rhfuihiivgeptd
X-ME-Proxy: <xmx:_ekKXRLUWvieLKf1Zw7Mtra4meypfS5RxOjWwlnmqnnqDOtucXn17Q>
 <xmx:_ekKXRG_9kO4JHhORrXdVPDCUHeooTc6K1znqeuSrhC0b5JYgwze4Q>
 <xmx:_ekKXSPgIcqDsIM9iVFyXzDe2qoAEttz3ZGzLCbWZjEBKKQX6DKVOw>
 <xmx:_ukKXeGr7a6v2cR9nNhfQQMryZyoyLzcnIU77-EIbLFDm78k20F9Nw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 8C09DE00A1; Wed, 19 Jun 2019 22:05:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-666-gb2312fa-fmstable-20190614v4
Mime-Version: 1.0
Message-Id: <d119d46f-e932-4b1c-a7f3-72417181448a@www.fastmail.com>
In-Reply-To: <20190618165311.27066-12-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-12-clg@kaod.org>
Date: Thu, 20 Jun 2019 11:35:49 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Peter Maydell" <peter.maydell@linaro.org>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: Re: [Qemu-devel] [PATCH v2 11/21] aspeed/timer: Ensure positive
 muldiv delta
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Christian Svensson <bluecmd@google.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wed, 19 Jun 2019, at 02:24, C=C3=A9dric Le Goater wrote:
> From: Christian Svensson <bluecmd@google.com>
>=20
> If the host decrements the counter register that results in a negative=

> delta. This is then passed to muldiv64 which only handles unsigned
> numbers resulting in bogus results.
>=20
> This fix ensures the delta being operated on is positive.
>=20
> Test case: kexec a kernel using aspeed_timer and it will freeze on the=

> second bootup when the kernel initializes the timer. With this patch
> that no longer happens and the timer appears to run OK.
>=20
> Signed-off-by: Christian Svensson <bluecmd@google.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/timer/aspeed_timer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 6501fa0768e7..1f0f1886fb2a 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -275,7 +275,11 @@ static void=20
> aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
>              int64_t delta =3D (int64_t) value - (int64_t)=20
> calculate_ticks(t, now);
>              uint32_t rate =3D calculate_rate(t);
> =20
> -            t->start +=3D muldiv64(delta, NANOSECONDS_PER_SECOND, rat=
e);
> +            if (delta >=3D 0) {
> +                t->start +=3D muldiv64(delta, NANOSECONDS_PER_SECOND,=
 rate);
> +            } else {
> +                t->start -=3D muldiv64(-delta, NANOSECONDS_PER_SECOND=
, rate);
> +            }
>              aspeed_timer_mod(t);
>          }
>          break;
> --=20
> 2.21.0
>=20
>

