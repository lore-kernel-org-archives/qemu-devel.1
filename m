Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB48C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7589720730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+U/Fga2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7589720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywqI-0000wV-N1
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iywpZ-0008S2-CR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iywpW-0005jk-IO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:57:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iywpW-0005dQ-Da
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580817441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VD0ohgWUap4ZR9v21UW0mFMEbDBvNR7eEh3rFIciSY=;
 b=T+U/Fga2p1ZPlmQDVhL6uwl+4SrvbDkb6AngsVGnCpAhpBz3JJ6NNZC99sGnAJWZ75o5U3
 iHQd/MKANp+4fXMOc5qm/6zi3kLP8ghL9l+1QF7afFkKeLP1pQD6jWkOos78G8zwlyzPcK
 4BLctsphiWsNr8Ip/UkG/+V47zGd/dY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-I95UmdYZOJWUaJkcUKu3xw-1; Tue, 04 Feb 2020 06:57:19 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so5786970wrs.22
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 03:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fjMyt7C72bxQ+hnFp6naT+0f4Iyvx9mzUZBjNISrnUg=;
 b=j8ADaoQXmAzsmbPkf6LOOWYzjP3G5jNfwzTFu7L6AyIfTNL40PmnJQmwmvWXgVxmnm
 4MoVJtMi29UM+JqOPYCpmjFTcBsHRS8RAEuRT8g6t0huDwXedLbb8vAjUdaI3ak/Rhy2
 qXEjVTOieKzI2RTMADi+Qdr0BybmyE1lqb7nhCKNYk8VBQ7LWSKn9ij3CGOCryJ7b3Hm
 yncwniZA+TF8Da+CUVqB0WdE4XYCiYgPJFzBmkW0ppKZd0u5i8dlXvFo75cStcccAXlz
 +UETUB+SwCxhaWL4o66jkV7/m+qgZgxTB9idXFNGKZTUC3S3Zjw9Ri2yKxGu4OBwjWA7
 TK9A==
X-Gm-Message-State: APjAAAX3xRP3N5MQrOazdKZ1UKl3FlDAgOPucP2uHOE2wLiRZKCWgm8U
 /VWfyOt4BsF6l9fHBbUjcGPTUYx36B9myTqY+ggAN5I1UtTboC1Cfbti2Bl0/6DTnQBl3SsW0iY
 za+fg0YqDY34B0fI=
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr21045287wro.375.1580817438618; 
 Tue, 04 Feb 2020 03:57:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzTaFcAxaErXzudaDi1vt0fVI92nMDyrUTW4g6f1J9mIKeNMczjXu2qIu9o6S+n5WfA7HhmQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr21045272wro.375.1580817438459; 
 Tue, 04 Feb 2020 03:57:18 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id c9sm3413334wmc.47.2020.02.04.03.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 03:57:17 -0800 (PST)
Subject: Re: [PATCH] .travis.yml: ensure python3-sphinx installed for docs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20200204105142.21845-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <66c6ba92-9f4c-846f-14b3-18fe5b29a102@redhat.com>
Date: Tue, 4 Feb 2020 12:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204105142.21845-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: I95UmdYZOJWUaJkcUKu3xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:51 AM, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index c1c6df475a8..8bdebd36c1f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -194,7 +194,7 @@ matrix:
>         addons:
>           apt:
>             packages:
> -            - python-sphinx
> +            - python3-sphinx
>               - texinfo
>               - perl
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


