Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7149CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A5220899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNhwOrM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A5220899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqtw2-0005ZB-GN
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqtvC-0004Dj-4i
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:46:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqtv9-0006Qq-7N
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:46:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so25636234wmg.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0hGSARydtO2kyV7v4ykgH6wONKNeQV9cTDQGWJZOkT4=;
 b=bNhwOrM8KvuGHfn9onGgGEhsloPrqfIWYVS1zPUQ2dCoxJ3t2dBKIQSPqZMlB4vcg3
 U7X8IFsZV1MQqf2jbdt6YjBlk7mzAKLNjlikN5LDw1dq2oMGr4BDDU48CCwWyCkaEoHu
 gbbV78obteyFzEJjr4mLscXyc6DT6exzCYX8r/TVlXxScf9dryuzn4AKw1cGOv0OT16H
 UiyD6lZL6scSQ2tqKf9ndHu2a4/t/0Z2nMCyQlSb1zmHbibfGsLXGyMehNkMl4puMKbb
 mdlFzNSHOi5gZMjYJjQEDmc0JAkFewyxPGQGx2KkzKx2p3EAXsXnVwmS4iiwVC/jn281
 7Hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0hGSARydtO2kyV7v4ykgH6wONKNeQV9cTDQGWJZOkT4=;
 b=MXE/4pFJkAYFXmqk63xyiszWOCyW3iuZXcwHSfAgrI/iGQqMFEKyTuIdW9/CKOhLIg
 V5WVMZ38PO9V85v2p6GyAYl5bKfwNgqFXCaE5UQcRl4IxcABB+ow948+MrIlwXYKZZ0d
 STZ8jFkVYpHMmhoJYZwq3aTE6tkUaxUq1hgsDfMLOxtk/NA4Jwkpi+XEmDCAKX/FpVe4
 q4Z7pqnoRj1Y0Dd2kqv5+AI3fmx3xcCOslGxPnCy/k4PHShj+QvwOUuXL6HWQrakqIr4
 GbhEGIfOSPfpS+NiQa09hJWYRvP/iRXbelx0JnXxNmPRpTMKu+HPHiEKxb0E2HDH6Gqz
 sCHg==
X-Gm-Message-State: AOAM532lPDxlUH4JhpVZCrJGbgdyr8/t6WgDAE3F3FqZoAAkV27HWstv
 wze1ka0Js+LufKRpnu1oHjYswA==
X-Google-Smtp-Source: ABdhPJwMVDLVdbXALDIt3HFQQ4C6ER/hbrJqQE4NE57mj6DUhnEziy8ufYYD87Mhrfrylv/n0+lyMQ==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr30334257wma.20.1593675969291; 
 Thu, 02 Jul 2020 00:46:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n125sm10073536wme.30.2020.07.02.00.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 00:46:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 47DBC1FF7E;
 Thu,  2 Jul 2020 08:46:07 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-29-alex.bennee@linaro.org>
 <CAHiYmc7tXuRiS51-pyoj6NoJppbkcObzcEggvAav2GWqwMoYgQ@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v4 28/40] tests/acceptance: skip multicore mips_malta
 tests on GitLab
In-reply-to: <CAHiYmc7tXuRiS51-pyoj6NoJppbkcObzcEggvAav2GWqwMoYgQ@mail.gmail.com>
Date: Thu, 02 Jul 2020 08:46:07 +0100
Message-ID: <87eepuqs00.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?utf-8?Q?Daniel_P=2E_Berra?= =?utf-8?Q?ng=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G . Cota" <cota@braap.org>, Cleber Rosa <crosa@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> On Wed, Jul 1, 2020 at 4:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> For some reason these tests fail all the time on GitLab. I can
>> re-create the hang around 3% of the time locally but it doesn't seem
>> to be MTTCG related. For now skipIf on GITLAB_CI.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> ---
>
> Alex,
>
> Thanks for having this test at all. I will review its content, but
> here is my stupid question:
>
> How can I, as a regular developer, repro the test in question? I am
> not familiar with GitLab at all.

To run the acceptance tests you just run:

  make check-acceptance

To run the individual test:

  ./tests/venv/bin/avocado run tests/acceptance/machine_mips_malta.py:Malta=
MachineFramebuffer.test_mips_malta_i64
00_framebuffer_logo_8cores

I used my retry.py script to just loop running the test for 100 times to
calculate the failure rate.

>
> Thanks,
> Aleksandar
>
>>  tests/acceptance/machine_mips_malta.py | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/m=
achine_mips_malta.py
>> index 92b4f28a112..7c9a4ee4d2d 100644
>> --- a/tests/acceptance/machine_mips_malta.py
>> +++ b/tests/acceptance/machine_mips_malta.py
>> @@ -15,6 +15,7 @@ from avocado import skipUnless
>>  from avocado_qemu import Test
>>  from avocado_qemu import wait_for_console_pattern
>>  from avocado.utils import archive
>> +from avocado import skipIf
>>
>>
>>  NUMPY_AVAILABLE =3D True
>> @@ -99,6 +100,7 @@ class MaltaMachineFramebuffer(Test):
>>          """
>>          self.do_test_i6400_framebuffer_logo(1)
>>
>> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>> @@ -108,6 +110,7 @@ class MaltaMachineFramebuffer(Test):
>>          """
>>          self.do_test_i6400_framebuffer_logo(7)
>>
>> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>> --
>> 2.20.1
>>


--=20
Alex Benn=C3=A9e

