Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2A32072A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZ2evanM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2A32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8q17-0000JJ-VS
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8q0M-00088d-El
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8q0L-000677-3y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:41:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8q0K-00066x-T1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:41:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id u9so158987wml.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=D8odA5Cz2P8+ZaWmgwDllv2ke3/fWMW52bygOufItCY=;
 b=LZ2evanMQ8ZjSlTtVpewpGmDxoaD5ac54zM3DZ79wjxZ1wXtjQWY5+AH/TP7vaq5Yk
 LCiOcFzcCDOc6v4y5053C8EOFbAnBH0sSM1HlIu4PSjzSCj9gFib90OeyRFxAXR/0ob7
 hRiXuYfl6DLJ275aK8AM6JQBTz1ZgzHTvN4dEQ0IulILWVpDc6uRvrl72dnsUOC9+Kem
 /cUuXZ1BsDkJTdujANfSLhvtC0HWYvZfdNeZTjvo2K5LF0VZlPheKASrxfEVaml+L6IE
 KxH6QAT7RwS8hkGHxddj8XqNlfWn1K54NacqOn9IYyubZguhoy/4QKlBlVS8VFrk7nU9
 Io7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=D8odA5Cz2P8+ZaWmgwDllv2ke3/fWMW52bygOufItCY=;
 b=Dg6IpbgVzwfv8urKIFRxBD0z1IPm2ELbAMoUn5aZtJlEb6hPHR+29tt1xOOPXfRCRU
 7DiQJfHSPyOdTERBWHE5g6ZED2FaIhBjG+X9r3Jm4dfwXs/ZrKFMt974CUhpR++i8NNu
 bwDxeZ+v3zmVa4LHEBAkiz6pEU/V7cLDK5ZhFN071+N/ykyoY4VQob5xFd+buHDDvFR6
 rVA/nIfnHjMjevro8ZAW9geB3ozCbd7QIWI0F+Cn5oaNexS5dOTWp4hye5hDIcoDpqWM
 5g2lhb3n/EnQNf/9PFtY4xZgSsjvJ5hxn2VqUBEOrOTfbWVVPJrRDIE8PVHk0Vx4JDWJ
 R5TA==
X-Gm-Message-State: ANhLgQ2LIHzhqPr6NKcYQR66zETROtJyi9zFfVyBIp6EmQ6Js1L9DOpq
 vZ2eda5JOycbFVzmj34ntvN2Dg==
X-Google-Smtp-Source: ADFU+vs0L2aU3bMk3e/7pe1c+3djLx35+fIlpIu23h/omi/baFcMGJSnzdEIfa5mDHp+189mqhjJEw==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr391204wmc.134.1583174483561; 
 Mon, 02 Mar 2020 10:41:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a70sm378574wme.28.2020.03.02.10.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:41:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CFEA01FF87;
 Mon,  2 Mar 2020 18:41:21 +0000 (GMT)
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-2-alex.bennee@linaro.org>
 <2f430da1-6429-746c-92e0-58b1fed5ffcb@redhat.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 01/10] tests/vm: use $(PYTHON) consistently
In-reply-to: <2f430da1-6429-746c-92e0-58b1fed5ffcb@redhat.com>
Date: Mon, 02 Mar 2020 18:41:21 +0000
Message-ID: <877e028ur2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 qemu-devel@nongnu.org, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/2/20 7:18 PM, Alex Benn=C3=A9e wrote:
>> From: Robert Foley <robert.foley@linaro.org>
>> Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
>> consistent with other cases like vm-build.
>
> So what you are trying to fix here is when you have two python3
> installed (one from the distribution and one manually built), and you=20
> want to use the manually built?

No - just consistency with the rest of the build system.=20

>
>> Signed-off-by: Robert Foley <robert.foley@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
>> ---
>>   tests/vm/Makefile.include | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
>> index 9e7c46a4735..778e5067554 100644
>> --- a/tests/vm/Makefile.include
>> +++ b/tests/vm/Makefile.include
>> @@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
>>     vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>>   	$(call quiet-command, \
>> -		$(SRC_PATH)/tests/vm/$* \
>> +		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>>   		$(if $(J),--jobs $(J)) \
>>   		--image "$<" \
>>   		--interactive \
>>=20


--=20
Alex Benn=C3=A9e

