Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5B5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB18206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeCIrqL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB18206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8nS-0000SX-16
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic8R1-0004jL-5b
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic8Qi-0000tC-GM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:41:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic8Qg-0000rD-5q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:41:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id g206so3005484wme.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 05:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tPC/W10EVua89TnzTtuDQj/3TF3e8ybTN5z8+oumMyc=;
 b=jeCIrqL2pKBOMLR0rtfMd5cA05VsHj6NdXdLXoezgAShTsmFYslFXfE8D/sBv41qoa
 5++/LGfMaS6xgsYxfVt2O/18pIQ3BsWz61dzbWuUFwk7HBxlYq00h39gN+9G6+imqGwI
 nIUG/4EnmuKQgR0iEC8tAsF32OmnqG5D94Mf1Fc1NLyyvJuQfKYotAm4bm4Hm2+SmnPn
 yTkh/6MgWyh5sAB4vuFf9h44xbTrGrt73Xhzo61muWvwGO0aDZ/BdR/6rr0NXmTWQg3n
 q4UX2hSBzIHSdfaVSteY+iSa8NKpx76VNp+mPkaZ9mCFD5hQQ3Kg9XgqDIAOgbpUm0Rd
 bPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tPC/W10EVua89TnzTtuDQj/3TF3e8ybTN5z8+oumMyc=;
 b=kE6G9nR1/m8RJyBTepOxse1SFTIAWqrU5CHeNyHwnQZnI/K8VtXpMIsUTS7jolzGoO
 BIiKiqG0Z3KdwW8f2lfxFH5VnpbG9qn/OHrBMW72F7LMVpElvCkmcwZBFZfKiV6/tfRo
 4RiPyGy2NjPY+BxYpa7rXVpSobzjlksZOTl6SDvAAGkBiZIXdTH7M/DDx72c2zpD/hw0
 a3+cLaxZGsaSxACKpo32/ui7MPRwtbBHBDow0zAKSpl1loCw29L7L/qRiFXjhT4bPjzy
 HiORdtpAT99sdgkks8JwSIP7KkQT6ihNunX8g9gXYiO5+qGID8VBxsHWjHSWPUfQ27NI
 UCTQ==
X-Gm-Message-State: APjAAAVjCsIRm84NWbL16zAXYvVCSyLJzvoU6B42QZl1TxEdoiUMifaR
 55a5VQxTQaULrfCqA+6hsFaKZQ==
X-Google-Smtp-Source: APXvYqy+I15y14xe93qBgWE7AsbYOlcUcQpSQvPBZhnDOz41bCzmPTxxcEM9cvHUlAZKoXrBL04bUQ==
X-Received: by 2002:a7b:c004:: with SMTP id c4mr33765904wmb.45.1575380482370; 
 Tue, 03 Dec 2019 05:41:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x125sm3172070wmx.43.2019.12.03.05.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 05:41:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7939B1FF87;
 Tue,  3 Dec 2019 13:41:20 +0000 (GMT)
References: <20190818231827.27573-1-philmd@redhat.com>
 <20190818231827.27573-4-philmd@redhat.com>
 <20190820133113.GA4422@dhcp-17-173.bos.redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/docker: Add test-acceptance runner
In-reply-to: <20190820133113.GA4422@dhcp-17-173.bos.redhat.com>
Date: Tue, 03 Dec 2019 13:41:20 +0000
Message-ID: <87d0d5bk73.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> On Mon, Aug 19, 2019 at 01:18:26AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Add a runner script to be able to run acceptance tests within
>> Docker images. We can now reproduce Travis CI builds locally (and
>> debug  them!).
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  tests/docker/test-acceptance | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100755 tests/docker/test-acceptance
>>=20
>> diff --git a/tests/docker/test-acceptance b/tests/docker/test-acceptance
>> new file mode 100755
>> index 0000000000..84edaa676c
>> --- /dev/null
>> +++ b/tests/docker/test-acceptance
>> @@ -0,0 +1,21 @@
>> +#!/bin/bash -e
>> +#
>> +# Compile default Travis-CI target and run Avocado acceptance tests
>> +#
>> +# Copyright (c) 2019 Red Hat Inc.
>> +#
>> +# Authors:
>> +#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2
>> +# or (at your option) any later version. See the COPYING file in
>> +# the top-level directory.
>> +
>> +. common.rc
>> +
>> +cd "$BUILD_DIR"
>> +
>> +DEF_TARGET_LIST=3D"x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64=
-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>> +TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>> +build_qemu
>> +check_qemu check-acceptance
>> --=20
>> 2.20.1
>>=20
>>=20
>
> I'm currently seeing test errors when running in a container:
>
>   MKDIR   /tmp/qemu-test/build/tests/results
>   AVOCADO tests/acceptance
> JOB ID     : fe56cc0b2d1adbc0b5bb5828902e113d596edccf
> JOB LOG    : /tmp/qemu-test/build/tests/results/job-2019-08-19T22.13-fe56=
cc0/job.log
>  (01/27) /tmp/qemu-test/src/tests/acceptance/boot_linux_console.py:BootLi=
nuxConsole.test_x86_64_pc:  ERROR: join() argument must be str or bytes, no=
t 'NoneType' (0.05 s)
> Interrupting job (failfast).
> RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 26 | WARN 0 | INTERRUPT 0 |=
 CANCEL 0
> JOB TIME   : 0.26 s
> /tmp/qemu-test/src/tests/Makefile.include:1158: recipe for target 'check-=
acceptance' failed
> make: *** [check-acceptance] Error 9
>
> That being said, I'm not running it under docker, but under podman,
> although I'm not convinced yet that is the defining issue.  I'll try
> to identify what's going here.

Was there a conclusion to the discussion about this series?

--=20
Alex Benn=C3=A9e

