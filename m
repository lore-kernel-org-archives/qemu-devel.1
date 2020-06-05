Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8980C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724F2206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSVDrANf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724F2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhF2R-00020c-Jy
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhF1R-0001Ql-9y
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:16:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhF1Q-0001K9-Gn
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591373803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N4N9dng90zU+yz0JKSHeQzSyHk4aO+K4Ez6ELdvfHVI=;
 b=bSVDrANfZZQghcZLFc1lvO5NzzKoOCMLV2gYiPPbRyg/hhGs61ArZyioz7B6aLsKPJOR/b
 Q3iefpP8QBtRriILJZuODnkuUHvCTsR7Ip17bXpX+sTWPWIB+2xNOAeqYmLgVDixbdyxbO
 wkCJeXTtEh/RnDeKuWGWmfBK1BmUPZU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-ERzFHsuTOYazyBfqWqQeMA-1; Fri, 05 Jun 2020 12:16:42 -0400
X-MC-Unique: ERzFHsuTOYazyBfqWqQeMA-1
Received: by mail-wr1-f72.google.com with SMTP id a4so3960660wrp.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=N4N9dng90zU+yz0JKSHeQzSyHk4aO+K4Ez6ELdvfHVI=;
 b=NAPJYPwh4yjLcrt5hnIKCiSJEoX8sohB90/rfCBHsAByEouKbl3QwPmvONmx3FA06T
 S5v1FMiXJA4SJoDlu/Ft0waeiaQrTgDwJ4zlRJPcJkfwQECAyzz8MB+1CNKBWalONS1b
 FpllRZlXuWY5EmF6i5hijv7mkTy6HM9bI5L/wjAHnxnts2hNthOwPUPFR9249qdn2imJ
 5oZTc+gjSqHEAko/LwYONMFSlCUjXHBLtNrkFUGPaC5Y4OhUYQeNdJgYbZq0Im1rExfP
 sX/ZRznmpHS6R8+xkpEoat8kD3biA26suNRW/F8bPD6h3St0Ml5J7QzbMGGKekITIbXe
 iJww==
X-Gm-Message-State: AOAM5306/hR9mkCKS5dxlBcJiMd4vpTkBTFyGh2SN0Cz4LQv2vB0zJk4
 +u4ybCUa/4Er2wax1lBb5fF3CyDCapIO0vslONT/J205Nrxk2vEeHnMKZLbcFY9/79MfqQ0p7Pi
 Pg7nZPwOahIKsrBo=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr11231170wrs.229.1591373800447; 
 Fri, 05 Jun 2020 09:16:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLlco0uTP4FSC8G4SlpIU+PD5SjH9y/QTfbJAH8bV94TvEkmIhSo56YsrNa/v5l946bykPJg==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr11231144wrs.229.1591373800264; 
 Fri, 05 Jun 2020 09:16:40 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm11681610wmc.21.2020.06.05.09.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 09:16:39 -0700 (PDT)
Subject: Re: [PATCH v1 14/14] linux-user: detect overflow of MAP_FIXED mmap
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200605154929.26910-1-alex.bennee@linaro.org>
 <20200605154929.26910-15-alex.bennee@linaro.org>
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
Message-ID: <6b4e83c1-325a-051a-d6a0-1e134923f2a9@redhat.com>
Date: Fri, 5 Jun 2020 18:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605154929.26910-15-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 5:49 PM, Alex Bennée wrote:
> Relaxing the restrictions on 64 bit guests leads to the user being
> able to attempt to map right at the edge of addressable memory. This
> in turn lead to address overflow tripping the assert in page_set_flags
> when the end address wrapped around.
> 
> Detect the wrap earlier and correctly -ENOMEM the guest (in the
> reported case LTP mmap15).
> 
> Fixes: 7d8cbbabcb

Reported-by: Laurent Vivier <laurent@vivier.eu>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index e3780337974..2e05bd499e6 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -467,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>           * It can fail only on 64-bit host with 32-bit target.
>           * On any other target/host host mmap() handles this error correctly.
>           */
> -        if (!guest_range_valid(start, len)) {
> +        if (end < start || !guest_range_valid(start, len)) {
>              errno = ENOMEM;
>              goto fail;
>          }
> 


