Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B288EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D05B235F7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFKDnYQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D05B235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqtY-0002hN-Og
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqsu-00021o-N8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:19:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpqst-0007Fm-5B
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593425970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gIOmuVUTz4GJvqnXTsn4KGEXLAhzbgDObg5/V7YiM7k=;
 b=GFKDnYQwF8ORckVWYn0Ir3nLW/3pV1lwJ1HDrCI5H1Jd73LBhwsIhDznz1VEcOUjvqrnX1
 AkVrwAJXGW0Ebb3Z1ouKIUgspnETjmyglBW6jhxYD44PP5Jbp7fBtpiz/gNNqHogRskUDJ
 gKe10qJs6gnhrJBL7QHkyWGAj3gJS+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-gx1hlgq0Pf-IIYpEWJLfHg-1; Mon, 29 Jun 2020 06:19:29 -0400
X-MC-Unique: gx1hlgq0Pf-IIYpEWJLfHg-1
Received: by mail-wr1-f72.google.com with SMTP id y13so16380763wrp.13
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gIOmuVUTz4GJvqnXTsn4KGEXLAhzbgDObg5/V7YiM7k=;
 b=s/AgYaVLYUYE3NiSWdweUv2TSONUV+vwsjxS5StBuVrciHrPZKZs8TNihhatJ04O/C
 KnawFVUly9I8NTEyWjo389WSheWm2k6w2zg+Niq7yUaNeXY/SByKiBy3wyLy4JSFXRE0
 dZvAIsK+K6SdPSmTn3zfMG0p8jmzYSHnw7Uvp3+ZtxbwCELT67s9pUlCGc4Q4R2fSutd
 d/dubCAkqGJi+MJRgb1h+rWSRi/rb/UZkDt0R30FZsH/XNppt4ybQlqUsm4vKeTUJQD6
 3CG65oZNErmIds7uYZZ39iJN3fqhmZwFjwAq8CQ4tT6TdqanxJ/OE4oZ6lOESitYAzPR
 kkgQ==
X-Gm-Message-State: AOAM531jLgHjGvFXzk/ydROZqXf/4I3fqFiRuHxlyUa1LiWPxd0sbRez
 KCFqrTKyu7vSzZ/nHTR1ZU8xrnPg6+0vG7xFZwu0DU+w0M4ITPtTPU9WyMim2Wv2wbJmkSIzLw6
 RpRtwP8De2OFcOp8=
X-Received: by 2002:a5d:4051:: with SMTP id w17mr15615885wrp.183.1593425968004; 
 Mon, 29 Jun 2020 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZIfn7yRazt6qQwzRA6wcX5a8IcEe3G8Ltgxdn5U63PZeKL2dQ4croMZjyOWv2NyRUW7vW3w==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr15615862wrp.183.1593425967778; 
 Mon, 29 Jun 2020 03:19:27 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l190sm27380731wml.12.2020.06.29.03.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 03:19:27 -0700 (PDT)
Subject: Re: [PATCH] trivial: Respect alphabetical order of .o files in
 Makefile.objs
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <20200629094934.2081180-1-dinechin@redhat.com>
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
Message-ID: <6e396bb1-ecc9-8f2b-f1b5-68f78b0b156f@redhat.com>
Date: Mon, 29 Jun 2020 12:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200629094934.2081180-1-dinechin@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:49 AM, Christophe de Dinechin wrote:
> The vmgenid.o is the only file that is not in alphabetical order.
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  stubs/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index f32b9e47a3..1df8bb3814 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -19,10 +19,10 @@ stub-obj-y += replay.o
>  stub-obj-y += runstate-check.o
>  stub-obj-$(CONFIG_SOFTMMU) += semihost.o
>  stub-obj-y += set-fd-handler.o
> -stub-obj-y += vmgenid.o
>  stub-obj-y += sysbus.o
>  stub-obj-y += tpm.o
>  stub-obj-y += trace-control.o
> +stub-obj-y += vmgenid.o
>  stub-obj-y += vmstate.o
>  stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


