Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7218C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C23D2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHd18Nhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C23D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDbN-0005hW-Du
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDYx-0003nH-LD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:35:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25899
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFDYv-0004mf-W2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599471345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P7heGYKj56N7tolGMwQynC06D8t5O1yJA6HFwtnMoj8=;
 b=VHd18Nhx3uAw5iIYPNPhUerdQBQJAkIZqG4V/QtGsXMN6fkU5LYZEotVjTJ1kabmA1YKpJ
 zatnJXf7kGnIcFbdbgAqDVvyJS5ir7X5kSOvrftu2X3buL5gh36/KEU0SAd84zTWnYupUq
 sIhZ0P9l5HHg5OOBVrndUXumbDF6IvQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-P-ho1VZLPEicQBW5BM2O7Q-1; Mon, 07 Sep 2020 05:35:43 -0400
X-MC-Unique: P-ho1VZLPEicQBW5BM2O7Q-1
Received: by mail-wm1-f70.google.com with SMTP id w3so3785793wmg.4
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=P7heGYKj56N7tolGMwQynC06D8t5O1yJA6HFwtnMoj8=;
 b=pptKJx2XHkILeRt2EPdgcDfpLjovT1lwLg8IOoXz+WbFV43C2jXDQxtB+Ok9HHdxI3
 dBD+4n5FVzqJfknGUg6eo3BcMC2nXYS2Gjg/XyX15efhXLpLR2/22gMGronEHMfoz6ue
 s7vADXYqbVT9vJ5MbEXG40985M1PtUw19FOqwyuNwkb7gjF0QzYp8EBiujI7TLp3wGs1
 HM7WR+XYu2KMor6Xz1FwcQWzHAEQkT0hhE2u4vOXk3A2tNfabLXCW78YnruOqAoec8fC
 NvHNx3l0X4XHg1asszoEfkZAxXHSYrOC2UO/o2Y+zPHHaTox9dJ4/hyxvHv5mmvBH/Hy
 eTNA==
X-Gm-Message-State: AOAM533bVrEo0Lr4Gck5KtM/H58Uo39LK3ev8yzRYlIZ+ZwFJC6FntI5
 GdaIyKDgAWcfI9jwWyIvDyIDc0AkKoYHs7+q15h1zZ5KZGhB5JNk1nGu+RpLKEmOXPSClJyYF84
 YhTdOYAObl9PqD3A=
X-Received: by 2002:adf:ed09:: with SMTP id a9mr20120847wro.407.1599471342681; 
 Mon, 07 Sep 2020 02:35:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkYHyRFdzZVlTBt8755V3gP2Ih01Jo7fdKK1YYBvpjISMPItmh4waLbe2iOFUk0t1kijHAEA==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr20120835wro.407.1599471342516; 
 Mon, 07 Sep 2020 02:35:42 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m13sm27117679wrr.74.2020.09.07.02.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 02:35:42 -0700 (PDT)
Subject: Re: [PATCH] file-win32: Fix "locking" option
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907092739.9988-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <75e6ec01-6ee5-a153-3b20-f29c9cc91d1c@redhat.com>
Date: Mon, 7 Sep 2020 11:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907092739.9988-1-kwolf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.69, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sw@weilnetz.de, luoyonggang@gmail.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 11:27 AM, Kevin Wolf wrote:
> The intended behaviour was that locking=off/auto work and have no
> effect (to remain compatible with file-posix), whereas locking=on would
> return an error. Unfortunately, the code forgot to remove "locking" from
> the options QDict, so any attempt to use the option would fail.
> 
> Replace the option parsing code for "locking" with something that is
> part of the raw_runtime_opts QemuOptsList (so it is properly removed
> from the QDict) and looks more like file-posix.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  block/file-win32.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/block/file-win32.c b/block/file-win32.c
> index ab69bd811a..e2900c3a51 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -299,6 +299,11 @@ static QemuOptsList raw_runtime_opts = {
>              .type = QEMU_OPT_STRING,
>              .help = "host AIO implementation (threads, native)",
>          },
> +        {
> +            .name = "locking",
> +            .type = QEMU_OPT_STRING,
> +            .help = "file locking mode (on/off/auto, default: auto)",
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -333,6 +338,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>      Error *local_err = NULL;
>      const char *filename;
>      bool use_aio;
> +    OnOffAuto locking;
>      int ret;
>  
>      s->type = FTYPE_FILE;
> @@ -343,10 +349,24 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>          goto fail;
>      }
>  
> -    if (qdict_get_try_bool(options, "locking", false)) {
> +    locking = qapi_enum_parse(&OnOffAuto_lookup,
> +                              qemu_opt_get(opts, "locking"),
> +                              ON_OFF_AUTO_AUTO, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +    switch (locking) {
> +    case ON_OFF_AUTO_ON:
>          error_setg(errp, "locking=on is not supported on Windows");
>          ret = -EINVAL;
>          goto fail;
> +    case ON_OFF_AUTO_OFF:
> +    case ON_OFF_AUTO_AUTO:
> +        break;
> +    default:
> +        g_assert_not_reached();
>      }
>  
>      filename = qemu_opt_get(opts, "filename");
> 


