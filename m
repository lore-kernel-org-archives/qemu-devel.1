Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C94C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F5F206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBisuLbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F5F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkm8A-0005Wu-0u
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkm7Z-00056D-RW
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:13:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29609
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkm7T-0003GD-KT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592216014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/F+fJs/IglwSy1W4jigQ/SxZk05uXn55JHXEgTyk3Q8=;
 b=WBisuLbYmNlrKCMPWCXRDyGtkZn3nSsjZNtwAssJArzqxd6DzNvt7JJD5fIMNKj5YrC6NJ
 DX/8Tue9RHI4X0ITUISDpiefz9k1+ZSawVlSKXQyBCaaNq+tbqwqywGfu6Me4nnopvKhZg
 VDV0VESSVtGI1S9mtS+WkWUL9DZymPg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-nuA4iVeKMk-FuUYM1Axp_g-1; Mon, 15 Jun 2020 06:13:32 -0400
X-MC-Unique: nuA4iVeKMk-FuUYM1Axp_g-1
Received: by mail-wr1-f71.google.com with SMTP id e1so6881515wrm.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/F+fJs/IglwSy1W4jigQ/SxZk05uXn55JHXEgTyk3Q8=;
 b=n+fCFdMqyIp/N+e3kzjn9XD2PkVRb9vQ/0CSipOjVTt92lIjrTPaAhhSFiMgFJQqaT
 HFAC+DayU51AiRX1enw04dQOb3cihtq52gae0ISLPztjjrWrSi6ZETCl8iBZq/MucBRO
 CJMW7bMKshR2efWsedrGJv799d4/fqhtTcIl/4AmUen+wN53sBSBRTdVOOkxsiSWdzXE
 2OjHzSFR0exBXGddHBWIYPUdnjZRLbEp20Na8271HxwqimBYmi/vHDqF7GD9F9G9O6fW
 GtcngD0vQF3gH8kllOrkQu+pOWHWpOCGVwxAAEdqfl6my+M5pj2fj56ETr9TDrRgkT0Q
 mUUg==
X-Gm-Message-State: AOAM530RqdqE0byC/iRPB1RwNDW98d4Bdc0Rka+E+zA9WNlj5XUUB/Hg
 qiCh26W5m+KpNub9RbyL0BOYIFyPTnfASD5RQzwhjIZv3YQ8HdAU4IX8klGlNVXLijXJ0YoPbtP
 fodGcTurHRNU0Rxg=
X-Received: by 2002:a5d:4090:: with SMTP id o16mr27659250wrp.354.1592216011594; 
 Mon, 15 Jun 2020 03:13:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP67opBMj598Qazy0GF0d+Yz6rtO3h1h0W/aimpJdX/8s7AhErmNh5AHaS4NZcorc1656GQw==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr27659231wrp.354.1592216011383; 
 Mon, 15 Jun 2020 03:13:31 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f2sm2665912wmj.39.2020.06.15.03.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 03:13:30 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] semihosting: don't send the trailing '\0'
To: konrad@adacore.com, qemu-devel@nongnu.org
References: <1592215252-26742-1-git-send-email-frederic.konrad@adacore.com>
 <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
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
Message-ID: <fff8f08b-5fbe-93ff-d0e9-c45940f649c6@redhat.com>
Date: Mon, 15 Jun 2020 12:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 12:00 PM, konrad@adacore.com wrote:
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Don't send the trailing 0 from the string.
> 

Fixes: a331c6d7741
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/semihosting/console.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
> index 22e7827..9b4fee9 100644
> --- a/hw/semihosting/console.c
> +++ b/hw/semihosting/console.c
> @@ -52,7 +52,9 @@ static GString *copy_user_string(CPUArchState *env, target_ulong addr)
>  
>      do {
>          if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
> -            s = g_string_append_c(s, c);
> +            if (c) {
> +                s = g_string_append_c(s, c);
> +            }
>          } else {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "%s: passed inaccessible address " TARGET_FMT_lx,
> 


