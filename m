Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34204C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED33820727
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWujxmaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED33820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjtc-0005Xy-2i
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 18:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjsf-0004mI-2R
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjse-0000Z3-68
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:04:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27279
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjse-0000YE-2K
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574809463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8F6t+/kcQk8gzHFbzRSd3WkpyFlsNRbvlKO9+13BFo=;
 b=fWujxmaBsqUo6kRU9I6d8cz5ZXEtS2GH0yT6215VSV2DXrZJEfAyDaA/MQ8FizzFpF4CDa
 YfhucFilCVxTfhA9P+abHz2hReTbTFuaBQS/p2wqX390Xyd9KiCFHuIlmGrYIZzQfN8D/t
 LTD5HMspKJtzKUInDmwlaMwWVib0znw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-AVHORO-9MEWB_K0_sZ7JOA-1; Tue, 26 Nov 2019 18:04:21 -0500
Received: by mail-wr1-f72.google.com with SMTP id q12so11283466wrr.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 15:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vm2ebZY7fZXCunZzln3Z08Oe/1vo6ZtidCn9sEnESXA=;
 b=tXsiukm7qEA1RmAVPzwk+4D4OBzW0aBSPzfj0AaY7GBUkpjKK3qFmB9p3weOczrqIK
 baVCVmyzohlOvB2D9K+v3T0yYE/luyvSHPePfCsTTpY3++V4gJcAF5NPPQwXHFz9mdE/
 D/QsTg8GWLsldMSbhXbIdWszEFIzvPdKnFZD8FNOk4bDq3wxQkIEIoG4nm1BGKv1ltG0
 O/egbHT8Z8f82qvIsU3xvbZAdCoeM9VMbwvgIoEYqYJeFgc4u3JexB96jCbusPe7Z0w0
 oVBuUceLr6uDT2VsCngOvO+655GY4a/EnNe1YbVP16lUUn9hjIDMFVylZXOJQjKL0KdT
 EGLQ==
X-Gm-Message-State: APjAAAVRQXcWNgJT99+d65Olij4kyzH/yZh07WVNkfCrGYHWgBja61ru
 Gnk8yaHAR06wPWzOY5jjLSWw0n85Jz0wiGzK+DMtujXJj0cCPQAfiNk6ZzTpSIbV7bAROXAC9vj
 qx9P7wg9bt6Hz8vw=
X-Received: by 2002:a7b:c934:: with SMTP id h20mr1254344wml.56.1574809460956; 
 Tue, 26 Nov 2019 15:04:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqy88g+SoNKT2J8UtTb8uXpaym6W0IWOaRANYRhRDInMc1iw6nWiBCVNgcgqk3nsFpO1gYvenA==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr1254330wml.56.1574809460790; 
 Tue, 26 Nov 2019 15:04:20 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id f67sm4787354wme.16.2019.11.26.15.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:04:20 -0800 (PST)
Subject: Re: [PATCH v36 06/17] target/avr: Add instruction translation -
 Branch Instructions
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-7-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64781d1d-071e-116e-a649-ac62dcf4167e@redhat.com>
Date: Wed, 27 Nov 2019 00:04:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-7-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: AVHORO-9MEWB_K0_sZ7JOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: dovgaluk@ispras.ru, thuth@redhat.com, richard.henderson@linaro.org,
 aleksandar.m.mail@gmail.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/24/19 6:02 AM, Michael Rolnik wrote:
> This includes:
>      - RJMP, IJMP, EIJMP, JMP
>      - RCALL, ICALL, EICALL, CALL
>      - RET, RETI
>      - CPSE, CP, CPC, CPI
>      - SBRC, SBRS, SBIC, SBIS
>      - BRBC, BRBS
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>   target/avr/translate.c | 549 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 546 insertions(+), 3 deletions(-)

Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


