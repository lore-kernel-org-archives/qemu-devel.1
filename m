Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BCFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCB22063A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azygkwgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCB22063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeE41-00051o-Hp
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeE3I-0004P6-HT
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:38:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeE3G-00076x-WA
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590655089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=589TavKDyjI2g08U9TwOMy6EslpQnv5Et5UXEc9LQ/c=;
 b=azygkwgNoAhxxzS3rF59pDmpiapjD8WB4jRbGTrm/m2CD6IJXagdjUzDTLCbzphLTwBOwV
 gRnhTv4QYGFne+6k4Br08OxvRSCuBQXgdowR4urCsPma4ATec6Vd41TU1dErcvNsvFDpGb
 X6WBZqcZ9e7PISt85Fi332Cc1p9qwBM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-aisMfzmaPzyrNh2n544V_Q-1; Thu, 28 May 2020 04:38:04 -0400
X-MC-Unique: aisMfzmaPzyrNh2n544V_Q-1
Received: by mail-wr1-f71.google.com with SMTP id z10so12389219wrs.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=589TavKDyjI2g08U9TwOMy6EslpQnv5Et5UXEc9LQ/c=;
 b=bjKVNJhTFoe22GfPx3ve9M8aK3S98JIhpjFO2jNkMum5p6Z6byKRT6H269maNoutYs
 SW85QcO1p/6MLD2G835tdnLBUMbmIQo64Z7X3Oxfq8KYuUNCSdO4/TRRMfvWtefUP6VC
 uNBK6cbhW0ZIvD3jz+I8ecM8fM21LLjtUZvPF3f2Wgx/I4NaeJPpNJEBLwARNh7I3MV1
 F9KlVefxxHx91xg/+F0ad4x4pLwR8hjrFY5llXbmTPnM2M7WCgObnDi5gR0HoQWnevby
 SEDlRR1u2mgvLsJhCRKPBfzTY2PAG0UuKuNpArthOyhvvXVyT5/3Df59yZZj5GrxYexp
 ITeg==
X-Gm-Message-State: AOAM532B/+TuGrc3cYZK/THp69Cfx/26Y77Ttx4xY2AJcLQyHe1g4F4g
 KauwS1814ew3D38haY9eWihfrJZVlfLDfHBGW2RUXIa+QNF/yNY2BwXbhIONaeal6k3pAHTieM+
 9X3uv1k6D7Eqg9yE=
X-Received: by 2002:adf:b786:: with SMTP id s6mr2346365wre.287.1590655083256; 
 Thu, 28 May 2020 01:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7AvMUXF58z219iS95l04UYFTBD+mFUWnxDmRu76RxkssiHNbueEQ9kLPuoso8XiHdYkch9Q==
X-Received: by 2002:adf:b786:: with SMTP id s6mr2346347wre.287.1590655083007; 
 Thu, 28 May 2020 01:38:03 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id z25sm5648549wmf.10.2020.05.28.01.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 01:38:02 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay test
 for x86_64
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org,
 crosa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
 <1510a96e-2768-32c9-44f5-465ed9b0d859@redhat.com>
 <19507b45-b8d5-0bab-c0bf-a9ae161281f6@ispras.ru>
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
Message-ID: <d03e2479-a341-c3e2-247b-797bc7d24a9b@redhat.com>
Date: Thu, 28 May 2020 10:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <19507b45-b8d5-0bab-c0bf-a9ae161281f6@ispras.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, pavel.dovgaluk@ispras.ru,
 wrampazz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 9:12 AM, Pavel Dovgalyuk wrote:
> 
> On 27.05.2020 17:53, Philippe Mathieu-Daudé wrote:
>> On 5/27/20 12:31 PM, Pavel Dovgalyuk wrote:
>>> This patch adds a test for record/replay an execution of x86_64 machine.
>>> Execution scenario includes simple kernel boot, which allows testing
>>> basic hardware interaction in RR mode.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>> ---
>>>   0 files changed
>>>
>>> diff --git a/tests/acceptance/replay_kernel.py
>>> b/tests/acceptance/replay_kernel.py
>>> index b8b277ad2f..c7526f1aba 100644
>>> --- a/tests/acceptance/replay_kernel.py
>>> +++ b/tests/acceptance/replay_kernel.py
>>> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>>>                       True, shift, args)
>>>           self.run_vm(kernel_path, kernel_command_line, console_pattern,
>>>                       False, shift, args)
>>> +
>>> +    def test_x86_64_pc(self):
>>> +        """
>>> +        :avocado: tags=arch:x86_64
>>> +        :avocado: tags=machine:pc
>>> +        """
>>> +        kernel_url =
>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>> +                     
>>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>> +                      '/vmlinuz')
>>> +        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
>>> +        kernel_path = self.fetch_asset(kernel_url,
>>> asset_hash=kernel_hash)
>>> +
>>> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE +
>>> 'console=ttyS0'
>>> +        console_pattern = 'Kernel command line: %s' %
>>> kernel_command_line
>>> +
>>> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
>>>
>> This one timeouted (I build with --enable-debug):
> 
> I've got the strange behavior for the couple of times.
> 
> Console output was correct (I saw 'Kernel command line' in logs), but
> _console_interation function didn't notice it.
> 
> Therefore the test finished with timeout.
> 
> How this could be possible?

IIRC there is a problem in how Avocado consume the chardev output.

Cleber has been working on some PoC / kludge.

Cleber/Eduardo do you remember the problem?

> 
>>   (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc:
>> replay: recording...
>> replay: replaying...
>> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
>> reached\nOriginal status: ERROR\n{'name':
>> '1-tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc',
>> 'logdir':
>> 'avocado/job-results/job-2020-05-27T16.48-71d7bf4/test-results/1-tes...
>> (90.68 s)
>>
> 


