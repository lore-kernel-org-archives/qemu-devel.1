Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5254C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8AA2474C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBiATtD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8AA2474C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmn34-0000f9-TC
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmn2V-0000BW-GY
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmn2S-0006cO-Hc
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 19:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592696202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hl2BFftMEeioh305z2Z+CdoBAaksSU1GNGBCEGOZNDw=;
 b=WBiATtD5DbnRo5akxepauL+9PP7bJpPI/8dFnCJ4qO4KM0RvCQiOAfzoqwpdwPRjfEanRf
 rr/EbcjKAU+xhaZQgh98JW3l/6cKGLbwuvnUPjJFYTnTLG35IPWfL1VEXP0p+gS0QyJjr2
 BImM3Hk6lKit9nx8PzHYfuuQ76xV6Ps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211--egQ_m0YPqqVsI7x9zfqZQ-1; Sat, 20 Jun 2020 19:36:38 -0400
X-MC-Unique: -egQ_m0YPqqVsI7x9zfqZQ-1
Received: by mail-wm1-f69.google.com with SMTP id e15so585149wme.8
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 16:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Hl2BFftMEeioh305z2Z+CdoBAaksSU1GNGBCEGOZNDw=;
 b=thC1Yp+A5OHNcvRZdIDF/aqNF9kNk7AXZyrE45Gfy2+GkKhXgeQyUdNfEd13d/4ON7
 bjCljp577JmH6GTZ0tGnGUmZQlEzXR8aWPXRJ8VPIUwkoGovtfApcWqKQfKLDkMc1DgQ
 Pc8jfzeCqJEIAJ9nEur7rE4ekF1HScrk2LmI2JTS2Qyg1rXIKIS1/EHCs9pVCseobWfr
 Hm08Qz5xHQEQUjOlmon3ZfSs9uivgT+/EBa1keeq9b6tigK/ZL7ss3XCmxfPNcIKsIye
 l8cn4Xbjz6w27RmziqXB33pEMQBRCB213cgGZNJkEl9SkTiMU7E7WgMJ8VuJpYpjjIJ+
 nt6Q==
X-Gm-Message-State: AOAM530pCAlSKVde5mb8XTMEeOilVFtNuikebjUBqOUXN++sJn6tihfj
 rj6PwbQ5K4LQD8xX2LJgPmL+ki9pcP9N3Dfxrhhk8ASWS2InCq9Br6o2S+TM7qjsqkIAIpyn/Qj
 o/zB1Q2PnfeLQYJ0=
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr10462254wmm.18.1592696197683; 
 Sat, 20 Jun 2020 16:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwro605Eh9Z+n+dmEkZUoTiw8xw++pN6REp2DMrBF3qLwckiaPq+nCsv6bh2LHPKCjozXpZ1A==
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr10462233wmm.18.1592696197395; 
 Sat, 20 Jun 2020 16:36:37 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o15sm12058292wrv.48.2020.06.20.16.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 16:36:36 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] Record/replay acceptance tests
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <159073587336.20809.5404476664125786279.stgit@pasha-ThinkPad-X280>
 <540831cc-c5b0-cf10-6889-bab499729a53@redhat.com>
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
Message-ID: <343df8f4-9d26-bfce-a714-2d06940a2586@redhat.com>
Date: Sun, 21 Jun 2020 01:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <540831cc-c5b0-cf10-6889-bab499729a53@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 19:36:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

On 5/31/20 5:09 PM, Philippe Mathieu-Daudé wrote:
> On 5/29/20 9:04 AM, Pavel Dovgalyuk wrote:
>> The following series adds record/replay tests to the acceptance group.
>> Test pass successfully with the latest submitted record/replay fixes:
>>  - replay: notify the main loop when there are no instructions
>>  - replay: synchronize on every virtual timer callback
>>
>> The provided tests perform kernel boot and disk image boot scenarios.
>> For all of them recording and replaying phases are executed.
>> Tests were borrowed from existing boot_linux*.py tests. But some
>> of the platforms and images were excluded, because icount for them
>> still has some issues.
>>
>> Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>
>>
>> v3 changes:
>>  - Added record/replay logging (suggested by Philippe Mathieu-Daudé)
>>  - Changed the console pattern to get longer kernel execution (suggested by Alex Bennée)
>>  - Coding style fixes
>>  - Other minor changes
>> v2 changes:
>>  - Some test structure refactoring (suggested by Willian Rampazzo)
>>
>> ---
>>
>> Pavel Dovgaluk (11):
>>       tests/acceptance: allow console interaction with specific VMs
>>       tests/acceptance: refactor boot_linux_console test to allow code reuse
>>       tests/acceptance: add base class record/replay kernel tests
>>       tests/acceptance: add kernel record/replay test for x86_64
>>       tests/acceptance: add record/replay test for aarch64
>>       tests/acceptance: add record/replay test for arm
>>       tests/acceptance: add record/replay test for ppc64
>>       tests/acceptance: add record/replay test for m68k

You forgot to Cc the maintainers for each target/machine tested.

Anyway this series has been on the list for 3 weeks, so I'm
queuing it for next acceptance-testing pull request.

Since the x86 tests generate some timeout errors on Travis-CI,
I squashed the following changes:

-- >8 --
diff --git a/tests/acceptance/replay_kernel.py
b/tests/acceptance/replay_kernel.py
index a25eb3d3ee..8fa6b517c5 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -12,6 +12,7 @@
 import logging
 import time

+from avocado import skipIf
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import archive
 from avocado.utils import process
@@ -72,6 +73,7 @@ def run_rr(self, kernel_path, kernel_command_line,
console_pattern,
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))

+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
diff --git a/tests/acceptance/replay_linux.py
b/tests/acceptance/replay_linux.py
index 472ab730cd..8e43e282a7 100644
--- a/tests/acceptance/replay_linux.py
+++ b/tests/acceptance/replay_linux.py
@@ -12,6 +12,7 @@
 import logging
 import time

+from avocado import skipIf
 from avocado.utils import cloudinit
 from avocado.utils import datadrainer
 from avocado.utils import network
@@ -92,6 +93,7 @@ def run_rr(self, args=None, shift=7):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))

+@skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
 class ReplayLinuxX8664(ReplayLinux):
     """
     :avocado: tags=arch:x86_64
---

Regards,

Phil.

>>       tests/acceptance: record/replay tests with advcal images
>>       tests/acceptance: refactor boot_linux to allow code reuse
>>       tests/acceptance: Linux boot test for record/replay
> 
> Thanks, patches 1/2/10 applied to my python-next tree:
> https://gitlab.com/philmd/qemu/commits/python-next
> 
> - tests/acceptance: allow console interaction with specific VMs
> - tests/acceptance: refactor boot_linux_console test to allow code reuse
> - tests/acceptance: refactor boot_linux to allow code reuse
> 


