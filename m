Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B307C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001042086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hs1rKGvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001042086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ZtL-0004li-69
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1j2ZsO-0004Ik-2v
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:15:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1j2ZsM-0004My-Qd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:15:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1j2ZsM-00049C-Jt
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581682517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrFkMpYHPAPBhbaNfyxrQcxNem8ileHHTLSI+vRQi2o=;
 b=hs1rKGvoJaLCRx/nEdMT565OsmqEiyPQy+NxKBqlySUilXBmEifebT6ZhohIiQS3WJ+jUH
 w8XIy98QelHYiJqNQomrhOv6u+GaqhJrk4ck+plQzFgyTSGQLMbtQGSEzBi+jCnbf0dWhq
 hA194hUq2ulqNwqMF1KH68SjscFu2mc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-QlXuv0HeMJeXOmiEUscYWA-1; Fri, 14 Feb 2020 07:15:13 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so3918618wrq.6
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 04:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mrFkMpYHPAPBhbaNfyxrQcxNem8ileHHTLSI+vRQi2o=;
 b=ovMeTIazdW/U+PrTzab6aMX7JrnSboIo8/xfW/We2WBo532qNorUS14gCw0A4t3Vgz
 vig9GUFhX8lZ4ssqCiwcBBMAu2nrif08+2UMstl4oMfXYYOw+gFgMWk6DDBO1fQUo0sg
 VbajO3GB8Gqujj1OlubJkcTQfqa/InvZ3K/dPYBwRZOJe8EM6yWfT+fUoOnZnkknZ6tU
 tMXK6+gFveHHqgx/bbth7vZFMDhinMSj5/761P3oAmLt7IOi/X/fMjUVIyHnSwtQHu66
 6VB+rIDEggJGDerwrVdVgBCDf4XsJF8yWQ4juOa6v5NhHTiN14KnEyYyZDfdhmF+Zvow
 W1Sg==
X-Gm-Message-State: APjAAAXXbW4aMOK1eO+IVEaWRzXwUNijd53+rmw8DFp4T/I6Z1jqTyZq
 ZC6cVRZFO+7t3SCMw7LlJ9upv5wvPCuvsFPNSoYrueh9KqpUuxege2dww73XnDUNzEHybpGQuOp
 CorzTwEiknh2oNW9oSjBKhdGVXQkgl+0=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr4696383wmb.137.1581682512525; 
 Fri, 14 Feb 2020 04:15:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ8VIZ8kLrlGxE9w+6bVeoAtxp6T+20BXZEL+73C/Ye00bpVjWO0lGvJzIkIQkY10ZMVyDDOHxcYkEzahEtLk=
X-Received: by 2002:a1c:541b:: with SMTP id i27mr4696358wmb.137.1581682512297; 
 Fri, 14 Feb 2020 04:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-8-alex.bennee@linaro.org>
In-Reply-To: <20200213225109.13120-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 14 Feb 2020 13:15:01 +0100
Message-ID: <CAP+75-Wp28ysW+hC0-SNzgTo3aJR_iJ1zCHHmp1jq4zHuozZsw@mail.gmail.com>
Subject: Re: [PATCH v2 07/19] travis.yml: single-thread build-tcg stages
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-MC-Unique: QlXuv0HeMJeXOmiEUscYWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Robert Foley <robert.foley@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Peter Puhov <peter.puhov@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 11:51 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> This still seems to be a problem for Travis.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 0612998958b..f4020dcc6c8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -400,7 +400,7 @@ jobs:
>      - name: "GCC check-tcg (some-softmmu)"
>        env:
>          - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,ar=
m-softmmu,aarch64-softmmu,alpha-softmmu"
> -        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
> +        - TEST_BUILD_CMD=3D"make build-tcg"

Can you explicit -j1 instead? This is self-explanatory.

>          - TEST_CMD=3D"make check-tcg"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>
> @@ -409,7 +409,7 @@ jobs:
>      - name: "GCC plugins check-tcg (some-softmmu)"
>        env:
>          - CONFIG=3D"--enable-plugins --enable-debug-tcg --target-list=3D=
xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
> -        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
> +        - TEST_BUILD_CMD=3D"make build-tcg"

With -j1 in both places:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>          - TEST_CMD=3D"make check-tcg"
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>
> --
> 2.20.1
>


