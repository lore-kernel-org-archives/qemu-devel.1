Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD17FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0DF207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARoMpNvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0DF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8UNi-0003rR-KS
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8UN2-0003Q4-7y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:07:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8UN0-0005lX-D8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597867657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TdwZh3gJiLRPvItzxQkrRlpLqrfQdUDVk4YfuCjLGBA=;
 b=ARoMpNvgiKGDsz/DmUSHKlL432DuqMXprvE2NzpxFGnNvJspa9os611KMRVE4rC87o4Mmb
 zW+loZvn7dibA5g1LBom4LZFfcJo28njQuRpyzxn1vdOu6mnblZzo2LRimyCE8a0N/JFzd
 abR71WHavM19cpwo3j2K+4YvDhTV0lw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-NKDAP_V2O4iSe0bJ04eT-Q-1; Wed, 19 Aug 2020 16:07:27 -0400
X-MC-Unique: NKDAP_V2O4iSe0bJ04eT-Q-1
Received: by mail-wm1-f69.google.com with SMTP id f74so9794wmf.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 13:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TdwZh3gJiLRPvItzxQkrRlpLqrfQdUDVk4YfuCjLGBA=;
 b=KrlB8ARVRmDW9PhSvOF107KyCh155RsmlTUUpeMwE0GxRbArnU2CzZNXendJf75DFB
 lW7beWQTufadu9eL8jEcpXEsN/0XjP1S0rjPd1BtzOg0aMuRIjw+E3SOWvBuspgqUDJa
 vOgrAG5N7IUsjLQZj2r639Eje3Vw05+dY8QYyfDcRYt5m81yBhBkChSDbOhhfeVvn0+U
 m7dY983CJU2JUOCfBnmSxQgHm3ighbahLS0Gvm2b+4++ItPJjvnaGrV6JH607DVYs/q8
 WReuaqAVJlg88wRDsGM1ZSaMaDbfDTOPhW5xD95GCiqyFArYvi0AbjMLN1GUaOlNU5sh
 kHMQ==
X-Gm-Message-State: AOAM531GDyY11C0w5Pmt53u8itotn0E2TtFyI7ifLazXU6kKNPguB9HG
 Q/PsXKxcuyeomkhb4PxIFK9QfRgPnJaNGeGXlp7fdJ45+Q0oH5E+8+VDL03kP7jSEm2Pf3yhjAm
 O5riYFGNDP1YKeBM=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr28286594wrs.226.1597867645716; 
 Wed, 19 Aug 2020 13:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOcij4fdNUF9jeQBNN4RYiKpmZm5yGAGEuVevOQLD4y/M63yTUcwqyNDzE5vXMDtg2LAUjdA==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr28286579wrs.226.1597867645407; 
 Wed, 19 Aug 2020 13:07:25 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g3sm45477463wrb.59.2020.08.19.13.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 13:07:24 -0700 (PDT)
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <CAFEAcA9jt21RHiu1eqAzK_PJAj9i6Ej27jT2=gfjSRZVjJsDKw@mail.gmail.com>
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
Message-ID: <2073e70d-f0c7-1831-b6c7-7ceaf8bd5599@redhat.com>
Date: Wed, 19 Aug 2020 22:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9jt21RHiu1eqAzK_PJAj9i6Ej27jT2=gfjSRZVjJsDKw@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

On 8/19/20 8:16 PM, Peter Maydell wrote:
> On Wed, 19 Aug 2020 at 19:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Wed, 19 Aug 2020 at 15:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>>>
>>>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to f5b5ef3b9f94d744f514f5469c97d3f80305111e:
>>>
>>>   docs: convert build system documentation to rST (2020-08-19 10:01:48 -0400)
>>>
>>> v5->v6: improved incremental build
>>>
>>> ----------------------------------------------------------------
>>> New build system.
>>>
>>> Missing:
>>> * converting configure tests
>>> * converting unit tests
>>> * converting some remaining parts of the installation
>>
>> Testing with what I think is the later commit 84264b99322
> 
>> Everything else seems to have passed.
> 
> Spoke too soon; "make --output-sync -C build/all-linux-static check-tcg"
> failed with:
> 
>   BUILD   TCG tests for mips-linux-user
>   CHECK   debian10
>   CHECK   debian-mips-cross
>   BUILD   mips-linux-user guest-tests with docker qemu/debian-mips-cross
>   RUN     TCG tests for mips-linux-user
>   CHECK   debian10
>   CHECK   debian-mips-cross
>   BUILD   mips-linux-user guest-tests with docker qemu/debian-mips-cross
>   RUN     tests for mips
>   TEST    threadcount on mips
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> timeout: the monitored command dumped core
> Segmentation fault
> ../Makefile.target:153: recipe for target 'run-threadcount' failed
> make[2]: *** [run-threadcount] Error 139
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile.qemu:76:
> recipe for target 'run-guest-tests' failed
> make[1]: *** [run-guest-tests] Error 2
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:450:
> recipe for target 'run-tcg-tests-mips-linux-user' failed
> 
> Which doesn't look on the face of it like it is a build system
> issue, but on the other hand it's not one I've seen before with
> the old build system...
> 

Probably not the cause, but I'm seeing now docker images are built in
parallel (before it was sequential, I run make with -j8).

This seems to flood the DNS which blacklist me then I get failures:

#5 47.62 Error: Failed to download metadata for repo 'fedora-modular':
Cannot prepare internal mirrorlist: Curl error (6): Couldn't resolve
host name for
https://mirrors.fedoraproject.org/metalink?repo=fedora-modular-30&arch=x86_64
[Could not resolve host: mirrors.fedoraproject.org]


