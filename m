Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA3EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717CF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlaUbNMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717CF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdF0z-0002cR-NZ
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEw0-0006LA-38
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:22:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38638
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEvz-0002xb-0E
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590420154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=09YsZlMehpnG4otuJml6kHyCHp79WGp7ZYaEzOhLXBU=;
 b=IlaUbNMPXRki8YfBUN3ybP8n5PWiqPvBQqftE3g9ili/xg6F5+WaqU1T2Mt56qdep7EnVU
 NTCZNND/QPkWqWGnYUkvB5O74SGY+uh+ABo8vLbUj8D03FIeQM6m8VWET0odXLZt4ZeQoW
 09zieB4Bu2fEuSmiYq241g59RyLoNzs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-GIxbWGt1PHuiYt1h5njacQ-1; Mon, 25 May 2020 11:22:30 -0400
X-MC-Unique: GIxbWGt1PHuiYt1h5njacQ-1
Received: by mail-ed1-f71.google.com with SMTP id c10so7566587edw.17
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=09YsZlMehpnG4otuJml6kHyCHp79WGp7ZYaEzOhLXBU=;
 b=BHmIzMXp8M+maSv2dIkKI+aXehVuFNuoU9I4pnR3smsnq2Ew4z/rBYzov5ufINF/rY
 CBkl3USMbrMP9VoLNIFc5Tvi2/reirtL3o/bu1uzxFODH35Js/gwkypPNFcggRhkUNbF
 Gjuqp4N0Ks7uKsUQbB9p5vnD3P6z0Abj+RDs37zViF5cix4JGaD809Pf/sg1kVTIkoWm
 yfDamVe1le2L7l6TIr9YJ3/OlmsMSCfDUR40FRzk7zjIj+tuUovmg/oH9C7pkQ1Py9oo
 O0JGJ2YDWxeYSjZk/8ZIeIzVCvKJxpt+G6O6THHpBnNmomIbokutz2gTP7wOTKDFyWoQ
 7bCw==
X-Gm-Message-State: AOAM530HXpJoee+HKicUemt3d2G4rUAXBVk2cRdn18Y4oUK0A1bM7Jjc
 syEcg6E1Szd7qQU7VaS2iu7Y2WFrGWH1bd2Jc0bm2nHE1FqqrpavGRdmTgczd7y6yXPwPhHdzd5
 HJllWXcEHEx+cDhM=
X-Received: by 2002:a17:907:36d:: with SMTP id
 rs13mr19734933ejb.478.1590420149099; 
 Mon, 25 May 2020 08:22:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmfTNn4D6/TJyAZsfoeqAAaVQCiviYVIgrD7TNJxxbUyn2zqcPLbWIGU8cvGjjH2W/HL8J2Q==
X-Received: by 2002:a17:907:36d:: with SMTP id
 rs13mr19734907ejb.478.1590420148836; 
 Mon, 25 May 2020 08:22:28 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id e9sm16808450edl.25.2020.05.25.08.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 08:22:28 -0700 (PDT)
Subject: Re: [RFC v3 4/4] cpus: extract out accel-specific code to each accel
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200525145440.29728-1-cfontana@suse.de>
 <20200525145440.29728-5-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <13391945-0948-1236-f854-57aa68601662@redhat.com>
Date: Mon, 25 May 2020 17:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525145440.29728-5-cfontana@suse.de>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:55:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Roman Bolshakov <r.bolshakov@yadro.com>, haxm-team@intel.com,
 Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 4:54 PM, Claudio Fontana wrote:
> each accelerator registers a new "CpusAccelInterface"
> on initialization, providing functions for starting a vcpu,
> kicking a vcpu, and sychronizing state.
> 
> This way the code in cpus.cc is now all general softmmu code,
> nothing (or almost nothing) accelerator-specific anymore.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS                          |   1 +
>  accel/kvm/Makefile.objs              |   2 +
>  accel/kvm/kvm-all.c                  |  15 +-
>  accel/kvm/kvm-cpus-interface.c       |  94 ++++
>  accel/kvm/kvm-cpus-interface.h       |   8 +
>  accel/qtest.c                        |  82 ++++
>  accel/stubs/kvm-stub.c               |   3 +-
>  accel/tcg/Makefile.objs              |   1 +
>  accel/tcg/tcg-all.c                  |  12 +-
>  accel/tcg/tcg-cpus-interface.c       | 523 ++++++++++++++++++++
>  accel/tcg/tcg-cpus-interface.h       |   8 +
>  hw/core/cpu.c                        |   1 +
>  include/sysemu/cpus.h                |  32 ++
>  include/sysemu/hvf.h                 |   1 -
>  include/sysemu/hw_accel.h            |  57 +--
>  include/sysemu/kvm.h                 |   2 +-
>  softmmu/cpus.c                       | 911 +++--------------------------------
>  stubs/Makefile.objs                  |   1 +
>  stubs/cpu-synchronize-state.c        |  15 +
>  target/i386/Makefile.objs            |   7 +-
>  target/i386/hax-all.c                |   6 +-
>  target/i386/hax-cpus-interface.c     |  85 ++++
>  target/i386/hax-cpus-interface.h     |   8 +
>  target/i386/hax-i386.h               |   2 +
>  target/i386/hax-posix.c              |  12 +
>  target/i386/hax-windows.c            |  20 +
>  target/i386/hvf/Makefile.objs        |   2 +-
>  target/i386/hvf/hvf-cpus-interface.c |  92 ++++
>  target/i386/hvf/hvf-cpus-interface.h |   8 +
>  target/i386/hvf/hvf.c                |   5 +-
>  target/i386/whpx-all.c               |   3 +
>  target/i386/whpx-cpus-interface.c    |  96 ++++
>  target/i386/whpx-cpus-interface.h    |   8 +
>  33 files changed, 1220 insertions(+), 903 deletions(-)
>  create mode 100644 accel/kvm/kvm-cpus-interface.c
>  create mode 100644 accel/kvm/kvm-cpus-interface.h
>  create mode 100644 accel/tcg/tcg-cpus-interface.c
>  create mode 100644 accel/tcg/tcg-cpus-interface.h
>  create mode 100644 stubs/cpu-synchronize-state.c
>  create mode 100644 target/i386/hax-cpus-interface.c
>  create mode 100644 target/i386/hax-cpus-interface.h
>  create mode 100644 target/i386/hvf/hvf-cpus-interface.c
>  create mode 100644 target/i386/hvf/hvf-cpus-interface.h
>  create mode 100644 target/i386/whpx-cpus-interface.c
>  create mode 100644 target/i386/whpx-cpus-interface.h

Patch looks good, but remember to add proper license headers to all new
files when removing the RFC tag.


