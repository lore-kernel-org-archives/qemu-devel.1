Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302BB22B4E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB4Nw9XL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302BB22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ems-0003QL-9N
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2elc-0002yO-LL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:00:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2ela-0000lb-PL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596477653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=30TUhlIYqhTYw+N9+e1K3kteHwsnV2eDT5UD6NNKxa0=;
 b=PB4Nw9XL99IxECCyVz0D565cdm2oWGrCAsfw9+L6VIMElI4JT7WW/f1yiS1UqpPUj4G0BD
 9s4ys2LO601RKp+QtKt8XSqF9TzyYtJWR+vEgpfiutdD6eRzkr3HdSq03W2nBWPsMU20PI
 D8I4UfhniDmIokRqGpqD3lVtfoM5tRE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-A0keDcbCMneAEdwwP7v7aA-1; Mon, 03 Aug 2020 14:00:51 -0400
X-MC-Unique: A0keDcbCMneAEdwwP7v7aA-1
Received: by mail-wr1-f72.google.com with SMTP id e14so8440641wrr.7
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 11:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=30TUhlIYqhTYw+N9+e1K3kteHwsnV2eDT5UD6NNKxa0=;
 b=pUKwRqGahmUNOUvPERsLEYjxrlQCy/cbmCFxNPzV2CzhdZyXiwRjam4bNDg0w4zZBb
 kBkEbh3CQ40pXG8CdVclVo1zw5OqzXNTtrckl9+hUZ/8XuICnmcEAudH4mUwHYiejReA
 yLuy61yxbO6UlhNtEFEOdkSbhfZOc3mSbYprFvytMyPOLAo7ojJcE5TSw+Tu4VCf3Lb/
 cWOyr9qOj9jwt3x0qYDlQzsRSw6gh6411b9FMmvjlE8kec6KmHsYkVUhKQmudDcAALMN
 UxY6PWQWUijGhfHYIjiZuK8vIMqGgpdNfVVXRvwr4PYl2AzccZULgy3iqvitaZEFTMqu
 M3/g==
X-Gm-Message-State: AOAM533LqDQ39wrLAXMIScK/IFnvCP0ovykC4TR5jPRU8Jp8ZZ4sYGB1
 eJxikFnTLdEo9ZZrdcvKfy6yZRns3poMj/tK0KawAk/lhgFO/WPh6mt7VT8/55B3TtCBHTb5XNL
 ikl/o/mU0/IzAUE0=
X-Received: by 2002:a5d:668b:: with SMTP id l11mr7512241wru.135.1596477649735; 
 Mon, 03 Aug 2020 11:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrzl9IrrNzUDamJKG3z9GzV6T//bgBWAX2aphszkyQ99jAJMsgot9amaCerpXh0JG4ABB/Tg==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr7512214wru.135.1596477649364; 
 Mon, 03 Aug 2020 11:00:49 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id a11sm29647574wrq.0.2020.08.03.11.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 11:00:48 -0700 (PDT)
Subject: Re: [PULL 00/63] riscv-to-apply queue
To: Thomas Huth <thuth@redhat.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
 <CAFEAcA-8QejH-sFsP_rmKuYdYbQdYRjrHaNz4vLHzfYiSBCKYA@mail.gmail.com>
 <CAKmqyKNo9rPtbtqb1R3OFKH71geYjo0mZONNLxkL0Mg6bnb1Zw@mail.gmail.com>
 <544fb149-c920-b396-7297-f9688a744445@c-sky.com>
 <29f57b2e-7d67-5da2-0ad0-0750e400a91c@redhat.com>
 <67c76bac-2416-9ace-a71b-ab56b864975b@c-sky.com>
 <808d1b49-c03c-6bc7-09e1-7028259bbef6@redhat.com>
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
Message-ID: <ff8340c3-7cc2-72aa-8698-8a847ce416b4@redhat.com>
Date: Mon, 3 Aug 2020 20:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <808d1b49-c03c-6bc7-09e1-7028259bbef6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 13:51:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 7:53 PM, Thomas Huth wrote:
> On 30/06/2020 10.44, LIU Zhiwei wrote:
>>
>>
>> On 2020/6/30 16:11, Thomas Huth wrote:
>>> On 30/06/2020 08.56, LIU Zhiwei wrote:
>>>>
>>>>
>>>> On 2020/6/29 6:51, Alistair Francis wrote:
>>>>> On Sun, Jun 28, 2020 at 7:30 AM Peter Maydell
>>>>> <peter.maydell@linaro.org> wrote:
>>>>>> On Fri, 26 Jun 2020 at 22:53, Alistair Francis
>>>>>> <alistair.francis@wdc.com> wrote:
>>>>>>> The following changes since commit
>>>>>>> 553cf5d7c47bee05a3dec9461c1f8430316d516b:
>>>>>>>
>>>>>>>    Merge remote-tracking branch
>>>>>>> 'remotes/pmaydell/tags/pull-target-arm-20200626' into staging
>>>>>>> (2020-06-26 18:22:36 +0100)
>>>>>>>
>>>>>>> are available in the Git repository at:
>>>>>>>
>>>>>>>    git@github.com:alistair23/qemu.git
>>>>>>> tags/pull-riscv-to-apply-20200626-1
>>>>>>>
>>>>>>> for you to fetch changes up to
>>>>>>> b39d59434ea10649fdb9e0a339c30c76e38c5e17:
>>>>>>>
>>>>>>>    target/riscv: configure and turn on vector extension from
>>>>>>> command line (2020-06-26 14:22:15 -0700)
>>>>>>>
>>>>>>> ----------------------------------------------------------------
>>>>>>> This PR contains two patches to improve PLIC support in QEMU.
>>>>>>>
>>>>>>> The rest of the PR is adding support for the v0.7.1 RISC-V vector
>>>>>>> extensions. This is experimental support as the vector extensions are
>>>>>>> still in a draft state.
>>>>>>>
>>>>>> Hi; I'm afraid this fails to build on PPC64 and s390x (ie
>>>>>> our big-endian hosts):
>>>> Hi Peter,
>>>>
>>>> Do you mean you built the patch set on PPC64 or s390x and got errors
>>>> in the list? Or just a worry?
>>>>
>>>> I have built the patch set on Ubuntu 18.04 X86-64. I don't know which
>>>> compile option
>>>> will fails the compilation. If you compiled on Ubuntu x86-64, could
>>>> you show me the
>>>> compile option?
>>>
>>> The related code in your patch "target/riscv: add vector stride load
>>> and store instructions" is in a "#ifdef HOST_WORDS_BIGENDIAN" section,
>>> so of course this bug does not trigger on a x86 host. You could
>>> temporarily turn the "#ifdef HOST_WORDS_BIGENDIAN" into a "#if 1" to
>>> see whether you can then also reproduce the error on x86.
>>>
>> Yes. I can reproduce it in this way.
>>>> As a note: I try to find a PPC64 for test, but I'm afraid it will be
>>>> too later.
>>>> Is there an available  PPC64  machine in the community?
>>>
>>> Maybe the easiest way to test your code on a big endian machine, too,
>>> is to get a github account, clone the QEMU repository there, and
>>> enable Travis for that repo. Then your code gets built on some non-x86
>>> architectures (including a big-endian s390x) as soon as you push it to
>>> the repo (see .travis.yml for details).
>>>
>> Thanks very much. I will have a try.
>>>>>> /home/ubuntu/qemu/target/riscv/vector_helper.c: In function
>>>>>> ‘vext_clear’:
>>>>>> /home/ubuntu/qemu/target/riscv/vector_helper.c: In function
>>>>>> ‘vext_clear’:
>>>>>> /home/ubuntu/qemu/target/riscv/vector_helper.c:154:21: error: invalid
>>>>>> operands to binary & (have ‘void *’ and ‘long long unsigned int’)
>>>>>>           memset(tail & ~(7ULL), 0, part1);
>>>
>>> You obviously must not use "&" with a pointer. I guess you have to
>>> cast to "uintptr_t" and back, or think of some other smart way to fix
>>> this.
>>>
>> Yes. That's the error. It  build successfully after the cast.
> 
> I'm sorry, but the new code fails to compile on big endian 32-bit
> targets, see https://gitlab.com/huth/qemu/-/jobs/667762754#L3434 :
> 
> /builds/huth/qemu/target/riscv/vector_helper.c: In function 'vext_clear':
> /builds/huth/qemu/target/riscv/vector_helper.c:154:16: error: cast to
> pointer from integer of different size [-Werror=int-to-pointer-cast]
>          memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
>                 ^
> /builds/huth/qemu/target/riscv/vector_helper.c:155:16: error: cast to
> pointer from integer of different size [-Werror=int-to-pointer-cast]
>         memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
>                 ^
> cc1: all warnings being treated as errors
> 
> A quick work-around is maybe to replace "ULL" with simply "UL" ?

Or use QEMU_ALIGN_PTR_DOWN?

> 
>  Thomas
> 
> 


