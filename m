Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F9820663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 08:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YukSLsNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F9820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh7q8-0006VG-OU
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 04:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh7pU-0005gd-C0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:35:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh7pR-0000eS-R9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 04:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591346152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oOltr0PrKiWj2OtMZURJqI2EW/7bgDshR0HKQR/6pG0=;
 b=YukSLsNP21eupqTJ5+v3bcOtOZwsq6B0B7L3BTykf26VPSOk3C4LVgvQwp3pl5Jugn5PQc
 Ae7cNy34pIK2sWKM1k8gXUIfhX3ZD5n6E4jpMZPk959vP5Hbt7EToslqsX/wD4fzXqGeqs
 WLssM+QRx4/XSiRbIi+X+pt3RpspMuU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-MG9x8HTMPJimdAL71WlBIA-1; Fri, 05 Jun 2020 04:35:47 -0400
X-MC-Unique: MG9x8HTMPJimdAL71WlBIA-1
Received: by mail-wr1-f70.google.com with SMTP id l18so3509236wrm.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 01:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oOltr0PrKiWj2OtMZURJqI2EW/7bgDshR0HKQR/6pG0=;
 b=qwgfhS8a0IkiwxRYCoYcoWl7ft/tbfzzoMDyrPa6JfKvN1DtY9Skz/LkWtvHntR0ar
 qbhO6Ahm5s+o0lt25a12rihoVSuTU7Ruvk6z95MWIJR7vt+bpe6ITN/l0QAHr4/50sw3
 ALpw154DD7IrpcWhjeo+pwhttQh3aJ7OU7RmCMCMpP6moxsINpZ5AoasG0RMhHP/nCgX
 q6waqhT0QSANqF6nTitx/tp2YvqVIzi9iPhrbkcRZ0b12mGjqodvseNCtIsY3AqrB10d
 xCzQ+pLIxsdkUnAjiazLcCpHsbF5YM7/HAEixVCcicum7Tcssd28F+AYqJw47p5IIFvH
 5FBg==
X-Gm-Message-State: AOAM530FB7rRGKaWbOZojqrMne3wtt2o0FtnAaqVojV0RDcmGhUTL0kF
 uTIgmQ2laiCeVSBapRVnvXjjcdjRlFyM621dMwzSptJTaYbJeePsnJrOY/EdICYuCEgbaZj+nCT
 fwWeiVDWIrt/2XUA=
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr8064363wrc.377.1591346146444; 
 Fri, 05 Jun 2020 01:35:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfgxowJA/59lNmt499EZ2tXXU1O+UDh2G2Rc1c8mxD2RQdstcNTTJoBzkkMcjTIpb80H0dOw==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr8064352wrc.377.1591346146276; 
 Fri, 05 Jun 2020 01:35:46 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y37sm13145115wrd.55.2020.06.05.01.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 01:35:45 -0700 (PDT)
Subject: Re: [PATCH v5 03/11] MAINTAINERS: Add an entry for the HAX accelerator
To: qemu-devel@nongnu.org
References: <20200605073953.19268-1-philmd@redhat.com>
 <20200605073953.19268-4-philmd@redhat.com>
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
Message-ID: <1d0b8e12-f18c-c54d-17cc-44793295abfe@redhat.com>
Date: Fri, 5 Jun 2020 10:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605073953.19268-4-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: Vincent Palatin <vpalatin@chromium.org>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Colin Xu <colin.xu@intel.com>, Yu Ning <yu.ning@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Tao Wu <lepton@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 9:39 AM, Philippe Mathieu-Daudé wrote:
> Nobody replied since the first time [*] that patch was
> posted, so mark HAX as orphan.
> 
> [*] https://mid.mail-archive.com/20200316120049.11225-4-philmd@redhat.com
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> This patch has been posted 5 times, first time more than 2 months ago:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg689009.html
> 
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Cc: Vincent Palatin <vpalatin@chromium.org>
> Cc: Yu Ning <yu.ning@intel.com>

FYI Yu Ning email is also invalid.

> Cc: Tao Wu <lepton@google.com>
> Cc: haxm-team@intel.com
> Cc: Colin Xu <colin.xu@intel.com>
> Cc: Wenchao Wang <wenchao.wang@intel.com>
> Invalid: Hang Yuan <hang.yuan@intel.com>
> Invalid: David Chou <david.j.chou@intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f725c12161..05d7210204 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -426,6 +426,12 @@ F: accel/accel.c
>  F: accel/Makefile.objs
>  F: accel/stubs/Makefile.objs
>  
> +HAX Accelerator
> +S: Orphan
> +F: accel/stubs/hax-stub.c
> +F: target/i386/hax-all.c
> +F: include/sysemu/hax.h
> +
>  X86 HVF CPUs
>  M: Roman Bolshakov <r.bolshakov@yadro.com>
>  S: Maintained
> 


