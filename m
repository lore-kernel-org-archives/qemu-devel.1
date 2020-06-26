Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586EDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233F02080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAOxIDUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233F02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joklO-0007xf-AY
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jokeC-0003Ei-Uf
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:27:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joke9-0007Uo-KJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593163663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eK1ByqFxjYOhmHmHtjXl69yX2Hyo7U2TRNxAda1lTpU=;
 b=eAOxIDUIfeOvB/a+h28XE4HVft1TBZF1S8BIaA2EQtimDDFjf6n6o0gxwPd5E7h9RaFWDK
 IK9VIAgZC/fK8nqWtc06oYoSFmuqDsxQYyiq8q81qoGArG66TjNs7842YDOYyWRIABk7b+
 L10F+thf9zAdAOPQKIGKk0JvtxFrtmM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-LSWcjTgJPz-lfPmWPQa0cg-1; Fri, 26 Jun 2020 05:27:40 -0400
X-MC-Unique: LSWcjTgJPz-lfPmWPQa0cg-1
Received: by mail-wm1-f71.google.com with SMTP id e15so10178868wme.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 02:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eK1ByqFxjYOhmHmHtjXl69yX2Hyo7U2TRNxAda1lTpU=;
 b=ooTZu8Q0F6B7tTeqJ8k+R91ItUPHAJmchURf7diqTr07/VTqAfCih1M4Rk30XvYsgO
 oDQWK79X8LzIFO5223hDo8WpapGDjmJ3SiPf8P7vNSaBsZSqzPx0uTiPIev6iG2IVW4O
 yHWsrDxquWaMo5mQ1oo+xXwZ+GWiv6jnirDxt4gcU3J9DAczOJQRaPGqIxAc1MN5ONuO
 sfpniRLn2I+GcpXxbQxEXKoOAZCZBtIZ+YqoF/rem9qSCNkjdDfGbz7slXNW7VwIqC/W
 RekTDx87gya3qDccfaeyFUCe2f/SnnmBCVHdkC60iQd9U2NVoXzc0HRJcBGoRf89JFab
 P5+A==
X-Gm-Message-State: AOAM533LHfA9Ai0KHEk7RjZXGpeH6z3qxiXcVvrhDUfOxmuZzrV8ToP2
 8kEB4fDfSp+P+VhLXKZp/mo5lk/W3/akJZrk35xcian4ispy/wdnqNpv/eswu9YHWaYBNNfIZh3
 x5oEGJ01T6je2ZLg=
X-Received: by 2002:a1c:a385:: with SMTP id m127mr2286153wme.112.1593163658716; 
 Fri, 26 Jun 2020 02:27:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyllPMigMAezTkofXzS5INEKqFe2vJP/crtWEjn212wQPzyk/rOL1/YBBD9YHfJd+P3+OeXbw==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr2286128wme.112.1593163658430; 
 Fri, 26 Jun 2020 02:27:38 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 63sm38807718wra.86.2020.06.26.02.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 02:27:37 -0700 (PDT)
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
To: Thomas Huth <thuth@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bug 1885247 <1885247@bugs.launchpad.net>, arilou@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
 <CAHiYmc7_ra2qWJ8mkZ-vqL5vN2BKdWxAZeKNnMEkPtien5-fsw@mail.gmail.com>
 <b34bf27c-3189-addc-0c50-b0c0c533876d@redhat.com>
 <d2657f75-26fe-117b-183d-732d88da2653@redhat.com>
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
Message-ID: <32aa7cf6-5f4d-eb79-2ebe-ee463f4389b8@redhat.com>
Date: Fri, 26 Jun 2020 11:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d2657f75-26fe-117b-183d-732d88da2653@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 11:20 AM, Thomas Huth wrote:
> On 26/06/2020 11.13, Philippe Mathieu-Daudé wrote:
>> On 6/26/20 9:37 AM, Aleksandar Markovic wrote:
>>> пет, 26. јун 2020. у 09:11 Aleksandar Markovic
>>> <1885247@bugs.launchpad.net> је написао/ла:
>>>>
>>>> Public bug reported:
>>>>
>>>> The code base is on master, checked out on Thursday June25th 2020,
>>>> 0250c595c9d. The build procedure:
>>>>
>>>> $ mkdir build-gcc
>>>> $ cd build-gcc
>>>> $ ../configure
>>>> $ make
>>>>
>>>> The build error message is:
>>>>
>>>>    CC      x86_64-softmmu/hw/hyperv/hyperv.o
>>>>    CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
>>>>    CC      x86_64-softmmu/hw/hyperv/vmbus.o
>>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function
>>>> ‘gpadl_iter_io’:
>>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast
>>>> to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>>>           p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
>>>> off_in_page);
>>>>               ^
>>>> cc1: all warnings being treated as errors
>>>> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69:
>>>> hw/hyperv/vmbus.o] Error 1
>>>> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>>
>> FWIW there is no CI job covering x86 KVM on 32-bit host build.
>> Should this be covered? I guess the problem is no CI services
>> provide 32-bit x86...
> 
> You can certainly provide either a container, or install the 32-bit
> libraries in a 64-bit environment. Then run
> 
> PKG_CONFIG_LIBDIR=... ./configure --extra-cflags=-m32
> 
> and it should be possible to build 32-bit binaries, too.
> 
> Alternatively, we could add a cross-compilation job that builds with
> i686-w64-mingw32 in 32-bit.

Oh, this case is covered:
https://app.shippable.com/github/qemu/qemu/runs/2437/2/console

But this doesn't use KVM ;)


