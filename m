Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5517C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487F5207BB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnJOPmxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F5207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnCA-0003m7-6B
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHnB9-0003En-5s
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHnB3-0004wL-2H
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600084902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKnAtIxn+Ws/5rO87OISz2KuHWE1xjc7tXBTXtV2Ucg=;
 b=KnJOPmxSm731bikO7AaQ26KCJdnmM50c0QsML+8P3CfiLKiBBslof0HEtwpDibKG0LcZRm
 9LAsghry1z5SvkPCKPFGvG3TAACji00EPd0o2OQU4YxrkO6UjCyLUlmuzChmJfju1lhdOG
 QiUVEx1ESek+ZyLXGvnANtfKpGIsKH4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-kCOlozmcOwOgDCQy-RYFRw-1; Mon, 14 Sep 2020 08:01:41 -0400
X-MC-Unique: kCOlozmcOwOgDCQy-RYFRw-1
Received: by mail-ej1-f71.google.com with SMTP id m24so7949474ejr.9
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lKnAtIxn+Ws/5rO87OISz2KuHWE1xjc7tXBTXtV2Ucg=;
 b=Fx8ex8i0WoFdyfW/RKW42RMywZ3PwU1n6Shsioqh6G/XaMn3EDr9S1gwtC5bwbWiiC
 LwX5rRMUhsZaMLxTbN4sbJPzUR4FaljEbF8JcySJdgW4RdOosFkOmh55bdnFOjXQnQDN
 d87Dl5jqQCd0vTp4N6IzI/1IiHkKyUXBOpbSKHPcNhWKy+OsQirEE45BSKmWALKhGAQ3
 swEEQmiXDonYJMK6MvKXzpll6h6vaFLXJoT08nv7ENdDaLWVipCZ5Mlwk8xFwjzRl1Ij
 PsWS4ZCdcYxl4/0EJWsaT3vrGZ/WrvS1vsfIKCjHTI2RQHpAKtbokdsKxS+2/EsUHsSu
 IaKQ==
X-Gm-Message-State: AOAM533lV0B1U/shvyJiX4n4cKITSH2QltEWkjMnOoMT6s6jW3aJ+YS0
 iOe71B2MRd37JFi4O9TCu9VggEgo9+qquREf9TIMT2XgvJgq+TVmRoj52CUyZuJ2ipy9IAxJO49
 Y+uym3iyCuwhUJ80=
X-Received: by 2002:a17:906:95cf:: with SMTP id
 n15mr9558275ejy.14.1600084899706; 
 Mon, 14 Sep 2020 05:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2d1I5w736gusZgP/o3FBtSUyg6rtbpuPx39UEpcNt9DVHxHJoKTI51HP0yX8Q6CAUwvRCNA==
X-Received: by 2002:a17:906:95cf:: with SMTP id
 n15mr9558238ejy.14.1600084899377; 
 Mon, 14 Sep 2020 05:01:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d386:a377:dd9c:9b59?
 ([2001:b07:6468:f312:d386:a377:dd9c:9b59])
 by smtp.gmail.com with ESMTPSA id b5sm8840146edq.69.2020.09.14.05.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 05:01:38 -0700 (PDT)
Subject: Re: [PATCH] scripts: display how long each test takes to execute
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200914110948.1425082-1-berrange@redhat.com>
 <fdbb969d-6569-87bc-901a-f51d7bf2cd21@redhat.com>
 <20200914113351.GJ1252186@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ac904ec-5b36-c96a-51f1-3e9af40db68b@redhat.com>
Date: Mon, 14 Sep 2020 14:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914113351.GJ1252186@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/20 13:33, Daniel P. Berrangé wrote:
> On Mon, Sep 14, 2020 at 01:19:20PM +0200, Paolo Bonzini wrote:
>> On 14/09/20 13:09, Daniel P. Berrangé wrote:
>>> I'm unclear if meson's native test runner can print timings. If not,
>>> we might want to submit an RFE there too.
>>
>> I agree that any holes should be filled in there.  In this case it does,
>> so I think we should start using it in CI so that RFEs can be sent there.
>>
>> mtest2make-style output has been in use (and good enough) for years so
>> I'd rather avoid piling up more hacks on top.  "meson test" is not
>> perfect but I'd rather improve it instead.
> 
> When I run "meson test" it doesn't use the results from the previous
> "make", instead it re-compiles the entire codebase using ninja.

Yes, you'd have to add --no-rebuild.

> If we're telling users to continue to use "make" and "make check" though,
> I don't think we should be using "meson test" in the CI systems, as it
> means CI is not testing the same build process as our users, which is
> defeating the point of CI.

We can of course cover both.

> If using "meson compile" and "meson test" already works though, what
> is our current ninja -> make convertor doing for us, besides letting
> people have a facade to pretend nothing has changed ?

Before unit tests were converted, it was needed because unit tests were
built part with Meson and part with Makefile rules.  Now we still need
the Makefile to build submodules.  Richard posted a patch to build
capstone from meson.build; libfdt can have the same treatment and SLIRP
can be converted to a subproject.  With that gone, there's no reason to
keep the ninja2make converter.

Even before that, it's also possible to send the build to Ninja instead
of using ninja2make.  In that case the Makefile would only spawn
recursive builds using either Make or Ninja.  That would also add a
Ninja build dependency, so I haven't proposed it yet (despite having the
patches ready).

To sum up: the hard part is done, but that means that we have to decide
in what order to do the next steps.

Paolo "what are the Romans doing for us?"


