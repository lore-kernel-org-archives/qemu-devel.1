Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26052C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DBE20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="looBZ67K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DBE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94py-0003O1-Qm
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j94jY-0002Nt-AU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j94jX-0004Is-3r
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:25:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j94jW-0004Hh-T4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:25:03 -0500
Received: by mail-wm1-x342.google.com with SMTP id e26so2229342wme.5
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Dq5HjRPAOPFeInJyforsQRkAZHEDMVB0NjPMzpNnlzQ=;
 b=looBZ67KGbt7TdilagYxG7bUmVruJB/sRGLDcP8aXfSR1NpkA52KWK4M77C0NQWXUx
 uYhRoYvRpt+zzgAg5c+s5H3FORb5yOPaEhZcBLTql3dgk47tCqmCXZMJI9cImCjw4zyu
 v0imqiujAwK6eiEacjv+podoaGy1E2LrM0Fp2QrgPSaPSU2yMVcfXE1iPYFxfvM3qgF0
 /p8Qgf689bVk0RBdVJC/M051/GUsDHEtLgerohb0R0Oryx4+FjDSJQomYy+j7Dz1aIkO
 85knd0jbC9DMBYEGuX2UDQVAAEosRAEWRzMfKE0T42DoGlbgmMBuqp82LMkTvgfsVK6U
 7JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Dq5HjRPAOPFeInJyforsQRkAZHEDMVB0NjPMzpNnlzQ=;
 b=ZBH9ITfh3gOYbncXB3bbNNuF9t5if7NeMRAt6DN3iN+/HNAiNdD4LDng++EFcuz8b9
 G5AsLd3RLsbpf+hhZqnsPrTCG2Veru1iFTGU/oVBt9YaPjuZWeQXcvWOZEoxIqRRGiQK
 gZtHne6a8iELmcg5waBBZw28z3gJa8jxZ4XLSAJhcSr72Ht2KmDtWpWJLuAPDMq35HLy
 Fz2PL4jeuqnnRM24X+rz6D5tGLylpWa1fnKSEbXDkRvAT1bk9Uf67WI+Byd1FSkdTFUT
 IOq4agvNczGo1yNfGakYwW1R37ku+VUaNEFW0hNyZEfOjE6PTd2cNoCwJkQEbklCHvSF
 vxqg==
X-Gm-Message-State: ANhLgQ0x60xiEz02zlB8m5tZrgtMx9K9Bj/MMLGbrxPU67QtYIIPXGeN
 U/mxuYPo3P9EvqY1nZProbp3Vw==
X-Google-Smtp-Source: ADFU+vv1N17YrjXjZSkWlQAT2EF9wyPml7nNvChziYZZ05NEe8WM8peJYVHQlvfbdIlo+vKD14dvLw==
X-Received: by 2002:a1c:e91a:: with SMTP id q26mr3652548wmc.103.1583231098098; 
 Tue, 03 Mar 2020 02:24:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d203sm3044612wmd.37.2020.03.03.02.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 02:24:56 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56BF61FF87;
 Tue,  3 Mar 2020 10:24:56 +0000 (GMT)
References: <20200302232220.761-1-philmd@redhat.com>
 <CAL1e-=jLe0zPCkCOYY_XXgVqAhAdAuiPqzn57mYv8YvVwDRihA@mail.gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to test
 itself
In-reply-to: <CAL1e-=jLe0zPCkCOYY_XXgVqAhAdAuiPqzn57mYv8YvVwDRihA@mail.gmail.com>
Date: Tue, 03 Mar 2020 10:24:56 +0000
Message-ID: <87y2sh7n2f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> 12:22 AM Uto, 03.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=
 =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> It appears ignore the decoration if just applied to the class.
>>
>> Fixes: 0484d9d4fbe9beacd
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> [PMD: Move decorations to each test function]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Alex, please accept this most complete version. Many thanks,
> Aleksandar

Queued to testing/next, thanks.

>
>>  tests/acceptance/machine_mips_malta.py | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/acceptance/machine_mips_malta.py
> b/tests/acceptance/machine_mips_malta.py
>> index 92b4f28a11..98463f7757 100644
>> --- a/tests/acceptance/machine_mips_malta.py
>> +++ b/tests/acceptance/machine_mips_malta.py
>> @@ -30,8 +30,6 @@
>>      CV2_AVAILABLE =3D False
>>
>>
>> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>  class MaltaMachineFramebuffer(Test):
>>
>>      timeout =3D 30
>> @@ -91,6 +89,8 @@ def do_test_i6400_framebuffer_logo(self,
> cpu_cores_count):
>>              cv2.imwrite(debug_png, screendump_bgr)
>>          self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
>>
>> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>      def test_mips_malta_i6400_framebuffer_logo_1core(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>> @@ -99,6 +99,8 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
>>          """
>>          self.do_test_i6400_framebuffer_logo(1)
>>
>> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>> @@ -108,6 +110,8 @@ def
> test_mips_malta_i6400_framebuffer_logo_7cores(self):
>>          """
>>          self.do_test_i6400_framebuffer_logo(7)
>>
>> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>>          """
>>          :avocado: tags=3Darch:mips64el
>> --
>> 2.21.1
>>
>>


--=20
Alex Benn=C3=A9e

