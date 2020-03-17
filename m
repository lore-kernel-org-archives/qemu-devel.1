Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC9C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2007120663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGFH1U15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Y6-0001yQ-0B
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9To-0004IS-T7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9Tn-0000SV-IF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:29:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22481)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9Tn-0000Mi-CY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584440987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=druU3B9TDUPa45d+I7yG2jBUIQy72LLiJic5ErdHDw8=;
 b=OGFH1U15FrVETzau0z1pUEjmJCkh4lvEU6XllNzAf4wTAduchJSgT4jTyBR0/YiBmKYusG
 PXKzkTO7XybmP/Q8PkW4bYoQyFKRJkgTm3aeJ15eIwMauWY3dEX0KZF2xSCUcve16dz7aP
 w27JqM7KdJkaKrt3aE1+hLctkH5K1CE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-MMt5o9v7NWSfgs7acjr_sw-1; Tue, 17 Mar 2020 06:29:43 -0400
X-MC-Unique: MMt5o9v7NWSfgs7acjr_sw-1
Received: by mail-wm1-f71.google.com with SMTP id r23so6978992wmn.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H/8EZFhA7VwCljRZso0Aa26Buw6kJJKPtM+QE3Y9nQg=;
 b=bAW5qQuzUsVKfR3wUh8wryPGRT7DabWD6JQraFWbugTaGlhG/DUgx5kVImOjeC71LM
 KOZrqGPHyDqh8b2f2SdIdvgbFGOuel3HLo2XEZIUs9DJGYk/zfPYt/AkRIi6i6cPzedx
 kfQGc3tsAmJah/9OWMYUrKFpaArmQpb9bdsU7TPkoKOsfYbByFQrkkGIISLmPgvZWH7V
 bD3OQUknV3YZ9wbTmuTAIzvuo1I0nF5PMhoTybJfB0m5eT+dJXiIbg7rVaCG8+2rGK51
 kuS2P2OmIf2OQtJLOi+dmNNGGM5WZPsxkezYET8uE1qRfVLhFzmdYxjpbsIhVhlRhw+A
 AbQg==
X-Gm-Message-State: ANhLgQ0yE+xQgWpnB85Ksb/vvU9wF70IgBqwMUOf61HsVkm6p298k632
 bs3OU3Ig7B9f3gHi48RawlLpA/ciAcsRZ4zPEY5WExtu+plTbvNhfVRTL9isWA+PzQf02y2ZQ6B
 nlrAe23jDnt1833Q=
X-Received: by 2002:a05:6000:18f:: with SMTP id
 p15mr5633264wrx.149.1584440981797; 
 Tue, 17 Mar 2020 03:29:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsv4vjdt8yuQ2Wj7bsXfgf0+gSPg1wLOQb+1btELiSbhNJbhIj8oGEe81kUKv76pWXZgOt32w==
X-Received: by 2002:a05:6000:18f:: with SMTP id
 p15mr5633249wrx.149.1584440981624; 
 Tue, 17 Mar 2020 03:29:41 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id r1sm3465811wmh.0.2020.03.17.03.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:29:41 -0700 (PDT)
Subject: Re: [PATCH v1 24/28] tests/tcg/aarch64: add SVE iotcl test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-25-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
Date: Tue, 17 Mar 2020 11:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316172155.971-25-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> This is a fairly bare-bones test of setting the various vector sizes
> for SVE which will only fail if the PR_SVE_SET_VL can't reduce the
> user-space vector length by powers of 2.
>=20
> However we will also be able to use it in a future test which
> exercises the GDB stub.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> ---
> v3
>    - use index to fill zreg
>    - CROSS_CC_HAS_SVE
> v5
>    - merge conflicts
> v6
>    - drop id check
> ---
>   tests/tcg/aarch64/sve-ioctls.c    | 70 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  4 ++
>   2 files changed, 74 insertions(+)
>   create mode 100644 tests/tcg/aarch64/sve-ioctls.c
>=20
> diff --git a/tests/tcg/aarch64/sve-ioctls.c b/tests/tcg/aarch64/sve-ioctl=
s.c
> new file mode 100644
> index 00000000000..9544dffa0ee
> --- /dev/null
> +++ b/tests/tcg/aarch64/sve-ioctls.c
> @@ -0,0 +1,70 @@
> +/*
> + * SVE ioctls tests
> + *
> + * Test the SVE width setting ioctls work and provide a base for
> + * testing the gdbstub.
> + *
> + * Copyright (c) 2019 Linaro Ltd
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <sys/prctl.h>
> +#include <asm/hwcap.h>
> +#include <stdio.h>
> +#include <sys/auxv.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP_CPUID
> +#define HWCAP_CPUID (1 << 11)
> +#endif
> +
> +#define SVE_MAX_QUADS  (2048 / 128)
> +#define BYTES_PER_QUAD (128 / 8)
> +
> +#define get_cpu_reg(id) ({                                      \
> +            unsigned long __val;                                \
> +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
> +            __val;                                              \
> +        })
> +
> +static int do_sve_ioctl_test(void)
> +{
> +    int i, res, init_vq;
> +
> +    res =3D prctl(PR_SVE_GET_VL, 0, 0, 0, 0);
> +    if (res < 0) {
> +        printf("FAILED to PR_SVE_GET_VL (%d)", res);
> +        return -1;
> +    }
> +    init_vq =3D res & PR_SVE_VL_LEN_MASK;
> +
> +    for (i =3D init_vq; i > 15; i /=3D 2) {
> +        printf("Checking PR_SVE_SET_VL=3D%d\n", i);
> +        res =3D prctl(PR_SVE_SET_VL, i, 0, 0, 0, 0);
> +        if (res < 0) {
> +            printf("FAILED to PR_SVE_SET_VL (%d)", res);
> +            return -1;
> +        }
> +        asm("index z0.b, #0, #1\n"
> +            ".global __sve_ld_done\n"
> +            "__sve_ld_done:\n"
> +            "mov z0.b, #0\n"
> +            : /* no outputs kept */
> +            : /* no inputs */
> +            : "memory", "z0");
> +    }
> +    printf("PASS\n");
> +    return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    /* we also need to probe for the ioctl support */
> +    if (getauxval(AT_HWCAP) & HWCAP_SVE) {
> +        return do_sve_ioctl_test();
> +    } else {
> +        printf("SKIP: no HWCAP_SVE on this system\n");
> +        return 0;
> +    }
> +}
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index b61b53e4dd1..c879932ff6c 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -47,6 +47,10 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
>   AARCH64_TESTS +=3D sysregs
>   sysregs: CFLAGS+=3D-march=3Darmv8.1-a+sve
>  =20
> +# SVE ioctl test
> +AARCH64_TESTS +=3D sve-ioctls
> +sve-ioctls: CFLAGS+=3D-march=3Darmv8.1-a+sve
> +
>   ifneq ($(HAVE_GDB_BIN),)
>   GDB_SCRIPT=3D$(SRC_PATH)/tests/guest-debug/run-test.py
>  =20
>=20


