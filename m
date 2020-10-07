Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF6EC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C015D208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLBQT7Us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C015D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1Vx-0003hb-JZ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1Um-0002NE-47
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ1Uj-0005w9-M0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602046565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kmvfdq8XcW12V8Dxv/Mv2QnLBNkoc9JRv3a3uvcUtzE=;
 b=iLBQT7UsK04g1121yiIACV7EQalu8fDmetn9EitMyBW9/0iA59SetkXll7ET81DSGawY7M
 e8JEuXxB4zEwJ6mLDl8MX/chdaejSDcjZdVf2/ZGNJYsuVCnCgyH7v6u4JhBdPrytRRhcb
 UgPRJpW9ADPuKvxMlR40a/v7nQ9VuOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-bAOjXZbGPGOxytH9V86vyg-1; Wed, 07 Oct 2020 00:56:01 -0400
X-MC-Unique: bAOjXZbGPGOxytH9V86vyg-1
Received: by mail-wm1-f72.google.com with SMTP id d197so98091wmd.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kmvfdq8XcW12V8Dxv/Mv2QnLBNkoc9JRv3a3uvcUtzE=;
 b=QrDLCfue1x7uXiilQ1H/HVG3xiZjNlrltEYUWMsH1vdia3Qppwo5rzb+oofUppD6WS
 oNEjQCbiGRsOVodGmftgv9CSppqdAufhfpVVIhotUEYnky/dVJuHGsQxLu2HmTFa3P6U
 i0Er9Rj6ppRgUgltWiLcQhJtbiY8vw+wqmzO2X9MauQDputjogKdfJwrCp8YuyvjiGZF
 v9csaiN4EVWUqb0vTdMfXp2SI6p4Kkq+DEYiYefFABNmIReDbSqK+m8TrLDCfBFS+g/c
 uUcn3NNhpt4wKcFGYTDOTnydnNXnhEnY27uM699pmYQkF2Y5TBDYB1q5qi4EwEMnUV5h
 stnQ==
X-Gm-Message-State: AOAM532VslnpYvC9KipXX+enM02yoGj7XBMqsvEvOaRYD/zw4UZhlBR1
 PpPIJD4LHKDCN1RME6OLXh76iaFw9pcOArwirFY8ucqlBLggymJ2FfrEML7X9DwZ1TQQD/Q9Uob
 EEiNG+q2NFL1HUeE=
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr1262845wrt.211.1602046560223; 
 Tue, 06 Oct 2020 21:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhALIMCZE9bN0Qr8QIT0dM1uzv/9DcYXrC3J1DEWbo9914T/J0EFRFDWgVJzTattcpvouwEQ==
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr1262830wrt.211.1602046559991; 
 Tue, 06 Oct 2020 21:55:59 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a17sm1078981wra.29.2020.10.06.21.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:55:59 -0700 (PDT)
Subject: Re: [PATCH 09/20] python/qemu: make 'args' style arguments immutable
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-10-jsnow@redhat.com>
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
Message-ID: <002ccb33-5b6c-5d47-13f2-e59994a2c55e@redhat.com>
Date: Wed, 7 Oct 2020 06:55:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006235817.3280413-10-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 1:58 AM, John Snow wrote:
> These arguments don't need to be mutable and aren't really used as
> such. Clarify their types as immutable and adjust code to match where
> necessary.
> 
> In general, It's probably best not to accept a user-defined mutable
> object and store it as internal object state unless there's a strong
> justification for doing so. Instead, try to use generic types as input
> with empty tuples as the default, and coerce to list where necessary.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  python/qemu/machine.py | 30 +++++++++++++++++-------------
>  python/qemu/qtest.py   | 22 +++++++++++++++++-----
>  2 files changed, 34 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


