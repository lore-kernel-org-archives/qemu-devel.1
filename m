Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B666FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8006620658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 07:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFfGo1qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8006620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7voT-0006Um-Nv
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 03:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7vnt-0005sy-J5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:13:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7vnr-0001Od-Ar
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 03:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597734782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=d8Eo9z8Sg6VSoZT4Sr1yp6znyApswFvmhZfCK4vMulM=;
 b=TFfGo1qA1es9Gm0dLLDygBg1zXka3R/o5w/NOSlnuXBJ1vneeRgJQ/8ytZFpggrNo1dF7A
 Jq8zXx+v+vD8ffitib/yawSCgp91rQhJbqBDv965xI42P91xMh85VSzqgVcjMwsZmez/ku
 /wmPUIfjTBbO4uRcoMxiIFgXuZByewQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-TZGF2eA1OlOIpvEOcJXAHA-1; Tue, 18 Aug 2020 03:13:00 -0400
X-MC-Unique: TZGF2eA1OlOIpvEOcJXAHA-1
Received: by mail-wr1-f69.google.com with SMTP id s23so7870029wrb.12
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 00:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=d8Eo9z8Sg6VSoZT4Sr1yp6znyApswFvmhZfCK4vMulM=;
 b=J4EMdUnWZHxQtVhXqqep2Hr0lLF0GPaUyA7IVbN6RA6ww8uNzGLbfOCWpFRZlrLUMr
 5+1GUGPdHzzo8YOq6yFYpUrQFAFyZzJkPVLJ+Pv90ED9fjXofgC+M9RTGaUElAMNCrmG
 9nSv1AMOc8FkSochD9MIYP+avNGoaOlWky+KOiQPM3ffWluS+TiBQ/D4MchV+eAQL2aS
 Ca0yUng+SVAKMd0YHAaoxYp/ZavtjCScay+ks3h6/npCDWkYDN5seGzSkv18GH8LzYME
 7qgESry73CN905XvQHQkv8vQBNgbqz2JpJsI5nnLVRo1zygYHxBaYDv18gb7cIZHQ1gx
 tsrQ==
X-Gm-Message-State: AOAM532xvtRU9cTfOriDevXJ7kDPYzpfU+hAv32llezlDwShl1nxu+Yt
 tSCOG9Xb/NgorBgeJ1oaKHik2YUWASJx0jZnraLfoCV/sbYK7iCxTPnivMvrstaEnSgPq7PPAx1
 lo0+NyVeMXZ+fbK4=
X-Received: by 2002:a1c:8195:: with SMTP id c143mr18492646wmd.85.1597734779436; 
 Tue, 18 Aug 2020 00:12:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9WCnO4CK0cIxkHV06ck3gzX5r0FKEE8kxluxB8hKeTETbpAcBnx5tr60MhxouYqvBaWmgKA==
X-Received: by 2002:a1c:8195:: with SMTP id c143mr18492630wmd.85.1597734779275; 
 Tue, 18 Aug 2020 00:12:59 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o2sm36843114wrh.70.2020.08.18.00.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 00:12:58 -0700 (PDT)
Subject: Re: [PATCH 13/41] hvf: Add missing include
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-14-ehabkost@redhat.com>
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
Message-ID: <804ef928-81f0-a092-3ade-fceeae931a99@redhat.com>
Date: Tue, 18 Aug 2020 09:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-14-ehabkost@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:25:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> The sysemu/accel.h header is needed for the ACCEL_CLASS_NAME
> macro.  This will be necessary to allow us to use OBJECT_DEFINE*()
> for TYPE_HVF_ACCEL.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/sysemu/hvf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 6d3ee4fdb7..d3bed80ea8 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -13,6 +13,8 @@
>  #ifndef HVF_H
>  #define HVF_H
>  
> +#include "sysemu/accel.h"
> +
>  #ifdef CONFIG_HVF
>  uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>                                   int reg);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


