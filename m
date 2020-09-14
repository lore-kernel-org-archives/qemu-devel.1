Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E894C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE21B207BB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8wxNaZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE21B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHm3z-0001uF-SJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHm3G-0001Sv-VJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHm3F-0003TI-3W
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600080576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5FK+hVTr6/aVGaV8DW0NXAjnDRgSGqaaJzDcp6g74c=;
 b=W8wxNaZePx1IALvG9qIn3aHjuLDwa7NDAMINBeWQayEbxJUolW38JZgFrtyxQeWerc4/Jr
 suTodEoNp1J7m9icZLQMfWc0hz8fZKZl/ZluBYZG+Fi8/LmPZ10m046gc/zhgrHotL0EHL
 KCeXFjK8QXucKKbMsOR9IP+BAqliFIQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-feZS3VvRNkGtz7mCZmKvag-1; Mon, 14 Sep 2020 06:49:34 -0400
X-MC-Unique: feZS3VvRNkGtz7mCZmKvag-1
Received: by mail-ej1-f72.google.com with SMTP id b23so7928536ejv.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b5FK+hVTr6/aVGaV8DW0NXAjnDRgSGqaaJzDcp6g74c=;
 b=HMujZ28REJ2mSUns4v8CAEA7FvXsOq8BsLuzjd6RLQrZtKJHsRpV9auYEeVJUrwczO
 absGPaQUEQ2OcVpYGFBNkHd+rgQfy/iCFB5V9cdUw/LneKvVLrLXvkNoFuvVZWHg6ien
 Eqn29CYyhuCYGibUVPNByaYe5tOL7SEffFHGekN+mzjgD2xYM3q5jWu+gHe5APRR+142
 Q9vpYHn3FrjJb6SQKaqRyDeWSU3WtzWoVm3cSZo9Zx9G8f4DljZDKD9OZRIS+NMyWn9m
 yvR3+yH325nbH8uxBX1NEOKfdCKPFC4y4DpW4iv7gAONX4XBpUTzlTKzzirwHd1QWOBk
 +fhQ==
X-Gm-Message-State: AOAM5305JyMUSFaqp6u/nAi2/aPHWuGIK0kEaGNfo/U/ww5sz8QHB2mx
 d0Tgtl8tltDtKayYjNrqFKAFQIq5nIuQe82F4sZcILDVuxRGTaBmy/jHpQIK2/c++xZQYNFWRpH
 GSfoKK99xln0U1Hs=
X-Received: by 2002:a17:906:3e08:: with SMTP id
 k8mr13726849eji.480.1600080573483; 
 Mon, 14 Sep 2020 03:49:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXkVwZfOiGikxcGFiJhz3U3ZufrPcmrgChFR/APdXBXZfDvgt2ZvFPkVnL3imsuJW/m6IbOg==
X-Received: by 2002:a17:906:3e08:: with SMTP id
 k8mr13726830eji.480.1600080573263; 
 Mon, 14 Sep 2020 03:49:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6047:f58e:7d32:2e02?
 ([2001:b07:6468:f312:6047:f58e:7d32:2e02])
 by smtp.gmail.com with ESMTPSA id w11sm9048608edx.81.2020.09.14.03.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 03:49:32 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <20200914091244.GE1252186@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70880397-cd17-ac4b-3f88-6c56e2b71e36@redhat.com>
Date: Mon, 14 Sep 2020 12:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914091244.GE1252186@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/20 11:12, Daniel P. Berrangé wrote:
> IMHO we should stay as far away from Perl as possible, and I say this as
> someone who enjoys writing Perl scripts !  Perl is a significant barrier
> to entry for potential contributors, because it just doesn't have the
> wide knowledge base that it did in the past. You can expect most people
> to have some familiarity with Python, or be able to pick it up fairly
> easily in a way that just isn't possible in Perl.
> 
> As for shell, we have a never ending stream of bugs due to the wide
> range of different shell impls which make portable coding very hard.
> 
> In general I think our overall goal should be to focus on getting down to
> use of a single scripting language in QEMU, and that language clearly has
> to be python3. We shouldn't introduce any new usage of Perl or Shell
> in QEMU IMHO. Even if we think the usage will only be short term temporary
> workaround, short term hacks in QEMU have a habit of living for years longer
> than we expect.

I totally agree.  This would not be a short term workaround, I expect it
to stay for years; I don't expect the transition of the configure script
to Meson to be very short.

This can be both a pro and a con.  On one hand it means this is "more
magic" that is here to stay.  On the other hand it makes transition
patches smaller and easier to review.

I agree that in principle all scripting should be Python.  On the other
hand Perl is quite suitable for "configure tasks that are too
complicated for shell" and are not going to be rewritten in Meson down
the road.  And I say that as someone who has written exactly 3 serious
Perl programs in his life, two of which are part of QEMU. :)

In this case shell scripting could also be a plausible alternative; I
didn't try only because I first tried the obvious choice of Python.

Or we can just decide that an incomplete help below a "please use
--python" error is good enough.

>> Opinions are welcome on whether this is worthwhile and how to solve
>> the above doubts.
> 
> IIUC, the motivation of this series is just to remove some duplication
> of defaults / args, nothing more than that ?

Yes, though it's quite some duplication: right now an option needs

- a default in configure

- command line parsing in configure

- a Meson -D argument in configure

- an help message in configure

- a declaration (including default and help) in meson_options.txt

so this patch reduces an option from 8-9 lines to 2.

There are a couple secondary goals too.  First, making sure all the
policy is in meson_options.txt and not configure; this avoids surprises
when/if we can start invoking meson directly.  Second, removing
variables completely from the configure script gives a better idea of
interdependencies between the configure tests.

Thanks,

Paolo

> I'd say we should focus effort on just converting more of configure
> to meson, as quickly as practical, and not try to add much more magic
> that's only relevant for the transition time.


