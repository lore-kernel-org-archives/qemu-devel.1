Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151D420708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA5G/Ctk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151D420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Wid-0001km-8h
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Whx-00015p-Gb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Whw-000148-Es
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:40:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48388
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Whw-00013t-BN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581432012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcFr0cnrHTTAW4AH1D/MKWrrR3+FcPd/pBf9B7yu9j4=;
 b=VA5G/CtkyOYzfiXyxNsssqSaTQV8S3StyFvDA5xjL/gFXg/kAx6IUBSL6mGUqgjpNMD5k8
 EVBXTmNJ+RR/kVqcL2WVKFLGrtFdZitB7ABJHoxNnZG0qVdj7OhYHWrAoOYqm5YyU3py2y
 HdL9Kg1+6FybaFNlc/lh/uaySCZAOMs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-RtkcCOzUNqSmF_M1wA2eqQ-1; Tue, 11 Feb 2020 09:40:10 -0500
Received: by mail-wm1-f70.google.com with SMTP id b133so1189010wmb.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 06:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w8YDB+nFDe6ADUNWgnur2rvXmvOWjWGVkhRTlCgwGvI=;
 b=XYChjPxKbz4bGkAjpt652K0D0EygMbXByRJLL+etWMK8pJFtmvcQr+Piwx63uJqzuh
 ydZjVEM0qDRKE9e5ZhZLfXeNVtjusDJBDhhfM8fb8JAkAuY3CjQR6MZxXZ16XKgH4A6C
 gkrubFNHvOqIJWmVvimlS6VEK4emtaycVqNgtZgCJf3R1LXdW7zOx22k1s49Z6iqMZTi
 hE2uvU1DrUkbIUULIe01eVrfd8mWKJBU0CqgLaUJzwq0elDBazU1BDOwT6K2Q6tH4eyI
 zZwVtJavMkTnGp5L5BYhQDDyQfnMrLY3TytUOz/I2gR41+GWbqBS615UpRgjqlr+3Zda
 gL7w==
X-Gm-Message-State: APjAAAXmDCBe8MeTXMPybEetYoo61cEvAplBLj6Zu6katB/7op6XnNqv
 nVQDXPXD/elmUEVtqRdlMRHymRkFRo57MiK50M7oWPGfs7MXcHMQ4SelRhO7HdcPU+1hyWTZ31F
 VwBwT8unzfwOskTw=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6213639wmi.51.1581432009265;
 Tue, 11 Feb 2020 06:40:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxaVSJqrFNGII4KM5bpRI7IQ+VHLqzAfopQ244HJx8ONjA86PZUDmr/ZsDqMr7ftrl46gKmDA==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6213618wmi.51.1581432009089;
 Tue, 11 Feb 2020 06:40:09 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id d22sm3939686wmd.39.2020.02.11.06.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 06:40:08 -0800 (PST)
Subject: Re: [RFC PATCH 55/66] Hexagon HVX import instruction encodings
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-56-git-send-email-tsimpson@quicinc.com>
 <fd38e134-8314-f206-9a04-0e41119105f6@redhat.com>
 <BYAPR02MB48865F7264F3F5B2D8735385DE180@BYAPR02MB4886.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0541dc03-b3f8-8612-9921-e1df9546ce87@redhat.com>
Date: Tue, 11 Feb 2020 15:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48865F7264F3F5B2D8735385DE180@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: RtkcCOzUNqSmF_M1wA2eqQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 3:35 PM, Taylor Simpson wrote:
> Hi Philippe,
>=20
> Thanks for all your feedback.  I' get your comments addressed soon.
>=20
> I'm sorry you had trouble applying this patch.

No problem.

> The target/hexagon/imported/encode.def should have been created by patch =
17.  Did you apply that one?

Ah, I haven't received patch #17, and can't find it on the list.

>=20
> Taylor
>=20
>=20
>=20
>> -----Original Message-----
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Sent: Tuesday, February 11, 2020 1:02 AM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; laurent@vivier.eu; riku.voipio@iki.fi;
>> aleksandar.m.mail@gmail.com
>> Subject: Re: [RFC PATCH 55/66] Hexagon HVX import instruction encodings
>>
>>> +#define EXTNAME mmvec
>>> +#include "mmvec/encode_ext.def"
>>> +#undef EXTNAME
>>> diff --git a/target/hexagon/imported/encode.def
>> b/target/hexagon/imported/encode.def
>>> index 33c3396..d1b3510 100644
>>> --- a/target/hexagon/imported/encode.def
>>> +++ b/target/hexagon/imported/encode.def
>>> @@ -71,6 +71,7 @@
>>>
>>>    #include "encode_pp.def"
>>>    #include "encode_subinsn.def"
>>> +#include "allextenc.def"
>>>
>>>    #ifdef __SELF_DEF_FIELD32
>>>    #undef __SELF_DEF_FIELD32
>>
>> I had a problem applying this one:
>>
>> Applying: Hexagon HVX import instruction encodings
>> error: target/hexagon/imported/encode.def: does not exist in index
>> Patch failed at 0054 Hexagon HVX import instruction encodings
>> hint: Use 'git am --show-current-patch' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>>
>> Resolved by doing:
>>
>> (review/hexagon|AM 54/65)$ touch target/hexagon/imported/encode.def
>> (review/hexagon|AM 54/65)$ git add target/hexagon/imported/encode.def
>> (review/hexagon|AM 54/65)$ git am --continue
>> Applying: Hexagon HVX import instruction encodings
>> Applying: Hexagon HVX import semantics
>> ...
>=20


