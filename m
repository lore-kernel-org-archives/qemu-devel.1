Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA85C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3F720659
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONwLOM5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3F720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4hf-0004Mh-1p
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ4fl-0002uA-Jv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:19:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ4fj-000867-Rk
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602058779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/bqT0yts++FYegCQzqbFikDxvze9DpzAErnr7TU/7ZE=;
 b=ONwLOM5rTcMBm13pxvIq0yTv31LaUrwc4Pkfe9QDPwRdd621/E8eIqPv4eg+q4vy2Qy2LQ
 JfltFP1RFaITiMcbjo+xfoBeVjLG5rb5jC1uvqSzKcXlg1Q0idewaSHq/p0ORfA6xIMC4q
 aTGHY2W7DrtSYyTISypILMTYGlKQdRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Yq_FHWVxPCKfQVikn8O_MQ-1; Wed, 07 Oct 2020 04:19:35 -0400
X-MC-Unique: Yq_FHWVxPCKfQVikn8O_MQ-1
Received: by mail-wm1-f72.google.com with SMTP id s25so212573wmj.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/bqT0yts++FYegCQzqbFikDxvze9DpzAErnr7TU/7ZE=;
 b=e/NW69sq2NaZtAGrsNhHVy2/OFsg4qfEBFF+XDsRGpwhh92U1yVHy9GB1SdoobsQxv
 31JM7TC+xfcv29ieo3fZ4KPnRGCSz72tit6Suyqn43qbcrwhBCjOhSqiqU5WWIY2Kfom
 nDlRCs7AoUzZYOqBny5eo5iAhbKUXjx10ciat5hVvO+GfKkrWHXk14+eUN7cCTCNnbAh
 FRGgXGgCs3Yn18f9Ky/0HzRQOytA6DOm4vlxT7wIa7WfyMcB7h121T5gmz/9Jw6bfO2B
 jBD4hMs9EzCky97TobbXBGmdiL1lFfFsmd3kE4AX5+FR49yGuaT5DYmxcNlOn/Ahj48n
 Tqlw==
X-Gm-Message-State: AOAM532kSFg0uRnYStUnvoDwjL5wM/Km+7j5SCQQXS2QMbyc50XyRNoL
 K/N0+cdE51tNTo1hXBWci+TxmkdIvk8lEfaoZuOWBjzkSS76+BnTu4sZr71+cK5uRFjYxQoLhi9
 TcobJimZC6RnLJ+w=
X-Received: by 2002:a5d:5548:: with SMTP id g8mr2139493wrw.364.1602058774428; 
 Wed, 07 Oct 2020 01:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLdtsk6EsAaP7+K6PBBdn5FvERRK1VQ8AqBoUQD1zLnNCYBUa51s2+66Vfc9vmZIgRFUGg5A==
X-Received: by 2002:a5d:5548:: with SMTP id g8mr2139471wrw.364.1602058774203; 
 Wed, 07 Oct 2020 01:19:34 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v8sm1647013wmb.20.2020.10.07.01.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:19:33 -0700 (PDT)
Subject: Re: acceptance-system-fedora failures
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <e577dded-ed2b-6cd0-5119-9bde4ab0c492@redhat.com>
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
Message-ID: <0c0a2036-1927-e228-fb56-14ec1e75e488@redhat.com>
Date: Wed, 7 Oct 2020 10:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e577dded-ed2b-6cd0-5119-9bde4ab0c492@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 9:23 AM, Thomas Huth wrote:
> On 07/10/2020 07.20, Philippe Mathieu-Daudé wrote:
>> On 10/7/20 1:07 AM, John Snow wrote:
>>> I'm seeing this gitlab test fail quite often in my Python work; I don't
>>> *think* this has anything to do with my patches, but maybe I need to try
>>> and bisect this more aggressively.
> [...]
>> w.r.t. the error in your build, I told Thomas about the
>> test_ppc_mac99/day15/invaders.elf timeouting but he said this is
>> not his area. Richard has been looking yesterday to see if it is
>> a TCG regression, and said the test either finished/crashed raising
>> SIGCHLD, but Avocado parent is still waiting for a timeout, so the
>> children become zombie and the test hang.
>>
>> Not sure that helps :)
> 
> No clue why that invaders.elf is now failing with the replay test, but if
> you look at the history of the CI runs:
> 
>  https://gitlab.com/qemu-project/qemu/-/pipelines
> 
> ... you can clearly see that the problem started with John's
> ide-pull-request 5 days ago:
> 
>  https://gitlab.com/qemu-project/qemu/-/pipelines/197124608
> 
> So maybe it's worth the effort to have a look at the patches that got merged
> here?

Great idea!

Bisected using:

$ make qemu-system-ppc check-venv && \
  tests/venv/bin/python -m \
  avocado --show=app,console,replay \
  run -t machine:mac99 \
  tests/acceptance/replay_kernel.py

55adb3c45620c31f29978f209e2a44a08d34e2da is the first bad commit
commit 55adb3c45620c31f29978f209e2a44a08d34e2da
Author: John Snow <jsnow@redhat.com>
Date:   Fri Jul 24 01:23:00 2020 -0400

    ide: cancel pending callbacks on SRST

    The SRST implementation did not keep up with the rest of IDE;
    it is possible to perform a weak reset on an IDE device to
    remove the BSY/DRQ bits, and then issue writes to the
    control/device registers which can cause chaos with the state
    machine.

    Fix that by actually performing a real reset.

    Reported-by: Alexander Bulekov <alxndr@bu.edu>
    Fixes: https://bugs.launchpad.net/qemu/+bug/1878253
    Fixes: https://bugs.launchpad.net/qemu/+bug/1887303
    Fixes: https://bugs.launchpad.net/qemu/+bug/1887309
    Signed-off-by: John Snow <jsnow@redhat.com>

 hw/ide/core.c | 58
++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 18 deletions(-)

Regards,

Phil.


