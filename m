Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5387BC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 04:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C9B20700
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 04:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoPmfL4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C9B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igLyF-0008OO-7y
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 23:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igLxe-0007zW-6O
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 23:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igLxb-00088b-0g
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 23:56:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43913
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igLxa-00087t-Ke
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 23:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576385809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8HFuknbXINXAAhRk14V53jaomrIIMFMcmuG8o0oqKM=;
 b=NoPmfL4xVIdugKixqq9r7tVj6ZKADB5ooPtb2w6BXP0bPDn0aINpUGjfNcjpH4Zust3fAm
 GsbsjaQ+zQLEi4c6vfURoigyL6qvHb5k9ZszI+ZoZmm33lNWdyBMQttXMRzAhY/0SmPxbb
 cr+oo0DyaCZOKj56lYydW6Q0hXJbb9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-eAZkUvgiOsS1drMPI86Zxg-1; Sat, 14 Dec 2019 23:56:47 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so1758424wrt.21
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 20:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rDlgANhttMxSBGvPj/xsQ6/eaqHcaNJi+vyNymVXSvw=;
 b=IIRACLYvZmOsjF6k8Hbti4w80RqMKuGx/dbBVn0X8fcGsH8v0YOPhf2ITBbm3+Vvq6
 665W7e+Rl4kJiUP9yhHSLAxBc7nQBN4MgjLCdlKBggU48zKgGU4Q+warM33aGI2Wosaa
 DZ3RVh1WsoK3cs2JQoBsAbPFblOaXfSNwMIJRgpA6YHnBxcS7G7WH3DPxi4nA6uVzwlJ
 bEXb8m9nndMfFbO8qQ8DEbLeJM5LdXGl0Lh8rGFL2da5Dg8oQojwOIWVWQKVEI9bXLNG
 KC87d1OteumMpqO0r+qnwxJTO0F/H85C6S5xqkMaH2ZGdQb4mU3bRglQYwNacRD2D/9o
 C8lw==
X-Gm-Message-State: APjAAAVhwQkGGVZM7jZHVU/I4Wy1em9QEY/uWdfVngXvjZnR9ehVTPvV
 JYOHr1DnvYmKSPpHDGCx7m1LehZfUikFzKPvmbJbTXz+V/+T1gpCZvk7Twcw/yVNfsnIfHOiL9s
 m/GqsQW7rKSIPePE=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr22594402wmb.81.1576385806114; 
 Sat, 14 Dec 2019 20:56:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDGyxL3C0sSEiSdhDYkbJdvhGm6ACjRaTBvWeJUbshMRGl3d/M0cKAGnHzaxGExViqWJqyKA==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr22594375wmb.81.1576385805703; 
 Sat, 14 Dec 2019 20:56:45 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id y20sm15499882wmi.25.2019.12.14.20.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 20:56:45 -0800 (PST)
Subject: Re: [PATCH] target/arm: Display helpful message when hflags mismatch
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191209134552.27733-1-philmd@redhat.com>
 <87d0cx32vv.fsf@linaro.org> <1d51109a-ae9f-7bfe-66d4-0e1e1266df64@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1407bf23-85c2-fce2-da17-bed6766456f9@redhat.com>
Date: Sun, 15 Dec 2019 05:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1d51109a-ae9f-7bfe-66d4-0e1e1266df64@linaro.org>
Content-Language: en-US
X-MC-Unique: eAZkUvgiOsS1drMPI86Zxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 1:36 AM, Richard Henderson wrote:
> On 12/9/19 8:00 AM, Alex Benn=C3=A9e wrote:
>>> -#ifdef CONFIG_DEBUG_TCG
>>> -    assert(flags =3D=3D rebuild_hflags_internal(env));
>>> -#endif
>>> +    assert_hflags_rebuild_correctly(env);
>>
>> I'm trying to recall why we don't just use:
>>
>>    g_assert_cmphex(flags, =3D, rebuild_hflags_internal(env))

s/=3D/=3D=3D/ ;)

>>
>> I think it came up in one of the reviews.
>=20
> checkpatch.pl.
>=20
> Because, I believe, there is an environment variable that causes this to =
*not*
> abort on mismatch.

Indeed, see commit 6e9389563e5:

commit 6e9389563e56607f72562bdb72db452fcd7e7f74
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Thu Apr 27 17:55:26 2017 +0100

     checkpatch: Disallow glib asserts in main code

     Glib commit a6a875068779 (from 2013) made many of the glib assert
     macros non-fatal if a flag is set.
     This causes two problems:
       a) Compilers moan that your code is unsafe even though you've
          put an assert in before the point of use.
       b) Someone evil could, in a library, call
          g_test_set_nonfatal_assertions() and cause our assertions in
          important places not to fail and potentially allow memory=20
overruns.

     Ban most of the glib assertion functions (basically everything except
     g_assert and g_assert_not_reached) except in tests/

     This makes checkpatch gives an error such as:

       ERROR: Use g_assert or g_assert_not_reached
       #77: FILE: vl.c:4725:
       +    g_assert_cmpstr("Chocolate", >, "Cheese");


