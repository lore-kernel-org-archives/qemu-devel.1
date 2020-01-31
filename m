Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1B1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ECE20663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8dnLL1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ECE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZ6p-0008Ns-6f
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYGZ-0004lg-3x
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYGV-0000PN-2V
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:31:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYGU-0000L6-Tg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580484686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCliUkwXUvVCNs0PhshHUDBou/Xtv0oVl4aS+tsOVXg=;
 b=F8dnLL1Ee+s4qg+v8IUQ52TV8zONfAAk+I3G90K450Nq+7krCrKGEhxPD1fD+XN+a6ew3+
 JyBHUOPHVM1A8+fu095IXDwrRFf2dErqocsYMTTq3MHMaREk6eA3eTdh+PT6sDzTUdIMAT
 fLq7uGRCagaeVWwV9rpB5K8CKImtQVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-Cffh5oowO7y6ztDonznW-g-1; Fri, 31 Jan 2020 10:31:24 -0500
Received: by mail-wm1-f70.google.com with SMTP id b202so2967140wmb.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nm3ZY8A2S90eBP5GizWyIlmWh/EzGz0w2I0nz4PfZb4=;
 b=hwWVnnQbKRGZQ9UTuk/UwHa+S9sUv1vG/30ST2YxsQLoqHArSAzcWBtn2JVeksL8+i
 Fp13qGY5JvKbCbQmp/xXPOJJSskFvqqwUMp4GjBohPYyvyiHxkwSrCxn8XvvsOjOiiDR
 MC19gqIbVrkgs54UpyEbJrEV6hTCuo3R6QPP4u3z09i3jMpBUpGbDG8WMH6EN5ABub3X
 FqVeXZ5e4SprnA5h6PUxmg6yXtFyvCqd+PiB0evz7FaTbJKqVzIJeyHh6wHEQbrrgqaZ
 AHNikcjK76/hDXGXRjn4aXNdoLV7oy9nsgM5QxO3A7wbZkQN+EQq7tFN+k9OhgA4VjSD
 KeAA==
X-Gm-Message-State: APjAAAUEp03VVS03n4iLt2UBEGTgUd/OKBxGVUiYdTNiC7BN8A5lbgiL
 G2eg/N/uBhDo4Dy5Uy2jvn98g7zFtZjGjuP3/8wsaGbw4MPbh7fBUbjHB9cLD3LX30AZ2+T3Fao
 +5k8Yh5FOfs5yGpA=
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr10634336wrx.153.1580484683172; 
 Fri, 31 Jan 2020 07:31:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxmlbfhnF5Z6lnBh3ZGXfYRXiFqKfJHuN5JBikQQoLOoyJU7ULYAgS+Pg/vKT2kko/Rw4nUBQ==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr10634281wrx.153.1580484682652; 
 Fri, 31 Jan 2020 07:31:22 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w20sm11217053wmk.34.2020.01.31.07.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:31:22 -0800 (PST)
Subject: Re: [PATCH v2 10/12] .travis.yml: move cache flushing to early common
 phase
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <34f6e4f8-5988-b06a-3ccc-e9ffe9c24983@redhat.com>
Date: Fri, 31 Jan 2020 16:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-11-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: Cffh5oowO7y6ztDonznW-g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
> We shall be adding more common early setup in a future commit.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index f245765cfe..1b92f40eab 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -82,11 +82,16 @@ git:
>     # we want to do this ourselves
>     submodules: false
>  =20
> +# Common first phase for all steps
> +before_install:
> +  - if command -v ccache ; then ccache --zero-stats ; fi

Odd, this rule is called 'before_install' but is run *after* the=20
addons:apt:packages list is installed.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
> +# Configure step - may be overridden
>   before_script:
> -  - if command -v ccache ; then ccache --zero-stats ; fi
>     - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>     - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log &=
& exit 1; }
> +
> +# Main build & test - rarely overridden - controlled by TEST_CMD
>   script:
>     - BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?
>     - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(e=
xit $BUILD_RC); fi
> @@ -268,7 +273,6 @@ matrix:
>         before_script:
>           - brew link --overwrite python
>           - export PATH=3D"/usr/local/opt/ccache/libexec:$PATH"
> -        - if command -v ccache ; then ccache --zero-stats ; fi
>           - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>           - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config=
.log && exit 1; }
>  =20
> @@ -499,9 +503,6 @@ matrix:
>           - TEST_CMD=3D"make install -j3"
>           - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
> -      before_script:
> -        - command -v ccache && ccache --zero-stats
> -        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>         script:
>           - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
>           - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
>=20


