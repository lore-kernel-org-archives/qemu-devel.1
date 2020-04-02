Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F674C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A300206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Me+kLczQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A300206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1OK-0002sW-Cr
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jK1IE-0003oi-Hd
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jK1ID-000696-2B
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:58:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jK1IC-00065e-Md
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:58:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id c7so4577971wrx.5
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=P9HDUl7OoPzL1Nk3VbeuZ1MpdTrUddacu2sKn0iZDPc=;
 b=Me+kLczQiqLTaAwxWWenka3/0ZzIC24ajAxZ+Fc+vPOlEijPJ3qFqQPWLl3yBCc6ma
 Z2Ki/ejBgzId7rLrBx5wQsb+MM8C7QlH/8r8y7gHB8VGiNk4IIwgFc19ED0Sk8W8BcWn
 vTkZ3ajTvskloDoqj3dqGoSbVdK5otk4X4XAUXh+cC7SINQtFw3fhDySRdjPfKy8KbxE
 JeIjVsYcZ/kZPKat/iA0ZSGJPq/nGaqmRgITmqh7VEnGTGrUVLaoJPP50OX9dPstNmfJ
 SWJMrCpIrA30LoCpp0ecH6LS/TiRcj6v6EwkHtNof2X69TxG6BAJh/3H7zNKh9jqRXx2
 D6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=P9HDUl7OoPzL1Nk3VbeuZ1MpdTrUddacu2sKn0iZDPc=;
 b=CK+m0cuKIG5OEJ3FXX6oYcYgpmN5TAKzltvssR4zsGB5rTBlElGKkSDiEb8cXY+bSy
 w64Ww9SyxGFNan/6d7p6ix94U1Hgf1gvzxr2JjDrCV6FYoFczp1gALgwHDELy+JLAkQy
 gUe77u5CmbGTC0wd77V0qdJYbi2RzM5U2KurqCGVliEzvxCqhjP25Ie5a4hMpzJKrqCa
 yWgHatPxtBocrLzlfZSZm/djwLg/yybZgMHIpeUfOwuVBWXbqp91BL7/wuLsgqLBrKG5
 PHCNTdAGcMioUywA/mTtmDauFSJlzijVzuSHpEvnX+GqS7hiX77+QkPRXCTLEidix7kE
 RW3g==
X-Gm-Message-State: AGi0PuZT/evpCJaf6HN2b1DpqyAQ/tt4jI8D9NSGSW6FA7KiYifRcK44
 f9DZ6QZ7WB5MUphfQeYO07owkQ==
X-Google-Smtp-Source: APiQypJu0kEX+XwHB+92YTmzkfb0DD1tZmfKbzWc3u9MGCha3vj/uNcfU9WWn+NwT6ZEr6ZqXsRwvw==
X-Received: by 2002:adf:ea8e:: with SMTP id s14mr3977288wrm.206.1585839482591; 
 Thu, 02 Apr 2020 07:58:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d7sm7660805wrr.77.2020.04.02.07.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 07:58:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62C5E1FF7E;
 Thu,  2 Apr 2020 15:58:00 +0100 (BST)
References: <CABLmASEaKJKzDdvKGv+iWfp=0vdr9bupM76zvLZZ6sZFAPkuRg@mail.gmail.com>
 <6ad7d2d1-658c-04db-4ce0-77c498efbba4@redhat.com>
 <CABLmASEBUzdzu8wt-2YbcntOAfNbsVm7W=W-Uk85ieu1757pMA@mail.gmail.com>
 <87h7y2dnwy.fsf@linaro.org>
 <CABLmASHEhe2gWpXY6zFxdWTJYASst6vCoEabXCRw34aYsO-qwQ@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: qemu-system-ppc 5.0 rc1 crashing on Windows
In-reply-to: <CABLmASHEhe2gWpXY6zFxdWTJYASst6vCoEabXCRw34aYsO-qwQ@mail.gmail.com>
Date: Thu, 02 Apr 2020 15:58:00 +0100
Message-ID: <87eet6djev.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Howard Spoelstra <hsp.cat7@gmail.com> writes:

> On Thu, Apr 2, 2020 at 3:20 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
>>
>> Howard Spoelstra <hsp.cat7@gmail.com> writes:
>>
>> > On Thu, Apr 2, 2020 at 12:47 PM Philippe Mathieu-Daud=C3=A9 <
>> philmd@redhat.com>
>> > wrote:
>> >
>> >> Cc'ing the persons referenced in the commit you referred,
>> >> who happened to be chatting about this issue few hours ago on IRC.
>> >>
>> >>
>> > Thanks, adding --disable-pie to configure solves this issue, but I gue=
ss
>> > the default detection should work ;-)
>>
>> Could you try the following patch:
>>
>>   Subject: [PATCH for-5.0] configure: Add -Werror to PIE probe
>>   Date: Wed,  1 Apr 2020 14:47:56 -0700
>>   Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>
>>
>> which fixed the win mxe cross compile failures.
>>
>>
> Hi,
>
> Thanks for your reply. However, I already did that. Please see the end of
> my original message repeated below.
> I never experienced compilation errors, just a crash when running.
>
>>> > Please note that I tried again after applying patch
>>> > https://patchwork.ozlabs.org/patch/1265368/ However, this has not
>>> solved
>>> > my issue.

Ahh sorry missed that. Is there anyway you get can a back trace?

--=20
Alex Benn=C3=A9e

