Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F5FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A008B206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTLouiBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYpP-000850-S7
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYCU-0007y7-6J
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYCT-0000f6-5Z
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:27:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYCT-0000ct-1I
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580484436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7d5WwEKlPIaSuVOdUyBudqEYQNxpNZiBzHCDBXv0UA=;
 b=XTLouiBJazowcJjQCnIiQOAQG+nOteRKWMyhH8iWwn4JLM7Zbjvm2T+0s4UymX6Sqc/vEO
 HT+5JgH7qFm0BPnLz3lHPgm9NMsI6iVoCWa89AbxGMQllSig0tVU7GVp9CB5hVj69zDnPn
 3bjQnhtOW/T74mwOHRihzOS6zTkMxqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-61L5Vv9mPMizDtznhl6Qog-1; Fri, 31 Jan 2020 10:27:14 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so3479408wrm.23
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gs2GXoPfrNQXjkj+9QUKUi5lKAzyq5nu+PeK00RtqlA=;
 b=nhUntEN5Gme4bZwEIOg95bi+xdcs2I9aJ98l+KrzRdnVbtu/08lv17WIWOFNEk9MDb
 BVSZL+QsYgpuIluxfLtHYVuEpvlYPtFy1SZT/A/8VtFA8pUVZXCORIGYFGyMMq63KJKh
 jhM4KL6eDHPeI0oU6pj2OJDJWHWy2CovUegRw7QOtWiseZ9TigKAjL/Idj78xpHJQUUa
 G3Ea8UhF0wZzDAQKAOt1XxdqEuDoeoKUadt8ocIyl+0cYaz1KOYGhKSDWEO7xny5XNnp
 9goQj7c8Ammd2fPwGxG7IoUFRS1gtEaCwv53jX7U6vfLvTJwKbw0TT9Y7N/zpzGk6mDW
 b3Ow==
X-Gm-Message-State: APjAAAVZGybZJICSI7Ysap4TtFJE+Ah5rUQ0kVAJDVlcSvCv3IbSnZ+/
 y76PNWGxrmKbcW/dB9N4Ci0n33XmoHuNw/PZNwpFxdodxK7QGOuoioW6d0Y6BOVH+tSiK0ZXiAq
 YStjh0SDPtCQcxLA=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr12493758wmh.35.1580484433156; 
 Fri, 31 Jan 2020 07:27:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwPEmxQ+gnnCnSIxOrmDvPyed+OWBw2s9n3y2QMxtyUboxxidqZDyUBEIM98vjaLF0jxS4bA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr12493732wmh.35.1580484432907; 
 Fri, 31 Jan 2020 07:27:12 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q3sm10928137wmj.38.2020.01.31.07.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:27:12 -0800 (PST)
Subject: Re: [PATCH v2 09/12] .travis.yml: build documents under bionic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2434e9a8-c4a3-c471-a04b-ad3960110716@redhat.com>
Date: Fri, 31 Jan 2020 16:27:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-10-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 61L5Vv9mPMizDtznhl6Qog-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> It looks like the xenial tooling doesn't like something in our setup.
> We should probably be moving to bionic for everything soon
> anyway (libssh aside).
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 056db1adac..f245765cfe 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -165,7 +165,8 @@ matrix:
>  =20
>  =20
>       # Check we can build docs and tools (out of tree)
> -    - name: "[x86] tools and docs"
> +    - name: "tools and docs (bionic)"

As noticed Thomas, it would be clearer to remove '[x86]' in the previous=20
patch, and add '(bionic)' description in this one.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +      dist: bionic
>         env:
>           - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
>           - BASE_CONFIG=3D"--enable-tools --enable-docs"
>=20


