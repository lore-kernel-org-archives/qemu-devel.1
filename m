Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB74F21E6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCJHgKbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB74F21E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUape-0008S7-Va
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUaok-0007zy-B2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUaoj-0002sQ-Dy
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:23:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUaoj-0002sC-87
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:23:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id z10so14341155wrs.12
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F75F6QfCpsQdU6dODz2D/z5TptqBOUX/XUlcd4a/kNw=;
 b=qCJHgKbXUinlneV4y/oSi++w7Gy6+PdYtK0jgPLkIANZy4fA5PnFHQn0VaPi1tDti/
 j39zG7nzg+1NHtZcUH2x1xiQ3AV0+zNu/8jSJjbVez/g3GDSYBAT3FkOe7e5BpeLdzJ3
 lUgqVo8doN0XpA6bPDRy8kR0Oggj1zn5Io/1OGOtWqmm72LxVAc5W3ak2yj8Ssfe6mGj
 v+QeRLmx4d3D2bvBQZDpXmEp7Tg760jxusf2YNcVl51cMDjrng1+uk8NK3T6lV1MRned
 DZeJPmxp3Z+WFQNZLLs9Bgq/GPQvIUx+WxOAxqNtGafFOgpz8QjRI2f5cBQ706VYDgBY
 ua6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F75F6QfCpsQdU6dODz2D/z5TptqBOUX/XUlcd4a/kNw=;
 b=I5WJyh72+yHZbdcGdKtXb4VIxUBvpzInn1kCFxyGYP7rLYYfJnCNIgz4tOhaQ7bW6v
 oK94OHBJj0h4/5MkMXPZIBvsp7Avg4kxBmW9/boqAfNwKjmDg8p0+CKVEf7hxu9Bwbb/
 d/DeFwiwbcmVhjLoidTRABUucGIutYPj5MV+yUWYyW7XTNCAC/Q33HTvIifAf+b+7IND
 sGPhfnoQrrUaDYM1v6vdyPhLmUBHqnFa4ScOsz6NwzuOxXwZjeK9Lplr/2ESUgiL9AMi
 EGwNZzjeKF5UGVDlVZA5BXRyaAu/tgwP4xvkXCUuIwG9utbPiuVLdlxz7FtwVOWXs8RY
 JLSA==
X-Gm-Message-State: APjAAAU+tM2ashWeG9vhCF3jykHBiuRFrBCtXwl0MFk4T6fEtBF3uWK0
 LNCBFH78OpjrwGtIEojG7/bV2j2G8KU=
X-Google-Smtp-Source: APXvYqzpvLKd1oZFPBVc/3Xt3xlnLQsiMViNaCiq/h4KPZfxNYekfMIZ/tDtzJmJslw4B5THWMfmLQ==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr27268447wrf.221.1573582983820; 
 Tue, 12 Nov 2019 10:23:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm20045825wrw.20.2019.11.12.10.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 10:23:02 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 569541FF87;
 Tue, 12 Nov 2019 18:23:02 +0000 (GMT)
References: <20191112150105.2498-1-robert.foley@linaro.org>
 <20191112150105.2498-6-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 5/5] Fix double free issue in qemu_set_log_filename().
In-reply-to: <20191112150105.2498-6-robert.foley@linaro.org>
Date: Tue, 12 Nov 2019 18:23:02 +0000
Message-ID: <87ftit7y49.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.puhov@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> After freeing the logfilename, we set logfilename to NULL, in case of an
> error which returns without setting logfilename.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

As this fixes an existing bug I would put this at the start of the
series. Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v1
>     - This is new in the patch v1.
> ---
>  util/log.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/log.c b/util/log.c
> index 802b8de42e..1eed74788c 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -148,6 +148,7 @@ void qemu_set_log_filename(const char *filename, Erro=
r **errp)
>      char *pidstr;
>
>      g_free(logfilename);
> +    logfilename =3D NULL;
>
>      pidstr =3D strstr(filename, "%");
>      if (pidstr) {


--
Alex Benn=C3=A9e

