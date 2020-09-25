Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C5C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980CF21741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSseRNT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980CF21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLlyG-0003PB-IT
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 07:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLlwI-0002VM-Lr
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:30:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLlwF-0008Ab-83
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:30:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601033451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKZZrcTTUfCrWEB2p75YHwDXbFiTqANqvHc9qq8r3UY=;
 b=hSseRNT27DTGEwDFEGm6MrkaIH7W3MW56613nwXi3jxyiuSuncnpkaL42ajPsnjr1klOaw
 KSEBjGwNCuhwm8ONaJiix4JIWQgWiFWVPyymWhQ1RnwTVx3rhL6BpCk0XJh0jTHzGOoLqb
 jgk3TLcigNJ60X05RKZGKINj7OncLeU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-06k6euowPBi68IsVlo-kTQ-1; Fri, 25 Sep 2020 07:30:49 -0400
X-MC-Unique: 06k6euowPBi68IsVlo-kTQ-1
Received: by mail-wm1-f69.google.com with SMTP id a7so983191wmc.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 04:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zKZZrcTTUfCrWEB2p75YHwDXbFiTqANqvHc9qq8r3UY=;
 b=hUx7lKAQwuuUN7s6FFmCsDj82vH9Cf3hmzDMAc/vHLdghJH3WUalTKo5Nl32Vy/14I
 AiSwMNfQkzE4S6d0JAaWFwtmZsW44rxTcLdGepCqAclkpcK4WKLr1NjJPt/dutwUk0Aa
 7puhyotKzOwiWBJsBemLZrWWrvcZuhyShbewxrKAQkxxJ/CacLuI7mJtQXlE+BO4QXIZ
 3qjQiCiR/Thb2c1SfK+qf/ocyr8ZAYgPyybVALBXH5ndc9/uWsjxfZZnvYFB+gZkabWM
 5UvIOIbl0tHQtoStDjTaA2q4T6ZJzmGJIk4vtifpriDi5sX1PtLJPlqs+vcSqAE+kOsE
 b7AA==
X-Gm-Message-State: AOAM532cHHnvo1SV2L2YX5CO12Cr1EYamTvbX3TrJmTuDlPPc0sTwENy
 oDku+yjckpQa9Vgs8QDyU/6b7VULa9VspMCZyWZI6ICeQeUOxUzVB1J4XQ09T27Z6zO6tY5X0/V
 yrXgHOChBw0hciSU=
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr2568599wme.140.1601033448376; 
 Fri, 25 Sep 2020 04:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYlEnMigaSfYf4niUOTn8wzsJKGGNYQ+L9QkSW6nP6LehIdxmuyOdwJwH/9U+D+m+1OrP96g==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr2568570wme.140.1601033448045; 
 Fri, 25 Sep 2020 04:30:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id b18sm2694079wrn.21.2020.09.25.04.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 04:30:47 -0700 (PDT)
Subject: Re: [PULL v2 00/92] Misc patches for 2020-09-24
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200925102257.1848666-1-pbonzini@redhat.com>
 <CAFEAcA-okvLfrjtvVVUWJWunzOSC8kgAEUuMM1JXciebfSJ0pg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd81135c-8374-1b43-ed3b-b09b6d577cc7@redhat.com>
Date: Fri, 25 Sep 2020 13:30:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-okvLfrjtvVVUWJWunzOSC8kgAEUuMM1JXciebfSJ0pg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/20 12:45, Peter Maydell wrote:
> On Fri, 25 Sep 2020 at 11:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 8c1c07929feae876202ba26f07a540c5115c18cd:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-09-24 18:48:45 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 24c146dec201c64552b20eec5a442687b65fd93d:
>>
>>   hw/net/can: Correct Kconfig dependencies (2020-09-25 06:18:57 -0400)
>>
>> ----------------------------------------------------------------
>> * SCSI fix (Dmitry, Li Feng, Li Qiang)
>> * memory API fixes (Eduardo)
>> * removal of deprecated '-numa node', 'cpu-add', '-smp' (Igor)
>> * ACPI fix for VMBus (Jon)
>> * relocatable install (myself)
>> * always remove docker containers (myself)
>> * serial cleanups (Philippe)
>> * vmware cpuid leaf for tsc and apic frequency (Sunil)
>> * KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
>> * i386 XSAVE bugfix (Xiaoyao)
>> * QOM developer documentation in docs/devel (Eduardo)
>> * new checkpatch tests (Dov)
>> * x86_64 syscall fix (Douglas)
>> * interrupt-based APF fix (Vitaly)
>> * always create kvmclock (Vitaly)
>> * fix bios-tables-test (Eduardo)
>> * KVM PV features cleanup (myself)
>> * CAN FD (Pavel)
>>
>> meson:
>> * fixes (Marc-André, Max, Stefan, Alexander, myself)
>> * submodule and environment CFLAGS overhaul (myself)
>> * moved libmpathpersist, cocoa, malloc tests (myself)
>> * support for 0.56 introspected test dependencies (myself)
> 
>  Date: Fri Sep 25 11:41:22 2020 +0100
>     Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
> ERROR: pull request includes tag with UTF-8 error in person name
> 
> (that's "configure: Do not intent to build WHPX on 32-bit host")
> 
> (I will run the merge through the other tests to see if there's
> any other issues with it.)

Thanks, I have pushed again and sent v3.

Paolo


