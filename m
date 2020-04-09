Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297ABC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9797206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OidQLt8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9797206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbFi-0002f0-4K
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMbEV-0001PE-Dj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMbEU-0000Dd-6j
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:44:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMbEU-0000DC-0u
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+SVBpZZX6qSaobC3qxS9jrZp76zQXKynlHCJk51VBw=;
 b=OidQLt8z5X/aiBnTKBm9f5+X1INJghbi2QSWiMsprHMXrE+KV7VYEJFJY19ngV6kKeTZce
 CAVsW1pvlRMeOdIcMt79oxuz8ThhNqOZNJCN53+CJUqqnKquNh/+Juq1K7UO0ny5x7jmLG
 EARQlNApBrBZIKfohmuCeMaF1l0H1QY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-IekFBgavMuKrcgo0hkTdWw-1; Thu, 09 Apr 2020 13:44:50 -0400
X-MC-Unique: IekFBgavMuKrcgo0hkTdWw-1
Received: by mail-ed1-f70.google.com with SMTP id b9so653844edj.10
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 10:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UGxR+zh3aYDulyGzTU58xo/KbIZABzGwrDoGOje1ckg=;
 b=dj5CKWlVyH6lrvQ9R0SJBwmKD2nMaOLuR8J+29hRp3oI+N+mx41aDRSMTmgLoSTWOD
 zbguGM8LmgRjWVpB/pz4HsfnhdZKE/i9UkNqLMkuiinEv25/4iYOZVwsMD3599071mSc
 r5yt4wuMgybN0gVdX8kWgVYIIR9nUO5Hv7dQaFFcoe7CIMACSbY+mKD1huDSdMNCIEG6
 IU+Zvx63fIWcTlMgJugJJ4/itKNusKXN+6yYDzSgGVjCR2LYNM55dbDyYLZOxjQy4ww9
 5+cna2fOKQsL/t1A6X+uCnhbc84arcMyqRzgn/d34dmOAE/Urh7B1Vg9xuK+m66XqZMN
 FbQg==
X-Gm-Message-State: AGi0PubK+SVWcXHU8jWgyh4Aj3VkzmFwZBCyojVJjBPE1cGNhDsjg2aU
 QROCJIVf/Eeym1pJzVvuETfYlzbpz74R43I/XUchzJuaFxT44HesnFdDJDhvtYfZiklg8EaWkS5
 bmTRBSZccZ/Jst+U=
X-Received: by 2002:a50:fe8f:: with SMTP id d15mr1247515edt.64.1586454288773; 
 Thu, 09 Apr 2020 10:44:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL6EzY/lItyq1N8krj8Q7frXgACLPTqEYu6GMGc89whQXUYODAWpj3XBL9GpfyvE4fi/OWJaA==
X-Received: by 2002:a50:fe8f:: with SMTP id d15mr1247494edt.64.1586454288434; 
 Thu, 09 Apr 2020 10:44:48 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j6sm1205562ejs.88.2020.04.09.10.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 10:44:47 -0700 (PDT)
Subject: Re: [PATCH RESEND 3/3] .travis.yml: Test building with Xcode 11.3
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200218142018.7224-1-philmd@redhat.com>
 <20200218142018.7224-4-philmd@redhat.com> <874kvezw8h.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41c6101f-8334-b3de-8ba2-2d5808ec4e18@redhat.com>
Date: Thu, 9 Apr 2020 19:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874kvezw8h.fsf@linaro.org>
Content-Language: en-US
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 1:29 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> We currently run a CI job on macOS Mojave with Xcode 10.
>>
>> QEMU policy is to support the two last major OS releases.
>> Add a job building on macOS Catalina, which comes with Xcode 11.
>>
>> Split the target list in two, as we don't need to cover twice the
>> same targets.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   .travis.yml | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index a2a7fd0dd1..d02a477623 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -269,9 +269,10 @@ matrix:
>>  =20
>>       # MacOSX builds - cirrus.yml also tests some MacOS builds includin=
g latest Xcode
>>  =20
>> +    # On macOS Mojave, the SDK comes bundled with Xcode 10.
>>       - name: "OSX Xcode 10.3"
>>         env:
>> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu,x86_64-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/i=
nclude --extra-ldflags=3D-L/usr/local/opt/ncurses/lib"
>> +        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-=
ldflags=3D-L/usr/local/opt/ncurses/lib"
>>         os: osx
>>         osx_image: xcode10.3
>>         compiler: clang
>> @@ -301,6 +302,39 @@ matrix:
>>           - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat confi=
g.log && exit 1; }
>>  =20
>>  =20
>> +    # On macOS Catalina, the SDK comes bundled with Xcode 11.
>> +    - name: "OSX Xcode 11.3"
>> +      env:
>> +        - CONFIG=3D"--target-list=3Darm-softmmu,ppc64-softmmu,x86_64-so=
ftmmu --extra-cflags=3D-I/usr/local/opt/ncurses/include --extra-ldflags=3D-=
L/usr/local/opt/ncurses/lib"
>> +      os: osx
>> +      osx_image: xcode11.3
>=20
> Are we duplicating what the latest Xcode on Cirrus is here?

Maybe, I'm not sure. It seems only few people care about=20
Cirrus/Shippable but they are not taken seriously by the community, as=20
they are often broken and nobody is notified. Currently Travis has a=20
broader audience.

Also I sent a series to fix various things that break on Cirrus from=20
time to time but I felt there is not many interest so I stopped spending=20
energy on it:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html

We could change that by refusing to merge pullreq that break such CI.


