Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65503C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 17:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D32206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 17:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGnuoyMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D32206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imL1i-0000JL-7I
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 12:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imL11-0008KS-EQ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imL0y-0000cJ-AN
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:09:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imL0x-0000Ut-Ke
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577812142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9xhqySPEwr8z7zqj3949Zs4KiUJgx1qovwiIrIWPhw=;
 b=EGnuoyMgPpbj80d4ZtoXWpG7Qkt3aeEL17ok/eCZ1aN+kmipU3Qkes2j8nctWhoMf7NI1l
 kNpQTxKSOG2vJ58ZIK8JqxfCzRhkU1feILSYIf0sL188wqEix7Ok87qTVgPc7k7V/OeuND
 Z/nf19O9Nv2c8oHTneIR9oLcjhFJi+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-XBez3s9LPfWxDHKUGfHWZQ-1; Tue, 31 Dec 2019 12:09:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id f10so11017073wro.14
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 09:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GhP8WeL1ajJtbVx6JJOzN+SpS39chGEYsHHbmj7zZVw=;
 b=UgaulCxN0Uk4eOkHM5xLZzsBJSO7uZBbNn22nT/QlTYFJTsdmOBolAEPuP2z1YszZl
 scpNqPHfTLYtBD2c1uwqQS2bJ83vc7ZtaUVUgtpVOmFrrL3aIW/j9rNhoZim4M28O4fF
 khxMEXPThBoc5XFOLImTxeD0cL2TQmKaKzBO+OQwAx+Dl/oQsP1F5+ZOUdiNXG+fojEv
 C3PQb4dOxwCuQV9mc5HhYpkuztmoVehYK82QLXLv0vDMw2HQhdDg9IuUF5YgMSOiF1yT
 Mjw5aMgf3r1vpX8TIhdMNaAz/WSH858luGtQG//P2O9b748zory9+zEMKLWczADO5wj0
 dGtw==
X-Gm-Message-State: APjAAAVaDBw1aE+4/rg9IgTIUnVOG89+8hwGWOzOEIkm8td/GiigZ2Pi
 MpBgjdmtVicmexuJq4tZ5thzVZWKZu2LSCP5EA0dRRPvxgU8KB6h5gYdCAUIAzaN7Z+3HQKfrqd
 1urm+j3iZC0/IDHA=
X-Received: by 2002:a5d:5308:: with SMTP id e8mr73235230wrv.77.1577812140039; 
 Tue, 31 Dec 2019 09:09:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwY7n0UivXwbnJzl9UuOwIezQ45C1JGjAYxVIOH5t12T2IeIwxd0BHPVrTYyrxh9M2lqmAxDg==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr73235218wrv.77.1577812139869; 
 Tue, 31 Dec 2019 09:08:59 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id v14sm49098186wrm.28.2019.12.31.09.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 09:08:58 -0800 (PST)
Subject: Re: [PATCH 1/2] travis.yml: avocado: Print logs of non-pass tests only
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191230184327.2800-1-wainersm@redhat.com>
 <20191230184327.2800-2-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ef47a74-efd2-5788-37db-3f997eeba43e@redhat.com>
Date: Tue, 31 Dec 2019 18:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230184327.2800-2-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: XBez3s9LPfWxDHKUGfHWZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, alex.bennee@linaro.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 7:43 PM, Wainer dos Santos Moschetta wrote:
> The acceptance tests build on Travis is configured to print
> the entire Avocado's job log in case any test fail. Usually one is
> interested on failed tests only though. So this change the Travis
> configuration in order to show the log of tests which status is
> different from 'PASS' and 'SKIP' only. Note that 'CANCEL'-ed tests
> will have the log printed too because it can help to debug some
> condition on CI environment which is not being fulfilled.

Nice!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Tested with a broken test:
https://travis-ci.org/philmd/qemu/jobs/631341382

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   .travis.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 376b7d6dfa..e7fdcb238c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -262,8 +262,8 @@ matrix:
>       - env:
>           - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-=
softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-sof=
tmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>           - TEST_CMD=3D"make check-acceptance"
> -      after_failure:
> -        - cat tests/results/latest/job.log
> +      after_script:
> +        - python3 -c 'import json; r =3D json.load(open("tests/results/l=
atest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["statu=
s"] not in ("PASS", "SKIP")]' | xargs cat
>         addons:
>           apt:
>             packages:
>=20


