Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962B92081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNhxsq83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962B92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ccA-0000HH-HC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7caV-00075v-I4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7caU-00010V-7a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7caU-000107-0k
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:37:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so18717193wrx.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MCUYC70I7qDpTmmGtQG3PeDT6/btgLvR6YIBa3KvaEk=;
 b=HNhxsq83Pt1ykrdxkEc3j2jkTTWlCrJW1LDKfR/B5644DC7xUcCQZGXbr6vPstapS0
 tUn2K6X8UahJP8UY18QHjRQua6nZdtH5hJULpNie2luYPohTpaMtydAfuS6FHgWAoEOa
 XUIB7D648E0ixHkKXqaLJcnvVR2mHbQ84c8qTFh6oCO+EZEuMpJekgDka+vaoyvdD7t4
 9AQmErtIBdbrZ4SYBLHv4l7vYFbuUUFIhjtMdLgcGeT2HTZmvYCcNbEQjomlZlubfcFm
 nc3CI+C/OYYR59ALUbqlWctXoJRHPk2ahRR2qHOQCAK0Mw4BDVK+o2xI+XPpPDqiQzEU
 eEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MCUYC70I7qDpTmmGtQG3PeDT6/btgLvR6YIBa3KvaEk=;
 b=G824jbY2weUnArwF10tzPTSDXglJPPGZQE8GWBk2n4z/J/Kd1Yb8LT55s+ZL6qgX2K
 NtS16bG+tXDOdV3ZSnR86vrHrlqX6sLyQLTpwoLqMudOf7o8I+KYL6aXgPRK1Fct4KLD
 ALAm2LXD7RvcLU7Xe/c5tbcY8PGIPDJTGsVbwcrlo+WfNRODRrlkZUPMAJQjjL1QxdKC
 LM99HDng1mhKy+h/hpske0PI+Btr50UMpS6T2XAAkwX5uyQgVgvZcssNYwduaZdffiv9
 qkYAPVJJ/w3Tcp7KmxOTob+yXuSIuJeSEv8Urlm+EKD59TdMO8x4nwCJItM6hUjC7nGV
 gldQ==
X-Gm-Message-State: APjAAAU3th8/6lv2m+HjlfS32EhV67ldJuyZ8m+eI+6tWOZeo3gEEt+r
 ygdCK3PezT6s5bJU7zDlwJ+YDQ==
X-Google-Smtp-Source: APXvYqw6rxEucMKggFdIQBRUQb4tq3XRabu/VW18zTmIwBJ2fdwLYAVafzUKLpG8MkRYVTMtZ3mKDw==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr5951675wrr.0.1568108244720;
 Tue, 10 Sep 2019 02:37:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v2sm3986720wmf.18.2019.09.10.02.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:37:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 315771FF87;
 Tue, 10 Sep 2019 10:37:23 +0100 (BST)
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <20190910084349.28817-45-alex.bennee@linaro.org>
 <20190910090743.GC8583@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190910090743.GC8583@redhat.com>
Date: Tue, 10 Sep 2019 10:37:23 +0100
Message-ID: <87o8zs1oh8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PULL 44/45] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 10, 2019 at 09:43:48AM +0100, Alex Benn=C3=A9e wrote:
>> From: Cleber Rosa <crosa@redhat.com>
>>
>> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
>> from tests/acceptance/linux_initrd.py, is currently failing to fetch
>> the "vmlinuz" file.  The reason for the failure is that the Fedora
>> project retires older versions from the "dl.fedoraproject.org" URL,
>> and keeps them in "archives.fedoraproject.org".  As an added note,
>> that test uses a Fedora 28 image, because of the specific Linux kernel
>> version requirements of the test.
>>
>> For the sake of stability, let's use URLs from the archived and
>> supposedely ever stable URLs.  The good news is that the currently
>> supported versions are also hosted on the later.  This change limits
>> itself to change the URLs, while keeping the fetched files the same
>> (as can be evidenced by the unchanged hashes).
>
> FWIW, I commented on the oiriginal patch before seeing this PR.
> I don't think we should be using the archive URL for anything
> which still exists on download.fedoraproject.org as that's placing
> undesirable load on the Fedora master servers, instead of using its
> primary CDN via the mirror services.

I think most of the CI services have caching proxies to the outside world
to reduce their internetwork load. Would we be able to check with the
webmasters to see what sort of effect we are having on their load?

The problem of using the normal CDN is if we don't keep on top of
updating URLs as the upstream moves the artefacts to archives our CI
keeps breaking. Perhaps we should be hosting these ourselves? But that
involves infrastructure and also ensuring we meet GPL requirements
whereas at the moment we basically offload that work onto the distros.

>
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

