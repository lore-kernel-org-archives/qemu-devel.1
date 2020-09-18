Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B329C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CAF206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSK7uPyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CAF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGk1-0006KZ-F6
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGil-0005oG-Ow
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJGij-00054v-Js
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600436796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g5inXGDH9UyK2+dZX5lnEBGvLwT+9N22Vj8ZEVId6M4=;
 b=MSK7uPyYRRW4uHa6hbEAt3Di+cwIebMAWYhiCRXv1kFS37w22V6xdtN+41TcOPV6e+C7ez
 BL8MZCdaaOmX9gkBenTZu4nUqYCghgEg3Te3XuNa1weLiOfr/2L4VXJOxMehxaiiG5vcT3
 FG7ItmSL5mES870xFD/rkLtyWm5LaYQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-Utft76p8N3q68OiG9UJYqA-1; Fri, 18 Sep 2020 09:46:33 -0400
X-MC-Unique: Utft76p8N3q68OiG9UJYqA-1
Received: by mail-wr1-f72.google.com with SMTP id l17so2136813wrw.11
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=g5inXGDH9UyK2+dZX5lnEBGvLwT+9N22Vj8ZEVId6M4=;
 b=YQC0PnPx0ih+waEdb1ce/qHNJkf97VenV8QXI7Xn6agQrPqUZN6THVZUENro5RlWHP
 NkPTRnxskAXlBfUgRyBUZWHkKYjbejPlmfEx/7CM+85iiBVgvlAtsjRSFAV3RPdhfwyA
 JkGTguHezC6V1sYIE8NBiJFx5ASDDoFw+LhqRQmJkJ6OSerCa3t6oP51UbWO++3rE7fn
 xw7/63l82QSEJWsdYn8MuUX0fYeSdkqAwcNo7CeU0RnLG18uGPnqU15HedVjg3lH2RXs
 XXgb8Q8zT0GAYP56v1Xb4o6kgM5GaCUQBUldcMGq9bbtbVry0rGcnH8fjTl1qheSKDvS
 gMoQ==
X-Gm-Message-State: AOAM533bD8QugWO/XMKZriIY/s+jvV5/mJhbpW0I0TCnMAjB1cakMSEy
 zuLtElW5+g2Wrxc7FRTBvJ0cpr95EcbG/WjwzS53SpFAbNaP0z/8WtmEHGCuUX6Y39j8WPQa8H9
 ZgWi62QCisAQ217w=
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr14958642wmk.184.1600436792252; 
 Fri, 18 Sep 2020 06:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEwxZ63vaok/bF1mTJ5Yu0nDUm24m8flnM+0tMk3yDvCVpOZs2LAVWC+54mO0RI9limfAjVQ==
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr14958626wmk.184.1600436792036; 
 Fri, 18 Sep 2020 06:46:32 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v4sm4979182wml.46.2020.09.18.06.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 06:46:31 -0700 (PDT)
Subject: Re: [PATCH 1/3] gitlab: add a CI job for running checkpatch.pl
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200918132903.1848939-1-berrange@redhat.com>
 <20200918132903.1848939-2-berrange@redhat.com>
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
Message-ID: <19bb60cd-1159-6215-6759-c2a10b9f8a66@redhat.com>
Date: Fri, 18 Sep 2020 15:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918132903.1848939-2-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 3:29 PM, Daniel P. Berrangé wrote:
> This job is advisory since it is expected that certain patches will fail
> the style checks and checkpatch.pl provides no way to mark exceptions to
> the rules.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/check-patch.py | 48 +++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.yml              | 12 ++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100755 .gitlab-ci.d/check-patch.py
> 
> diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
> new file mode 100755
> index 0000000000..5a14a25b13
> --- /dev/null
> +++ b/.gitlab-ci.d/check-patch.py
> @@ -0,0 +1,48 @@
> +#!/usr/bin/env python3
> +#
> +# check-patch.py: run checkpatch.pl across all commits in a branch
> +#
> +# Copyright (C) 2020 Red Hat, Inc.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import os.path
> +import sys
> +import subprocess
> +
> +namespace = "qemu-project"
> +if len(sys.argv) >= 2:
> +    namespace = sys.argv[1]
> +
> +cwd = os.getcwd()
> +reponame = os.path.basename(cwd)
> +repourl = "https://gitlab.com/%s/%s.git" % (namespace, reponame)
> +
> +# GitLab CI environment does not give us any direct info about the
> +# base for the user's branch. We thus need to figure out a common
> +# ancestor between the user's branch and current git master.
> +subprocess.check_call(["git", "remote", "add", "check-patch", repourl])
> +subprocess.check_call(["git", "fetch", "check-patch", "master"],
> +                      stdout=subprocess.DEVNULL,
> +                      stderr=subprocess.DEVNULL)
> +
> +ancestor = subprocess.check_output(["git", "merge-base",
> +                                    "check-patch/master", "HEAD"],
> +                                   universal_newlines=True)
> +
> +ancestor = ancestor.strip()
> +
> +subprocess.check_call(["git", "remote", "rm", "check-patch"])
> +
> +errors = False
> +
> +print("\nChecking all commits since %s...\n" % ancestor)
> +
> +ret = subprocess.run(["scripts/checkpatch.pl", ancestor + "..."])
> +
> +if ret.returncode != 0:
> +    print("    ❌ FAIL one or more commits failed scripts/checkpatch.pl")
> +    sys.exit(1)
> +
> +sys.exit(0)

Hmm I'm very tempted to add various check I've been reluctant to
add to checkpatch.pl here, and use check-patch.py instead...


