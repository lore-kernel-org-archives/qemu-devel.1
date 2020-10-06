Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F0C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6392075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We/nSGkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6392075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmWT-000364-Na
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmOD-0002Of-6A
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmO9-0000gl-Mv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/mmMnQpTHJgisDdu2/OSzH7KyzjmhCD8t94+wvfYWFw=;
 b=We/nSGkWuEoRhpy8JnCa7AyMWU2bN5lupDVJQFfKHV5zRLx/jMUlgBc5p4mfb2XG0mkD8X
 mYlec2StE3fWDhnO0zpZzJT+QnuDZcK5DTBJ3Mg52+gED9AwCKu2slbgtznVrgnB1/ocUi
 pipI60WgvW6Klud2Hi5e57d8Lqzrhc4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-Wtp3LxTQNgW_hWE0UucR2A-1; Tue, 06 Oct 2020 08:48:12 -0400
X-MC-Unique: Wtp3LxTQNgW_hWE0UucR2A-1
Received: by mail-wm1-f72.google.com with SMTP id u82so1075091wmu.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/mmMnQpTHJgisDdu2/OSzH7KyzjmhCD8t94+wvfYWFw=;
 b=e3nuKj+FpMriaEK944+2mK2i+0SHp80VC7NA8cDTFIbuE7JdEUgVrvSzZLxXhiiAPC
 tcLki7RV3ON94G0a+O0+r3OXR4BqCyIMftVtQI54Pf5CYM4IOT7ot8varZdKriM2HBNN
 eq0+DOqwG1OPSWWWskOkumGDBjl3L2ArxYJsUUCUJgXgMRf/nAGmihAM1udHkMzlyAf9
 PwGIzSadOJ6or09RFz5+nAlQ978tIDi04uecFeWyfGJ7UhBdoDlhXU0HX8/UQwJdrHGc
 VLkrkCf4mslC3KqF6xNvFhuCFaqRlinLaicJXAfydHCk3VRcn+pb4tIIWqwBlxxL/c9G
 xsgg==
X-Gm-Message-State: AOAM532Gytwfv7v1DnAiOY8oYAwwdQjqtd27VtKdiFeaRrCYlj53q/gY
 /yHMPVQ9y1j/SYKgqdpKBLLw0/AYWsNut44/mzlikORscPjmqmr1Ja8lI87dx+ZLVH+RFth8wB1
 JNWn1R3kHgz+cURI=
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr4703042wrr.283.1601988490954; 
 Tue, 06 Oct 2020 05:48:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxroH24shHVG1c5vtsv48SL1jgJDsBbBOn2aiO3sWpuSBSUnwXSGg6ZAEOyad9tJFDhjJFmZg==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr4703022wrr.283.1601988490699; 
 Tue, 06 Oct 2020 05:48:10 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm4432129wrt.82.2020.10.06.05.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 05:48:09 -0700 (PDT)
Subject: Re: [PATCH 00/10] meson: Move the creation of the library to the main
 meson.build
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201006111219.2300921-1-philmd@redhat.com>
 <c3fe9454-dd67-62c5-d3dd-8852810e7969@redhat.com>
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
Message-ID: <e757c406-11b4-215e-da22-205c8b099c02@redhat.com>
Date: Tue, 6 Oct 2020 14:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c3fe9454-dd67-62c5-d3dd-8852810e7969@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 1:29 PM, Paolo Bonzini wrote:
> On 06/10/20 13:12, Philippe Mathieu-Daudé wrote:
>> Make Meson machinery more consistent, as requested by Paolo.
>>
>> Philippe Mathieu-Daudé (10):
>>   migration: Only add migration files to the Meson sourceset
>>   meson.build: Add comments to clarify code organization
>>   meson.build: Sort sourcesets alphabetically
>>   hw/core: Move the creation of the library to the main meson.build
>>   chardev: Move the creation of the library to the main meson.build
>>   migration: Move the creation of the library to the main meson.build
>>   io: Move the creation of the library to the main meson.build
>>   crypto: Move the creation of the library to the main meson.build
>>   authz: Move the creation of the library to the main meson.build
>>   qom: Move the creation of the library to the main meson.build
>>
>>  meson.build           | 86 ++++++++++++++++++++++++++++++++++++++-----
>>  authz/meson.build     | 10 -----
>>  chardev/meson.build   |  6 ---
>>  crypto/meson.build    | 10 -----
>>  hw/core/meson.build   |  6 ---
>>  io/meson.build        | 10 -----
>>  migration/meson.build |  8 +---
>>  qom/meson.build       |  8 ----
>>  8 files changed, 77 insertions(+), 67 deletions(-)
>>
> 
> Nice!  Apart from the change to patch 1, perhaps move the "Targets"
> headline a little earlier, namely just before
> 
> foreach m : block_mods + softmmu_mods
> ...
> endforeach

Oh OK, I was not sure of this block.

> 
> Thanks!
> 
> Paolo
> 


