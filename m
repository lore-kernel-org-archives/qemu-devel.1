Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325ADC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B6422242
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1XLX0bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B6422242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYHL-0001Lt-Pr
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIYGD-0000Nq-TY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIYGB-0003Yy-F2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600265889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+rU9Bq1aFu38w3bxslRAhXU2+NpWCI82eZvBIkiJa9U=;
 b=M1XLX0bYgkNvlqfzbnDwfACSxmjGO9K7iJSVRXN4t8+4Xj/WGAn1vBkcdcpeVm3GKrAdQH
 96h2qv+sBfcqs/giWoNdngMsiRuzFX/L9u+4zG/iNIMT4ZrDUfI868ONYyPK/9RNONDFb9
 zgutVlRkANNyBGOeSUYmtdsaJblYwwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Z3KrN6TsO4OJObxD33xMMw-1; Wed, 16 Sep 2020 10:17:56 -0400
X-MC-Unique: Z3KrN6TsO4OJObxD33xMMw-1
Received: by mail-wm1-f72.google.com with SMTP id m20so1089871wmg.6
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 07:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+rU9Bq1aFu38w3bxslRAhXU2+NpWCI82eZvBIkiJa9U=;
 b=sFEkKuoS+j7MmoduZuM7UVEFEEx+rROr6tOqpd1WeKuww7xG3H0lR6So3B3FCS0rB6
 6jzEzWz3q70l/bv/JSYuP6odTl37bcE26tHUyubRLbsOySWBytq3QwRofM3SmQvjyqNp
 SNkxI7hlgiwQK0Lph0mCjfdsMyv5saqBXB6FDOuapEVE9R7uwPMGcA8Cy5PqIA0/pq4k
 vk3BZ/P/65d9QTLs18UYj+GHgleDXSib0ZrWNB7G1Th8FTL5L1TvnVQAS5bDCVEgn4WS
 TAj+VDLKGA1ALMooaohK4viRe8HYSFXMsQEY1ljgnbdA8w0YJJbHNs7hVdxsK0O/A0tC
 4lgQ==
X-Gm-Message-State: AOAM5304G1yyXN8PbVLO1U8sbKd8cCWorKmKwFo+PV2AVxx8Ey+ePdxx
 Q67YZaZSHNrCaTQdVXKI88uMlZdwGB75S2dkA5uvY+zmknmlx+JrpJVwTrJrJ21LYssraBditjU
 BuLK4arU852PEDYc=
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr25974129wra.383.1600265874901; 
 Wed, 16 Sep 2020 07:17:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWbQINzaDV55JrFG+X88n13KAhRctpaDSqISmOjFnLGl647oH0yIO0X6Lb7g7kOx3VsdTUJQ==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr25974098wra.383.1600265874704; 
 Wed, 16 Sep 2020 07:17:54 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m4sm34907234wro.18.2020.09.16.07.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 07:17:54 -0700 (PDT)
Subject: Re: [PATCH v4 9/9] memory: assert MemoryRegionOps callbacks are
 defined
To: P J P <ppandit@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200811114133.672647-10-ppandit@redhat.com>
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
Message-ID: <4b55545d-6ab1-59e3-b825-91ccba8f4e17@redhat.com>
Date: Wed, 16 Sep 2020 16:17:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811114133.672647-10-ppandit@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 1:41 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When registering a MemoryRegionOps object, assert that its
> read/write callback methods are defined. This avoids potential
> guest crash via a NULL pointer dereference.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  softmmu/memory.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Update v4: add Reviewed-by tag
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05324.html
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..1f4b37b3a6 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1485,7 +1485,13 @@ void memory_region_init_io(MemoryRegion *mr,
>                             uint64_t size)
>  {
>      memory_region_init(mr, owner, name, size);
> -    mr->ops = ops ? ops : &unassigned_mem_ops;
> +    if (ops) {
> +        assert(ops->read || ops->read_with_attrs);
> +        assert(ops->write || ops->write_with_attrs);
> +        mr->ops = ops;
> +    } else {
> +        mr->ops = &unassigned_mem_ops;
> +    }
>      mr->opaque = opaque;
>      mr->terminates = true;
>  }
> @@ -1663,6 +1669,8 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
>  {
>      Error *err = NULL;
>      assert(ops);
> +    assert(ops->read || ops->read_with_attrs);
> +    assert(ops->write || ops->write_with_attrs);
>      memory_region_init(mr, owner, name, size);
>      mr->ops = ops;
>      mr->opaque = opaque;
> 


