Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211C7C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949D320782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpZDCXuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949D320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7n3-0007EB-9N
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ7lo-0006Dk-F8; Wed, 07 Oct 2020 07:38:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ7lm-0007jb-KH; Wed, 07 Oct 2020 07:38:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so1763111wrt.3;
 Wed, 07 Oct 2020 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Wy4UHVoGJYMc6JPWv+2mNIeFyvDGmgZhediZKa2XN8=;
 b=IpZDCXufFw6IxN2GdcZM2ptTjG1KVOBUzAJlzKlPFNzepYv0kqZw9sSJI7Hgs4+Y+4
 3bPe6XfgSpuHrWJbLByA0qVjjmEIcpN8VRL6XVrcZqup+iDXdir0/mzNpng7dPwC9g3k
 ZqpK02HTLprpGhKEcelcqC9f7j8uNt2cBJ+2K1NYhzB5uQ6g3/0sNu4zStfL36cZTn4G
 Tj/5ricj2hgfQ+l+eS6RmLZGI3wMi3XaFpJK4QyevWAUWGXpG+8+IrrR2M2vGO/WaY2j
 06kOSrs7BQ02FcGoSxVwY4Y7EVWZP+HNaqjt7FsByLXgpGrc4UhGxJVTHYWkqi5AxVKG
 M6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Wy4UHVoGJYMc6JPWv+2mNIeFyvDGmgZhediZKa2XN8=;
 b=ceoOK/b3kLwMoteZiiuxrSW7groFrmxsHZ7MnsqYyjDex9GIowEUPw58hEOp3y19F6
 1ayMj6k+VqW9AGt/7DfBHJw6sksrdQh2KMs464vXzNWCzKtTQ4WXpQgIuDrkoJcafG00
 IJH7uUnWkol/bzWNU4XtZjCKXi6LdFej1W/yVHPs53H0ySC88ovpbjKd1gSIwCBRmbyT
 Ar3HSYTKvDyEIpgez57S9CX3ZNPfQlq6sWlZCgqZ+mtJ628g71O8i0nZD585o2qUVspW
 9MkDH0Pxl5WroS/IV0stSlFdndPetiF+j4Yc2aldpfs7bGZ7E5krljzifM1OKG7k3rLQ
 xqzA==
X-Gm-Message-State: AOAM533bQ5qgedB9Ap3wXSdkhfJNg7xYxOULCQ6EkSy9njgbTliGlzP3
 uff/JSkP/gwSjrzfDkK8fj8=
X-Google-Smtp-Source: ABdhPJwTMev34l/tOOT1hIqqiOZeqMs4HI7B4xWJWyCz6tNcPG1i8dq09W+Eui9Pdru/3/5i2UUEzA==
X-Received: by 2002:adf:fe08:: with SMTP id n8mr2998894wrr.159.1602070684687; 
 Wed, 07 Oct 2020 04:38:04 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h4sm2538723wrv.11.2020.10.07.04.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 04:36:32 -0700 (PDT)
Subject: Re: [PULL 19/33] mips/cps: Use start-powered-off CPUState property
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
 <20200908051953.1616885-20-david@gibson.dropbear.id.au>
 <87h7r61j1j.fsf@linaro.org> <1ffe5f96-be5e-f151-a1fe-7c9f4f765b4d@amsat.org>
 <87eema1fem.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80772cc3-6a15-41ae-33a0-08ba694e00ac@amsat.org>
Date: Wed, 7 Oct 2020 13:36:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87eema1fem.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org, danielhb413@gmail.com, groug@kaod.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 12:47 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 10/7/20 11:28 AM, Alex Bennée wrote:
>>>
>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>
>>>> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>>>
>>>> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
>>>> start-powered-off property which makes cpu_common_reset() initialize it
>>>> to 1 in common code.
>>>>
>>>> Also change creation of CPU object from cpu_create() to object_new() and
>>>> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's not
>>>> possible to set a property after the object is realized.
>>>>
>>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>>> Message-Id: <20200826055535.951207-6-bauerman@linux.ibm.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> I've finally bisected the breakage in check-acceptance to this patch:
>>>
>>>   10:24:09 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966…)|BISECTING|✔ + ./tests/venv/bin/avocado run tests/acceptance/machine_mips_malta.py
>>>   /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arguments will be changed to boolean soon: sysinfo, output-check, failfast, keep-tmp and ignore-missing-references.
>>>     FutureWarning)
>>>   JOB ID     : 1a71a0a81cf9fb9a387d2ab105f8196a26cab84e
>>>   JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.24-1a71a0a/job.log
>>>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core: PASS (5.70 s)
>>>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '2-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores',
>>>   'logdir': '/home/alex.bennee/avocado/job-r... (28.91 s)
>>>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '3-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores',
>>>   'logdir': '/home/alex.bennee/avocado/job-r... (30.58 s)
>>>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | CANCEL 0
>>>   JOB TIME   : 70.12 s
>>>   10:25:27 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966…)|BISECTING|✔ 8 + make -j30
>>>   make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>>>   make[1]: Nothing to be done for 'all'.
>>>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>>>   Generating qemu-version.h with a meson_exe.py custom command
>>>   Compiling C object libqemu-mips64el-softmmu.fa.p/hw_mips_cps.c.o
>>>   Compiling C object libqemu-mips64-softmmu.fa.p/hw_mips_cps.c.o
>>>   Compiling C object libqemu-mipsel-softmmu.fa.p/hw_mips_cps.c.o
>>>   Compiling C object libqemu-mips-softmmu.fa.p/hw_mips_cps.c.o
>>>   Linking target qemu-system-mips
>>>   Linking target qemu-system-mips64el
>>>   Linking target qemu-system-mips64
>>>   Linking target qemu-system-mipsel
>>>   10:26:26 [alex.bennee@hackbox2:~/l/q/b/bisect] (a2c93f06…)|BISECTING|✔ + ./tests/venv/bin/avocado run tests/acceptance/machine_mips_malta.py
>>>   /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arguments will be changed to boolean soon: sysinfo, output-check, failfast, keep-tmp and ignore-missing-references.
>>>     FutureWarning)
>>>   JOB ID     : ccf294ef4e5ebdf19b3a0b53479d574df4ea54ea
>>>   JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.26-ccf294e/job.log
>>>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core: PASS (5.82 s)
>>>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores: PASS (15.16 s)
>>>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores: PASS (15.97 s)
>>>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>>   JOB TIME   : 40.01 s
>>
>> Using:
>>
>> -- >8 --
>> diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
>> index 2f7b2c9592..7c11fb3d44 100644
>> --- a/hw/misc/mips_cpc.c
>> +++ b/hw/misc/mips_cpc.c
>> @@ -38,6 +38,7 @@ static void mips_cpu_reset_async_work(CPUState *cs,
>> run_on_cpu_data data)
>>      MIPSCPCState *cpc = (MIPSCPCState *) data.host_ptr;
>>
>>      cpu_reset(cs);
>> +    cs->halted = 0;
>>      cpc->vp_running |= 1ULL << cs->cpu_index;
>>  }
> 
> That seems reasonable.
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Do you want to roll that into a proper patch or shall I apply directly
> into my testing/next tree?

I'll send a patch, thanks for testing!

