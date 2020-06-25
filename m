Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71622070A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 07:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C27wI0Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71622070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joMeg-0000hV-St
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 03:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joMe8-0000C2-17
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 03:50:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joMe5-0003PL-6Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 03:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593071403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/o+n2wOdT5Fmx+2sNadno2UFWbmAiyYTb+/NbnaxKLU=;
 b=C27wI0HaHHicH+9/jMwin7q0EyaIMHnt91nwLvbyV3HLGNDD5tXAlU/AYVhXppfqUfgYls
 mQ187fHafAcvuEl1G9BZgXx+uH/n9SNB02Nc/Oxcj1gwrpoFk3jFeUVx+mgLOjBHMYgfC1
 V8PrwYzxWNfRillwc9Wo33ZaJk91y7s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-lWkseLggOcuq-evBtFkP2w-1; Thu, 25 Jun 2020 03:49:59 -0400
X-MC-Unique: lWkseLggOcuq-evBtFkP2w-1
Received: by mail-wr1-f71.google.com with SMTP id y13so6250323wrp.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 00:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/o+n2wOdT5Fmx+2sNadno2UFWbmAiyYTb+/NbnaxKLU=;
 b=n5T1GH3KjPRHBenJ81VslTwrFuBDcR355YCo17HsWR5pyNrD2fJvASQ4pRx0aX1iAg
 xyaCpHO/iQ6QPRQW3GOZtpDU1humDRu4aDaraFu7fSCXQdkCLgGoyVcmGxoggDW8+rHN
 wdYEhmy3mR0vJ6lb8wKgwr+wCQdXbmUY0tlmOiivK6x3nCi7KOrKHSg5ivpS3p+Wsdps
 0QjDJ5QwhvBXi97CKyOH8Ehe8PKDzc2o3oJokeHME8wIgpaYIHTtFZqcsmH4Dne8BqRj
 sF2M5EwVmkga5rYqMNyIw1tneGbp8K9QjGH3wc+hYOxzk1NMx37r08YtBSdrV8DP04eN
 9joA==
X-Gm-Message-State: AOAM530/nnyRqsB8uL1Ef/zLNCGnS7ASg7JKUyn4rEsuR7Kre4bjPBp+
 dBpOhwgWPj4ZHpJwuiNet8sf9FE2nAul32DAzcOz6Dt6+pTN8Dow5jUXhUshYRvI/7G5qEnVYyL
 EyCt2kv5I/AJjRiE=
X-Received: by 2002:adf:e482:: with SMTP id i2mr11378416wrm.75.1593071398677; 
 Thu, 25 Jun 2020 00:49:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz42IZoKfKcz1HwQ3k06qsrnpELNIHRWNyOmlH/HyFeGDP3L7nh8WxtzawP2PgoT4CebpRo+Q==
X-Received: by 2002:adf:e482:: with SMTP id i2mr11378400wrm.75.1593071398490; 
 Thu, 25 Jun 2020 00:49:58 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y17sm31628974wrd.58.2020.06.25.00.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 00:49:57 -0700 (PDT)
Subject: Re: [PATCH v9 00/10] accel: Allow targets to use Kconfig
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
 <5332815d-49d7-21da-e752-c39c5b35adc4@redhat.com>
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
Message-ID: <05a17243-6203-0663-2bc1-e5efd59c4e67@redhat.com>
Date: Thu, 25 Jun 2020 09:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5332815d-49d7-21da-e752-c39c5b35adc4@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, haxm-team <haxm-team@intel.com>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

Claudio raised an issue with patch #4, so at this point
I have to admit again having the KVM-only build merged
for the next release won't be possible :(

Only patch #9 depends on patch #4. Are you OK to take
the rest of the series, patches 1-3, 5-8, 10 (all but
4 and 9). Patches are fully reviewed. If it is easier
for you I can respin without 4/9.

Thanks,

Phil.

On 6/22/20 6:47 PM, Philippe Mathieu-Daudé wrote:
> On 6/18/20 2:33 PM, Philippe Mathieu-Daudé wrote:
>> Missing review:
>> - 03/10 MAINTAINERS: Cover the HAX accelerator stub
> 
> I forgot again to include the HAXM team...
> 
>> - 04/10 configure: Generate rule to calculate base arch of target
>>
>> This series include generic patches I took of the KVM/ARM
>> specific series which will follow.
>>
>> - Update accelerators in MAINTAINERS
>> - Add accel/Kconfig
>> - Allow targets to use their how Kconfig
>>
[...]
>>
>> Previous RFC for semihosting posted earlier:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg631218.html
>>
>> Alex Bennée (1):
>>   configure: Generate rule to calculate the base architecture of a
>>     target
>>
>> Philippe Mathieu-Daudé (9):
>>   MAINTAINERS: Fix KVM path expansion glob
>>   MAINTAINERS: Add an 'overall' entry for accelerators
>>   MAINTAINERS: Cover the HAX accelerator stub
>>   Makefile: Remove dangerous EOL trailing backslash
>>   Makefile: Write MINIKCONF variables as one entry per line
>>   accel/Kconfig: Extract accel selectors into their own config
>>   accel/Kconfig: Add the TCG selector
>>   Makefile: Allow target-specific optional Kconfig
>>   accel/tcg: Add stub for probe_access()
>>
>>  configure              | 19 +++++++++++++++++++
>>  Makefile               | 15 +++++++++++----
>>  accel/stubs/tcg-stub.c |  7 +++++++
>>  Kconfig.host           |  7 -------
>>  MAINTAINERS            | 14 +++++++++++++-
>>  accel/Kconfig          |  9 +++++++++
>>  6 files changed, 59 insertions(+), 12 deletions(-)
>>  create mode 100644 accel/Kconfig
>>
> 


