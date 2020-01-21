Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD2AC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4984324653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxGp1PPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4984324653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itujl-00025P-Vo
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ituhI-0007r0-VL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ituhH-00087D-L8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:40:04 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ituhH-00086G-EL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:40:03 -0500
Received: by mail-wm1-x342.google.com with SMTP id w5so2254501wmi.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=R6Az3gwoWZNkDFLQXHPIGyziLTtcKolDITyBwaRAT3w=;
 b=mxGp1PPpktnA7AC7aVThJvIPrnc9A6FzNzAUk5pTEWhdgoNsIuZ9wbHRAw3afGMQDx
 un3FdLlU9TJPfShC3Vhnb8P1HPkh0ysiekZuo9JgmNVFQYhcM2WYgqsrGYfAdxFc0go9
 RvPJugMSFq2Ef3kwTQXsmI/con2VTzg7lj6JnmOnNGVCqZ0ANhuns7xTmYXNehCqieUO
 NdmagefTJbbZ0rNq11eU0gCyyXvImxTtC6TYODqtt+xXkM/55W8s3M0laMO+QCABT+NQ
 CquLAlSL7cEs9mrsgOQ8CYPJvQ+9pWSNpfoZ4Gmvn1lptEl9zpa7iiC2xhfRpjNlUXWm
 5NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=R6Az3gwoWZNkDFLQXHPIGyziLTtcKolDITyBwaRAT3w=;
 b=I5RG7/46zL1r1j/XnXVXyW6i8+KZDpUqepiAjmLbR/Ez1ml4TKqvmDOQl/3C5gHp/r
 VZl4zS7PLiEWPYtx+HSULw8W75b11zVXs1lzOFhcdQg6QPYYtFm12SJvH8fxQaOusvof
 oTyRTHUWHzWUe4pMlVhScFJWl2XDeQ6D3lo7cduqkLdeVm3uRFoauQk7HRuUGPKFv1nP
 djlIE07Mevm6RZ9ShyPmTW7B3/1i0rksXnFveF+cSvZGn4MtFq1rVTU6MtZnJNBAhEdt
 3WT8sJY99RISlHFqOMNgai0YEx7hJlFL/C5wjln/bqBgJicdmxbPAcXzjEtJWfbWSKJQ
 j1Vw==
X-Gm-Message-State: APjAAAUgcSTIYBIRdwN/rL9F96Q99AURdKUbXL2moJ1e7NGJ9IQVj6DG
 ZIX4dGiBEsJ/qTjE6aKPuQgx2A==
X-Google-Smtp-Source: APXvYqx2lePNWimjTWeUFUiSLJtp89OirYYrs9mVeQAbFaeAz6IM5RXwuYQYyzdCnyapXgXw3O9KnQ==
X-Received: by 2002:a05:600c:2383:: with SMTP id
 m3mr4838116wma.32.1579617601169; 
 Tue, 21 Jan 2020 06:40:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g25sm44627wmh.3.2020.01.21.06.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 06:40:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C3101FF87;
 Tue, 21 Jan 2020 14:39:59 +0000 (GMT)
References: <20200121131936.8214-1-thuth@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] gitlab-ci: Refresh the list of iotests
In-reply-to: <20200121131936.8214-1-thuth@redhat.com>
Date: Tue, 21 Jan 2020 14:39:59 +0000
Message-ID: <87d0bc27r4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> iotest 147 and 205 have recently been marked as "NBD-only", so they
> are currently simply skipped and thus can be removed.
>
> iotest 129 occasionally fails in the gitlab-CI, and according to Max,
> there are some known issues with this test (see for example this URL:
> https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg00499.html ),
> so for the time being, let's disable it until the problems are fixed.
>
> The iotests 040, 127, 203 and 256 are scheduled to become part of "make
> check-block", so we also do not have to test them seperately here anymore.
>
> On the other side, new iotests have been added to the QEMU repository
> in the past months, so we can now add some new test > 256 instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

> ---
>  .gitlab-ci.yml | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d9a90f795d..52d73c1c72 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -51,12 +51,12 @@ build-tcg-disabled:
>   - make check-qapi-schema
>   - cd tests/qemu-iotests/
>   - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 =
048
> -            052 063 077 086 101 104 106 113 147 148 150 151 152 157 159 =
160
> -            163 170 171 183 184 192 194 197 205 208 215 221 222 226 227 =
236
> - - ./check -qcow2 028 040 051 056 057 058 065 067 068 082 085 091 095 09=
6 102
> -            122 124 127 129 132 139 142 144 145 147 151 152 155 157 165 =
194
> -            196 197 200 202 203 205 208 209 215 216 218 222 227 234 246 =
247
> -            248 250 254 255 256
> +            052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 =
163
> +            170 171 183 184 192 194 197 208 215 221 222 226 227 236 253 =
277
> + - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 10=
2 122
> +            124 132 139 142 144 145 151 152 155 157 165 194 196 197 200 =
202
> +            208 209 215 216 218 222 227 234 246 247 248 250 254 255 257 =
258
> +            260 261 262 263 264 270 272 273 277 279
>=20=20
>  build-user:
>   script:


--=20
Alex Benn=C3=A9e

