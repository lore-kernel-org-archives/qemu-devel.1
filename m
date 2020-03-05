Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AED1C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255892073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUgj6tx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255892073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nmr-0005tu-A3
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9nle-0004KM-FR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9nlZ-00021o-GQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:30:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49085
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9nlZ-00021U-Cw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583404209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZBh0kTNzW9ctEazEIZPnqTdx42MYCMea6WgfBDdMDH0=;
 b=AUgj6tx71Gf5Q5T7XNgn8PUS19sswIHu8+wVf1NI29XDIvZUVD04EONS95VGoW6HMFhQwW
 cCYLpS/dgiH77fG8JFWgkrGtSO8ZCYr8mzfK/45H6V28inzaOVGwj8XOdUtcCWPJw9tk6S
 jzKUDt/UkCplm1BnVeUJcPeLaDS1Fd4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-41ol0KhSPAizRVKglDedyw-1; Thu, 05 Mar 2020 05:30:05 -0500
X-MC-Unique: 41ol0KhSPAizRVKglDedyw-1
Received: by mail-ed1-f69.google.com with SMTP id y23so4048258edt.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 02:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KUe/CqwkpeS7oHd3ZruuLfaGykjCKJwjuv1ZK/ukBlk=;
 b=Bd4T9tHdtR44GfMT3SThUFJX7Ngi+XJoCcYhzSluUE/voaOhulqeY4iCNavfraiLCk
 ZN5gKMKYDLMTcLdGRfeytXYSAvz+omtjug+qulMHSNV/FcgRtYJkEEuIHTjmwMst2jud
 wAMFuyERKORRXbRjjXWUFGXIm+YCwmtNtmGabypF8xG+NXFXAzcjfijA+U3ZpaZaZJLT
 FmzNtcbd4tR157Y+3siAL1geoBIYtqCNwLOTw3Dm3tNcY3ijSI63Zy9ZXS7QQHmVDf6n
 f2T/2vqD8K3Iq8QjHOK9LcD2FP8wwpSVgxq3t6bI9a+4L9gT0O34i9311gtW6dUI7g7A
 p12A==
X-Gm-Message-State: ANhLgQ1s3BSoBMzDYFmYFejcKavwatFbOdlMFea0qVw6xf2GLaitiyok
 ShMpDdEpPaasqdH751nayWcUw8pRAhFnZH0Kv54eiP4y2XSzj/TZpPzQ+Sw57so5EWV0KmeW3WM
 qjFeQ4bwQQFaq9P8=
X-Received: by 2002:a05:6402:22d2:: with SMTP id
 dm18mr1662609edb.245.1583404204004; 
 Thu, 05 Mar 2020 02:30:04 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsEh7aAyYnE049fB7lu/bMX8g+8g83c3+4LKnZ6Z2ICtqtJhUSHtC/HRN85U3za1bsBxpFXYA==
X-Received: by 2002:a05:6402:22d2:: with SMTP id
 dm18mr1662593edb.245.1583404203835; 
 Thu, 05 Mar 2020 02:30:03 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id br7sm1528196ejb.13.2020.03.05.02.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 02:30:03 -0800 (PST)
Subject: Re: [PATCH] tests/docker: Install tools to cross-debug and build
 Linux kernels
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
References: <20200212202738.12986-1-philmd@redhat.com>
 <4481651f-1c10-ca86-dc57-02aaff7d2a1a@redhat.com>
Message-ID: <030679b1-2fb7-0687-9ac7-f2cfe4ed8b02@redhat.com>
Date: Thu, 5 Mar 2020 11:30:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4481651f-1c10-ca86-dc57-02aaff7d2a1a@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping ping?

On 2/24/20 1:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/12/20 9:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> We often run Linux kernels to test QEMU. We sometimes need
>> to build them manually to use non-default features. We only
>> miss the tiny 'bc' tool.
>>
>> The ncurses library is helpful to run 'make menuconfig'.
>>
>> Finally, gdb-multiarch allow us to debug a TCG guest when its
>> architecture is different than the host.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> =C2=A0 tests/docker/dockerfiles/debian10.docker | 3 +++
>> =C2=A0 tests/docker/dockerfiles/debian9.docker=C2=A0 | 3 +++
>> =C2=A0 2 files changed, 6 insertions(+)
>>
>> diff --git a/tests/docker/dockerfiles/debian10.docker=20
>> b/tests/docker/dockerfiles/debian10.docker
>> index 5de79ae552..2fcdc406e8 100644
>> --- a/tests/docker/dockerfiles/debian10.docker
>> +++ b/tests/docker/dockerfiles/debian10.docker
>> @@ -17,14 +17,17 @@ RUN apt update && \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEBIAN_FRONTEND=3Dnoninteractive apt inst=
all -yy eatmydata && \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEBIAN_FRONTEND=3Dnoninteractive eatmydat=
a \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt install -y --no-install-recommends \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bison \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build-essential \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca-certificates \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clang \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbus \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flex \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb-multiarch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gettext \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libncurses5-dev \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg-config \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psmisc \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python3 \
>> diff --git a/tests/docker/dockerfiles/debian9.docker=20
>> b/tests/docker/dockerfiles/debian9.docker
>> index 8cbd742bb5..92edbbf0f4 100644
>> --- a/tests/docker/dockerfiles/debian9.docker
>> +++ b/tests/docker/dockerfiles/debian9.docker
>> @@ -17,13 +17,16 @@ RUN apt update && \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEBIAN_FRONTEND=3Dnoninteractive apt inst=
all -yy eatmydata && \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEBIAN_FRONTEND=3Dnoninteractive eatmydat=
a \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt install -y --no-install-recommends \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bc \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bison \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build-essential \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca-certificates \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clang \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flex \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb-multiarch \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gettext \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libncurses5-dev \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg-config \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psmisc \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 python3 \
>>
>=20
> ping?


