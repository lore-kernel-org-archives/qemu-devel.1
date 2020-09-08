Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837A7C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119B221D43
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx+6e+dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119B221D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYuc-0004DP-8O
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYu5-0003nJ-IX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:23:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFYu3-0001bW-DW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599553378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1mxoaWMs8wFqOLi9pm9/hlvh0zyWqwL+EPmboWlIccs=;
 b=Mx+6e+dkD1+hoCrYGK0YxvGXqM0SyRa5b9aoIoecPrjOFlcFnlaDXt9FQnTf1+VYeDh8iL
 DhM66h/sm0biD7dvHpktG6M9Rtw5RDM6mwnY7wez7FNRsRCf7txhd+Zr5YxOIbxLrxB+UP
 jXfrVfETNwOMu8qRcL0FjAb/CvFwGgM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-gIqwgQvXMyaHQRCVmmQq4g-1; Tue, 08 Sep 2020 04:22:55 -0400
X-MC-Unique: gIqwgQvXMyaHQRCVmmQq4g-1
Received: by mail-wr1-f70.google.com with SMTP id v12so6702636wrm.9
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1mxoaWMs8wFqOLi9pm9/hlvh0zyWqwL+EPmboWlIccs=;
 b=shFxYO82FmXMXV3sL1Tn7NpllWcsszOREUclXBXLjU7lsA8FK/a1vn/LuyTrXSJvtd
 8IixfRAttyJcW6jnncGag085MX6R2GiYntHtp+D8zs+EYwvTQ0XEzhWudGA17GzSjiEL
 vuItFvTaUmNNvc0gwyw/YrWdbBdqgR7n6ND6qpsRk0kk8rq5gQl8EjWk+kotmtcCoSxw
 NFCC78w7emOoFaAQuqtqF9wVhFnQ26TYuIONJ1Hv217Ml1vaLxm931UfX4AWkWeyCntp
 n184HgEn1M4IOFw+QY4218HdObTdZgJg0RqlUAEiywKQ3M4n2n4DXLmU+ByU+lXv0mbS
 KunQ==
X-Gm-Message-State: AOAM533NYsPztM9HjivcoOnan5ayiLcTUwfTUaVmpWF++j34oGz4LYnE
 3j68J0R+b/c8YP4yTLYm67w9pOj09adFOlxznCktPPQwbrEXMMsw1far1DI4Ns62qKo6p46qnvL
 pTja8HVRel7ZQAJs=
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr3186986wmg.92.1599553373721; 
 Tue, 08 Sep 2020 01:22:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEU7zhNqwReAwToh4+7ZMqwXUX/idR7C0+Ww968e/f/XhIKYjM9AR9MbryTiyJ+PGxaZazhw==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr3186972wmg.92.1599553373518; 
 Tue, 08 Sep 2020 01:22:53 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y5sm22773236wrh.6.2020.09.08.01.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 01:22:52 -0700 (PDT)
Subject: Re: [PATCH 05/10] roms/edk2: update submodule from edk2-stable201905
 to edk2-stable202008
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-6-lersek@redhat.com>
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
Message-ID: <1356c404-517c-cf5c-bc04-04237c03f572@redhat.com>
Date: Tue, 8 Sep 2020 10:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908072939.30178-6-lersek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 9/8/20 9:29 AM, Laszlo Ersek wrote:
> Update the edk2 submodule from release edk2-stable201905 to
> edk2-stable202008. The release notes can be read at
[...]
> 
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  roms/edk2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/roms/edk2 b/roms/edk2
> index 20d2e5a125e3..06dc822d045c 160000
> --- a/roms/edk2
> +++ b/roms/edk2
> @@ -1 +1 @@
> -Subproject commit 20d2e5a125e34fc8501026613a71549b2a1a3e54
> +Subproject commit 06dc822d045c2bb42e497487935485302486e151

FYI applying this I got:

Fetching submodule roms/edk2
Fetching submodule roms/edk2/CryptoPkg/Library/OpensslLib/openssl
From https://github.com/openssl/openssl
Could not access submodule 'krb5'
Errors during submodule fetch:
        CryptoPkg/Library/OpensslLib/openssl
Errors during submodule fetch:
        roms/edk2

Probably harmless, as if one care about this submodule,
will run "make edk2-basetools" which runs 'git submodule
update --init --force' and silently fixes the submodules.


