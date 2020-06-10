Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87835C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554382072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+wjLxis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554382072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jivao-00042t-IS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 03:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivZh-0002up-K5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 03:55:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivZg-0005pG-P2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 03:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591775702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xcXpiP5EjIJlcz2DAeNxEkqxJi2yHLreSgzH/67YT3U=;
 b=L+wjLxisZveETu5nExs9L9cCYgCOgvxbo+gRVpeGTEJRgkNXSn3ZpE8Pp132vI62fLAIQp
 YaIeADZPp4At4psagUPfvgt3GUgXtc79PBo23bLehkxW2+gWx01yCf3ZWWR2/q86PEVlxd
 oAs7a3oDkXdBoIGNapkH1mABVdSlCnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427--pfowBdwN_u1BC8zqEx9UQ-1; Wed, 10 Jun 2020 03:55:01 -0400
X-MC-Unique: -pfowBdwN_u1BC8zqEx9UQ-1
Received: by mail-wr1-f72.google.com with SMTP id n6so728606wrv.6
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 00:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xcXpiP5EjIJlcz2DAeNxEkqxJi2yHLreSgzH/67YT3U=;
 b=ox6axdcM2+5iqnYB+7BoEOD6DohcJ0aF3zPtFbor0OGSAwCMCnCdYjL/1gOJ+TbiVc
 ifaVX/wMTvEdVTEO6ZHTDSsMnHFqpE2csSVnPm9TMtaPIXBZTOCs8+cZgPSlmM0hnusk
 i897Shk3v/D4FC+VMrCGjAQNxNVIsDJwFioiu90ZKNoCZpZjISHA2HDvhzOeaKqT9/vY
 opwZA06nCXl1QUOmZnRfI3+fJcDsOoz9LlneiosO1zPl6YlsMyNed2EgOa81IplAwBVA
 CdeAcqeq2GvdV4+oVdi9PX86wndSiCslN6SkSyOJ8dBlsF/y2Dj2LcsFEoOiDtLSgXwc
 Sk0A==
X-Gm-Message-State: AOAM533wK71Wrgw8fkcR6zukKOuKnXq5Ylgrn72MII18p4k9MvuNHNXt
 V0tnFOFhoft733phmsfKbRgo7w5pYFnAkOdoqqYCgBp+tPvr19k0//2Ep1Iw7y6B+9MItF1+sME
 ejuOkiqCCX1IqiXc=
X-Received: by 2002:adf:fd48:: with SMTP id h8mr2305057wrs.226.1591775700012; 
 Wed, 10 Jun 2020 00:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+w2OAzEjCOqk3hp+UIGEBEFBbNmEOUqlecqv7kZeSCVefGMtlfLYuqim30NoXucxEa93zDg==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr2305045wrs.226.1591775699803; 
 Wed, 10 Jun 2020 00:54:59 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o20sm7112825wra.29.2020.06.10.00.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 00:54:59 -0700 (PDT)
Subject: Re: [PATCH RESEND v3 52/58] microbit: Eliminate two local variables
 in microbit_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200610053247.1583243-1-armbru@redhat.com>
 <20200610053247.1583243-53-armbru@redhat.com>
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
Message-ID: <9eaf8044-eb17-7b3f-171f-bbb500744d6d@redhat.com>
Date: Wed, 10 Jun 2020 09:54:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610053247.1583243-53-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 7:32 AM, Markus Armbruster wrote:
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/arm/microbit.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index d20ebd3aad..8fe42c9d6a 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -36,15 +36,13 @@ static void microbit_init(MachineState *machine)
>      MicrobitMachineState *s = MICROBIT_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *mr;
> -    Object *soc = OBJECT(&s->nrf51);
> -    Object *i2c = OBJECT(&s->i2c);

Thanks for this new patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


