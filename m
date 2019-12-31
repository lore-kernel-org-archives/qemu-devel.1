Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84244C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 17:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51004206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIgLGgcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51004206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imL2x-0001Z1-F1
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 12:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imL2G-00019H-In
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imL2F-000529-AZ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:10:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imL2F-00050F-5m
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577812222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UeHFkZDW3N7ew+J0Q2WhfXpN4G+vC9T0Z17VOYvS6CM=;
 b=EIgLGgcVyygdXkrw93mXi7hd1D6OnMf27raAJUkiApiNu7KHU4DPPnGDGtQ5xyYY6zcQ8z
 GL4ShzAaIZ2HzV0y6WcI0oL6BzoW5nPWdCTY9J6CdbO8fE3FvAO8AinObQnN9KcKyofT7R
 aIL2WB49Pgpd6Cz4ijdRqVg4dO5p1Ss=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-3vl_SgE5OWGyNvklLofS4w-1; Tue, 31 Dec 2019 12:10:18 -0500
Received: by mail-wr1-f70.google.com with SMTP id c17so13146275wrp.10
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 09:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5S+Az2Tdfaz3mKPw+rtFLBTcYQRzDenBBq5L3DFG9Nk=;
 b=NFb0EOuwKIlh0kx62lAiEUkHVEYZ3qfPD4HtNx2iwhfmbIccpddC1v8QxKOonSU9dS
 LW2YD81fyYuXDqjFfr3Yxle1C4axb9LqBgpoprI28/pgCAp0Gs4hc5A7pWLK5nFrOAiM
 I3MVB2E1B80kKNkEkOMuLllj2ivv+ThStbfppzM44F3yik1k5HSRwkNwzBNI33igQFgx
 qggTz+4LzTg2flqo2nW/gK0P8sZJEr92TxoPcO1Fvy+SopQ/Hos1WGAnLMZS3z51UOCy
 XJo2SWplmSyK3xUjJ+ZfylDLxepbVM5LnqS+TVxoCzo7hLHgmzFTXkz2b0+CVhLKv2e8
 0L1w==
X-Gm-Message-State: APjAAAWXX37S58s5omsPozhDKNTA4LphYOl3O//Fxcu8KmX2NCBH6lJr
 w0hajTLAIxJUxRpN/Um8DLXkEvc7hLlj3BFukpDjB7URBpLNC/dcA4B2ZEOORuc821e31/052IK
 dh7vXPiJYEWkH05A=
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr73416197wrt.381.1577812216787; 
 Tue, 31 Dec 2019 09:10:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqygCA5BtVkqcWb6ubbCOfr+czk6DYU1izxk4mBEgs4klVGoCZuFXUfTwPC1pKRubUYhGFYkhg==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr73416183wrt.381.1577812216614; 
 Tue, 31 Dec 2019 09:10:16 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id g23sm3039681wmk.14.2019.12.31.09.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 09:10:16 -0800 (PST)
Subject: Re: [PATCH 2/2] travis.yml: Detach build and test steps
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191230184327.2800-1-wainersm@redhat.com>
 <20191230184327.2800-3-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7ad5bf7b-9640-b617-2251-4e4b29f0d7f7@redhat.com>
Date: Tue, 31 Dec 2019 18:10:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230184327.2800-3-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: 3vl_SgE5OWGyNvklLofS4w-1
X-Mimecast-Spam-Score: 0
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
Cc: fam@euphon.net, alex.bennee@linaro.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 7:43 PM, Wainer dos Santos Moschetta wrote:
> Currently build and test commands are a single step in a
> Travis's `script` block. In order to see the output
> of the tests one needs to scroll down the log to find where
> the build messages ended and the limit is not clear. If
> they were in different steps then Travis would print the
> result build command, which can be easily grep'ed.
>=20
> So this change is made to detach those commands
> to ease the visualization of the output.
>=20
> Note that all steps on the `script` block is executed regardless
> if one previous has failed. To overcome it, let's save the
> return code of the build then check whether succeed or failed on
> the test step.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Tested with a broken test:
https://travis-ci.org/philmd/qemu/jobs/631341382

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   .travis.yml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index e7fdcb238c..fcc9de368b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -94,7 +94,8 @@ before_script:
>     - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>     - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log &=
& exit 1; }
>   script:
> -  - make -j3 && travis_retry ${TEST_CMD}
> +  - BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?
> +  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(ex=
it $BUILD_RC); fi
>   after_script:
>     - if command -v ccache ; then ccache --show-stats ; fi
>  =20
>=20


