Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F6EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABF9222C8
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqms8Vey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABF9222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFdzA-0007Vb-0Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 09:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFdyQ-0006nU-C5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:47:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFdyL-0001Cp-Rx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599572864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h9D63/GnAdET+Pfu3KRV+q0nr7oZ3TMVfwl2QOqMB1g=;
 b=hqms8Veyia4//v/RyYwhO3MDc+oka8mN0P2SQGU4Tpguw3oN0KRmIWzRIFPXTQNxP+hUgW
 s2If86m2JmDk7d/D4Gg2fzu7MZ3x2VrnEDRsbr/LdQVrsyozh1oTt/WQ/Sua3VYRXh5sn8
 YA/meAit3XoqAuNRHTalb0YtiFsr1+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-20Qw2ZLxMT2VuDMEnd3Bng-1; Tue, 08 Sep 2020 09:47:40 -0400
X-MC-Unique: 20Qw2ZLxMT2VuDMEnd3Bng-1
Received: by mail-wm1-f70.google.com with SMTP id m25so4775882wmi.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 06:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=h9D63/GnAdET+Pfu3KRV+q0nr7oZ3TMVfwl2QOqMB1g=;
 b=oesaQ4EZoU15ZThXrM/CVwQyc4QBRa7kRhY3vM8lOuBL6bP8CrwIn6f+jInr99k1q+
 H5cFHjTVYFqHvHl1kwzZgYyM8JaUoXY1NGiGRw0nTLrtGjOQxqskU9JUAdAkuCPe3SbE
 atc+kdbEQ6s6CAK1fGOMF3S88ep9N+B6uTaE4+BuMzquGWYQfD4OdE/slQtVK+f9pqN7
 UvSeJZ5tUqoxyQ4uOpuCTOiD1UrS4+8pPHGi7G2X+WAY/hWOKLACQLiDNEBaMgFAab0l
 QWhv2ZdCRFUZs+Mehe8Bb3QvDPWFVD77BysJZM0DQ4T1ShMmrc+03sRO6jzDl+CxoSxq
 hR7g==
X-Gm-Message-State: AOAM532EEpz/SJ/VuCFUD/RHWHaKLYi3/89rs54cmOs7Zz+E8P6Upw4+
 fQncuUlVWkK3gDSEnV/q18aNVLNfUD7HHAxM6FjZ3FsqzRBcKQOojWnZAG9bXj/eWzBzB4wpm28
 XMmKVJVV8Yn/7o4s=
X-Received: by 2002:a1c:3284:: with SMTP id y126mr4550787wmy.146.1599572859540; 
 Tue, 08 Sep 2020 06:47:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu7WLzr1F8OnFv0buAxF7FH7iXIYEYx25jH+UetgDl3+6fsluJVK2Gzk0hfEpZ9dO6lBn7gw==
X-Received: by 2002:a1c:3284:: with SMTP id y126mr4550745wmy.146.1599572859211; 
 Tue, 08 Sep 2020 06:47:39 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id s5sm34461454wrm.33.2020.09.08.06.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 06:47:38 -0700 (PDT)
Subject: Re: [PATCH 1/4] Acceptance tests: use an available kernel image
 package for arm
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200907042000.415931-1-crosa@redhat.com>
 <20200907042000.415931-2-crosa@redhat.com>
 <001385a1-92eb-d311-88b5-8e1e7f6f1f48@redhat.com>
 <20200907093930.GD810755@redhat.com>
 <34814b29-a47a-efd3-971b-520bc5ac6309@redhat.com> <87r1rcpfpy.fsf@linaro.org>
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
Message-ID: <abf41633-adce-9cb3-dc49-5a0ca5c72fea@redhat.com>
Date: Tue, 8 Sep 2020 15:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1rcpfpy.fsf@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 3:20 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 9/7/20 11:39 AM, Daniel P. Berrangé wrote:
>>> On Mon, Sep 07, 2020 at 10:06:13AM +0200, Philippe Mathieu-Daudé wrote:
>>>> [Cc'ing Daniel who usually have good ideas for that
>>>> kind if project-wide problem]
>>>>
>>>> On 9/7/20 6:19 AM, Cleber Rosa wrote:
>>>>> Which means a newer kernel version.  Expected output was changed
>>>>> to match the new kernel too.
>>>>
>>>> Nack.
>>>>
>>>> Acceptance tests are not to test the latest Linux kernel,
>>>> they aim to assert a specific kernel tested by some developer
>>>> still works while QEMU evolves.
>>>> QEMU doesn't have to adapt to the latest kernel;
>>>> QEMU should keep boot an old kernel.
>>>>
>>>> Testing new kernels is good, you are adding coverage. But
>>>> this break the acceptance testing contract "keep testing
>>>> the same thing over time".
>>>>
>>>> The problem you are trying to fix is the "where to keep
>>>> assets from public locations where they are being removed?"
>>>> one. Two years ago [*] you suggested to use some storage on
>>>> the avocado-project.org:
>>>>
>>>>   For Avocado-VT, there are the JeOS images[1], which we
>>>>   keep on a test "assets" directory.  We have a lot of
>>>>   storage/bandwidth availability, so it can be used for
>>>>   other assets proven to be necessary for tests.
>>>>
>>>>   As long as distribution rights and licensing are not
>>>>   issues, we can definitely use the same server for kernels,
>>>>   u-boot images and what not.
>>>>
>>>>   [1] - https://avocado-project.org/data/assets/
>>>
>>> If I look at stuff under that directory I see a bunch of "Jeos" qcow2
>>> images, and zero information about the corresponding source for the
>>> images, nor any information about the licenses of software included.
>>> IOW what is stored their right now does not appear to comply with the
>>> GPL licensing requirements for providing full and corresponding source.
>>>
>>>> It is time to have QEMU assets managed the same way.
>>>
>>> I'd rather we didn't do anything relying on binary blobs with no
>>> info about how they were built. Pointing to the 3rd party download
>>> URLs was the easy way to ensure we don't have to worry about licensing
>>> problems.
>>
>> I tried to be very strict including the recipe about how to rebuild
>> and description of the source (for licensing) in each commits (Alex
>> Bennée once said Debian/Fedora based was OK):
> 
> Debian and Fedora both have good project hygiene for tracking sources
> for their binary packages and extensive archives which we can work with.
> These other projects seem to be more of a moving feast which I think is
> proving we can't rely on them as a CI test and at best best efforts for
> developer testing.
> 
> It seems Armbian do document their build process but it's not quite as
> easy as just downloading the source deb.

Should we remove the Armbian based tests? I don't have any problem,
as long as the requisites for adding a test are clearly documented
(as there are not obvious to all).

> <snip>
>>
>>>
>>> IIUC, the majority of our acceptance tests needs should be satisfied
>>> with a combination of a Linux kernel and busybox tools. We already
>>> use cross-compilers to build TCG test cases.
>>>
>>> I'd like to see us provide a minimal "config" file for each Linux
>>> kernel combo we need to test. We should be able to define a fairly
>>> simple script that do the Linux build, busybox build and then puts
>>> the combination of them into a disk image.  Something 100% automated
>>> and reviewable.
>>
>> For Debian/Fedora this config is available in their package (or source
>> package).
>>
>>>
>>> Even a minimal linux build takes some time, so we would need to cache
>>> the binary result in some suitable manner. At least this way we have
>>> a clear record of what we're building & how and can thus satisfy the
>>> license rules.
>>
>> Yes, but if the Debian/Fedora build farms already build/published
>> their packages, it is easier to use it directly.
>>
>> QEMU developers are very reluctant to add tests. I suppose we prefer
>> to develop or fix bugs rather than write tests. If we ask full build
>> recipe for each tests, I doubt we'll have much testing.
> 
> I've pondered this before and while it might have a place for random
> weird machines with no mainline distro support it's not a path I'm keen
> to go down. This goes especially for some of the more esoteric ARM
> hardware where you start relying on hacked up vendor trees with very
> specific toolchain requirements.

What I'd really like is to have the test logic in mainstream (not
the test artifacts). That way maintainers can "pass" their tests
when passing maintenance, or if one stop contributing, the tests
are still usable by anyone in the community.

Some closed-source binaries are available publicly, and we can
verify their hash.
Is it acceptable to add test + hash in mainstream, so any developer
in possession of such binaries is free to run the tests? There
should not be any licensing issue.

I would like to avoid "black box" devices we are afraid to modify
because very few people can test them.

Example of tests I'd like to add:
https://www.mail-archive.com/xen-devel@lists.xenproject.org/msg41162.html

Thanks,

Phil.


