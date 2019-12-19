Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEB4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB37206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gziABo40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB37206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxyC-0003Mf-68
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihxwY-0001sH-2F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihxwT-00059M-Qe
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:42:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihxwS-00055x-Cx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576770138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=me9ZPU+c8bJxVSjOc6Plgtp2X+N7KAZbVAcjU5yqHl4=;
 b=gziABo40O+G5fLuMMzyQEur+zJStU/sYYiI5cMWStjsbvE+swp0cPhL9kCiN8yHvZpW2kQ
 kx+dCmYI3ldEMaINb152mraaEpa4v339wVygnSf8+4gKIC0AvHslPHyfPU9vImAm7Pl1eN
 jyIxhRm24fk5Aq55hLFKpefa7X8al2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-lW5dPG7pNmGXAE6OaDwaiw-1; Thu, 19 Dec 2019 10:42:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so1512296wmt.4
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 07:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vj9OEH3kSVf6ONmGZaBheO/z8fqQYZnEv529gnM98pM=;
 b=m256rxBkf06qUiII7Qc826jRlJ24c44lDbr+OVlW6LcCsiqSFFitdJN0zhkBrGDYqz
 mQQGpUmYkW+zG+zh0GZxYIVCRIS7gEbnHsyBNg8u6gXBrQCYLdq3lmv5bt8TZGm6npeG
 Lcs6TxhIOerAJExgdc3LqxqkW+miOqaBtkrsCUmE8/Af7MmCV3wsFXn7K4OugBv7uJo6
 q3i2cHi7NjnMIca+KQS5idDOF5hP6wKXQsTuMZ5flFbRideOyedVF8kTUvWeXdOjRz+3
 sCcxfVxvX7Uyp8YRVszbV6FjyeeIrYNYK0ajQJDiQW7Vs/Jpg08TGlsnhkm/ulbKgCV8
 vwCw==
X-Gm-Message-State: APjAAAX1ERdsFlF6uhteT7/i7thYLiGPbHYHE/gDwp54u7tacCtWrfCo
 AC07vyOUzQBxqBpf9G8Hhop1PLL2/6QHkCPbJnMcxXhioBJ+Y9iPj3ga0ic1lwSNGufidq9n4tD
 PqGY4MTvvFCaadwQ=
X-Received: by 2002:a7b:c934:: with SMTP id h20mr10610337wml.103.1576770136582; 
 Thu, 19 Dec 2019 07:42:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3Vmv2aPm0h4MUqUvqq/85p0P45e/WyS7uSayfXHyxGI8gMBL5fCN3Y8ZACsT5T43lFm5sdQ==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr10610320wml.103.1576770136406; 
 Thu, 19 Dec 2019 07:42:16 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id f1sm6665510wru.6.2019.12.19.07.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 07:42:15 -0800 (PST)
Subject: Re: [PATCH 2/2] target/mips: Correct data on deprecated r4k machine
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1576764920-24514-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1576764920-24514-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35b7c79e-eab9-b79a-d6c7-2c75496b279b@redhat.com>
Date: Thu, 19 Dec 2019 16:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576764920-24514-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: lW5dPG7pNmGXAE6OaDwaiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 3:15 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Change the release since r4k machine is deprecated from 4.2 to 5.0.
>=20

Fixes: d32dc61421b
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>   qemu-deprecated.texi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 62680f7..f71c740 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -254,7 +254,7 @@ The 'scsi-disk' device is deprecated. Users should us=
e 'scsi-hd' or
>  =20
>   @section System emulator machines
>  =20
> -@subsection mips r4k platform (since 4.2)
> +@subsection mips r4k platform (since 5.0)
>  =20
>   This machine type is very old and unmaintained. Users should use the 'm=
alta'
>   machine type instead.
>=20


