Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D9BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26598207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqTIJtHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26598207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3fW-0002Wa-US
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ3eE-0001UC-BI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ3eB-000075-HN
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602054837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YEtrNpXFcCMt/0WxaAGJxmsm4+hWcRA8A18HiNYOfJw=;
 b=GqTIJtHD+izOwrxm8rezDA+TGqgKf/3rYectAFC+EAZUXH4crXAbFzevnrx9IdUe7ftWCe
 l7dHgPMRUcUWv6/b3C/jp9whuBGSStjpOBPAGpzmAUb4D7xV3WE3KUgHrGtYwoQGnZPOnx
 uDYVsnAqbmYGnpTdSGHM3g1NGQ4MPFI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-1E0PydVWOnSc2MUJG-Q6Yg-1; Wed, 07 Oct 2020 03:13:56 -0400
X-MC-Unique: 1E0PydVWOnSc2MUJG-Q6Yg-1
Received: by mail-wr1-f72.google.com with SMTP id c6so604670wrt.6
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 00:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YEtrNpXFcCMt/0WxaAGJxmsm4+hWcRA8A18HiNYOfJw=;
 b=NJyLqFZvD91BNWnv32J1po98C9JnIklzWfAk7rpZeTTVj8QPFoypH762D1FGQrvIx6
 xcoWw5dWF2+WLd68B9Fzek+d8DIXaCr5KIra3RsyaRb01aHEE+0su1jmwdgqvrqPAdwd
 S8zapgxvkgEayIIQ1XzkiQmttLzz4kbdNC+Iyxz9JphHJPAqu4n5SK3g84W0+y1kLuN9
 XxNazo6sMirlPdPnMymcen7sFsycbAOyZk3HA//0/1yMR59EF5SLxFuxa5aGKX42Ts08
 j+M8QSxU9cKbyuYdb2NrlJmd7H78/MNkqBpWGJMNe9R5EgnOvZas3PDge4suur1hLob7
 ExEA==
X-Gm-Message-State: AOAM531BRtbS96ay+RnV5vHjlba0WglerbdPG6AAj/xNuk2ZvgwqSg5z
 ZwBgkZtjLds0a0nN0DwemgY/7P3EcakmPkp6NgqmmGk653QcylJ6u+93bNZH6dUqkjDO2x8Kr0Y
 M6KoScA6RlocYVZ0=
X-Received: by 2002:a1c:5602:: with SMTP id k2mr1710383wmb.25.1602054835156;
 Wed, 07 Oct 2020 00:13:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyojem/vVuPc0qW47/3Yt7PDW5p9XkfIaLv5QI4Otcz5zcjyIKMgjU1S2sVlC7pxNdWz+qdEw==
X-Received: by 2002:a1c:5602:: with SMTP id k2mr1710359wmb.25.1602054834916;
 Wed, 07 Oct 2020 00:13:54 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c16sm1623298wrx.31.2020.10.07.00.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 00:13:54 -0700 (PDT)
Subject: Re: acceptance-system-fedora failures
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
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
Message-ID: <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
Date: Wed, 7 Oct 2020 09:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 7:20 AM, Philippe Mathieu-Daudé wrote:
> On 10/7/20 1:07 AM, John Snow wrote:
>> I'm seeing this gitlab test fail quite often in my Python work; I don't
>> *think* this has anything to do with my patches, but maybe I need to try
>> and bisect this more aggressively.
>>
>> The very first hint of an error I see is on line 154:
>>
>> https://gitlab.com/jsnow/qemu/-/jobs/776334918#L154
>>
>> 22:05:36 ERROR|
>> 22:05:36 ERROR| Reproduced traceback from:
>> /builds/jsnow/qemu/build/tests/venv/lib64/python3.8/site-packages/avocado/core/test.py:753
>>
>> 22:05:36 ERROR| Traceback (most recent call last):
>> 22:05:36 ERROR|   File
>> "/builds/jsnow/qemu/build/tests/acceptance/avocado_qemu/__init__.py",
>> line 171, in setUp
>> 22:05:36 ERROR|     self.cancel("No QEMU binary defined or found in the
>> build tree")
> 
> Last year the Avocado developers said we could have a clearer
> log error report, but meanwhile this verbose output is better
> that not having anything ¯\_(ツ)_/¯
> 
>>
>> Is this a known problem?
> 
> "No QEMU binary defined or found in the build tree" is not a
> problem, it means a test is skipped because the qemu-system-$ARCH
> binary is not found. In your case this is because your job
> (acceptance-system-fedora) is based on build-system-fedora
> which only build the following targets:
> 
>     TARGETS: tricore-softmmu microblaze-softmmu mips-softmmu
>       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu
>       sparc64-softmmu
> 
> Now I don't understand what binary the EmptyCPUModel/Migration tests
> are expecting. Maybe these tests only work when a single target is
> built? IOW not expecting that the python code searching for a binary
> return multiple ones? -> Eduardo/Cleber.
> 
> w.r.t. the error in your build, I told Thomas about the
> test_ppc_mac99/day15/invaders.elf timeouting but he said this is
> not his area. Richard has been looking yesterday to see if it is
> a TCG regression, and said the test either finished/crashed raising
> SIGCHLD, but Avocado parent is still waiting for a timeout, so the
> children become zombie and the test hang.

Expected output:

Quiescing Open Firmware ...
Booting Linux via __start() @ 0x01000000 ...

But QEMU exits in replay_char_write_event_load():

Quiescing Open Firmware ...
qemu-system-ppc: Missing character write event in the replay log
$ echo $?
1

Latest events are CHECKPOINT CHECKPOINT INTERRUPT INTERRUPT INTERRUPT.

Replay file is ~22MiB. End of record using "system_powerdown + quit"
in HMP.


I guess we have 2 bugs:
- replay log
- avocado doesn't catch children exit(1)


Quick reproducer:

$ make qemu-system-ppc check-venv
$ tests/venv/bin/python -m \
  avocado --show=app,console,replay \
  run --job-timeout 300 -t machine:mac99 \
  tests/acceptance/replay_kernel.py

> 
> Not sure that helps :)
> 
> Regards,
> 
> Phil.
> 


