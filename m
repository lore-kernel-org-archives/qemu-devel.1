Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F3C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081882166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5TLUiqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081882166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0Lj-0006uU-AV
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 04:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw0LH-0006UK-3M
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw0LG-0003BS-6r
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:33:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw0LG-0003Ap-0G
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:33:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id p77so5699082wme.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IVQ1O09GLzqr469rc+nuIgkNwbp/rpG4p3VYloBf89E=;
 b=L5TLUiqjVELWjrmiImarzHPbCg3S9zhZicpm/qQqtVowHTNren4wHXHZCjWcMYQfor
 kC/l9NWl7vITDsd+hT2DnW+JR9ZGkwrPPPUg5+37X4J0RPqumy4+WKEzvfJxjQm7IC+6
 1mrV1rOTOwK65anK6w+uNH+aOgITQ4Bh/8IDRgxO6TZ4ZP4uOuW6AUXRZi4C7yzXirbc
 nWCjxqpvnyZ0/dQYmbDqWZtVafZDSusMrDbpLzCMASdSPttMwPaGxTlp7tIbZWvmADE8
 tTjav9B4mTlCqjEpzKVmgV9DSiKsu68RC5G21EUaOhafvFxq9XlmE+Jv3jpYMtpkYJMD
 8f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IVQ1O09GLzqr469rc+nuIgkNwbp/rpG4p3VYloBf89E=;
 b=QLRKk5IS6cU+3+9fhjd/JJ7i9i5TqitAeS639VL3B9nFoYK8OvU3iMXMtgxnWzNdGL
 1bgWopRgC6ITjqm7LdDAHImTEGKRxAtfexVOAtNjVO5qLwgSRvbNCpuWv6ltk1qKEN10
 NggyHlpG4ka7qW4cOgz1xL8nVVen/+8eOFK/VYU1fMAvcn4IHJKh8A+Go888DQyB4Mfk
 iZatosuRjqpEOJ0lZpwi1h+MqQCNOz36Y7ZZZnqWvsIKCFTw3DFJ4jaA/+641tSorDMB
 33bEmSlhR/w0/pAe/4+zm10FXvWRSAzCQEtgsm02m6YaNfwQA7BHCKIJ5NVpWE9YV1b3
 bHQw==
X-Gm-Message-State: APjAAAW/I0PQOKNec4spt+hD4pNUF+VCTPzBxF3xWvyOiOGc9yK3wUz/
 nYToV988V3DR1oSDZ6pb702yug==
X-Google-Smtp-Source: APXvYqzWPfdQf4Vf2Dn9UC5tsWq61oTkoFV2KZkfXzTpeOj6G2/btk7dnafze/+pqI2JvR8Dp3HmtA==
X-Received: by 2002:a1c:c00e:: with SMTP id q14mr9124080wmf.142.1565339620636; 
 Fri, 09 Aug 2019 01:33:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v23sm6190717wmj.32.2019.08.09.01.33.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 01:33:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92DA31FF87;
 Fri,  9 Aug 2019 09:33:39 +0100 (BST)
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-6-alex.bennee@linaro.org>
 <0dd4b130-dfe2-6a0b-fdd1-e265e9004ec9@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <0dd4b130-dfe2-6a0b-fdd1-e265e9004ec9@linaro.org>
Date: Fri, 09 Aug 2019 09:33:39 +0100
Message-ID: <871rxuivq4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 5/7] target/mips: rationalise softfloat
 includes
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/8/19 9:41 AM, Alex Benn=C3=A9e wrote:
>> index 21c0615e020..f146924623c 100644
>> --- a/target/mips/cpu.h
>> +++ b/target/mips/cpu.h
>> @@ -5,7 +5,8 @@
>>
>>  #include "cpu-qom.h"
>>  #include "exec/cpu-defs.h"
>> -#include "fpu/softfloat.h"
>> +#include "fpu/softfloat-types.h"
>> +#include "fpu/softfloat-helpers.h"
>
> Do you really need softfloat-helpers.h here?
> It appears as if this is only needed by target/mips/internal.h

I've moved the helper to internal.h which somehow gets auto-magically
included for cpu_loop.c for linux-user.

>
>
> r~


--
Alex Benn=C3=A9e

