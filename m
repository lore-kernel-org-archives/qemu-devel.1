Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6474C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB0524673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjUrPgKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB0524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiPF-00089k-KV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iugak-0003lg-VH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iugaj-0003os-SH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:48:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iugaj-0003oi-Ou
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579801709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=he0bOUoKdJVspjP0ewqETfR4N7KbjzO4CCs4NglZMo4=;
 b=bjUrPgKMjNHepttaHBvt0TK4bKs5pKlmcuVcDc4WVChzVRJvPpyMqDZ4oknXYH7wKpJG/g
 848NLCYz75x/Kviy8u2uARHvNxhseWd+CtnKa+26wgFvwXw4znPbKMpEiAw+2mbZqjCdgR
 fyTwqFAOD1bOgWdoQQyHaedxp5W7XmQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-sWJRYkfqOia5SoABj8TxCA-1; Thu, 23 Jan 2020 12:48:19 -0500
Received: by mail-wm1-f71.google.com with SMTP id p5so1016650wmc.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0TQedrmhIxYAdFh0sbcBzXS6ZGcfli+d/vKhQZ0CrCo=;
 b=e0uUt7o7dizLmbMW6bA/hXwdNK+1f56vAZuw0ej+QlGc3YF3MnZVmOa/L8BQRVPvv2
 WEkydP7iewBP9NX/vFCX1b5Z+esjpa4hpJvQa724fVxcvLxv22ziBYulYnS7JLnDYP72
 /IO8q2lL5RxdgObjXlYPXK25vRIruDEYC297/WDUYC/tTa/L9KIGhPhlSurNGKL3oHPz
 AMbZPnFSSbrVqD++wE48Sos+BPCsQ+cQr2ScDfzxnH/RlmK55LNpt44odMjeapuS/gmH
 /VHWbB7qEIvEcVRQdoJsZOJwo5JYkEqvXjwlHUp4n1kXdaFdA3mbXAshPSGqj1RmEJQv
 Nalw==
X-Gm-Message-State: APjAAAWcOWgpIelbCNqQPOpHbjYwKx8I/9ttFJcw7OT8HgClJzch9Sr9
 L6xaeaUJTGSjpzUV+VHPI8zBucscJO82R7IeCCZm1revZhwhGfABczC0U4MI69JAe3HZ4un7xGv
 zu3BHbnKDxz8xGds=
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr5263676wml.50.1579801697569; 
 Thu, 23 Jan 2020 09:48:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcyRuEXS2UQLUH8J831UoVWlXS1m1pPs9fgMZyRlizEpOnvCj+7bSCJRTvH2lDKz7Vk+2Igw==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr5263665wml.50.1579801697411; 
 Thu, 23 Jan 2020 09:48:17 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a184sm3543398wmf.29.2020.01.23.09.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:48:16 -0800 (PST)
Subject: Re: [PATCH] Makefile: List the sphinx documentation in 'make help'
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200122172137.7282-1-philmd@redhat.com>
 <CAFEAcA_4yGD4Tm5LpN3PXP6S_cbFGdVD8jAcnrm2pEyLNteW0w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <087f4fc3-2a83-fd15-aae8-f7a06dc8759d@redhat.com>
Date: Thu, 23 Jan 2020 18:48:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4yGD4Tm5LpN3PXP6S_cbFGdVD8jAcnrm2pEyLNteW0w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: sWJRYkfqOia5SoABj8TxCA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 12:53 PM, Peter Maydell wrote:
> On Wed, 22 Jan 2020 at 17:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> In commit 5f71eac06e1 we started to support the rST documentation.
>> List the build target we need to call to generate the rST files in
>> the 'make help' output.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 6562b0dc97..b777f7fcdd 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1197,7 +1197,7 @@ endif
>>          @echo  '  vm-help         - Help about targets running tests in=
side VM'
>>          @echo  ''
>>          @echo  'Documentation targets:'
>> -       @echo  '  html info pdf txt'
>> +       @echo  '  html info pdf txt sphinxdocs'
>>          @echo  '                  - Build documentation in specified fo=
rmat'
>>   ifdef CONFIG_GCOV
>>          @echo  '  coverage-report - Create code coverage report'
>=20
> 'sphinxdocs' wasn't intended to be a user-facing target.
> If you do 'make html' this will build the HTML Sphinx
> documentation (as well as any legacy non-Sphinx HTML).

Ah OK! I guess I didn't read enough the documentation then :/


