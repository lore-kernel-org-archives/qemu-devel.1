Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C134C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E397207F7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvXqmMyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E397207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1xp-0003gh-Df
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO1rk-00047p-IB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kO1rh-00080L-IA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601571332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZfPS9Tm833Dn4xc7RxiWS4OoueOXZG61kBV2z6Nu5Y=;
 b=TvXqmMyd8wlGbE88RpaeJBKM0+hPGrLC9tHlnzSPUDtWdbcuTONsUDZ+3eSp/4UBujEtZS
 7zrTUIa8QIJTV483N+tRJRIYLz6OIebImpoQcIU+vR7W7ahv68JSW/y8fbvzQGSGk2xYjZ
 EqwVACFoB+q6gFt8gamweGR3lQLKWnA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-XWPSBa4lMmertUo4TTKcYw-1; Thu, 01 Oct 2020 12:55:28 -0400
X-MC-Unique: XWPSBa4lMmertUo4TTKcYw-1
Received: by mail-wr1-f72.google.com with SMTP id a10so2256812wrw.22
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PZfPS9Tm833Dn4xc7RxiWS4OoueOXZG61kBV2z6Nu5Y=;
 b=APeQOEcgdCDhnCOj8BgmUvzXvWejvOFl3TH2F9ALSvb1h5tzWdFyvVob6R60zw7QX6
 DKaXoiOam+pEWOEi0NJCTRhh7Hw6OP/9XyHeCtAYP0fMP32m/9ALyx81somIClCIKCAW
 VkyufwuRiD1xRD/tzlZqXclO01go0eypg/Vz0xFotbppxlJO1CyERqrahbj2FmHokWac
 6IGgXi/5LjFHj3FmdUeu1limI9+eZrKUm3mCLLEj50WI6JJbKBIfrK8MULwZETEv4Z8y
 rXwurfA7Mm8SdA9W5aZyhz/ISvNWYsUrKRvfvvrpJMbW2BY1yTqVUpCQR1Qtv8n/4a3L
 sL7A==
X-Gm-Message-State: AOAM5335zNrye7fMLHR+bI7PWPKU88eicyW0uZM9u7BpqHDAAYc5Kziw
 bP73XNsq+89aC3CPDoRQr4V9PngdWuJdXCttSNEYpRPQJH6PU5llEAkW8jqzx+Mz7ZWkFjczY87
 qCVKxMrLqp5CpBzY=
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr979181wmb.138.1601571326902; 
 Thu, 01 Oct 2020 09:55:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDs6FgB3/sWa/2Sq7odn2iSi2IpxnNKuvdTAnz1UQ+m8rQXGxVDr+LP+fADeODvODhAqiArA==
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr979156wmb.138.1601571326563; 
 Thu, 01 Oct 2020 09:55:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:86de:492a:fae3:16f2?
 ([2001:b07:6468:f312:86de:492a:fae3:16f2])
 by smtp.gmail.com with ESMTPSA id i14sm10761039wro.96.2020.10.01.09.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:55:25 -0700 (PDT)
Subject: Re: [PULL 29/86] meson: move libudev test
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <20200930195850.278104-2-pbonzini@redhat.com>
 <CAFEAcA98nJiysUkGEUaq4OMJ815pQRTKz4TWxZFHqzzNX2r2uw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5eba8be2-0076-025a-2e21-281427b69d23@redhat.com>
Date: Thu, 1 Oct 2020 18:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98nJiysUkGEUaq4OMJ815pQRTKz4TWxZFHqzzNX2r2uw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/20 18:19, Peter Maydell wrote:
> Hi; this commit seems to have broken my static build.
> Previously configure did not include libudev in the link
> for a static build (there is no libudev.a, at least on my
> system). Now it does, and then the link fails with
>   /usr/bin/ld: cannot find -ludev
> 
>>  ##########################################
>> -# Do we have libudev
>> -if test "$libudev" != "no" ; then
>> -  if $pkg_config libudev && test "$static" != "yes"; then
>> -    libudev="yes"
>> -    libudev_libs=$($pkg_config --libs libudev)
>> -  else
>> -    libudev="no"
>> -  fi
>> -fi
>
> This is the old code, which doesn't enable libudev for
> static builds. [...]
> I'm not very confident about reading meson.build logic, but it
> looks like this trusts meson/pkg-config to tell it about
> whether it can do a static link against this library,
> which doesn't work on my system, at least. (Ubuntu 18.04.4).

Yes, and the same was of course true of pkg-config without meson.  You
probably got the same warning that you reported on v7.

In fact, my guess is that the "test $static != yes" was added in reply
to a similar complaint; the commit that introduced it has a note that
the test was added by the maintainer:

    commit 3efac6ebb88e4d099f07fef65178ebaa595ae770
    Author: Tomáš Golembiovský <tgolembi@redhat.com>
    Date:   Tue Oct 23 13:23:10 2018 +0200

    configure: add test for libudev

    Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
    Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
    *make libudev optional to avoid breaking existing build/test
    environments
    *disable libudev for --static builds
    Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

But I don't think --static should affect the build this way, especially
since libudev was the only library that had this test in the configure
script (checked in 5.1).  Debian doesn't package "libgtk-3.a" either and
yet GTK+ it is not special cased in the configure script, so I'm not
sure what it is that makes libudev special.

Do you actually build just with "--static"?  Or do you have a list of
"--disable" options so you can add one more?

Paolo


