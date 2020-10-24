Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA2FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 07:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E81A20936
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 07:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClcWNDTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E81A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWE8j-0008QO-Oa
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 03:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWE7n-0007t4-K3
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 03:38:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWE7k-0000ZV-QI
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 03:38:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id a72so4480273wme.5
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9+o+c+XtEph6MbygU+HPYDzVSgol8nL75s9bZ2XuK44=;
 b=ClcWNDTRmtPhjQ2cEJUw3SIohTEGJp+TxCw2KUOcG771W009KsO6U7N5JVQkfB0O40
 //151cVmDbjap0gqgARLJiJtfDK0j9/lrfHpNJblsL+TZNWTSpi/JOaQ7eo5iAtzrXbi
 fYmgugmmxxL+KWjy4AruCEAALlAOphG3goTiHCDPt2cHD7e51dlT1vvbNYbMsBgeNPG3
 H9Avpv0pNdcY0IOlQ/dBdGZO7rPj5IOggEVi5aMGtqLBai7Fyrr6M+gEPIB4GfxQVGtA
 8kJNetmfpWXj+uvd77AvOUPNJR2hs82haRBlYHv2C/sKZqbYCKZA5lJ9lj3d3Y2CulwW
 3P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9+o+c+XtEph6MbygU+HPYDzVSgol8nL75s9bZ2XuK44=;
 b=dJxCOKg/5rgnzFGd7a2lfPg47U6iMER6kpdWjK3LxHxEP+n0UJxgirKnpLxpYEwunO
 DzlbuNzwnS6dBGmR86dLZiJx6jeq808SJtrR96ioL1pWS+y0CdVn7OE3yPU2iNQk0eWM
 sm15GouXkhduutt4t/jAcO+0yE4siJehSoMtyNqsNS7bNNXNFW0LLtOf7JrRUbxaTmzo
 b/XiwiK/JGld1aVxPyfijxDx4qUyrzlReZoSsDew2+jntWjuxxJuZeS7FgbnH+61BIu9
 ypsKWeAjD/JzuykwlDffSX4s3+FuHz2x8kLlWQ9gQhzi5B7lS+Nz9noyRD4QT2NKa8C6
 hDmQ==
X-Gm-Message-State: AOAM530U23GxLtui5iVu62gPOYRmfSVhEvds1lTrieZO7LImOW7fKyft
 Yqqy1EoqB7ehL3mTA5IQVTM=
X-Google-Smtp-Source: ABdhPJyJ1wfXM+m1eFU+6c0iMNKoi6H3OjSsEeKCUBuee355DZtl4xP46X6FQHjUf1/UVnGs+vVy2g==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5572807wmk.127.1603525078999; 
 Sat, 24 Oct 2020 00:37:58 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u5sm11253515wru.63.2020.10.24.00.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 00:37:58 -0700 (PDT)
Subject: Re: [PATCH 4/6] tests/acceptance: Introduce tesseract_ocr() helper
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <20201021105035.2477784-5-f4bug@amsat.org>
 <0b31c367-f054-ce03-c1f8-d6fb6cbffc28@redhat.com>
 <3cd8bd76-2115-1317-f852-fb1ffdde544a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <87b084e3-8e6e-359d-784d-2f1353522f98@amsat.org>
Date: Sat, 24 Oct 2020 09:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3cd8bd76-2115-1317-f852-fb1ffdde544a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.108,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/20 8:40 AM, Thomas Huth wrote:
> On 24/10/2020 08.35, Thomas Huth wrote:
>> On 21/10/2020 12.50, Philippe Mathieu-Daudé wrote:
>>> We are going to reuse the tesseract OCR code.
>>> Create a new tesseract_ocr() helper and use it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   tests/acceptance/machine_m68k_nextcube.py | 21 +++++----------------
>>>   tests/acceptance/tesseract_utils.py       | 18 ++++++++++++++++++
>>>   2 files changed, 23 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
>>> index 3c7400c43e4..09e2745cc52 100644
>>> --- a/tests/acceptance/machine_m68k_nextcube.py
>>> +++ b/tests/acceptance/machine_m68k_nextcube.py
>>> @@ -7,13 +7,11 @@
>>>   
>>>   import os
>>>   import time
>>> -import logging
>>>   
>>>   from avocado_qemu import Test
>>>   from avocado import skipUnless
>>> -from avocado.utils import process
>>>   
>>> -from tesseract_utils import tesseract_available
>>> +from tesseract_utils import tesseract_available, tesseract_ocr
>>>   
>>>   PIL_AVAILABLE = True
>>>   try:
>>> @@ -61,12 +59,8 @@ def test_bootrom_framebuffer_size(self):
>>>       def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
>>>           screenshot_path = os.path.join(self.workdir, "dump.ppm")
>>>           self.check_bootrom_framebuffer(screenshot_path)
>>> -
>>> -        console_logger = logging.getLogger('console')
>>> -        text = process.run("tesseract %s stdout" % screenshot_path).stdout_text
>>> -        for line in text.split('\n'):
>>> -            if len(line):
>>> -                console_logger.debug(line)
>>> +        lines = tesseract_ocr(screenshot_path, tesseract_version=3)
>>> +        text = '\n'.join(lines)
>>>           self.assertIn('Backplane', text)
>>>           self.assertIn('Ethernet address', text)
>>>   
>>> @@ -77,13 +71,8 @@ def test_bootrom_framebuffer_ocr_with_tesseract_v3(self):
>>>       def test_bootrom_framebuffer_ocr_with_tesseract_v4(self):
>>>           screenshot_path = os.path.join(self.workdir, "dump.ppm")
>>>           self.check_bootrom_framebuffer(screenshot_path)
>>> -
>>> -        console_logger = logging.getLogger('console')
>>> -        proc = process.run("tesseract --oem 1 %s stdout" % screenshot_path)
>>> -        text = proc.stdout_text
>>> -        for line in text.split('\n'):
>>> -            if len(line):
>>> -                console_logger.debug(line)
>>> +        lines = tesseract_ocr(screenshot_path, tesseract_version=4)
>>> +        text = '\n'.join(lines)
>>>           self.assertIn('Testing the FPU, SCC', text)
>>>           self.assertIn('System test failed. Error code', text)
>>>           self.assertIn('Boot command', text)
>>> diff --git a/tests/acceptance/tesseract_utils.py b/tests/acceptance/tesseract_utils.py
>>> index acd6e8c2faa..72cd9ab7989 100644
>>> --- a/tests/acceptance/tesseract_utils.py
>>> +++ b/tests/acceptance/tesseract_utils.py
>>> @@ -6,7 +6,9 @@
>>>   # later. See the COPYING file in the top-level directory.
>>>   
>>>   import re
>>> +import logging
>>>   
>>> +from avocado.utils import process
>>>   from avocado.utils.path import find_command, CmdNotFoundError
>>>   
>>>   def tesseract_available(expected_version):
>>> @@ -26,3 +28,19 @@ def tesseract_available(expected_version):
>>>           return False
>>>       # now this is guaranteed to be a digit
>>>       return int(match.groups()[0]) == expected_version
>>> +
>>> +
>>> +def tesseract_ocr(image_path, tesseract_args='', tesseract_version=3):
>>> +    console_logger = logging.getLogger('tesseract')
>>> +    console_logger.debug(image_path)
>>> +    if tesseract_version == 4:
>>> +        tesseract_args += ' --oem 1'
>>> +    proc = process.run("tesseract {} {} stdout".format(tesseract_args,
>>> +                                                       image_path))
>>> +    lines = []
>>> +    for line in proc.stdout_text.split('\n'):
>>> +        sline = line.strip()
>>> +        if len(sline):
>>> +            console_logger.debug(sline)
>>> +            lines += [sline]
>>> +    return lines
>>
>> Would it make sense to completely hide the tesseract version handling in
>> this new tesseract_utils.py file now, so that the tests themselves do not
>> have to worry about this anymore

Yes, good idea.

> (i.e. would it be possible to merge
>> test_bootrom_framebuffer_ocr_with_tesseract_v3 and
>> test_bootrom_framebuffer_ocr_with_tesseract_v4 into one single test that way?)
> 
> If I've got that right, there is also now a proper release 4 of Tesseract,
> so maybe we can simply scratch the testing with version 3 now?

Good to know, I'll have a look. Thanks!

> 
>   Thomas
> 

