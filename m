Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AEBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6502E2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ2qQfF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6502E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3qd-0002Ff-71
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG3pp-0001Jc-5X
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG3pm-0000Cl-DE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599672277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OTqPsjosPC9c+asZGU29XKZKzVAh1Gyme2UFBiG4EcM=;
 b=JJ2qQfF9IN368EOLdgWC4hT4SqTlXCr6FV459YJbGkZWOLXZ40Dz+c5NGZCGktIMHomUvy
 BQbGunPVbbOpepdy6hO7GZNpRIili1qviO1GQi94Zefs/qXBMr9DHDbw5k+TKonzS1i8px
 s148x25HchPLxiuAv9Upri41uMQHVBk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62--GF1TwBdPNKvXSKHyFaR6g-1; Wed, 09 Sep 2020 13:24:33 -0400
X-MC-Unique: -GF1TwBdPNKvXSKHyFaR6g-1
Received: by mail-wr1-f72.google.com with SMTP id l17so1199689wrw.11
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OTqPsjosPC9c+asZGU29XKZKzVAh1Gyme2UFBiG4EcM=;
 b=XdvaIqtICzkeDCfKYL4WrYcF/NZYaekRVL0HULWmh7eRatS1M1osvhv/ImiKalWH3R
 AVzzxwwyr/sL6EUKxO5a5n4xV8ZfWqTXCRRJb6CrGBvsIb3kFVHzedFffdkQHbsagSFc
 4HycH9hXYWN7AwC75rL9Gfav5Dt3ysCvJRqVX5+F8U/HlI+/1lt0YqyqhPlOgbFZZcO0
 dRJPP0YCyMQw0ANh6sV9+hGWysl32jOiQ+tzeqoDLMveiXkh1hftb0lRkICDnVS5YKkl
 oWcA5fDoUO8sH4kvlZGU+cEuyo8hcQlZV0923PbmJjHR8ZMVp61Q5G7AMS60dBlT2pHW
 YJNw==
X-Gm-Message-State: AOAM532Om9gi9FVLYhDJoZy7i9UT/gyhFMXPXIO8SVLLn82n2l4PIfAb
 8++ygZH1mDoyaJN1H3vkK3NbqwDCgRbMEX4ZDH/FKT+wtUz5KIHznAW7i40+guKZsKu9h4rRSW1
 2yhrYz4iQbV7SamQ=
X-Received: by 2002:a7b:c210:: with SMTP id x16mr4378416wmi.76.1599672272307; 
 Wed, 09 Sep 2020 10:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXvVXUBrvF9afTMQB5PlyjxQD2woiONEuldGzcBTnNdG+jVnVEO6qUWYVW6D+PtVdl/WmNzg==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr4378397wmi.76.1599672272107; 
 Wed, 09 Sep 2020 10:24:32 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v2sm5399758wrm.16.2020.09.09.10.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:24:31 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/timer/hpet: Fix compiler errors with -DHPET_DEBUG
To: Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
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
Message-ID: <8d9ae068-77cc-6152-7b90-a51bf70648a0@redhat.com>
Date: Wed, 9 Sep 2020 19:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909083650.46771-1-dovmurik@linux.vnet.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 10:36 AM, Dov Murik wrote:
> Fix several compiler errors when compiling withe -DHPET_DEBUG.
> 
> Steps to reproduce the issue:
> 
>     mkdir build
>     cd build
>     ../configure --target-list=x86_64-softmmu --extra-cflags=-DHPET_DEBUG
>     make
> 
> Dov Murik (2):
>   hw/timer/hpet: Remove unused functions hpet_ram_readb, hpet_ram_readw
>   hw/timer/hpet: Fix debug format strings
> 
>  hw/timer/hpet.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 

I sent almost the same patches last week :)
https://www.mail-archive.com/qemu-devel@nongnu.org/msg736836.html

You seem to fix a 4th format, can you rebase on top? (As these
patches have already been queued).

Glad to see you are interested in debugging the HPET too.

Regards,

Phil.


