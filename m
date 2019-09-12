Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD60C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 22:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AED20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 22:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlpM9MNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AED20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8toh-0003AI-D6
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 18:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1i8tnx-0002hz-Ah
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1i8tnw-0004M9-3s
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:12:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1i8tnv-0004Lw-WA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 18:12:36 -0400
Received: by mail-ot1-x341.google.com with SMTP id h17so27011592otn.5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=fbTyolerSTELJCoHG8xVxQ+aF5ZczYp131brQWOzIhA=;
 b=tlpM9MNicW1zxI0E8t6eqpe3wb5B8AKCeLLUiKusbVbHTcoPrWy+HX+3vMa4Nj0tzq
 GJVjrMeU92y4/OxvBUGHN+Yv7EOYLLl55aKOBsETCd0TiUPIbekPgQck7cZc6OkaOZxW
 ZCFn1ri8jsaBkG99MulROahojO6rfAdos+AphwxAbQk8r1RoczVxUTEvk4CsMbS9esX7
 3jpNmshjMQjtQyAbEHOxexYxZrI+teVM4/+8YkhhUaJo4BbEUojPqjjmJ/7RCH6cD9LZ
 8+Bo/h3hhSgKKcA6o7eEtXs9dAPgNsoVNH0QqC6lT6BH8HZW65ZX/YaMa3rRUvxefkLI
 KFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=fbTyolerSTELJCoHG8xVxQ+aF5ZczYp131brQWOzIhA=;
 b=KuF4DOPhF3ufXb3xbbKMtmT+xgIncEGrzZm08+QWRdZOITsTrOUsSwc1YL8xOSU2NB
 rJBWXlftr84DDfcgLNOr88lWhBeLq2oclgRynziM9sulN+9UD/bp67raEt/LN2qY1RbA
 9JDGTQmJATLmBjejjWAOAGtsPv1mCBJvrDWGzKDMz3EzzJptWOm/OqXNB7chxoLEF9c/
 NMgRSpXFCMILO/r4mzVMEMVkYe/K3ZOo7VkG8BHxg19IXoLj8oE/BhL/25voyRoyJl9l
 zJLUvhrOgQW3nC3bRcxK4GGks6audptZmwxIAV8PdXielAdMPI9XDgLcKqPP42m+M95d
 5inA==
X-Gm-Message-State: APjAAAXqOpd2wPt60pz7XjqDRwx2G5gTZysNeY1L4MowbrisyOh9Cgq9
 ynS2Ic5fpmqeo4L5Cp2hoG7xQgFc
X-Google-Smtp-Source: APXvYqx6qa8zoZaUlXSD3o5TpruUwmuEqd1UotiatiQStcaXyaiP/YDZ5Oeb3cGGbMBkjXvYX+E5SQ==
X-Received: by 2002:a9d:7006:: with SMTP id k6mr34059426otj.303.1568412754539; 
 Fri, 13 Sep 2019 15:12:34 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l6sm8747463otr.71.2019.09.13.15.12.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Sep 2019 15:12:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Bishara AbuHattoum <bishara@daynix.com>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190819131620.1302-2-bishara@daynix.com>
References: <20190819131620.1302-1-bishara@daynix.com>
 <20190819131620.1302-2-bishara@daynix.com>
Message-ID: <156833130242.26182.17002244700908394194@sif>
User-Agent: alot/0.7
Date: Thu, 12 Sep 2019 18:35:02 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 1/1] qga-win: network-get-interfaces
 command name field bug fix
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Bishara AbuHattoum (2019-08-19 08:16:20)
> Network interface name is fetched as an encoded WCHAR array, (wide
> character), then it is decoded using the guest's CP_ACP Windows code
> page, which is the default code page as configure in the guest's
> Windows, then it is returned as a byte array, (char array).
> =

> As stated in the BZ#1733165, when renaming a network interface to a
> Chinese name and invoking this command, the returned name field has
> the (\ufffd) value for each Chinese character the name had, this
> value is an indication that the code page does not have the decoding
> information for the given character.
> =

> This bug is a result of using the CP_ACP code page for decoding which
> is an interchangeable code page, instead CP_UTF8 code page should be
> used for decoding the network interface's name.
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3D1733165
> =

> Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands-win32.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6b67f16faf..64b1c754b0 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1387,12 +1387,12 @@ static IP_ADAPTER_ADDRESSES *guest_get_adapters_a=
ddresses(Error **errp)
>  static char *guest_wctomb_dup(WCHAR *wstr)
>  {
>      char *str;
> -    size_t i;
> +    size_t str_size;
> =

> -    i =3D wcslen(wstr) + 1;
> -    str =3D g_malloc(i);
> -    WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK,
> -                        wstr, -1, str, i, NULL, NULL);
> +    str_size =3D WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL=
, NULL);
> +    /* add 1 to str_size for NULL terminator */
> +    str =3D g_malloc(str_size + 1);
> +    WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, str_size, NULL, NULL);
>      return str;
>  }
> =

> -- =

> 2.17.2
>=20

