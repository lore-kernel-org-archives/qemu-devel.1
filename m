Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52DDC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0622076C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSowhfk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0622076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUIv-0003op-EI
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHUI3-0003CO-4Z
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHUI0-0008O1-Rd
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600012299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TVNR0Uz25C9/MisZusV2pVLyKU2VyQjSzocaG5txcmc=;
 b=XSowhfk+TE4JAHDwgPcy65MPE3BVg95rpPnqoYQ8gYRj9iyfsrnH5qouNWW823rvMplEfY
 rXNeRp3i7Q8SbppcUx2dPcRZIxkymKFxvIPIdNpS46Tsgr7m5udNgC51BTleddpRnerCnk
 a24RVXbflp6ga+2oImxW4qgirJXqBvA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-pyLDtMWKN_e3XO7ky_iWuA-1; Sun, 13 Sep 2020 11:51:36 -0400
X-MC-Unique: pyLDtMWKN_e3XO7ky_iWuA-1
Received: by mail-wr1-f72.google.com with SMTP id f18so5702077wrv.19
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 08:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TVNR0Uz25C9/MisZusV2pVLyKU2VyQjSzocaG5txcmc=;
 b=SCJQqh7IT0slMJvs9bv5RSUIZJKGKzQe6SK3K3vFzFj+gmtR90HQkRfob/hyFKXZyE
 3Fnyx2hQ6wqKbNH7ALwPGLgK1jmXs0M2YHSu8+jXYw2Pn6kBZu0pJt7pi64yIlldBRd7
 vDXd/Upg4xilLCu1d4XRZBR2RkHhYOYMkB18lWGeggCL5JAOGi+P4C8bw+uYGgR2BKdi
 SEVcXjyDCV+b6wFPwgTZdUpfORKtdpbWAqspCej1W/xAnHDpHDERm0FslH4tS4T6GmBd
 oyGcIW07gEh0c+EH6TLYwwfVWP8p8kTUdkTYft0+JyWgVd1x8e3ZjWu6j+NzKbx3eb6G
 JcKA==
X-Gm-Message-State: AOAM531GknN9UL/Q/7VGHwuAd5CAfFcEcVtJHD+7XtFAoDMXgmY1nImp
 wQoSl5pcU3OZwk4l78KoxKJo49/SqZC1zAyI8gSmA0rtUrDGJNx1TyxkPlza8Ul9yoJKaxKLlbw
 X3BUvMcA7ve0exho=
X-Received: by 2002:adf:e989:: with SMTP id h9mr12414936wrm.38.1600012295679; 
 Sun, 13 Sep 2020 08:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3U+yR/MYYRUq9/y+K2mZCiDd7bKxyXZLQUekGiEPybDQIwy3UksLEk/+aqABKmkvnVVlTIA==
X-Received: by 2002:adf:e989:: with SMTP id h9mr12414912wrm.38.1600012295490; 
 Sun, 13 Sep 2020 08:51:35 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a15sm17638151wrn.3.2020.09.13.08.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 08:51:34 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] user-mode: Prune build dependencies (part 2)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
 <f8c9c94c-9b27-6c16-bde1-1a0a91287563@redhat.com>
 <fb687ccc-919c-6c61-4dbc-9e76625c3743@redhat.com>
 <84799885-c40c-a8ae-915d-798fdae3e303@redhat.com>
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
Message-ID: <e3ce5624-f67e-0877-4129-ac8cdcea48a7@redhat.com>
Date: Sun, 13 Sep 2020 17:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <84799885-c40c-a8ae-915d-798fdae3e303@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 3:40 PM, Paolo Bonzini wrote:
> On 13/09/20 13:31, Philippe Mathieu-Daudé wrote:
>>> I'm not sure about the first.  It's a bit ugly to have a property whose
>>> getter aborts.
>> This is (IIUC) the change Markus requested in v3 (see [*]).
>>
>> Commit description: "add a stub to satisfy the linker."
>>
>> This stub should be never used on user-mode => abort.
>>
>> [*] https://www.mail-archive.com/qemu-block@nongnu.org/msg67560.html
>>
> 
> Yes, I'm not sure about the stub _in general_.  I would prefer to either
> have the type available even on user-mode emulation, or remove the
> property altogether... I don't know, anything but not a property that
> aborts. :)

I plan to eventually get user-mode cleaned, but this is out of the scope
of this generic second part which is already big enough for Laurent to
digest. Maybe part #4 will be x86 specific.

Let's wait for Markus view on this (personally I don't mind removing
the abort, it was not there on v3).

> 
> Paolo
> 


