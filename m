Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B39206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mV8iT+pN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B39206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2Us-00015Q-R4
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic2Tv-0000Sy-V6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic2Tu-0006uG-FL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:20:23 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40973)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic2Tu-0006qY-00
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:20:22 -0500
Received: by mail-wr1-x441.google.com with SMTP id b18so2268650wrj.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=q0Vsd1zf62gZ0k3iovKkNu3Vf/WpD4q1dfFJQMmRDJ0=;
 b=mV8iT+pN85J6w7UA1kx80Pinz2mW4B7uF6VlYcN6D4eof1sSB6+HWJR/lRmZ5WawRs
 Fzr1NKcNE5id8VfTOilBKsWzT20N2r7g2MYRuIHPpqHa06raxw2Xk+hf3nVaNsC97izF
 Mf3NpHvEcjbGq5gUto2yw+2RVY2hGGj2YTKvckSIohzchK5JmOxEJPDPUHcA5bVEA/kn
 qqhfWkTWWZ8WmFC8KAi2edaGe5Ix1yci6QGpgeNdmy2QZTOAVWVwBr3tR3v+n+j8jCvR
 sM/nfscc5op3R3l3oTxVg3FFeX5TMJKlFK+MnYl+h0U+HHE4FT7dShwYHRg1w0QH23R3
 vYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=q0Vsd1zf62gZ0k3iovKkNu3Vf/WpD4q1dfFJQMmRDJ0=;
 b=NYzATkqHSMkmVZJvySya6PjC7ZJGRYJcbJxfmNNUfTtycFklpR+E2EUwsySqtE8X+7
 sMdpFviPFSqiq1XR9SDh89reVgppzecSMXrBVV6dm9WB4rtR9imk5Ro4b1ABBnTaR0lr
 8J8HAcaUGTtW1jIPy+L/IMiHBiaLJ8+mNJkO7aJXT9cHBx9RTLgszM7vs9pvhn1MwGzl
 vIy6EM6IM06ZgBj4B2PuAF0t7XI6tNimR/UEb1GFajBU/qXqkM6h0t44RavBXcz8SpT+
 gmqtDlExc2EAGQIHqzgHDs/JRqhTBNarE/JKrAI95OMwmXHrfaN7KTsreIHFO8a8HBRB
 6xdw==
X-Gm-Message-State: APjAAAXoc9hpTvcWqdfZXEuUV+u8bWKCCXsqmvOlMwGrt513xZfhKigi
 A0z1ScCxodfMLD9AkKnsDvjIiA==
X-Google-Smtp-Source: APXvYqzwSZprvw737+b0DTaYxXdROlHBL45cE+UbzwB+NPbz5ZDs2IqeSS0YfAFD8Oxws1r+AXK2LQ==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr3476589wri.378.1575357618156; 
 Mon, 02 Dec 2019 23:20:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm2341622wrt.82.2019.12.02.23.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 23:20:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E034C1FF87;
 Tue,  3 Dec 2019 07:20:15 +0000 (GMT)
References: <20191129150801.26654-1-pbonzini@redhat.com>
 <20191202114958.606de16f@bahia.w3ibm.bluemix.net>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] docker: remove libcap development packages
In-reply-to: <20191202114958.606de16f@bahia.w3ibm.bluemix.net>
Date: Tue, 03 Dec 2019 07:20:15 +0000
Message-ID: <87blsp6fkg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Greg Kurz <groug@kaod.org> writes:

> On Fri, 29 Nov 2019 16:08:01 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> Libcap was dropped from virtio-9p, so remove it from the dockerfiles as =
well.
>>=20
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>
> Similarly to what was discussed in these threads:
>
> 20191129111632.22840-2-pbonzini@redhat.com
>
> 20191129142126.32967-1-dgilbert@redhat.com
>
> I'm ok to take this one in my tree as well if I get an ack from Alex
> or Fam.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>>  tests/docker/dockerfiles/fedora.docker     | 1 -
>>  tests/docker/dockerfiles/ubuntu.docker     | 1 -
>>  tests/docker/dockerfiles/ubuntu1804.docker | 1 -
>>  3 files changed, 3 deletions(-)
>>=20
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docke=
rfiles/fedora.docker
>> index 4ddc7dd112..47732fc5d5 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -25,7 +25,6 @@ ENV PACKAGES \
>>      libasan \
>>      libattr-devel \
>>      libblockdev-mpath-devel \
>> -    libcap-devel \
>>      libcap-ng-devel \
>>      libcurl-devel \
>>      libfdt-devel \
>> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docke=
rfiles/ubuntu.docker
>> index f486492224..ecea155646 100644
>> --- a/tests/docker/dockerfiles/ubuntu.docker
>> +++ b/tests/docker/dockerfiles/ubuntu.docker
>> @@ -23,7 +23,6 @@ ENV PACKAGES flex bison \
>>      libbrlapi-dev \
>>      libbz2-dev \
>>      libcacard-dev \
>> -    libcap-dev \
>>      libcap-ng-dev \
>>      libcurl4-gnutls-dev \
>>      libdrm-dev \
>> diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/d=
ockerfiles/ubuntu1804.docker
>> index 3cc4f492c4..32a607471a 100644
>> --- a/tests/docker/dockerfiles/ubuntu1804.docker
>> +++ b/tests/docker/dockerfiles/ubuntu1804.docker
>> @@ -12,7 +12,6 @@ ENV PACKAGES flex bison \
>>      libbrlapi-dev \
>>      libbz2-dev \
>>      libcacard-dev \
>> -    libcap-dev \
>>      libcap-ng-dev \
>>      libcurl4-gnutls-dev \
>>      libdrm-dev \


--=20
Alex Benn=C3=A9e

