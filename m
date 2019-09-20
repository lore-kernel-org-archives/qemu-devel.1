Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9929C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857DA206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEoveNRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857DA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIfV-0007Wt-NA
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iBIYQ-0001Q1-W4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iBIYP-0000Vk-Gz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:02:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iBIYP-0000VQ-8u
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:02:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id p7so2391220wmp.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1ICezypSQPPh/OzwVANjih9Z1HhpS5ok1r5PaIeBYnw=;
 b=YEoveNRO7AtNVGQ9xZFB9U1bYgGvXyKImqbRWQQ6OP6gps5EMjBx94NJYsSMfmdYYg
 rsSJrE+u+xNrAgRRwWIeb30zn55ULN5pO3nCokDgwaUmWuFw3VuCmcvKdaEEJ2Pyq5n6
 He8x5JU0I3A53eAvwhAqfZe6ZQpUqYp81fNX69AbHqubY8PQBytLTSgr5cAZXlm7T+ab
 qGahrIzXBAFa+beszY0TfsnEsRkzKm4CePmVoHB+cJjzs4B5lZLOb77QaQaJ15QMoEE7
 CKP60xmxEK7nsTR+QK37nan65cJlDuiEzfMC/yqQtwJ7ID8lme8fmO66L2uOUv+3gvuC
 jgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1ICezypSQPPh/OzwVANjih9Z1HhpS5ok1r5PaIeBYnw=;
 b=pZ2uEhjLJu5QVp89oHNqaPrtDS5cf73t9SZucAUhH6m+xDyjQeekZzJn9iO6Evub/r
 EMrfbZzKJZwjNPFFGQkPl74UwQjvdByukubCA+RDOsvjvOusd08YuBCtbXc2ZhbKu5BN
 hSCDTd7NsxGfbMi9yOcJ3zlden5v9jUy03Nf02MLq/oD39/JhAOdqXj7Cxialsg4yKVm
 MvOrMs1ttOzr+nd8OxaHEIznepE2kf3x08P6wRRAc3k/CEf818XLYnZVw1LB4fYqKyTb
 Pt8ek4AJPm+7Faf3Xg8/YDAe0uq+QPoX5+z4gv700cVyYbIcg9ohudCjsaof/ab+p2lB
 OZkQ==
X-Gm-Message-State: APjAAAUhBxbZLHpzxMMhSiol402kYXCWrl+5MxD56x0YuvHN4tT/M2+9
 Q8xC99BsoGhWrQflY7KI5wgbpiZM4+A=
X-Google-Smtp-Source: APXvYqwIftgAuSMhMxQXo8Ef/OgOWp7DWh7YW5Lg296prkEh/nk4+gsUaUyUrEs5ZxD7E1FVB7t+GQ==
X-Received: by 2002:a1c:3cc3:: with SMTP id j186mr3305593wma.119.1568984547578; 
 Fri, 20 Sep 2019 06:02:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z142sm3463237wmc.24.2019.09.20.06.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 06:02:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 929E01FF87;
 Fri, 20 Sep 2019 14:02:25 +0100 (BST)
References: <20190919092829.15393-1-david@redhat.com>
 <5cbd350c-0fb6-2b6b-e64b-04bd7f7f0b65@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] tests/tcg: target/s390x: Test MVC
In-reply-to: <5cbd350c-0fb6-2b6b-e64b-04bd7f7f0b65@redhat.com>
Date: Fri, 20 Sep 2019 14:02:25 +0100
Message-ID: <87ftkryvby.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 19.09.19 11:28, David Hildenbrand wrote:
>> Let's add a test that especially verifies that no data will be touched
>> in case we cross page boundaries and one page access triggers a fault.
>>
>> Before the fault-safe handling fixes, the test failes with:
>>       TEST    mvc on s390x
>>     data modified during a fault
>>     make[2]: *** [../Makefile.target:116: run-mvc] Error 1
>>
>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  tests/tcg/s390x/Makefile.target |   1 +
>>  tests/tcg/s390x/mvc.c           | 109 ++++++++++++++++++++++++++++++++
>>  2 files changed, 110 insertions(+)
>>  create mode 100644 tests/tcg/s390x/mvc.c
>>
>> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.=
target
>> index 6a3bfa8b29..241ef28f61 100644
>> --- a/tests/tcg/s390x/Makefile.target
>> +++ b/tests/tcg/s390x/Makefile.target
>> @@ -7,3 +7,4 @@ TESTS+=3Dexrl-trt
>>  TESTS+=3Dexrl-trtr
>>  TESTS+=3Dpack
>>  TESTS+=3Dmvo
>> +TESTS+=3Dmvc
>> diff --git a/tests/tcg/s390x/mvc.c b/tests/tcg/s390x/mvc.c
>> new file mode 100644
>> index 0000000000..aa552d52e5
>> --- /dev/null
>> +++ b/tests/tcg/s390x/mvc.c
>> @@ -0,0 +1,109 @@
>> +#include <stdint.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <sys/mman.h>
>> +#include <signal.h>
>> +#include <setjmp.h>
>> +
>> +jmp_buf jmp_env;
>> +
>> +static void handle_sigsegv(int sig)
>> +{
>> +    siglongjmp(jmp_env, 1);
>> +}
>> +
>> +#define ALLOC_SIZE (2 * 4096)
>> +
>> +static inline void mvc_256(const char *dst, const char *src)
>> +{
>> +    asm volatile (
>> +        "    mvc 0(256,%[dst]),0(%[src])\n"
>> +        :
>> +        : [dst] "d" (dst),
>> +          [src] "d" (src)
>> +        : "memory");
>> +}
>> +
>> +int main(void)
>> +{
>> +    char *src, *dst;
>> +    int i;
>> +
>> +    /* register the SIGSEGV handler */
>> +    if (signal(SIGSEGV, handle_sigsegv) =3D=3D SIG_ERR) {
>> +        fprintf(stderr, "SIGSEGV not registered\n");
>> +        return 1;
>> +    }
>> +
>> +    /* prepare the buffers - two consecutive pages */
>> +    src =3D valloc(ALLOC_SIZE);
>> +    dst =3D valloc(ALLOC_SIZE);
>> +    memset(src, 0xff, ALLOC_SIZE);
>> +    memset(dst, 0x0, ALLOC_SIZE);
>> +
>> +    /* protect the second pages */
>> +    if (mprotect(src + 4096, 4096, PROT_NONE) ||
>> +        mprotect(dst + 4096, 4096, PROT_NONE)) {
>> +        fprintf(stderr, "mprotect failed\n");
>> +        return 1;
>> +    }
>> +
>> +    /* fault on second destination page */
>> +    if (sigsetjmp(jmp_env, 1) =3D=3D 0) {
>> +        mvc_256(dst + 4096 - 128, src);
>> +        fprintf(stderr, "fault not triggered\n");
>> +        return 1;
>> +    }
>> +
>> +    /* fault on second source page */
>> +    if (sigsetjmp(jmp_env, 1) =3D=3D 0) {
>> +        mvc_256(dst, src + 4096 - 128);
>> +        fprintf(stderr, "fault not triggered\n");
>> +        return 1;
>> +    }
>> +
>> +    /* fault on second source and second destination page */
>> +    if (sigsetjmp(jmp_env, 1) =3D=3D 0) {
>> +        mvc_256(dst + 4096 - 128, src + 4096 - 128);
>> +        fprintf(stderr, "fault not triggered\n");
>> +        return 1;
>> +    }
>> +
>> +    /* restore permissions */
>> +    if (mprotect(src + 4096, 4096, PROT_READ | PROT_WRITE) ||
>> +        mprotect(dst + 4096, 4096, PROT_READ | PROT_WRITE)) {
>> +        fprintf(stderr, "mprotect failed\n");
>> +        return 1;
>> +    }
>> +
>> +    /* no data must be touched during the faults */
>> +    for (i =3D 0; i < ALLOC_SIZE; i++) {
>> +        if (src[i] !=3D 0xff || dst[i]) {
>> +            fprintf(stderr, "data modified during a fault\n");
>> +            return 1;
>> +        }
>> +    }
>> +
>> +    /* test if MVC works now correctly accross page boundaries */
>> +    mvc_256(dst + 4096 - 128, src + 4096 - 128);
>> +    for (i =3D 0; i < ALLOC_SIZE; i++) {
>> +        if (src[i] !=3D 0xff) {
>> +            fprintf(stderr, "src modified\n");
>> +            return 1;
>> +        }
>> +        if (i < 4096 - 128 || i >=3D 4096 + 128) {
>> +            if (dst[i]) {
>> +                fprintf(stderr, "wrong dst modified\n");
>> +                return 1;
>> +            }
>> +        } else {
>> +            if (dst[i] !=3D 0xff) {
>> +                fprintf(stderr, "wrong data moved\n");
>> +                return 1;
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>>
>
> I'll send this along with the updated pull request of
>
> "[PULL SUBSYSTEM s390x 00/29] s390x/tcg: mem_helper: Fault-safe
> handling"

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e

