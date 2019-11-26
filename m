Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0045C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B78206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 23:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgbG7v03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B78206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjvo-0007OQ-MQ
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 18:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZjus-0006XC-Qn
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZjuo-0001wd-Uk
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:06:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZjuo-0001wO-Qz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 18:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574809598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYUfJmk3G6kIXhSUtE6jjvfxW4qxAFx8n5VD/8T664g=;
 b=DgbG7v03QjZSJJF0owgxdhMfxCy8qLDPinApDL6XDWya9bgl9xjFUb32nS834PThJ6ALRJ
 r92VYcowTe/OjS1wTXjvaLOdxIqBDMuZ2JvxrcFGdOuYoY2I1jZQxmlrFxG5A36oBVXDIn
 CjSLPNDOSsjILnYNso/ZDNDZyEgI1Ww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-1E0tzhYwMrqdSxjEOMXttA-1; Tue, 26 Nov 2019 18:06:35 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so7888850wrq.6
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 15:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5GhZoERYqP0uOsB8KMwCsM/Z8qKI+FPh2xnEx1fPLiM=;
 b=oYjIgdxdu7llDSTS7UHyK6+KDGoYnXUQiEIYO82R9UMrVRcXEQQND4Q5iKMmT1rT4r
 4jxQFiN7iHRUXyPhCIiqvBCuozx7qW/CQug3ngeIvEMVnLvqGpwRjfnVBqA6bkxzBCma
 s4ph8NzFKq+p2Qsx23x2/tq2fiKj0gLQU7i/FPSz1SnxNaYLqzdmakwTKRjZ5cS9MMRw
 pjBMkPpQ+ilZRWioBQHZfky/XIM1L/1ZV9fQaL3oiAtSQz+kwZu3+K8jQrqmr4pRq1da
 CAxjx09Akl9vlaFn6e6PEVta7RTyg5Q5kDpIwxSod96v/eq8PZ3igMk2MX3PSXN1o39p
 EHyw==
X-Gm-Message-State: APjAAAWUG+jBrWg9R8wfOEZf7Qlvc92gu2OwErVcnRRqAxGps033wtix
 ac91XM4kuxQrfDjV5xUAhGz/t0A6ZXPXafydr80O4y5SrwmZ1Rngr3Mk/ji0Lr4pegEk+yVM9we
 cYv9ukQansab+RCM=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr18128270wrn.214.1574809592329; 
 Tue, 26 Nov 2019 15:06:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyihr7tVuo0Kdmjk5GykhDtYR41fJP/q0elapvfR7v89TVV05lvVJng0B6rtW+ydLSdasqHjg==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr18128257wrn.214.1574809592172; 
 Tue, 26 Nov 2019 15:06:32 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id p25sm4510599wma.20.2019.11.26.15.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2019 15:06:31 -0800 (PST)
Subject: Re: [PATCH v36 04/17] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-5-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <19ef7027-f24a-683a-863a-114dbd20f326@redhat.com>
Date: Wed, 27 Nov 2019 00:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191124050225.30351-5-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: 1E0tzhYwMrqdSxjEOMXttA-1
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
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>   target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 132 insertions(+)
>   create mode 100644 target/avr/translate.c

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


