Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3AC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 11:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C39121655
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 11:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLOi/t4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iicrR-0000ZN-As
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 06:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iicqe-0000AJ-04
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iicqb-0003Xc-Qb
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:23:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iicqb-0003Qb-7E
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576927380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRZIv1iKq33Md29eUccsGHfLfYeRhTWSYZJZ3/DBQns=;
 b=ZLOi/t4ukb07LYP7I2nojIv/HmASkWCMQnnmI8dKCeKzxoGB9MXHGAQtu8/c+kFz+SsXVp
 bnLmKcHAGcXHguQIak8kwWPPDSGEumq9s9DqO9tZ8V5ukga9BThjE+tNkoelIUgr4WXi3q
 MnGaU0QpWDCbngF+g0zO1Rjmufypw7k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-QZFQkbJDN86woefPrKvliQ-1; Sat, 21 Dec 2019 06:22:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so5062978wrm.18
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 03:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L++EXYIEx4ZpMySPKuXmJc2IIIJLkEVYW3Dn1grh5KA=;
 b=VgxL7cRPS913XcyNz6n6kgekV7TchRw6BLetiNCFaklcoLo/84CeIxOrO7U33Mmdy/
 gdVa3jmO7L4nH/frIdphoc3CCXAqDB/ckGJ994KJwck3H8Rw2TjUHrLfWO3YAK8TsHZ3
 6nm7rl/tAwSyCVf2q3MYPxZavZx9JtStpOw03HTP8TXbHulRtNRJbmFtVQOMcrd2zKUD
 C5T+zYhn2aE8NlauKMImkc21lGjBX2yJQCBprTBKnepJnRIuEdrKvdgawpg3exN0B6YC
 eFviyncbSfwy1+6BQqbNSO5Gbbf8p6+v0IB9fixntZMdymSTK0Gue29jZkEu4X4hQvr+
 tHnA==
X-Gm-Message-State: APjAAAU11pyf9bsRvxGC8/NFVGn/zhE8x+Y+0qtdGh8c6AEuuh4bnAk4
 8k6bppcnVzwSsKvkK8EwAzdlkx7Z9CwzcrfswOAr6q67wf7WQS8aJ36s3R+7eU17FEvLSWNWXxj
 RlT1TWYMToICUMDY=
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr20336817wrt.381.1576927376946; 
 Sat, 21 Dec 2019 03:22:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqw+7/kgB3eBcSFPpvnwX31+pAXaETwHP1lPF9rgpi3I1YrP87epktvIEwTqWrryjvy69yIQ/A==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr20336799wrt.381.1576927376760; 
 Sat, 21 Dec 2019 03:22:56 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x11sm12831832wmg.46.2019.12.21.03.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2019 03:22:56 -0800 (PST)
Subject: Re: [PATCH v39 01/22] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-2-mrolnik@gmail.com>
 <CAL1e-=ikJOrT+ZCA+jjN0mj08uoeY7RpFqti=qE4RU+R+ikd2g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5e6bb53e-97ac-c630-c6c3-82cbd9657a79@redhat.com>
Date: Sat, 21 Dec 2019 12:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ikJOrT+ZCA+jjN0mj08uoeY7RpFqti=qE4RU+R+ikd2g@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: QZFQkbJDN86woefPrKvliQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "thuth@redhat.com" <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 12/21/19 11:53 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com=20
> <mailto:mrolnik@gmail.com>> wrote:
>=20
>     This includes:
>     - CPU data structures
>     - object model classes and functions
>     - migration functions
>     - GDB hooks
>=20
>     Co-developed-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
>     <mailto:S.E.Harris@kent.ac.uk>>
>     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>>
>     Acked-by: Igor Mammedov <imammedo@redhat.com
>     <mailto:imammedo@redhat.com>>
>     Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0target/avr/cpu-param.h |=C2=A0 37 +++
>      =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0|=C2=A0 54 ++++
>      =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 258 +++++++++++++=
+++
>      =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 654 +++++++++++++=
++++++++++++++++++++++++++++
>      =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0|=C2=A0 84 ++++++
>      =C2=A0target/avr/machine.c=C2=A0 =C2=A0| 121 ++++++++
>      =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 |=C2=A0 49 +++
>      =C2=A07 files changed, 1257 insertions(+)
>      =C2=A0create mode 100644 target/avr/cpu-param.h
>      =C2=A0create mode 100644 target/avr/cpu-qom.h
>      =C2=A0create mode 100644 target/avr/cpu.h
>      =C2=A0create mode 100644 target/avr/cpu.c
>      =C2=A0create mode 100644 target/avr/gdbstub.c
>      =C2=A0create mode 100644 target/avr/machine.c
>      =C2=A0create mode 100644 gdb-xml/avr-cpu.xml
>=20
[...]
>     +typedef enum AVRFeature {
>     +=C2=A0 =C2=A0 AVR_FEATURE_SRAM,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_PC,
>     +=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_PC,
>     +=C2=A0 =C2=A0 AVR_FEATURE_3_BYTE_PC,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_1_BYTE_SP,
>     +=C2=A0 =C2=A0 AVR_FEATURE_2_BYTE_SP,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_BREAK,
>     +=C2=A0 =C2=A0 AVR_FEATURE_DES,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LA=
T */
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_EIJMP_EICALL,
>     +=C2=A0 =C2=A0 AVR_FEATURE_IJMP_ICALL,
>     +=C2=A0 =C2=A0 AVR_FEATURE_JMP_CALL,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_ADIW_SBIW,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_SPM,
>     +=C2=A0 =C2=A0 AVR_FEATURE_SPMX,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_ELPMX,
>     +=C2=A0 =C2=A0 AVR_FEATURE_ELPM,
>     +=C2=A0 =C2=A0 AVR_FEATURE_LPMX,
>     +=C2=A0 =C2=A0 AVR_FEATURE_LPM,
>     +
>     +=C2=A0 =C2=A0 AVR_FEATURE_MOVW,
>     +=C2=A0 =C2=A0 AVR_FEATURE_MUL,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPD,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPX,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPY,
>     +=C2=A0 =C2=A0 AVR_FEATURE_RAMPZ,
>     +} AVRFeature;
>     +
>=20
>=20
> Very good! Now, each feature should have some really brief (less than=20
> say 45 characters) comment in the same line as the definition, like this=
=20
> one:
>=20
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AVR_FEATURE_MOVW, =C2=A0 =C2=A0 =C2=A0/* sup=
ports MOVW instruction */

IMHO this looks overkill when the name is already obvious. In some cases=20
we can explicit, such 'RMW'.

Maybe we can simply group the features by type with a single comment=20
previous the group, such:

           /* Instructions */
           AVR_FEATURE_MOVW,
           AVR_FEATURE_MUL,
           AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */
           ...

>=20
> You already did it for AVR_FEATURE_RMW
>=20
> Of course, all such comments should be vertically aligned nicely.


