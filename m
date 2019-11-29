Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8287C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711962176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJ6fbX3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711962176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeFp-0003sD-Ba
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iadFA-00024F-FQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iadF8-0002eE-EF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:11:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iadF8-0002a9-4q
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575022275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bT7Naek2MFdovtr/nNhC4ejYeS7bQC7PxzdXaVFB78o=;
 b=PJ6fbX3Ji0C0kQ3w25TaVEEX9VyhAHep9R6gMXBrc4oXEbpnuMxlY38Nq4GC3e6xyHIttj
 02xXEbK0UgrANQ9zhkVXFetAyzB2gm8M6pT2UcQFGcNAtZ2evF9DkdsCcnKmIr1KpeqA7c
 3OXpOTrx0nP1hZs533hnAw5u+BAHsEE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-lfJQyQ5SMNWzOtWsidwf4w-1; Fri, 29 Nov 2019 05:11:12 -0500
Received: by mail-wm1-f70.google.com with SMTP id g8so4173083wmg.6
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 02:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bT7Naek2MFdovtr/nNhC4ejYeS7bQC7PxzdXaVFB78o=;
 b=lN/Q/RBpN2/mC47coJWVoX3bRM7MOGtwLXIfgOW7xRSntx/bXQ7t6OXt7x5RQILp8k
 wwa1RF42JRymjcfH8XeY82fgR3Il88Rw4CLrqvi1AaEEvPASZIIetMmifLlbnAorJW8n
 iasgV89MFW3CHOQQwTkkag+OXUjOChs6sms9SFZ3s3vRkfs5odRjkZg8F/Nv/MgEuhKk
 dwbA+danZ6XNLHyouwdd9uy95qIQ9jmzl5gwU2j1t1zjBh20Zvt9YnM/1/u+UGdDe6oO
 J/PTwVmJh0oXmDH7yseyHq6ubMz3NmtP+ijTwL/F0KMO7wScSN96rd9uFu7VWGCUJY/3
 sbiQ==
X-Gm-Message-State: APjAAAWvBOY9B1yIjoJzBPMcKHCnweuq+tELjr4a3qViYikZRKTOH2YT
 WlWTmKVL7Yxhrlmy3l4D8QOKlLVA0l2E9asKjhj9rBvJTWgM8FjLTrDJvyLEIEj51Pvn1+PFsfu
 mJshMJlOczWzry6I=
X-Received: by 2002:a05:600c:2911:: with SMTP id
 i17mr13274479wmd.83.1575022271161; 
 Fri, 29 Nov 2019 02:11:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxuIB4qxJSHi6we38U3XMvtsXcjrJ82ImJ7eSBjPk4u4PSwpitv21aPt5M/+lwa4pNsCVud6Q==
X-Received: by 2002:a05:600c:2911:: with SMTP id
 i17mr13274447wmd.83.1575022270877; 
 Fri, 29 Nov 2019 02:11:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id s9sm12717745wmj.22.2019.11.29.02.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 02:11:10 -0800 (PST)
Subject: Re: [PATCH 2/2] Add -mem-shared option
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191128141518.628245-3-marcandre.lureau@redhat.com>
 <20191128172807.788e6aeb@redhat.com>
 <CAJ+F1CLZxhMf-bOAB4sVfuB1yaUMqiO70-ogpKVS3CqfC7y5KA@mail.gmail.com>
 <20191129110703.2b15c541@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04dadf85-cd35-fd37-9642-8087cba625bd@redhat.com>
Date: Fri, 29 Nov 2019 11:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129110703.2b15c541@redhat.com>
Content-Language: en-US
X-MC-Unique: lfJQyQ5SMNWzOtWsidwf4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 11:07, Igor Mammedov wrote:
>>> So user who wants something non trivial could override default
>>> non-numa behavior with
>>>   -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
>>>   -machine memdev=mem
>>> or use any other backend that suits theirs needs.  
>> That's nice, but not as friendly as a simple -mem-shared.
> (I still do not like idea of convenience options but it won't
> get onto the way much if implemented as "global property" to memdev,
> so I won't object if there is real demand for it)

I agree with Igor, we should always think about the generic ("object
model") options and only then add convenience option.

It looks like the remaining point is to decide between "-m memdev" and
"-machine memdev".

Paolo


