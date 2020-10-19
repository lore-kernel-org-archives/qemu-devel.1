Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A1C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920BC21D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjwR9E3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920BC21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUp1-0007HI-GE
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUUlQ-0004LO-55
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUUlN-0001WS-In
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603112383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pOe3Ts3UwSoenBgC1eipa2tHkvmoJYi24ORRDbfttQ=;
 b=YjwR9E3caaOugRCIJtBtY7hnJcebKxqvNWd/07X/Hr+bWzdTanpuXKz+5tuY5N6OJezL9c
 JVC4o8VZa3F0m/etjI2iUZw2Dt0HDqyO10RCtXAZQCfCXobscsGQ+lXhOkkE4rOXZrA49m
 tIFjvGgzQjDs/Gn9nYBWFKqttuIzBtk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-wt-YYIlxOCmTYgRZLiQ9wQ-1; Mon, 19 Oct 2020 08:59:42 -0400
X-MC-Unique: wt-YYIlxOCmTYgRZLiQ9wQ-1
Received: by mail-wm1-f72.google.com with SMTP id u5so4396966wme.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 05:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7pOe3Ts3UwSoenBgC1eipa2tHkvmoJYi24ORRDbfttQ=;
 b=MHGzYICxPfa5Sml63Cz3GPuRu/o3WnKsftCkFGSWQBzgJ1lGHeP4PKhhG2w0/0LLew
 uqk+ImNaH1D1vr0+3T6nAHs8+MDH8xNqfP9FMUw2l3WtYHC9QDGjjevFknIRO0LGfFKn
 BsfTXXlEldza1z4fEgZKEzXxRR8/yGFL4PDqxIJyCFVY1IckirOmE/8T0qVFO2doT+gK
 fX1yR37HFVwhFPtTAXNQtb2ku67T+oG6/1JY+QTCM7twn67+AU2Be3/xkBk5UDucYjvr
 urwlMkZqoD5/prDH22hOqhnGP4wrVAkNw9J9rOz+kEt20YcTMiFv90JPCxjH75qHT7um
 WIvg==
X-Gm-Message-State: AOAM531ZN/vsE/m9pGo7DCAqG1q6sR2z3M2sTOPXOo7BvXdBpH3f+A+H
 wcv83rZgbuN0ycmmiVZiBTCsJI8hIsR5cMrrNAQ4uzjzJaoBcPAIS/WF8cYz+vxDIaCD7tQ6Fvt
 Ql7lGEXahrPC9lHo=
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr20777441wrp.179.1603112381166; 
 Mon, 19 Oct 2020 05:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc+B26woZOEoUXA2PX08s/W0+r3tNjYi6I3rmX9XFrmNguibg3kBfMkvtF3EnvhZD+JIqeGw==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr20777426wrp.179.1603112380939; 
 Mon, 19 Oct 2020 05:59:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id h3sm17764509wrw.78.2020.10.19.05.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 05:59:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] unbreak non-tcg builds
To: Claudio Fontana <cfontana@suse.de>
References: <20201013192123.22632-1-cfontana@suse.de>
 <6dc61a89-6173-099d-c813-cb8266a7d485@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96f02402-fb89-ecc9-aac7-c456c7a2671f@redhat.com>
Date: Mon, 19 Oct 2020 14:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <6dc61a89-6173-099d-c813-cb8266a7d485@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/20 12:11, Claudio Fontana wrote:
> Hi all,
> 
> anything more for me to do here?

I think nothing, I picked up patch 1 due to conflicts but I was waiting
for comments from Richard.  I have now picked them up.

Paolo

> On 10/13/20 9:21 PM, Claudio Fontana wrote:
>> This series now unbreaks current non-tcg builds
>> (!CONFIG_TCG).
>>
>> tests Makefiles need to avoid relying on all non-native
>> archs binaries to be present,
>>
>> bios-tables-test needs to skip tests that are tcg-only,
>>
>> and notably the replay framework needs to consider that
>> it might not be functional (or its code present at all)
>> without TCG.
>>
>> Tested ok target x86_64-softmmu on x86_64 host with:
>>
>> ./configure --enable-tcg --disable-kvm
>> ./configure --enable-kvm --disable-tcg
>> ./configure --enable-tcg --enable-kvm
>>
>> running make check-qtest
>>
>> v3 => v4:
>> * abandon attempts to avoid the code duplication and functional code
>> in stubs, just providing the minimal changes to get things working.
> 
> Paolo, is the latest respin ok for you?
> 
> Thanks,
> 
> Claudio
> 
>>
>> v2 => v3:
>>
>> * do not alter the replay api, provide a block wrapper
>> instead to call into replay events handling
>> or the normal call flow depending on whether replay events are enabled.
>>
>> v1: initial RFC
>>
>> Claudio Fontana (2):
>>   qtest: unbreak non-TCG builds in bios-tables-test
>>   replay: do not build if TCG is not available
>>
>> Paolo Bonzini (1):
>>   tests/Makefile.include: unbreak non-tcg builds
>>
>>  block/meson.build              |  3 +-
>>  migration/savevm.c             | 11 ++--
>>  net/meson.build                |  3 +-
>>  replay/meson.build             |  2 +-
>>  replay/replay-input.c          |  4 +-
>>  stubs/meson.build              |  1 -
>>  stubs/replay-user.c            |  9 ----
>>  stubs/replay.c                 | 98 ++++++++++++++++++++++++++++++++++
>>  tests/Makefile.include         |  2 +-
>>  tests/ptimer-test-stubs.c      |  5 --
>>  tests/qtest/bios-tables-test.c | 10 ++++
>>  tests/qtest/qmp-cmd-test.c     |  3 ++
>>  ui/input.c                     | 12 ++++-
>>  13 files changed, 136 insertions(+), 27 deletions(-)
>>  delete mode 100644 stubs/replay-user.c
>>
> 


