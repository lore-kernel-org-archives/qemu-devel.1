Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE9C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F59207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNKw+biG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F59207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iomhE-0004YQ-0W
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:06:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iom1Y-00072z-LM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iom1W-00054m-Tz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:23:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iom1W-00054W-QV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578392622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIL3H1x6ie2zXjouJF8C4YsdjY9w1cjkztIBIuT9QiQ=;
 b=LNKw+biGxidzjW2LQ4AIV1AJG26yBlDMwkeDVonBOchN4EGnS5kHWOtAQo91+8N/ouzu/d
 QUJVORjdiNoJaTT3uBbE0YrdTpq70BbmX574QFo6fae1/SeswqzhZUiLy0uXhT6iHZhIS/
 j3qs6cCeJz242Imdz9p/Ki8LvbUGPZg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-4wIZx8tRNZmkPKEfZNhrAQ-1; Tue, 07 Jan 2020 05:23:41 -0500
Received: by mail-wm1-f70.google.com with SMTP id f25so3910537wmb.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LljreVIzk79cpDkkWo+8lxz0CtNiTwpS9iEy8ZzfD78=;
 b=tHZiQpcVdxNNHsG6gEVESeAEIlmfUiA1q35iomKJBFf6VMSnjsgSsz9SK/cNi3GGkV
 hxfaanIVIIomM2598sl0SnJL9qhLrFq5TZezUcElyWymPLfZ7f6XswCHSOzc4c8fTYAd
 70AvOQyGqS76xjuyObWsd5i4DdzQ7Xq4yB92nt+iuO5nXmnTBTQrRXykcDtoMT14E63b
 3eJ0KgMfzORoKuONeEEV9GdIGQ61daM6S+ymrqHfNZShGRrc9nE3PMxy1CAYHAFTHbDa
 POyA4G32zAEC6JGWqEXnc68CNCRI0EK15LCvfgM0o6V4IicRK+2akzEbppWBR7l07TPG
 caZg==
X-Gm-Message-State: APjAAAWgOGBkc2/cRk327rujGfkfW8B7LB5I+h+v82Y55EvVpJlamnO8
 i3QEttJjTScZMpyOaAl6nqyguN1AhjJJ07W7YgXqGEMqy1i38322zNCD7d0bZxxF3jFXOfw9Qxb
 Qyqfn+d91v8m8hG8=
X-Received: by 2002:adf:df0e:: with SMTP id y14mr40898911wrl.377.1578392619854; 
 Tue, 07 Jan 2020 02:23:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzM+1IrK2wKoSwhwSj0ilpAVDjBe+htU9IxCDImbFTaAvKHAPhNQO15OYSGZ8CxCb3TVTPhVA==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr40898879wrl.377.1578392619575; 
 Tue, 07 Jan 2020 02:23:39 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b15sm25909021wmj.13.2020.01.07.02.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:23:39 -0800 (PST)
Subject: Re: [PATCH 3/3] gitlab-ci-edk2.yml: Use ccache
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-4-philmd@redhat.com>
 <b70f81d0-596d-d867-b722-f9e7aab0e935@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2b92278d-256b-2bf6-c463-22c6447039a1@redhat.com>
Date: Tue, 7 Jan 2020 11:23:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b70f81d0-596d-d867-b722-f9e7aab0e935@redhat.com>
Content-Language: en-US
X-MC-Unique: 4wIZx8tRNZmkPKEfZNhrAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 11:19 AM, Laszlo Ersek wrote:
> On 01/06/20 19:46, Philippe Mathieu-Daud=C3=A9 wrote:
>> By using ccache we reduce the job duration from
>> 40 minutes 26 seconds to 32 minutes 6 seconds.
>>
>>    Running after script...
>>    $ ccache --show-stats
>>    cache hit (direct)                  6604
>>    files in cache                     12090
>>    cache size                         335.5 MB
>>
>> For now downloading this cache takes 16 seconds, archiving
>> it 44 seconds.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   .gitlab-ci-edk2.yml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
>> index abfaf52874..329ba24f20 100644
>> --- a/.gitlab-ci-edk2.yml
>> +++ b/.gitlab-ci-edk2.yml
>> @@ -14,12 +14,19 @@ build-edk2:
>>      - edk2-stdout.log
>>      - edk2-stderr.log
>>    image: ubuntu:16.04 # Use Ubuntu Xenial
>> + variables:
>> +   CCACHE_DIR: ${CI_PROJECT_DIR}/.ccache
>> + cache: # Use the same cache for all EDK2 jobs
>> +   key: ubuntu16.04-edk2-ccache
>> +   paths:
>> +   - ${CCACHE_DIR}
>>    before_script: # Install packages requiered to build EDK2
>>    - apt-get update --quiet --quiet
>>    - DEBIAN_FRONTEND=3Dnoninteractive
>>      apt-get install --assume-yes --no-install-recommends --quiet --quie=
t
>>        build-essential
>>        ca-certificates
>> +     ccache
>>        dos2unix
>>        gcc-aarch64-linux-gnu
>>        gcc-arm-linux-gnueabi
>> @@ -29,9 +36,13 @@ build-edk2:
>>        nasm
>>        python
>>        uuid-dev
>> + - export PATH=3D/usr/lib/ccache:$PATH
>> + - ccache --zero-stats
>>    script: # Clone the required submodules and build EDK2
>>    - git submodule update --init roms/edk2
>>    - git -C roms/edk2 submodule update --init
>>    - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
>>    - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
>>    - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stder=
r.log >&2)
>> + after_script:
>> + - ccache --show-stats
>>
>=20
> I suggest dropping this patch. (In the first place: thank you for making
> this a separate patch!)
>=20
> I'm not a fan of ccache, to be honest. I've seen obscure failures with
> it in the past. Also, the edk2 build system is a complicated beast in
> itself; let's not compose that with another opaque thing. I'm especially
> not fond of caching artifacts between multiple edk2 jobs.
>=20
> For speeding up my builds, I used to use distcc instead; it worked
> better than ccache (using multiple machines in my home). But I abandoned
> even that, after a while.
>=20
> I certainly don't intend to nack this patch -- if others really like
> (and trust) ccache, they are welcome to ack. I'm just not a fan of it.

I understand. I'll still include it in v2, tagged 'RFC' (or NOTFORMERGE)=20
so Thomas can look at it, and it gets saved on the mailing list archive.


