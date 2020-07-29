Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96517C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C9620809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKWAjtIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C9620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0s5E-0001Wb-43
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 15:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0s4Q-0000o5-QI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 15:48:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51960
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0s4O-0007CW-Ik
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 15:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596052135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3cfw7wMtxODBUohAk+xxahw+dEadRD+b/iE47VKVDBc=;
 b=HKWAjtIenrCp/acOv1uQKhHqZfVfIgIhhhki/Gn7RixzvjgOKcHLtA4mkM899pg9WHlKg/
 GjwBKunfrrhEb3ClgDWymSid4dUqS0txKH/ZZcnciyjfpBiOiBn/DK1Y2uZ5uzjQmACAaA
 3QYOV478HKgrjqze01q+XK3ZlNmSu7U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-6Jux2yQeM6W5mlHS8Tsdtw-1; Wed, 29 Jul 2020 15:48:50 -0400
X-MC-Unique: 6Jux2yQeM6W5mlHS8Tsdtw-1
Received: by mail-ed1-f69.google.com with SMTP id k25so8695023edx.23
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3cfw7wMtxODBUohAk+xxahw+dEadRD+b/iE47VKVDBc=;
 b=GPDnxFaM8WEP6GJXZjCKqjbMqNbaHzUF7t9kUWJPQGwKjQwNtMTtUFNeKzTKKi+4S4
 ZAjkLi5M7SACrf+1nKFr4KHeDzS439m3yRB2GYxc1/7VK5IAwbc9NO9YMnqHLRvIMvZ6
 ZbXgmyCG/B3jVYkyFhJ0UDEKvSdX1zx9nnYIpngJsVQ/1D/q38dIlpSQpsIrCsL5NQCH
 rQUVcyuQ/vs4rMel+6LnC5C42nn3zhkayYbWvsH5jgshGTog4xz6IaXRZn8aWf26trz2
 DOjyIvz8wpLyYw23aM1DF5sjxxQivoQMqlEMQMTMjjXaBSWqJlN3BNGU1GBUSOZdLB0p
 MEXQ==
X-Gm-Message-State: AOAM533vvwmc3nkLusKwEkTx0XvDhh9kMNyt/zue7uqM8VbU5ml6ymIY
 cqIhEF2rhn4Fb5VGinwnSIfdmN+AkcchWiLp8St3a1UIHwX1BnYFY9M4vd16j03O52lKajx4FPq
 UZ3xno5HLFU5+B6I=
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr23362619edc.7.1596052128815; 
 Wed, 29 Jul 2020 12:48:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAQqTOD25DYtGA1dIjVJ95ByI387ARy9vgOl7Sv7b4Tn4XIntUjF/hOqcmSjXJBprOqilvdw==
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr23362601edc.7.1596052128528; 
 Wed, 29 Jul 2020 12:48:48 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id rv14sm2380972ejb.33.2020.07.29.12.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 12:48:47 -0700 (PDT)
Subject: Re: [PATCH for-5.1] qapi/machine.json: Fix missing newline in doc
 comment
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200729191019.19168-1-peter.maydell@linaro.org>
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
Message-ID: <6868de54-02f7-1b8d-2cda-55898a8786e3@redhat.com>
Date: Wed, 29 Jul 2020 21:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200729191019.19168-1-peter.maydell@linaro.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 13:17:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 9:10 PM, Peter Maydell wrote:
> In commit 176d2cda0dee9f4 we added the @die-id field
> to the CpuInstanceProperties struct, but in the process
> accidentally removed the newline between the doc-comment
> lines for @core-id and @thread-id.
> 
> Put the newline back in; this fixes a misformatting in the
> generated HTML QMP reference manual.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not very important but I've suggested for-5.1 as it's a safe
> docs fix. You can see the misrendered doc at
> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#index-CpuInstanceProperties
> 
>  qapi/machine.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index f59144023ca..daede5ab149 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -825,7 +825,8 @@
>  # @node-id: NUMA node ID the CPU belongs to
>  # @socket-id: socket number within node/board the CPU belongs to
>  # @die-id: die number within node/board the CPU belongs to (Since 4.1)
> -# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
> +# @core-id: core number within die the CPU belongs to
> +# @thread-id: thread number within core the CPU belongs to
>  #
>  # Note: currently there are 5 properties that could be present
>  #       but management should be prepared to pass through other
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


