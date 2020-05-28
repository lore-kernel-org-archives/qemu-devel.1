Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA17C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E1E2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7MeGV9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E1E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGmW-0001KU-FG
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeGlx-0000u3-UT
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:32:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39605
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeGlw-0003Ab-Kh
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590665546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2DPEx2uzuIT4HJJaxP5NjmP8B5TITmuezd2XqH6y6a8=;
 b=N7MeGV9XbIgIiqJs51/g5DknOh6c988XVO/zt68ct2uxd+lQiEDndE/On9AiqNsqJroQ3w
 PnfWAb0C3X86XRl/upde4ro6NbzF/kyInNLobmnPo4X+HkiZ1MDVNwY0rt7oHqlMXkY++u
 S3VAQ8kudmPgrTLlQm2LIbxnkkPZh/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-TbeJlTDqNGycIQ6_yDaYkg-1; Thu, 28 May 2020 07:32:21 -0400
X-MC-Unique: TbeJlTDqNGycIQ6_yDaYkg-1
Received: by mail-wr1-f70.google.com with SMTP id q24so7104534wra.14
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 04:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2DPEx2uzuIT4HJJaxP5NjmP8B5TITmuezd2XqH6y6a8=;
 b=O+Cae6Hv7kT1gW1jGClXWlurUcSzNXbCTfIKL+nFSVfwUBY+kfyb4r/STyFUB3gJPi
 oFNF7MB56CSBD39sRqpU8iKeQa7HtjE6KaK0fSoPcyw7yVaAWlnXrCy5aW80ftJyj5k1
 OdmztrLXXnQeDZo9L13r0miVnZJOIUH+0sQw7NfWorHqf3GZ9/EXkzh3kVG0/+ZRkjUZ
 I+VLLss61/FEGewU/MIgcYsU5GvZ/WnhWpzFzPEFj+ghSlPRWl3xYYECm1TCoY/c7Css
 pZMITnlT9aHjD7W54MFGl8PNSW1NxaHonqBh7nP2Mc1nCHHfw4+bUdSRXUKJQH3+JZVp
 a/eA==
X-Gm-Message-State: AOAM530JMSHWWeYR1l6zPObK5kymbxOshFPhVpaGe8DCOQt4F80KiUGn
 GNaV7KXTmEKnbuDBzc297dYSWIvybjRz0jwMzfmtjE/tn6U0Ug5dnw93A/SuHC66maq2W+4XTse
 ctE7yqsVa0vzaAxE=
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr3363509wrx.55.1590665540744; 
 Thu, 28 May 2020 04:32:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9RI806788gW/Xe3devcr6whoRxmSUeM/MPVXv1Wp7x8mWIYXeQ54jmPli4lcS9OWr5bMRhg==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr3363494wrx.55.1590665540572; 
 Thu, 28 May 2020 04:32:20 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u4sm6138701wmb.48.2020.05.28.04.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 04:32:19 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay test
 for x86_64
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
 <1510a96e-2768-32c9-44f5-465ed9b0d859@redhat.com>
 <19507b45-b8d5-0bab-c0bf-a9ae161281f6@ispras.ru>
 <d03e2479-a341-c3e2-247b-797bc7d24a9b@redhat.com> <87k10w48t9.fsf@linaro.org>
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
Message-ID: <9cbf625d-258c-9419-e1d3-13b0d5a25bb2@redhat.com>
Date: Thu, 28 May 2020 13:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k10w48t9.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, pavel.dovgaluk@ispras.ru,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, wrampazz@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:07 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 5/28/20 9:12 AM, Pavel Dovgalyuk wrote:
>>>
>>> On 27.05.2020 17:53, Philippe Mathieu-Daudé wrote:
>>>> On 5/27/20 12:31 PM, Pavel Dovgalyuk wrote:
>>>>> This patch adds a test for record/replay an execution of x86_64 machine.
>>>>> Execution scenario includes simple kernel boot, which allows testing
>>>>> basic hardware interaction in RR mode.
>>>>>
>>>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>>>>> ---
>>>>>   0 files changed
>>>>>
>>>>> diff --git a/tests/acceptance/replay_kernel.py
>>>>> b/tests/acceptance/replay_kernel.py
>>>>> index b8b277ad2f..c7526f1aba 100644
>>>>> --- a/tests/acceptance/replay_kernel.py
>>>>> +++ b/tests/acceptance/replay_kernel.py
>>>>> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>>>>>                       True, shift, args)
>>>>>           self.run_vm(kernel_path, kernel_command_line, console_pattern,
>>>>>                       False, shift, args)
>>>>> +
>>>>> +    def test_x86_64_pc(self):
>>>>> +        """
>>>>> +        :avocado: tags=arch:x86_64
>>>>> +        :avocado: tags=machine:pc
>>>>> +        """
>>>>> +        kernel_url =
>>>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>>>> +                     
>>>>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>>>> +                      '/vmlinuz')
>>>>> +        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
>>>>> +        kernel_path = self.fetch_asset(kernel_url,
>>>>> asset_hash=kernel_hash)
>>>>> +
>>>>> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE +
>>>>> 'console=ttyS0'
>>>>> +        console_pattern = 'Kernel command line: %s' %
>>>>> kernel_command_line
>>>>> +
>>>>> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)
>>>>>
>>>> This one timeouted (I build with --enable-debug):
>>>
>>> I've got the strange behavior for the couple of times.
>>>
>>> Console output was correct (I saw 'Kernel command line' in logs), but
>>> _console_interation function didn't notice it.
>>>
>>> Therefore the test finished with timeout.
>>>
>>> How this could be possible?
>>
>> IIRC there is a problem in how Avocado consume the chardev output.
> 
> Is this the same problem Robert has tried to work around in tests/vm?
> 
>   From: Robert Foley <robert.foley@linaro.org>
>   Subject: [PATCH v7 12/12] tests/vm: Add workaround to consume console
>   Date: Tue, 19 May 2020 09:22:59 -0400
>   Message-Id: <20200519132259.405-13-robert.foley@linaro.org>

Exactly! I guess Marc-André or Eduardo suggested the same fix (use a
dedicated polling thread).

> 
>>
>> Cleber has been working on some PoC / kludge.
>>
>> Cleber/Eduardo do you remember the problem?
>>
>>>
>>>>   (1/1) tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc:
>>>> replay: recording...
>>>> replay: replaying...
>>>> INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
>>>> reached\nOriginal status: ERROR\n{'name':
>>>> '1-tests/acceptance/replay_kernel.py:ReplayKernel.test_x86_64_pc',
>>>> 'logdir':
>>>> 'avocado/job-results/job-2020-05-27T16.48-71d7bf4/test-results/1-tes...
>>>> (90.68 s)
>>>>
>>>
> 
> 


