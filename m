Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775C1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAE6206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blE1FLO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAE6206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspXG-0003Wd-GH
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jspWO-0002cD-7S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jspWL-0007Vp-1d
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594135712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fcCqCe4aEFC3Zh+ldOtHWDR5dSdrg+Le4/pd1mv10KI=;
 b=blE1FLO9LS9/vAvf3J39/8fqy7x3mHqimBt73zoK18t7Wwp8CTBjxWJhXaYwWW/8kUyUd6
 9N9xO+52Iu0szazqhZA7SXOaiH7+6FPtRD53RoD5t8Bd3Kf0+MMx7tWmLoIwratWBlv/Wh
 mkiHVYaYJ/4b1jWDPhN5VMc8yL7YrMs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-J1ZLr198MVG5tB6RH53G1g-1; Tue, 07 Jul 2020 11:28:26 -0400
X-MC-Unique: J1ZLr198MVG5tB6RH53G1g-1
Received: by mail-wm1-f69.google.com with SMTP id g138so43937366wme.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 08:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fcCqCe4aEFC3Zh+ldOtHWDR5dSdrg+Le4/pd1mv10KI=;
 b=H1m1drcrRQu3X8saYnU95ZGcPJIWkvFTEh372P8ZVKr36mns83cmccnRoEzp/8G5wH
 l9ArAJn3hGwTXvMRNMSTEonbak3LrsoOz2yf57Q5GLpHrbkUOXhRq6XYLFn/mqTsddZ0
 AG0OUMTHmNa11Widjmadijs7eeaknamTT6p2LB40be/L3I8FcmuaDj9ltMG3sbHI4Fc4
 AIH6Bu+adTDXwH8Ht4zu2f8sDaE83SxmaW1z7iLdcQ/NMUnsyohLrKwf9rViBgnY83eX
 hUqkfWvGtYTyEJF/O5nQHigAvLBgfGAeBl4mnn33SOpzPAr84wLA1PGq+A3eQ/nW0Sxk
 rMjw==
X-Gm-Message-State: AOAM533JVCFaX15NLL0Mn/Dm3rlpPCbAsywAI3+EfPZD3uNLu5R+Vuts
 spkzg45QneOVVeM9z2CJ0xsDSexHPc+eLlcAh6v7gISKQFjTjd9nGsq6WlrkA++Ck4bntihD2D3
 PGn+Trhd5JXh3Ay0=
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr4749875wmj.136.1594135703765; 
 Tue, 07 Jul 2020 08:28:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAmNKML0PpHomBDs/aMk0qtLj7L9/fXdoZlgrgoQhnML815V2iOW2AKHypLTyqjxqbjH54kg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr4749857wmj.136.1594135703448; 
 Tue, 07 Jul 2020 08:28:23 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v5sm1544148wmh.12.2020.07.07.08.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 08:28:22 -0700 (PDT)
Subject: Re: [PULL 00/12] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200624100210.59975-1-stefanha@redhat.com>
 <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
 <20200626102506.GD281902@stefanha-x1.localdomain>
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
Message-ID: <cab22670-6804-9ddc-c3ee-b6dcf3a74ac4@redhat.com>
Date: Tue, 7 Jul 2020 17:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626102506.GD281902@stefanha-x1.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 12:25 PM, Stefan Hajnoczi wrote:
> On Thu, Jun 25, 2020 at 02:31:14PM +0100, Peter Maydell wrote:
>> On Wed, 24 Jun 2020 at 11:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>> The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:
>>>
>>>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/stefanha/qemu.git tags/block-pull-request
>>>
>>> for you to fetch changes up to 7838c67f22a81fcf669785cd6c0876438422071a:
>>>
>>>   block/nvme: support nested aio_poll() (2020-06-23 15:46:08 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Pull request
>>>
>>> ----------------------------------------------------------------
>>
>> Failure on iotest 030, x86-64 Linux:
>>
>>   TEST    iotest-qcow2: 030 [fail]
>> QEMU          --
>> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
>> -nodefaults -display none -accel qtest
>> QEMU_IMG      --
>> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-io"
>>  --cache writeback --aio threads -f qcow2
>> QEMU_NBD      --
>> "/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 e104462 4.15.0-76-generic
>> TEST_DIR      --
>> /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.8tgdDjoZcO
>> SOCKET_SCM_HELPER --
>> /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotest/socket_scm_helper
>>
>> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
>>  2019-07-15 17:18:35.251364738 +0100
>> +++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/030.out.bad
>>   2020-06-25 14:04:28.500534007 +0100
>> @@ -1,5 +1,17 @@
>> -...........................
>> +.............F.............
>> +======================================================================
>> +FAIL: test_stream_parallel (__main__.TestParallelOps)
>> +----------------------------------------------------------------------
>> +Traceback (most recent call last):
>> +  File "030", line 246, in test_stream_parallel
>> +    self.assert_qmp(result, 'return', {})
>> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
>> line 848, in assert_qmp
>> +    result = self.dictpath(d, path)
>> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
>> line 822, in dictpath
>> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
>> +AssertionError: failed path traversal for "return" in "{'error':
>> {'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not
>> found"}}"
>> +
>>  ----------------------------------------------------------------------
>>  Ran 27 tests
>>
>> -OK
>> +FAILED (failures=1)
> 
> Strange, I can't reproduce this failure on my pull request branch or on
> qemu.git/master.
> 
> Is this failure deterministic? Are you sure it is introduced by this
> pull request?

Probably not introduced by this pullreq, but I also hit it on FreeBSD:
https://cirrus-ci.com/task/4620718312783872?command=main#L5803

  TEST    iotest-qcow2: 030 [fail]
QEMU          --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      --
"/tmp/cirrus-ci-build/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 cirrus-task-4620718312783872 12.1-RELEASE
TEST_DIR      -- /tmp/cirrus-ci-build/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.aZ5pxFLF
SOCKET_SCM_HELPER --
--- /tmp/cirrus-ci-build/tests/qemu-iotests/030.out	2020-07-07
14:48:48.123804000 +0000
+++ /tmp/cirrus-ci-build/build/tests/qemu-iotests/030.out.bad	2020-07-07
15:05:07.863685000 +0000
@@ -1,5 +1,17 @@
-...........................
+.............F.............
+======================================================================
+FAIL: test_stream_parallel (__main__.TestParallelOps)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 246, in test_stream_parallel
+    self.assert_qmp(result, 'return', {})
+  File "/tmp/cirrus-ci-build/tests/qemu-iotests/iotests.py", line 848,
in assert_qmp
+    result = self.dictpath(d, path)
+  File "/tmp/cirrus-ci-build/tests/qemu-iotests/iotests.py", line 822,
in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'DeviceNotActive', 'desc': "Block job 'stream-node8' not found"}}"
+
+----------------------------------------------------------------------
 Ran 27 tests

-OK
+FAILED (failures=1)
Failed 1 of 74 iotests
gmake: *** [/tmp/cirrus-ci-build/tests/Makefile.include:880:
check-tests/check-block.sh] Error 1
Exit status: 2


