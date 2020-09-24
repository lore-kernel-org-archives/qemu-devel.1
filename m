Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEA9C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D6F2395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDgegnhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D6F2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLP04-0004fI-AJ
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLOzB-0003n5-1G
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLOz5-0001gm-Tl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600945218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=epafIGV6J9MtgnVJ8iv4oNBTmD18i7Z4rPIFYnDJte0=;
 b=SDgegnhf6KltlPlhLhRNNDWPTng5NcrREka0KBYuox37Vi6GNOEq8DqKg2sLCVgbr7BDA/
 0X/Ia1SwjR5+8DSvFhxW1PP5B5wTTLLLekpVEA4OrDsNUVPQ2oypNp5aYCAtFgcvwWmItA
 /aEwwe0qYeOiAp4DldUELF51gfXaJ4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-JCkbynerNM2t1mi0jAPjhQ-1; Thu, 24 Sep 2020 07:00:16 -0400
X-MC-Unique: JCkbynerNM2t1mi0jAPjhQ-1
Received: by mail-wr1-f70.google.com with SMTP id 33so1099498wre.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 04:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=epafIGV6J9MtgnVJ8iv4oNBTmD18i7Z4rPIFYnDJte0=;
 b=MvsMybC1kzT5GhTO8GW3kFbMycGVAsaL6aWuCI1i8hKIhdGx7FzJ8ARewbV0lG2ZvR
 eoCch09eMPX770pbllDpwqDmS1zQboGCZYs8f/5vNPhwa4V1cteb+uwGBKMESDoJ+cfW
 VmjgjRc+m6LTS7ijyVDU52uK9KqaDEszmmwFUmhcxyOUpMqabjDbR0xwymCTSpbDYjFo
 Dxsbu058yb79k/xo0WeOL4g5A6jJYXHI22Sr+XX/VsNhc3oM4p9JDIHH9WxI1tXwZ8ed
 bkSuflUNNg6o//EugVNdyCJeZFtef+g1aMCeXB2vSOAMzyUVK7kt9Kuk8We/cq37pKBg
 hajA==
X-Gm-Message-State: AOAM530U56m46Vjs4GT6g1mnNn6zPfVSO8KWWy/vsax1VpGVmwD3zEtr
 f7fwzdQt5Sr3NBMSwCb+iKba06FZhES1d052Jcjyb1tYGxGPpDyTGbqyH9FpGx2kQDNJ+6t3oD+
 kQ435th/QJy46kAk=
X-Received: by 2002:a7b:ce8d:: with SMTP id q13mr4090783wmj.119.1600945214978; 
 Thu, 24 Sep 2020 04:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWp9x6a83iGCtEdXjzGCewn/XnTM4OZQhDvDIno4ZOHdDB70tDI+unHgybXBZW4ANgo6qSPA==
X-Received: by 2002:a7b:ce8d:: with SMTP id q13mr4090756wmj.119.1600945214722; 
 Thu, 24 Sep 2020 04:00:14 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id k4sm3299813wrx.51.2020.09.24.04.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 04:00:14 -0700 (PDT)
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
 <20200923164029-mutt-send-email-mst@kernel.org>
 <CAFEAcA8WSbvG9Cgp6J4fqp4AX-rCR2F3vjPsAVegv3axAFUiMA@mail.gmail.com>
 <CAFEAcA_EyDoO0nA39wrc9ERn=hQ08TWoMVHf1H1Lc2QMAfUjkw@mail.gmail.com>
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
Message-ID: <c8e42a7b-01fd-9c17-1984-bf898677cce6@redhat.com>
Date: Thu, 24 Sep 2020 13:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EyDoO0nA39wrc9ERn=hQ08TWoMVHf1H1Lc2QMAfUjkw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 12:51 PM, Peter Maydell wrote:
> On Thu, 24 Sep 2020 at 11:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Wed, 23 Sep 2020 at 21:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> Peter, you said you see issues on some systems.
>>> I pushed a tag:
>>>     git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream_test
>>> which drops some patches I suspect.
>>> If that helps, pls let me know.
>>
>> Yes, the original tag seems to just cause 'make check' to stall
>> out (the logfiles simply stop) for OSX, NetBSD, OpenBSD and
>> s390x. I'll try your test tag...
> 
> ...if the test tag works do you want me to merge it?

Not very important, but latest commit 8b004b51b9c is mis-squashed.

> 
> thanks
> -- PMM
> 


