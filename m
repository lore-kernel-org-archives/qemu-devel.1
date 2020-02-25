Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12067C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D534A2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAg924yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D534A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eKr-0004g0-2g
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6eK6-0004Fs-5W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6eK4-0005To-UI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:48:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6eK4-0005Sk-Pl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582652924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pPjWmYzLYCso+OFix1AYUOs0c309lNtl6nH+Q80DWYY=;
 b=GAg924yfiucsofgGWQuFW2CGIUneYcIIM1ZWsyihiuzzcQS0dYUOIwvEEVUDuzdHChuewm
 cPq6HhVKDWvL9L/glOWCGKlVGq9ZIdOfEm+WzvHx93dbTj5SC0t3yaYDFgjoTaiQmXV3xA
 xLXVvWLuKuYLzgYP9gY65rBq3u6E2uw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-bgyQ_A3pPHycC55QrpK-uQ-1; Tue, 25 Feb 2020 12:48:42 -0500
X-MC-Unique: bgyQ_A3pPHycC55QrpK-uQ-1
Received: by mail-wr1-f70.google.com with SMTP id m15so116874wrs.22
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pPjWmYzLYCso+OFix1AYUOs0c309lNtl6nH+Q80DWYY=;
 b=cpDDuooyBvP9HqxqoOZUy5Mbn8KXH+hRe9vWYMy8+f3N1RP3oUyOM2s24Cyd6nJBde
 HfWf1Z2TIsxjP4Xg1E67rC9MTTvaixJ3mrU50AWId1xcHSNf4UtXxtKIda6qJgiQ5V1V
 YJMjea8ePqtGw6reiZzJTxXDQvsKN2DDOHbswad0f7xWd8xTBDe8/8ZL7uvih5PPqh5T
 QxyzMNLBJvJioYw26HWo/bkt+/YCa1tNEb7zY3adjiU7YPsFtj7KyQWB38gyCLL71dB7
 amRxjtJ3r6Extwmya1+n1i0KKCQpwdpSONZVZjVv5NeJlpplL6WvyG6iKJybi+zwZ3yr
 OOFA==
X-Gm-Message-State: APjAAAUcv4r63Q3nEQMW0Q6lI9FuBuLN06aZI1xvsQUxmSrbodtTIPf9
 6Jb+QsiXWri8z8y15pzkmYPcGamJrqds6mQhFzeo/BMdO7/71f2POWcUa9GHVVOLcHBZmVG9RBE
 MlK/g90PHMT5U3z0=
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr362613wmf.189.1582652921156;
 Tue, 25 Feb 2020 09:48:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSrTDpEePYlpD5sRLy5WoNXG3G6t2sKxg7KcMnD/YBqEbwAnq+Bmdwbz4AAxAJuXnzB5kOcw==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr362590wmf.189.1582652920873;
 Tue, 25 Feb 2020 09:48:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6?
 ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
 by smtp.gmail.com with ESMTPSA id h205sm5254794wmf.25.2020.02.25.09.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 09:48:40 -0800 (PST)
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
Date: Tue, 25 Feb 2020 18:48:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/02/20 18:11, Peter Maydell wrote:
>> I assume these are not meant to be applied now, except patch 2?
> No, I intended them to be reviewable and applied now. Why
> do you think we should wait?

Because they remove information from qemu-doc.texi.  I think it's
feasible to do a mass conversion quite soon, within a single pull
request, the only important part that is missing is the hxtool conversion.

(See also the patches I posted today, which take the opposite direction
of making qemu-doc.texi's structure more like what we'll have in the end
in docs/system).

Paolo


