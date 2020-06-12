Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE33C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B9B2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbAbEY4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B9B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjjpH-0000JY-36
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 09:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjjob-0008Iz-B7
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:33:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjjoZ-0003lW-CS
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591968823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hqu7Fw/wZQnC+squha1mkq3vSjkZLBAyszwxCf61sbg=;
 b=LbAbEY4pnil2pcQ7ROVxQ/IzAo0RcY8sh4YIuO0Jhes+RZAYpmQ8sL6c3SPqiV839XWXW4
 7nAZReSsE1raJnvGL27JnKfRzh9pQP0YuFukFWVuBghwQCcxkSirjnuNGGmNM7aexkyv7d
 bYz1nWOTECU4H7nO418XYuVyZokuY1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-qIFlNbAxNEGZizA-ShTZvA-1; Fri, 12 Jun 2020 09:33:41 -0400
X-MC-Unique: qIFlNbAxNEGZizA-ShTZvA-1
Received: by mail-wr1-f71.google.com with SMTP id n6so3920929wrv.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 06:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hqu7Fw/wZQnC+squha1mkq3vSjkZLBAyszwxCf61sbg=;
 b=FacfuqjASX0MnPK3dM/ShIlgLwiKp5epokBuQzNAWAEHZXCGoFqT/njxfS/GEy0ctc
 dUwVLNPGSFVzLE0T/TlUpCWcXm3JJ2EzUBr5EV0qWXLrqHq2qq82UjNX7Qk5tUyf1ie0
 IgN92L7XXo21cDZMofJy4EZ3d8sH2mpM/8ZvvWNc7shFPz6hQMm4+P7jZkTlA6XPJIeT
 YPvMN9j+aiRoombjth1hnGGrq6WhvM+bM2WisskSj6P68cFd6RKigKA/5nEWkOBR9Ruc
 UHEzKU7MJN9lkTB49xgopYfiofdiApGE1Ipmpwqel8k/uynqZhax0mwtt/i3+puQJ29t
 ATBg==
X-Gm-Message-State: AOAM533T+h2lkI3DKv/wnKQSFpji7HdZapjkyg9HO937ODQKq0661JDP
 Sy7icQU1QwRS54I9W1RUnnnWT9ky//9m6O0zB4mriaZDU40fPdnfixfB3F8uLonuTClyIQgd4v5
 E/Ad7pHaV0t+N+0E=
X-Received: by 2002:adf:de91:: with SMTP id w17mr16233674wrl.249.1591968820559; 
 Fri, 12 Jun 2020 06:33:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFXEEyniND5DMP48i+gpdpqRNmVb+ZNeYG0fObZ+LQEkam2TKv464U2GbM9mLrt454ml9wFA==
X-Received: by 2002:adf:de91:: with SMTP id w17mr16233656wrl.249.1591968820306; 
 Fri, 12 Jun 2020 06:33:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d?
 ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
 by smtp.gmail.com with ESMTPSA id n189sm8914360wmb.43.2020.06.12.06.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 06:33:39 -0700 (PDT)
Subject: Re: [PULL 000/115] Huge miscellaneous pull request for 2020-06-11
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200611194449.31468-1-pbonzini@redhat.com>
 <CAFEAcA-qrxBdn5aA0kaituroTX8c1yFGdRux0_X1Y+W5_s-WHA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e1f1fa5-2a23-b586-a3b4-1394c82794d7@redhat.com>
Date: Fri, 12 Jun 2020 15:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qrxBdn5aA0kaituroTX8c1yFGdRux0_X1Y+W5_s-WHA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Joseph S. Myers" <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/20 15:09, Peter Maydell wrote:
> Hi; I'm afraid this fails to build on OSX, and has a check-tcg
> failure on x86-64 Linux.
> 
> OSX:
> 
> In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
> In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
> /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:1601:5: error:
> unknown type name 'hvf_lazy_flags'
>     hvf_lazy_flags hvf_lflags;
>     ^
> In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
> In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
> In file included from /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:2021:
> /Users/pm215/src/qemu-for-merges/include/exec/cpu-all.h:442:12: error:
> returning 'void' from a function with incompatible result type
> 'ArchCPU *' (aka 'struct X86CPU *')
>     return container_of(env, ArchCPU, env);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qemu/compiler.h:56:41: note:
> expanded from macro 'container_of'
> #define container_of(ptr, type, member) ({                      \
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:53:
> In file included from /Users/pm215/src/qemu-for-merges/include/sysemu/hvf.h:16:
> In file included from /Users/pm215/src/qemu-for-merges/target/i386/cpu.h:2021:
> /Users/pm215/src/qemu-for-merges/include/exec/cpu-all.h:464:14: error:
> initializing 'ArchCPU *' (aka 'struct X86CPU *') with an expression of
> incompatible type 'void'
>     ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
>              ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 3 errors generated.
> 
> 
> On x86-64 Linux host, running the check-tcg tests on the static
> linux-user build:
> 
>   BUILD   i386-linux-user guest-tests with docker qemu:fedora-i386-cross
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/i386/test-i386-pcmpistri.c:
> In function 'main':
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/i386/test-i386-pcmpistri.c:28:15:
> warning: left-hand operand of comma expression has no effect
> [-Wunused-value]
>    28 |     if ("%d\n", _mm_cmpistri(s1.x, s3.x, 0x4c) != 16) {
>       |               ^
> 
> (only a warning because we don't seem to be using -Werror here?)
> 
> and then the test crashed at runtime:
> 
>   TEST    test-i386-pcmpistri on i386
> qemu: uncaught target signal 4 (Illegal instruction) - core dumped
> timeout: the monitored command dumped core
> Illegal instruction
> ../Makefile.target:151: recipe for target 'run-test-i386-pcmpistri' failed

I'll resend without the offending patch.  Roman, Joseph, please take a
look and (especially for the OS X) please check if your series need a
rebase.

Thanks,

Paolo


