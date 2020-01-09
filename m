Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC536C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 08:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B733F20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5cP8xBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B733F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipT8e-0003Jc-QV
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 03:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipT7T-0002Lv-8v
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipT7S-0000RD-0w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:24:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipT7R-0000MS-Pv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 03:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578558281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6UqrQ5wXOIrkhec0hjeQGd/K7p+NaLIQDI/4XaBDoPg=;
 b=G5cP8xBT/Gg5XFhK0jEKcCPKuU4WWQTqjGWNux9cH6unjbo4KTwuvlAFr8EUh55GFBf0AE
 sP5k4QqGyXRLzQ31IstUE0wAIeFBAZsCqzjkIK8mWv7MapbjYof0nzmGYZ7bI6VHJx++Ls
 pQNcAqvEf8kdxjAtmvhJyimDOE570Ns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-tcaLKXEOMLaO_394PcTHLg-1; Thu, 09 Jan 2020 03:24:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 568E4107ACE3;
 Thu,  9 Jan 2020 08:24:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E51F21001B2C;
 Thu,  9 Jan 2020 08:24:34 +0000 (UTC)
Subject: Re: [RFC PATCH] travis.yml: split into build stages
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200108224952.17988-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9bb45641-ac1a-6ac7-6cc4-d7a4b4445666@redhat.com>
Date: Thu, 9 Jan 2020 09:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200108224952.17988-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: tcaLKXEOMLaO_394PcTHLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/2020 23.49, Alex Benn=C3=A9e wrote:
> The idea of this is split the build across stages so any failure in
> one stage will save time running later stages. So far I have have
> arbitrarily chosen:
>=20
>   canary: up-front quick to build and run
>   platforms: common build configurations
>   rest: everything else
>=20
> The ideal should be canary and platforms catch the most common and
> frequent build breakages and the "rest" aims for completeness.

I like that idea. Just two nits:

> diff --git a/.travis.yml b/.travis.yml
> index 6c1038a0f1a..648c523ce59 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -17,8 +17,12 @@ cache:
>    pip: true
>    directories:
>    - $HOME/avocado/data/cache
> +stages:
> +  - canary
> +  - platforms
> +  - rest
> =20
> -
> + =20

White space damage #1

>  addons:
>    apt:
>      packages:
[...]
> @@ -116,28 +123,33 @@ matrix:
>          - CONFIG=3D"--disable-user --disable-system"
>          - TEST_CMD=3D"make check-unit check-softfloat -j3"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> +      stage: canary
> =20
> =20
>      # --enable-debug implies --enable-debug-tcg, also runs quite a bit s=
lower
>      - env:
>          - CONFIG=3D"--enable-debug --target-list=3D${MAIN_SOFTMMU_TARGET=
S}"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
> +      stage: rest
> =20
> =20
>      # TCG debug can be run just on its own and is mostly agnostic to use=
r/softmmu distinctions
>      - env:
>          - CONFIG=3D"--enable-debug-tcg --disable-system"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> +      stage: rest
> =20
> -
> +     =20

White space damage #2

>      - env:
>          - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr =
--disable-brlapi --disable-libusb --disable-replication --target-list=3D${M=
AIN_SOFTMMU_TARGETS}"
> +      stage: rest
[...]
> @@ -272,6 +299,7 @@ matrix:
>          - TEST_CMD=3D"make check-acceptance"
>        after_script:
>          - python3 -c 'import json; r =3D json.load(open("tests/results/l=
atest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["statu=
s"] not in ("PASS", "SKIP")]' | xargs cat
> +      stage: rest
>        addons:
>          apt:
>            packages:
> @@ -321,6 +349,7 @@ matrix:
>              - uuid-dev
>        language: generic
>        compiler: none
> +      stage: platforms
>        env:
>          - COMPILER_NAME=3Dgcc CXX=3Dg++-9 CC=3Dgcc-9
>          - CONFIG=3D"--cc=3Dgcc-9 --cxx=3Dg++-9 --disable-pie --disable-l=
inux-user"

Could you maybe also make sure that we've got the same order of the tags
everywhere? Currently, you sometimes use "stage" before "env" and
sometimes after "env", that's a little bit confusing.

 Thomas


