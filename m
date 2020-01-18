Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C50C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087E024680
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBVlkaej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087E024680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishKR-0007ts-0w
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishJn-0007Sa-LP
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishJj-0000ig-J9
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:10:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishJj-0000hC-77
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579327842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5V5qx2H6cnrqCHl6OiwHZXjaJWvLfBnbsGSNCW/0V0=;
 b=FBVlkaejAa4dRjMz/bMdoJGKhqc3tHa9bC+V/gCh1ligR9nqc9fROlTX5EDDO0+SNRtDxj
 9rrufEm64wjXC9e0VVDlnDsc7A6ViqMZzDwT3W58vyDLwFOuhMIdV5YZ5NO3bSfmHhLRFo
 lOGf+JG5Hjn7d05MEOpCF+gwC4ITois=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-8LRxH6QuNnOQakyKajLysw-1; Sat, 18 Jan 2020 01:10:38 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so11365038wrq.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+osWOotiM2GwZz5JWAk495gfw0qkXyBAqxjNKYqyFjk=;
 b=H2Wfg3ta5naAKCY5WG0TQfZA5pLsPpilxeCLva05r58CJ7vkBHjPytDi5LXISU050/
 0LjfL6lFCNvVdF3owz7VzI499NbPGVi4MkbS67heVXMuNI9yUeFl9r4ia9EQWoWJ0ssx
 EJ0YNoA0BQQCXd7hiWZ/jNNlvX1C+iNKJhZjAkRClPS2ulblaWsGlvf/Z1WLCwd0zbAe
 l9EApQzLbipR5TvSdZ7iH+uojJ+oiWN53T9P21YNXRXa5M+KuLHgDi6qtaF5cJpU1S+6
 AyDgZfZUGN/1nhdKoLd/hzOyTrVD40fDkEyEKOZrzYXRGyyETt2v0hZGzaGRFxM7F8p2
 V2mA==
X-Gm-Message-State: APjAAAUqTqo5G1gO9VAwQbpJG1K6gtC6VegoO5O0RGauqNTewSR9vJQa
 epcqe/guA0IzfmpCEhag+Mqy42mD+nAYSbEJkOu0ldCu3g/HnF3PtXtvLTxo81ECGwOm9gx2TiK
 m940sLPeRM9k2wxc=
X-Received: by 2002:adf:a285:: with SMTP id s5mr7139365wra.118.1579327837142; 
 Fri, 17 Jan 2020 22:10:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwz7p6HvF5AH3pN4Y2XWI1vZj1a+FS+HvjOpFiHCB8w2uRcRLtQvu2urASAc1Ep0wrd7ITvBQ==
X-Received: by 2002:adf:a285:: with SMTP id s5mr7139350wra.118.1579327836887; 
 Fri, 17 Jan 2020 22:10:36 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z4sm12677444wma.2.2020.01.17.22.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:10:36 -0800 (PST)
Subject: Re: [PATCH] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
To: Richard Henderson <richard.henderson@linaro.org>
References: <20200117015322.12953-1-richard.henderson@linaro.org>
 <CAP+75-WqE4j7kRkSae+fQHn9N0=L+OTZz5xUziZkn9Z-1uAs9Q@mail.gmail.com>
 <ae03e9e6-af60-1b32-751f-68c08d0b3d51@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0650e07e-d9d9-d5dd-2387-65ee3c5a12f1@redhat.com>
Date: Sat, 18 Jan 2020 07:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ae03e9e6-af60-1b32-751f-68c08d0b3d51@linaro.org>
Content-Language: en-US
X-MC-Unique: 8LRxH6QuNnOQakyKajLysw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Helge Deller <deller@gmx.de>, dave.anglin@bell.net,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 8:23 PM, Richard Henderson wrote:
> On 1/17/20 8:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On Fri, Jan 17, 2020 at 2:53 AM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
>>> or the operation is undefined.  However, real hardware only generates
>>> an unaligned access trap for unaligned mod 4.
>>
>> This Linux kernel commit seems relevant:
>>
>> https://github.com/torvalds/linux/commit/14e256c107304#diff-e85862c72275=
99cb24e36494f75948d5R159-R164
>>
>>    /* From: "Jim Hull" <jim.hull of hp.com>
>>    I've attached a summary of the change, but basically, for PA 2.0, as
>>    long as the ",CO" (coherent operation) completer is specified, then t=
he
>>    16-byte alignment requirement for ldcw and ldcd is relaxed, and inste=
ad
>>    they only require "natural" alignment (4-byte for ldcw, 8-byte for
>>    ldcd). */
>=20
> It isn't completely relevant.  We don't implement hppa 2.0.

Oh... It was late and I misread it as:

   if (PA2)
     ...
   else
     ... "instead of PA 2.0 ... the 16-byte alignment ... is
     relaxed, and insted only require "natural" alignment ..."

   endif

>=20
> I added a TODO comment for HPPA64, as I said in reply to Dave Anglin else=
where
> in this thread.


