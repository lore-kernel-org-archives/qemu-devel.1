Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E17FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8C62253D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvA9RIaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8C62253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBa4k-0002a2-FA
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBa3a-0001y0-6n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBa3X-0002sj-O6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:16:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBa3W-0002pG-8t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:16:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id x3so171919wmj.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DrscYjyVhDHvVLRLtENT8MLVjp3CGk9Vf65/1fUpJKk=;
 b=MvA9RIaOKKl8UjVhAyBMsGn5OznSxUIGJtm5hLLblmjvdkVFUCaiFdyG5fEqV5cCP/
 AkrSmws7KkyUri70LAHjUaP0fEjje33oUugNi/gU7bc0zjmZ+G/xi5N+3ZBz5Z+uUPJs
 e35OkwxqWPXtDU0T/NSl68iQbYlgNiId5kBHz5tY9mmMe7KAgVCFki/8eu03v6Jb0vUc
 UabOxx1i549abD7f/k2MdZ+y7Q1ucTY3h+MnB7ANlXu6tb7kLku5n2/1LhCQR/sLKtNK
 co20PrT5bsVR+6hEtRCk2LbzEIyXvOAOB/Jjl9f2lHtnt5hVExWROAArlGlJU0WP/7xe
 kRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DrscYjyVhDHvVLRLtENT8MLVjp3CGk9Vf65/1fUpJKk=;
 b=KRrLL//X5B/BDAXuXL51NlqG67a7A1qvpklPAAmkPkftQfE7OBpaEsD9Ci64wGKcDF
 pjoeyReSZiE308AZ2+vC6LIuEOzeWaaI97ZmXETGf6UYcUa4iutPjntYtLJqwMqcS9eG
 558kAEEXgNcCB+cmHfW9xCQ/8VUkjvxKz1TfQ+6ojlSCBp1Abbh9kovy226CTFtZZeC6
 Y6c8jboZlX79WMaIysuaeXMlxnQpqwSmA+np0+q8DZ5T2fhQpqB8rvjR1ZgGRnoS2MCB
 iE/onRfnBIVWvxrrL+2bhk9avDDZt7atFM7o5Dx8d6qqRymEeX4yW4Smnp4bBPdnGisH
 ETfQ==
X-Gm-Message-State: ANhLgQ3Z7Oo945EHtLb9RkSGtiyQycLehW7pruujrXM8GA3d4Km2J2Cz
 qJyiH/JCuSkiQe+/yfoktWofNw==
X-Google-Smtp-Source: ADFU+vs3sI/OuB6+iW3KCZq2vlCn69HqOyp5G1GmYD4JfhtAo24x4L3zVoHiDia/LKH1d7oqRpyfQw==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr848118wmb.154.1583828160623; 
 Tue, 10 Mar 2020 01:16:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r23sm9583357wrr.93.2020.03.10.01.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 01:15:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADDA41FF7E;
 Tue, 10 Mar 2020 08:15:58 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com>
 <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAPan3WqOT1B4xuJeAYUh4Np1UjJuypCDSQVGeV2yyNbH5mBxKw@mail.gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
In-reply-to: <CAPan3WqOT1B4xuJeAYUh4Np1UjJuypCDSQVGeV2yyNbH5mBxKw@mail.gmail.com>
Date: Tue, 10 Mar 2020 08:15:58 +0000
Message-ID: <87pndkiq0x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> Hi Alex,
>
> On Wed, Mar 4, 2020 at 9:55 PM Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
>
>> Hello Alex,
>>
>> On Wed, Mar 4, 2020 at 11:35 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> wrote:
>>
>>>
>>> Niek Linnenbank <nieklinnenbank@gmail.com> writes:
>>>
>>> > The Xunlong Orange Pi PC machine is a functional ARM machine
>>> > based on the Allwinner H3 System-on-Chip. It supports mainline
>>> > Linux, U-Boot, NetBSD and is covered by acceptance tests.
>>> >
>>> > This commit adds a documentation text file with a description
>>> > of the machine and instructions for the user.
>>>
>>> This is great, thanks for taking the time to include documentation.
>>>
>>
>> Sure, I'm happy to contribute it. I tried to include most relevant
>> information
>> in there for developers and potential users of the machine. If something
>> is missing
>> just let me know and I'll make an update for it.
>>
>>
>>>
>>> >
>>> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>>> > ---
>>> >  docs/orangepi.rst | 226
>>> > ++++++++++++++++++++++++++++++++++++++++++++++
>>>
>>> I suspect there is a better place to put this is than the top level. I
>>> wonder if it should be docs/specs?
>>>
>>
>> Yeah I'm fine to move it to a different subdirectory if needed. Right now
>> its placed in docs,
>> as it seems that documents for machines are also placed there, for examp=
le
>> docs/microvm.rst
>>
>>
>>>
>>> >  MAINTAINERS       |   1 +
>>> >  2 files changed, 227 insertions(+)
>>> >  create mode 100644 docs/orangepi.rst
>>> >
>>> > diff --git a/docs/orangepi.rst b/docs/orangepi.rst
>>> > new file mode 100644
>>> > index 0000000000..a9b46f553c
>>> > --- /dev/null
>>> > +++ b/docs/orangepi.rst
>>> > @@ -0,0 +1,226 @@
>>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>> > +Orange Pi PC Machine Type
>>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>>> > +
>>> > +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
>>> > +based embedded computer with mainline support in both U-Boot
>>> > +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
>>> > +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
>>> > +various other I/O.
>>>
>>> When Peter's document PR goes in later this week there will also be a:
>>>
>>>   docs/system/target-arm.rst
>>>
>>> which would benefit from a section for the Orange Pi in it.
>>>
>>
>> Nice, I'll have a look at it when it gets merged and add a section for
>> Orange Pi.
>> I'll try to include that in the next version of this series.
>>
>>
>>>
>>> > +
>>> > +Supported devices
>>> > +-----------------
>>> > +
>>> > +The Orange Pi PC machine supports the following devices:
>>> > +
>>> > + * SMP (Quad Core Cortex A7)
>>> > + * Generic Interrupt Controller configuration
>>> > + * SRAM mappings
>>> > + * SDRAM controller
>>> > + * Real Time Clock
>>> > + * Timer device (re-used from Allwinner A10)
>>> > + * UART
>>> > + * SD/MMC storage controller
>>> > + * EMAC ethernet
>>>
>>> Do we ever exercise the ethernet in the acceptance tests? I see we have
>>> some that boots a full OS but boot console only seems to touch the
>>> serial console.
>>>
>>
>> Good point. Currently in the acceptance tests U-Boot and Linux detect
>> the ethernet device, but there are no explicit checks for that in the
>> acceptance tests
>> nor any actual packet transmission.
>>
>> I'll try to extend the current tests in the next version of this series =
to
>> include some
>> basic checks for the ethernet device, perhaps with DHCP or a ping.
>> I'm open to suggestions for the preferred way to do this.
>>
>
> FYI, I added some coverage for the ethernet device by extending the
> test_arm_orangepi_sd test with a few lines like:
>
> +        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 up', 'eth=
0:
> Link is Up')
> +        exec_command_and_wait_for_pattern(self, 'udhcpc eth0',
> +                                                'udhcpc: lease of
> 10.0.2.15 obtained')
> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
> +            '3 packets transmitted, 3 packets received, 0% packet loss')
>

That will work as a smoke test. Are you going to re-spin this week so we
can get the final reviews done?

> Regards,
> Niek
>
>
>> Regards,
>> Niek
>>
>>
>>
>>
>>
>>
>>>
>>> <snip>
>>>
>>> --
>>> Alex Benn=C3=A9e
>>>
>>
>>
>> --
>> Niek Linnenbank
>>
>>


--=20
Alex Benn=C3=A9e

