Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0591CC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D5B206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIMOfi15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D5B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOd9X-0006lO-MQ
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 04:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOd8M-00062J-9j
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOd8K-00036m-Ki
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601714591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qtSXb3I+sn0KqSfNi5fm0qvrDV/u6lcgBRwiQOHUe2U=;
 b=iIMOfi15xuosVMEHNt/iZcpHsqB7u7jyI3U/CMD88J0jxTkLEseKG1BdHG6grgcjOAwU9n
 IOnGvW/+zsnlgrJdLJJ+1WABvHoUlmveESqvjZdEI53v8ZygAcVLkOOHzVwfAXOYcFll/L
 rXy3fJvBRS0qnZ9tXqvqM7tSkTcpQbU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-2ZIzbE0iOTSAAV4q97NO-g-1; Sat, 03 Oct 2020 04:43:10 -0400
X-MC-Unique: 2ZIzbE0iOTSAAV4q97NO-g-1
Received: by mail-wm1-f70.google.com with SMTP id 23so947788wmk.8
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 01:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qtSXb3I+sn0KqSfNi5fm0qvrDV/u6lcgBRwiQOHUe2U=;
 b=g5YVbJ5fjGcPT93OiksLDoKpVbsv9/EbkL6d6n7VaQuDu/fZ38243UjunLuc8Q4FZ9
 +8XOY6Cww2a9eQE8xBCfXlv1AcqXPAUPNJ8A43Alax8G+NuszfO2wDu7y50C1GvxffGj
 6lLJZdSUPCwmgBvAlGmUZIijiUo8VkCa2H18lYoKgiFrW2UCIuUd0yBQItkZLF2p15FL
 wtFooDWJX8v7fHTeUYoHXi+rdznvTZrgkScGS7r0N3AdRDEU6ewfmOZjueETnmjRLQAU
 vAX250A0euXrcUK/Tlyfqhmb+SFggPadEoSfNth80wkCMTPcLriIwFwFDnDXS7zo8NbM
 1j+g==
X-Gm-Message-State: AOAM530v1p5HyETcfOSicgsxQHfC5jXZ6BNIpfwzTDvbNiar360eDJGt
 /mOv9iQR7hTbISWzQaVkwC2jAYDF1piq0Mw9LDdRKcCIpr2vD+eA/4RLLsCbh9VIi4m9T5ZMj1+
 xndZMXjOJfloni/g=
X-Received: by 2002:a5d:5543:: with SMTP id g3mr2062013wrw.154.1601714588192; 
 Sat, 03 Oct 2020 01:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQaLcX3l8cZQryXewgH+t1xsTSLsjB07F8wWs0yescG7ttBy05ld5V7yDVG3aokj2Ukg2ejg==
X-Received: by 2002:a5d:5543:: with SMTP id g3mr2062001wrw.154.1601714587963; 
 Sat, 03 Oct 2020 01:43:07 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id p4sm313226wru.39.2020.10.03.01.43.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 01:43:07 -0700 (PDT)
Subject: Re: [PATCH] meson.build: Don't look for libudev for static builds
To: luoyonggang@gmail.com
References: <20201002105239.2444-1-peter.maydell@linaro.org>
 <b1a6000a-c9a1-43fb-7646-b6ea87797b2e@redhat.com>
 <CAFEAcA9PbBByROzJ3+pfxycAoP-C5JnmfxQEt5jm6+3A3n2fbw@mail.gmail.com>
 <df5bd19c-da9d-d3b0-71a9-4deed67450bf@redhat.com>
 <CAFEAcA9M_BP9mnZHCLM93aYvMxrRHYFELQZ3FvsyH3hNvXtHDA@mail.gmail.com>
 <CAE2XoE-RnJ2j732JfxDA2A9O0Bp4KJ2rGG0LTjrDMKvRox-VBg@mail.gmail.com>
 <d6417044-324c-0bec-a05c-1142dcdc6003@redhat.com>
 <CAE2XoE_4S6NpA7+TOuzwQ=TFjw5=rOe-_mrSkuJ4OEzUWK1X2A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bd109cd-e78b-6857-d704-4519d8150ef9@redhat.com>
Date: Sat, 3 Oct 2020 10:43:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_4S6NpA7+TOuzwQ=TFjw5=rOe-_mrSkuJ4OEzUWK1X2A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 02:43:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/20 10:29, 罗勇刚(Yonggang Luo) wrote:
> For some meson script like this:
> curses = not_found
> if iconv.found() and not get_option('curses').disabled()
>   curses_libname_list = ['ncursesw', 'ncurses', 'cursesw', 'pdcurses']
>   curses_test = '''
>     #include <locale.h>
>     #include <curses.h>
>     #include <wchar.h>
>     int main(void) {
>       wchar_t wch = L'w';
>       setlocale(LC_ALL, "");
>       resize_term(0, 0);
>       addwstr(L"wide chars\n");
>       addnwstr(&wch, 1);
>       add_wch(WACS_DEGREE);
>       return 0;
>     }'''
>   foreach curses_libname : curses_libname_list
>       libcurses = dependency(curses_libname,
>                              required: false,
>                              method: 'pkg-config',
>                              static: enable_static)
> 
>       if not libcurses.found()
>         dirs = ['/usr/include/ncursesw']
>         if targetos == 'windows'
>           dirs = []
>         endif
>         libcurses = cc.find_library(curses_libname,
>                                     required: false,
>                                     dirs: dirs,
>                                     static: enable_static)
>       endif
>       if libcurses.found()
>         if cc.links(curses_test, dependencies: [libcurses])
>           curses = declare_dependency(compile_args:
> '-DNCURSES_WIDECHAR', dependencies: [libcurses])
>           break
>         endif
>       endif
>   endforeach
> endif
> 
> We also need to define extra  compile_args  '-DNCURSES_WIDECHAR' as the
> part of dependencies.

You can do that with #define before including <curses.h>.

Paolo


