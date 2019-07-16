Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFE1C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1880E20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj5TGSCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1880E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOgn-0005GF-CN
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46811)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnOgc-0004rl-A4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnOgb-000133-47
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:44:10 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnOga-00012H-Ja
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:44:09 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so21354232oth.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8d87O2jKLySwtlcRqG0KA8pj/VdIswPpPOmMTFhvFBU=;
 b=Dj5TGSCk/dN3cvDSz1P+KDxnB+qxPFAZXBhUMUJqM8mAx+JWozzOC/a8Ukk61WX2Hf
 q+N5Nw068eEUlCxD+MC8mYktFADlj1+XRPQF1O/Su6UFic2nS4NsS89+CYs3FTV+I6Di
 Yk58sp6Ta5BkS6Hyfe7JsVn/+hVfsI0jLI4Q2wAplSCrxhHISoJVWp/iJhwZPNE6mrcc
 ZZDEeMdY+vkciEjFRXuFpiOCEl5Vv2blll9/DG+jg/+LKi1jdHyUWX8xYuHG9XMQAVe5
 fsWpi9M/3KEjmYaM5sDViXFRUJH/TC6itKWS8ZNlVo9CljF6wHZQTNe+LYOW2CAz/eeV
 Og9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8d87O2jKLySwtlcRqG0KA8pj/VdIswPpPOmMTFhvFBU=;
 b=uh9tdtfuK0qrGv6avc10+dFYd4+Xj9Y1xxCZ0HygNsdWqAyd18YoYsI03Mf5M8f9QJ
 GzX0omo6W3AkVid6Bxg47vh/F2bfEOHzgXnYIprrsr9GHUmxb2Y88QNNp4MwHCOXS2t2
 kLqP2QgHo10YhNnoT7oXt+3gnwpe5wP+yRbxjZkOphn+fvWBtRHH1dketU43IasUPP55
 Bpx0JttCzVBnYgWSVpM2U+H8eSMzlc+5wW0JklSouRd2MWAkIm6C9ccgrvbEvGqk8C7X
 BMWBJYftwDzScZ/UowKsfZW4DgXSZDccvptmhsXfJ75mMjTWDt+KHgnQ2L8ONWYeNtF6
 7Z5g==
X-Gm-Message-State: APjAAAXC7wwi6ZznvnLbpvZUPyNI1wJOE5/3vnU3YDsz2s31zYO3Z/Fi
 73sV6sQ5zIc6kYIhTtK0glkungggHOr9Ng4hs0b/hw==
X-Google-Smtp-Source: APXvYqzHl/lswCQuBSdzUs5jXSm9vL2sTIWDztnCkF83PmOA0LNQ/ShIu0bdv92WKoH78n3VcR/SaohkJl50hXBu4w0=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr17840211otr.232.1563288247482; 
 Tue, 16 Jul 2019 07:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190716140133.8578-1-alex.bennee@linaro.org>
In-Reply-To: <20190716140133.8578-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 15:43:56 +0100
Message-ID: <CAFEAcA8V2h3pqC_g5aaD2gsv08c18YZKRcxLM+hDNuMv_C55=Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1] linux-user: unparent CPU
 object before unref
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
Cc: Riku Voipio <riku.voipio@iki.fi>, 1836558@bugs.launchpad.net,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ccing the QOM maintainers to make sure we have the
QOM lifecycle operations right here...

On Tue, 16 Jul 2019 at 15:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When a CPU object is created it is parented during it's realize stage.
> If we don't unparent before the "final" unref we will never finzalize
> the object leading to a memory leak. For most setups you probably
> won't notice but with anything that creates and destroys a lot of
> threads this will add up. This goes especially for architectures which
> allocate a lot of memory in their CPU structures.
>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1836558
> Cc: 1836558@bugs.launchpad.net
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 39a37496fed..4c9313fd9d0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7183,6 +7183,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>                            NULL, NULL, 0);
>              }
>              thread_cpu =3D NULL;
> +            object_unparent(OBJECT(cpu));
>              object_unref(OBJECT(cpu));
>              g_free(ts);
>              rcu_unregister_thread();

I think (as I mentioned on IRC) that we also need to unrealize
the CPU object, because target/ppc at least does some freeing
of memory in its unrealize method. I think we do that by
setting the QOM "realize" property back to "false" -- but that
might barf if we try it on a CPU that isn't hotpluggable...

thanks
-- PMM

