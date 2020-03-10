Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA29C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CB920578
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTphg0SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CB920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgnt-0001LN-Me
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jBgmc-0007s7-RF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jBgmb-000151-PS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:27:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40800
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jBgmb-00013r-LJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583854021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cv/qNWd5Zc/U3js15QhZznlnr3EMJeqvXdPXHmcMGCQ=;
 b=LTphg0SEfF1xXr2J3QopYLN1k3fEGxLOdOT7my9cwe2+IV0VS3nbrhoMOBc6mcAyWYj7it
 3W2pyxdFnqVqJQQY2dSqyNpiRB38yygvoJsLvyS5s7sJbhBGsO7sp2TA+49L1PEutCr/Ku
 ifm9+kcW2nt5itvy2wt2SPXkDsUn3JE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-_YMRzGOmMHWEaOQyRSyODA-1; Tue, 10 Mar 2020 11:26:58 -0400
X-MC-Unique: _YMRzGOmMHWEaOQyRSyODA-1
Received: by mail-wm1-f72.google.com with SMTP id r19so511924wmh.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 08:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cv/qNWd5Zc/U3js15QhZznlnr3EMJeqvXdPXHmcMGCQ=;
 b=XnRsUZ1I1GYseSyg85hsaTgcVV5iwy2ycw1eJZh0NifCPs1PdTp1BrqwgNWdmgT56q
 RCm8GB8lXqZplvhTyqVScUu0sW0+W2ggtg+mU4lx1M2kIFNDKFmb7jMEnTeGEdutQrGu
 pCWFeqaFd6DFzDjoh+coANHJbm3+gYoU7iJZSn7klXw9IwInwkHXDiFgT2ffrKHRqsb/
 oW2h2OTg1gsP7heiDWvCMhJLGsZmHeYfESCuUMX/95wFLpI0ORdl2rUWI40V+fs6NOHV
 xDNhjNnSCjsIsQfey/AXR/x31kBqAyj0GELnh4zcfVufNKniGKg5dAupj8wq6ssJxqQK
 oIWQ==
X-Gm-Message-State: ANhLgQ2PteLaN9INtlmrLBxkYZIz9gEI27RP9rZFg3o50WuCi53X5c2n
 pg6bYWKK2Nb9uhvl/XfK3WD0SfOnfR82yGasL0t6C2Z0zjfasou4y0JJI614BHLLgn3wa8objjq
 a79lFddkWC2nCjoo=
X-Received: by 2002:a1c:568a:: with SMTP id k132mr2657869wmb.2.1583854017470; 
 Tue, 10 Mar 2020 08:26:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtJzMSBAptJ5jmu0v9BQ1UVkEQCfRF4ExQK7sVw91AAIjxNnAtxpGqz4u4nwE9L3HgbQfvFAg==
X-Received: by 2002:a1c:568a:: with SMTP id k132mr2657854wmb.2.1583854017242; 
 Tue, 10 Mar 2020 08:26:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f1b5:9f9:3125:2a5a?
 ([2001:b07:6468:f312:f1b5:9f9:3125:2a5a])
 by smtp.gmail.com with ESMTPSA id f9sm15183120wrc.71.2020.03.10.08.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 08:26:56 -0700 (PDT)
Subject: Re: [PATCH] tests: Disable dbus-vmstate-test
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200310152141.13959-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99854e03-fe9e-e6a9-d9ba-3abf8d9acf98@redhat.com>
Date: Tue, 10 Mar 2020 16:26:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310152141.13959-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 16:21, Peter Maydell wrote:
> 
>   dbus-daemon[9321]: Could not get password database information for UID of current process: User "???" unknown or no memory to allocate password entry
> 
>   **
>   ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>   cleaning up pid 9321
>   ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>   make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
>   make: *** Waiting for unfinished jobs....
> 
> It's not clear why this is happening (perhaps a recently revealed
> race condition or a change in the patchew build environment?).
> 
> For the moment, disable this test so that patchew test runs are
> useful and don't email the list with spurious failure mails.

It has failed forever since it has been committed.  It only happens in
the Ubuntu configuration, and I had disabled it for a long time due to
this failure.  On March 6th I added it back to see if someone had fixed it.

Paolo


