Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65307C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2360C2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zvp9uMPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2360C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydCL-0004Hx-BJ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iydBA-0002pS-3j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iydB8-0005Rg-Ci
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:58:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iydB7-0005QH-Ja
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580741899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVVxWbpsyTxaHh0NI4Ejuf7ancAOA9U5sjQvbJWK4aw=;
 b=Zvp9uMPy0R2wPoGj8A+H62cvC+2VP5c0S/pBom4UIpgNcuH/dTRO4GzXlfJjFV7ldk6kLL
 Tn+Ldu6DUSLQqPt/fvKq+YC+oFhu8re6XRtfYlpBBR45DsQiE9fWRyspx9hoSinzGHu5Wj
 nNSamkA6fQi6CWKFO9JlF0LoXTl5ooM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-IOpJXRuQNRSeDvWloxRMcA-1; Mon, 03 Feb 2020 09:58:15 -0500
Received: by mail-wr1-f71.google.com with SMTP id m15so4121941wrs.22
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mEriLGrC3/SGuMkSPWYgIPFJHulZ0p50W0lj/DRSIZY=;
 b=Q8VK6tmKN1GIJYNbG/HAdRd3aa6wEZFWamsBx7Iac4ARFZikqe2zNcaS6esQEUiZi8
 ZCk6RW9BEajRTtqrI2+euOXc9gJ1XA5dqvOnURFkdTxu3PJyfvnAhUQ9W3rP8FmZ8wAa
 n/f7njGdrqC4OT7to70CuG8WZhWgCBLUg3/WWZXzHFTxUfIFXbtjRbSIkfFR3vWVEaaO
 wqoxYPzuQMeO7GDwk0eNjEe2v+L15ypNFfl7EoKIJC5XPLh+j92l0z7bmvQr/jZCJ0Cb
 Z2Nt+SSLIAEEyy60/iu4+nnglUo1cv4TlkUphi4oslMXdfzSB9dQ2sWVw55AEn9qxjYG
 0GUA==
X-Gm-Message-State: APjAAAUlkG/KIXBW1fE6TsvHn+H5bW+zcMFsKvCHkN9sU8o4Wl/QqnK2
 OsyGOXrKwz+cg9MPM7RPJ+mPGsB4Vmi4woFzk/SZXftAGHwjxsBAfiHZ80DpH3YHqKJYDtj8Frq
 GZEKlOq8t79ChmSQ=
X-Received: by 2002:a1c:7d8b:: with SMTP id
 y133mr30635191wmc.165.1580741894457; 
 Mon, 03 Feb 2020 06:58:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqww0Ftsk6FaU0D8LvHhl+BJJAwQ6kD3IpGVQjyg927pw5IsgvBheGD+OWHvTrF4uTNshGOMfg==
X-Received: by 2002:a1c:7d8b:: with SMTP id
 y133mr30635164wmc.165.1580741894237; 
 Mon, 03 Feb 2020 06:58:14 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id v8sm25786621wrw.2.2020.02.03.06.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2020 06:58:13 -0800 (PST)
Subject: Re: [PATCH v3 15/17] .travis.yml: drop the travis_retry from tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200203090932.19147-1-alex.bennee@linaro.org>
 <20200203090932.19147-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f4a816c-79bf-7828-b98c-b18f31bb3a2e@redhat.com>
Date: Mon, 3 Feb 2020 15:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203090932.19147-16-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: IOpJXRuQNRSeDvWloxRMcA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 10:09 AM, Alex Benn=C3=A9e wrote:
> This was a crutch when we introduced it - however it does have the
> disadvantage of causing tests to timeout with large amounts of logs.
> Lets drop it and see if the stability has improved since.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 022462f6981..875671325c8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -103,7 +103,12 @@ script:
>       else
>           $(exit $BUILD_RC);
>       fi
> -  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(ex=
it $BUILD_RC); fi
> +  - |
> +    if [ "$BUILD_RC" -eq 0 ] ; then
> +        ${TEST_CMD} ;
> +    else
> +        $(exit $BUILD_RC);
> +    fi
>   after_script:
>     - if command -v ccache ; then ccache --show-stats ; fi
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


