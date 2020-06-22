Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57102C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230B6206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dyx2sgKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230B6206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMBq-0001x8-AF
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnMB7-000171-VD
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:08:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnMB5-000804-Em
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592831278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1Nzsjv2GD9kLDtRyY0ngeucK6DclnqSYHaejzaZJTGw=;
 b=Dyx2sgKVdTnTckDtNYZxBxQMAUqH8pw09HKMzmHsrmT7iDIj8X/vHG1ity1nBvGEuj4g1E
 yJnMMsZLJb4O6QVAl9tWr7MEdp/fkbCJM0OLgKM3vUbrtaaoCt8L7GyQuZ0yOKPMfaDqTa
 Vq7pmAKCpUqkZQB3rJ8kBOSa/HgGIUQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-XoeuKr6WPumY4eQsRhXw1A-1; Mon, 22 Jun 2020 09:07:54 -0400
X-MC-Unique: XoeuKr6WPumY4eQsRhXw1A-1
Received: by mail-wm1-f72.google.com with SMTP id q7so6796185wmj.9
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1Nzsjv2GD9kLDtRyY0ngeucK6DclnqSYHaejzaZJTGw=;
 b=WfWHAOQuKI55T8Bwq8pN3B8QY0pYd2KE7/hRUd0tS9zFxPfuEmfoLGsSHRDXA77eHB
 6Ess3HCirAPE+BU/ThNVjtCBYJtbq+rT75Urz9Zpf8doPXp2MUM67ftIT00AHY3+mBqd
 oshn8ZWuofdqERkbee7N9/yB0QkqSOJBMbQ65XsMEFJJNNwN7XDDsCa72O+C1MS3H798
 QXMQQy2jlceVvLTiJ6pqMKK5JfqimKocuq1zKRqdkBvjXPhGR29eOYWZkmVRCLn4n1NT
 bODKZh3a+eFT4U1f9jB2LSZzY4rhCVacwDjgHctSEGYkJxyf919ToXIVxbsWzepjqbBW
 VWMg==
X-Gm-Message-State: AOAM533mrQc0ErIXz6hN26zEhJMqQ7udv568rIA3ovCusYf3cXGvvsvj
 DU6NugOIzfpggfANGN05eLXreY6CGhlhAkGllKdXsWWspI1ZzPjwGegCJLP9h5zcd31Zj0Bpcji
 QKZXKR9QKeoKVLw4=
X-Received: by 2002:adf:e701:: with SMTP id c1mr15744063wrm.350.1592831272964; 
 Mon, 22 Jun 2020 06:07:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc7TkkzNbWiGERqJfw8EbcxGdweR4zfDkko84//3WOdOtQIkRGU18AD0+jlJXzQr+UhPvM/Q==
X-Received: by 2002:adf:e701:: with SMTP id c1mr15744026wrm.350.1592831272651; 
 Mon, 22 Jun 2020 06:07:52 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l17sm16617806wmi.16.2020.06.22.06.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 06:07:52 -0700 (PDT)
Subject: Re: [PATCH v3 11/19] audio: deprecate -soundhw pcspk
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200622112914.30454-1-kraxel@redhat.com>
 <20200622112914.30454-12-kraxel@redhat.com>
 <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
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
Message-ID: <1bc80fe2-6ec4-000d-483d-70b34ff15adc@redhat.com>
Date: Mon, 22 Jun 2020 15:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 2:59 PM, Thomas Huth wrote:
> On 22/06/2020 13.29, Gerd Hoffmann wrote:
>> Add deprecation message to the audio init function.
>>
>> Factor out audio initialization and call that from
>> both audio init and realize, so setting audiodev via
>> -global is enough to properly initialize pcspk.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  hw/audio/pcspk.c | 24 +++++++++++++++++++++---
>>  1 file changed, 21 insertions(+), 3 deletions(-)
> [...]
>> +static int pcspk_audio_init_soundhw(ISABus *bus)
>> +{
>> +    PCSpkState *s = pcspk_state;
>> +
>> +    warn_report("'-soundhw pcspk' is deprecated, "
>> +                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");

Markus's "Crazy shit around -global (pardon my french)"
series instead suggest to use '-device ...':
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06667.html
Could that work here?

>> +    return pcspk_audio_init(s);
>> +}
> 
> While "-soundhw pcspk" is quite easy to use for the average user, I
> think the "-global" options will be quite hard to figure out, especially
> once this deprecation message got removed again when -soundhw has been
> deleted. Could you maybe add a description how to configure the
> pc-speaker to docs/system/target-i386-desc.rst.inc, too?
> 
>  Thanks,
>   Thomas
> 
> 


