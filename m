Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0EFC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC1A20717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfS7Z81q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC1A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIvZ-0007RK-5S
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyIue-0006aR-MY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:52:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56110
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jyIuc-0001Ra-Od
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595440333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycQz61I7K7qVwbbQfYYh60iLRfoy+L/4IX3bY33AaXM=;
 b=MfS7Z81qRKSMGhVO/H22p2NOiCAcDMPbSMpl9UZnK02eSYUkOyJjUjpyKg6YLauBoDakYj
 rBGe0aPtWluWkHAQj4cKf5W8tE8b4To4z///0zhCa+Yu74v6Dq+wvHEdaWRRThnw/idSXc
 RdyGj72MvSow95Tuq3gok04tb/CDrZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-G_gKBPBXNYqFT-6W59sULw-1; Wed, 22 Jul 2020 13:52:08 -0400
X-MC-Unique: G_gKBPBXNYqFT-6W59sULw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E8C91932482;
 Wed, 22 Jul 2020 17:52:07 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-129.ams2.redhat.com
 [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9920E2B4DD;
 Wed, 22 Jul 2020 17:52:04 +0000 (UTC)
Subject: Re: [PATCH] target/i386: floatx80: avoid compound literals in static
 initializers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200716144251.23004-1-lersek@redhat.com>
 <a38a3da3-7406-0ba3-ca32-e96a99915c97@redhat.com>
 <af008780-5207-c156-56f3-dcda95367a5a@redhat.com>
 <cc685d76-db4c-74bf-34dc-744fdd28add3@redhat.com>
 <d3686a7e-c949-8111-80d9-45aa506fcf58@redhat.com> <87eep4voth.fsf@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d925cbad-128a-091c-d76b-450b40285c1d@redhat.com>
Date: Wed, 22 Jul 2020 19:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87eep4voth.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joseph Myers <joseph@codesourcery.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/21/20 18:02, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 7/17/20 6:46 PM, Laszlo Ersek wrote:
>>> On 07/17/20 11:26, Laszlo Ersek wrote:
>>>> On 07/16/20 17:09, Philippe Mathieu-Daudé wrote:
>>>>> On 7/16/20 4:42 PM, Laszlo Ersek wrote:
>>>>>> Quoting ISO C99 6.7.8p4, "All the expressions in an initializer for an
>>>>>> object that has static storage duration shall be constant expressions or
>>>>>> string literals".
>>>>>>
>>>>>> The compound literal produced by the make_floatx80() macro is not such a
>>>>>> constant expression, per 6.6p7-9. (An implementation may accept it,
>>>>>> according to 6.6p10, but is not required to.)
>>>>>>
>>>>>> Therefore using "floatx80_zero" and make_floatx80() for initializing
>>>>>> "f2xm1_table" and "fpatan_table" is not portable. And gcc-4.8 in RHEL-7.6
>>>>>> actually chokes on them:
>>>>>>
>>>>>>> target/i386/fpu_helper.c:871:5: error: initializer element is not constant
>>>>>>>      { make_floatx80(0xbfff, 0x8000000000000000ULL),
>>>>>>>      ^
>>>>>
>>>>> This reminds me of:
>>>>>
>>>>> commit 6fa9ba09dbf4eb8b52bcb47d6820957f1b77ee0b
>>>>> Author: Kamil Rytarowski <n54@gmx.com>
>>>>> Date:   Mon Sep 4 23:23:06 2017 +0200
>>>>>
>>>>>     target/m68k: Switch fpu_rom from make_floatx80() to make_floatx80_init()
>>>>>
>>>>>     GCC 4.7.2 on SunOS reports that the values assigned to array members
>>>>> are not
>>>>>     real constants:
>>>>>
>>>>>     target/m68k/fpu_helper.c:32:5: error: initializer element is not
>>>>> constant
>>>>>     target/m68k/fpu_helper.c:32:5: error: (near initialization for
>>>>> 'fpu_rom[0]')
>>>>>     rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
>>>>>
>>>>>     Convert the array to make_floatx80_init() to fix it.
>>>>>     Replace floatx80_pi-like constants with make_floatx80_init() as they are
>>>>>     defined as make_floatx80().
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>
>>>>>>
>>>>>> We've had the make_floatx80_init() macro for this purpose since commit
>>>>>> 3bf7e40ab914 ("softfloat: fix for C99", 2012-03-17), so let's use that
>>>>>> macro again.
>>>>>>
>>>>>> Fixes: eca30647fc07
>>>>>> Fixes: ff57bb7b6326
>>>>>> Link: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg06566.html
>>>>>> Link: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04714.html
>>>>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>>>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>>>> Cc: Joseph Myers <joseph@codesourcery.com>
>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>>>> ---
>>>>>>
>>>>>> Notes:
>>>>>>     I can see that there are test cases under "tests/tcg/i386", but I don't
>>>>>>     know how to run them.
>>>>>
>>>>> Yeah it is not easy to figure...
>>>>>
>>>>> Try 'make run-tcg-tests-i386-softmmu'
>>>>> but you need docker :^)
>>>>
>>>> That worked, thanks! Even without Docker: I just had to add
>>>>
>>>>   --cross-cc-i386=gcc
>>>>
>>>> to my ./configure flags.
>>>>
>>>
>>> Also -- I meant to, but I forgot to put "for-5.1" in the subject prefix;
>>> sorry about that.
>>
>> Alex, as Paolo is not available, can this go via your tree?
> 
> Ok queued to for-5.1/fixes-for-rc1-v2, thanks.

Many thanks!
Laszlo


