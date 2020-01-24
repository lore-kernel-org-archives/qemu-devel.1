Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B74C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C40420708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmS+cw/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C40420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuwI2-0002Ot-GT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuwHQ-0001vV-A8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuwHO-0000uv-Jk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:33:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuwHO-0000uR-GU
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579862013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLZG0OSmeXw9/jo1C2/0VmIhTKeU6f1/uxgiUfF7Qfk=;
 b=BmS+cw/2D2RQoJdOtR14jYP0WE5LkoOMQ1Ted00sI1l0EW3Zxut7n3TAlAvvaaj6lQM8Eq
 ANUgSct14EfQI6L2eEejMtetoFhmTwQV+ubPLTUn7+6GLOmdYSfiamTQHGzAF/rWAbOgHV
 c5hg8K/543lfSszDg1ip76iHSaQkX6c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-0XvMqkn1OTC5iNAxQVLDng-1; Fri, 24 Jan 2020 05:33:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id f17so949138wrt.19
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wUaOuj7DD7o1kDaFKZGfV8OsBH6FzPhQLU8pzD3gs0Q=;
 b=rurFPb+cNxwFkV+iRRu9evCtODphSZKcDQxHRTysyk+/ck9JYxXbLpFfui8gO+rs4p
 EagXQBmj+XCSFBuWzgkco7aPzOoil1bgWVBleSNq+msJYZWU43+q5GbYx/f/sOMF4kgV
 vI21FYgF/tg3wTJwrtj4S8b7BQgrr/bDXRiAUJkryPxn/FWmuMWZD7N5qM0TgIWqtlvz
 mLj2diaM7iwjo2Pq0XpX4+aFeeQRvHRa3L8eyNpCHgXxw7iAooRHHFG9p/Xbyai8Txu9
 zPCvwcP2WMTBHuIBxLdKGN4h3HZCo77lXsp6tDV9FgNeNS5hYMA/cpXWmDV7ki/G+ox+
 GOSw==
X-Gm-Message-State: APjAAAUAB7wKPhRUIFyGMe6jbhhm4qC+5Jp772Une2GZF16wfxpKL5hU
 AQMxNI176NjjWUMEgdAxHvJZj1BZ5/XIueul9uLzMml6Dt2IJ4NHj9cPIhh2HuJIYbTHy5HwuHp
 bJ2UTtQuow302ppU=
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr3680233wrs.247.1579862008015; 
 Fri, 24 Jan 2020 02:33:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzH4dL3/5HrKG1bvLnvArB2If6MLXewZVzM+E0J/uADaY9YXvO74DJb1XY80ax8A5wSbGEbVg==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr3680196wrs.247.1579862007693; 
 Fri, 24 Jan 2020 02:33:27 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u16sm6056278wmj.41.2020.01.24.02.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 02:33:27 -0800 (PST)
Subject: Re: [PATCH] tests/boot-serial-test: Allow the HPPA machine to shudown
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200123003603.11610-1-f4bug@amsat.org>
 <a71b6c89-b36c-ebb6-3ff4-c3866309125c@redhat.com>
 <0deda7d0-78a1-6618-e2b5-9b92b301557a@redhat.com>
 <1c474db4-a9b6-1103-b34d-c37a5338a91e@redhat.com>
 <0e5d2965-4249-2499-db5e-ee6dd88afb54@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d7b6f52-3141-982e-a0cf-af793e898990@redhat.com>
Date: Fri, 24 Jan 2020 11:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0e5d2965-4249-2499-db5e-ee6dd88afb54@redhat.com>
Content-Language: en-US
X-MC-Unique: 0XvMqkn1OTC5iNAxQVLDng-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 8:02 AM, Thomas Huth wrote:
> On 23/01/2020 22.37, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/23/20 7:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 1/23/20 5:39 AM, Thomas Huth wrote:
>>>> On 23/01/2020 01.36, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> The boot-serial test uses SeaBIOS on HPPA, and expects to read the
>>>>> "SeaBIOS wants SYSTEM HALT" string, see [*]:
>>>>>
>>>>>  =C2=A0 122 void __VISIBLE __noreturn hlt(void)
>>>>>  =C2=A0 123 {
>>>>>  =C2=A0 124=C2=A0=C2=A0=C2=A0=C2=A0 if (pdc_debug)
>>>>>  =C2=A0 125=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("H=
ALT initiated from %p\n",
>>>>> __builtin_return_address(0));
>>>>>  =C2=A0 126=C2=A0=C2=A0=C2=A0=C2=A0 printf("SeaBIOS wants SYSTEM HALT=
.\n\n");
>>>>>  =C2=A0 127=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile("\t.word 0xfffdead0"=
: : :"memory");
>>>>>  =C2=A0 128=C2=A0=C2=A0=C2=A0=C2=A0 while (1);
>>>>>  =C2=A0 129 }
>>>>>
>>>>> A 'SYSTEM HALT' would really halts the CPU, but SeaBIOS implements
>>>>> it as an infinite loop.
>>>>>
>>>>> If SeaBIOS does not use the expected serial port but another device,
>>>>> we might poll the console indefinitely while the machine is halted.
>>>>>
>>>>> Allow the HPPA machine to 'shutdown'. When it does, we'll get
>>>>> a qtest error:
>>>>>
>>>>>  =C2=A0=C2=A0 $ make check-qtest-hppa
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-hppa: te=
sts/qtest/boot-serial-test
>>>>>  =C2=A0=C2=A0 ** (tests/qtest/boot-serial-test:31924): ERROR **: 01:1=
2:37.604:
>>>>> Failed to find expected string. Please check
>>>>> '/tmp/qtest-boot-serial-sjxoM6Q'
>>>>>  =C2=A0=C2=A0 ERROR - Bail out! FATAL-ERROR: Failed to find expected =
string.
>>>>> Please check '/tmp/qtest-boot-serial-sjxoM6Q'
>>>>>  =C2=A0=C2=A0 make: *** [tests/Makefile.include:628: check-qtest-hppa=
] Error 1
>>>>
>>>> The tests are run with -no-shutdown. Why does qemu exit in that case?
>>>
>>> Because the HPPA firmware called HALT.
>>>
>>>> Sounds like a bug in another place, and not in the boot-serial-test.
>>>
>>> Yes, the bug is elsewhere, but with the bug the boot-serial-test hangs
>>> forever.... No output on the console, qtest waiting indefinitely.
>>
>> Richard explained me on IRC what you probably meant, which was not
>> obvious to me at first.
>=20
> I think I also did not really understand what you tried to do here ;-)
>=20
> The -no-shutdown is required, too, otherwise you could get a race
> between the test reading the serial output and the termination of QEMU,
> see commit 7150d34a1d60851d73d6ab6783b12b1d25e68f86, and I think we need
> that for HPPA, too.
>=20
>> Now I found in check_guest_output():
>>
>>  =C2=A0=C2=A0=C2=A0 /* Poll serial output... */
>>  =C2=A0=C2=A0=C2=A0 while (1) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Wait at most 360 seconds.=
=C2=A0 */
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 now =3D time(NULL);
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (now - start >=3D 360) {
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_usleep(10000);
>>  =C2=A0=C2=A0=C2=A0 }
>>
>> $ QTEST_QEMU_BINARY=3Dhppa-softmmu/qemu-system-hppa \
>>  =C2=A0 time tests/qtest/boot-serial-test -k
>> /hppa/boot-serial/hppa:
>> ** (tests/qtest/boot-serial-test:18604): ERROR **: 22:33:25.010: Failed
>> to find expected string. Please check '/tmp/qtest-boot-serial-sZq7ljM'
>> Command terminated by signal 5
>> 0.31user 0.66system 6:00.07elapsed 0%CPU
>>
>> Indeed the test fails after 6min, I guess I didn't expect that much
>> while testing interactively.
>=20
> Yeah, the huge timeout is ugly, but it is required for very slow hosts,
> see commit 627fce617868df87b3757375a2a0318ad2beb381.
>=20
> So if you want to "fix" your problem, I think you could maybe add a
> check for the QEMU events here instead. Or add a check to see whether
> the registers of the guest change between iterations to make sure that
> the guest is still alive (that way you also handle the case that the
> guest crashed and loops forever in a "branch self" instruction). Or
> simply continue with the 360s timeout, it's long, but it should trigger
> only in case of other bugs, so it's maybe not worth the effort to add
> more logic here.

Good idea. With QMP it is easy:

{ "execute": "query-status" }
{
     "return": {
         "status": "shutdown",
         "singlestep": false,
         "running": false
     }
}


