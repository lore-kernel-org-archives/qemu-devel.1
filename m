Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7C62177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqdRNw6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7C62177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yHh-0001aD-I6
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yH2-00013p-RN
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:02:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3yGz-0007zY-D2
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596790964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8GVp4zsu6d6ieOsWvsDk9XwnicLjeYUWVYrCgp6M7bc=;
 b=KqdRNw6PEYRXJsc2QE55A4f9r5GNbFXjKErE0QxU488FOMMRD2KRGS3L99ouFZaZde8t7t
 FDKEa1AjDGVOl3/Xm//ftPGKoX/AZhtN2cbsOYo1OhVLOa9z8vuSsDDyNgPr057kERyNi3
 0Cbskw3mWQa7oGuZcl8aGgKgfR4Dhac=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-zBnRZMitOUy7IDrcrNg2UA-1; Fri, 07 Aug 2020 05:02:42 -0400
X-MC-Unique: zBnRZMitOUy7IDrcrNg2UA-1
Received: by mail-wm1-f70.google.com with SMTP id a5so527241wmj.5
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8GVp4zsu6d6ieOsWvsDk9XwnicLjeYUWVYrCgp6M7bc=;
 b=UjuRscudtWy81tZmmc9LUbssO2KDuDu8rve95S87vcTANbwEDAlZr6rGA4eUCSJnTh
 OwYZXV7kJ0DVD74LrbXQd4Tu/dsvIR9SY7soMQTdw96MUghzSLjcdGrVclRB5n/abrS8
 BIte/1FnGxr1k53ULW3yY+YnMh8xNEOf/6IcszriZJTLHEuhJrrMHTXZZ6usfpx6nHgE
 0GYOARo2SW4w2qGEV2t/KN4AjqprnZZEmxz1fdzI2vNo4AtRZnCBFumSygB2M90djIn1
 EyvmK+3Upt7AhDb0fsZSOTdpbbC7VIyRA7DxvljBBAY62TF9e43iGXkcgOSiBquPXAX/
 0Wig==
X-Gm-Message-State: AOAM533mJTCzCSgZFkxtNySlY5PcOESm7NKghr/Lg4hFWDtpQzqXkP8W
 UBeD9fkVK/v8yWKMjQ06MlNgaecNriNynuruphW4QuUJI6Ias5gu0HnH6n5u4OWvdsXfFLLOqvO
 kR2MChzWt/McbHuk=
X-Received: by 2002:a5d:4984:: with SMTP id r4mr11009103wrq.401.1596790961330; 
 Fri, 07 Aug 2020 02:02:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybp0am3mQH9Lbaf8TZY1xQHo7uE1oXXZ50nSIfMW0tUF185Di0PL2S8ekTFdL4yjG32ZMpZQ==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr11009086wrq.401.1596790961106; 
 Fri, 07 Aug 2020 02:02:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id o3sm9630294wru.64.2020.08.07.02.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 02:02:40 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc73a810-ee9e-711e-dad0-76a566b923e4@redhat.com>
Date: Fri, 7 Aug 2020 11:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 10:49, Peter Maydell wrote:
>> This the more or less final version of the Meson conversion.  Due to
>> the sheer size of the series you have been CCed only on the cover
>> letter.
>
> Does this work with actually-released versions of Meson yet?
> I am still not very enthusiastic about the prospect of having
> to carry around an entire build system in a submodule. That
> still seems to me to be living closer to the bleeding edge
> than I would like...

Yes it works with 0.55.0, with only a few warnings about possible future
incompatibility.  Those will be fixed in 0.56.0, where the feature was
stabilized without introducing any incompatibility.

Carrying around Meson in a submodule was mostly done to let QEMU build
transparently on older distros.  Removing it is easy (though it would
involve modifying the docker files to install the latest meson, so
whatever you throw out of the door comes back through the window).

Paolo


