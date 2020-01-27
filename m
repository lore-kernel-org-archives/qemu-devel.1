Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA1E24679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNLmy38k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA1E24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50209 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwAHD-0001dF-32
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwAGJ-0000lC-PV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwAGI-0000J9-CD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:41:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwAGI-0000Ir-8W
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580154090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdEyuDHYOz+B55hfuSpZDwJonzL98piIjHpVkGzVj+o=;
 b=cNLmy38k8ozb3XWvDccEFYjoWtJdZBVzD4572feDsgf4gWEpzNM2KNpYb4if2LbwP2LPRM
 KVHd+1AgaE/D0E/09sZWoyRAgJaWQvvyc6sMvJGsbMK2NRlE34ZGjnWEoCwq3ChTveSXcg
 E+YhYGNDBE4lU7JpRGp12C2+SMxSEk0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-iCzB6EynPeypzqtShFAeVw-1; Mon, 27 Jan 2020 14:41:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id u18so6615921wrn.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yvan30+caGF/AUWdwvl1DSqVPfpvHScKaB0p2APY90s=;
 b=BDAvKx8qZKkzge6TCbX1DM4bLctXomOfVf9GVRyjd5DNQkIt4TX4/jEEuha3av+Sm4
 jWrnD6eOpkHQk/SDtWk8U4fN8KFeOopKh5Du7cegKA0zgzE+JZyCQTxT8Qs8Z1AN5pqI
 vLv9z6hLaCLPUUJIrdX6V9CLGq6dIl0HTk9S5OzSqWvG2WTqX0C7rafFcIXSIxbOZ4xh
 QyKpqmO55Aya1HCklK0VvUqrEF4z+7WiFwcPhejFy7uMg4B0FQpF7wEXSQOZM7dDod7v
 UnFWScT+h/tmg+3ivRxYj5LlgUHfSUMNsp6IdGyC4ffDHqsUP2A/HeXAmA1Mofu7Lz/W
 GUSw==
X-Gm-Message-State: APjAAAXRfASpVi6En1RrfJSHsYcSLSjiTcgrkGFjTXLec6riGBWV1PTN
 pT9V90oTueHQCYFslieZSMD0xlQyKDBkvV6WNlpDPDcbgCpoP2ctoagpYGcOb5ESwted6xGV3f7
 Mk/T3iXqGNRlKa4I=
X-Received: by 2002:a7b:c218:: with SMTP id x24mr205165wmi.149.1580154086508; 
 Mon, 27 Jan 2020 11:41:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzegQYTzKAghD8DEVO7nhwkeuqH+js6mcN+aM3jOSyRrxNVKQ3BJLRUZ8UPvhHAIaf9kNsSig==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr205146wmi.149.1580154086340; 
 Mon, 27 Jan 2020 11:41:26 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b16sm19849273wmj.39.2020.01.27.11.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:41:25 -0800 (PST)
Subject: Re: [PATCH v1 10/13] tests/docker: add debian10-native-qemu-build
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200124204026.2107-1-alex.bennee@linaro.org>
 <20200124204026.2107-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f316e5bd-3b98-ad31-0421-a9a60ed7df85@redhat.com>
Date: Mon, 27 Jan 2020 20:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124204026.2107-11-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: iCzB6EynPeypzqtShFAeVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 9:40 PM, Alex Benn=C3=A9e wrote:
> This is a new dockerfile which can build the native architecture QEMU
> on a Debian 10 based image whatever architecture that may be.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .../dockerfiles/debian10-native-qemu-build.docker | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>   create mode 100644 tests/docker/dockerfiles/debian10-native-qemu-build.=
docker
>=20
> diff --git a/tests/docker/dockerfiles/debian10-native-qemu-build.docker b=
/tests/docker/dockerfiles/debian10-native-qemu-build.docker
> new file mode 100644
> index 0000000000..71bd2b1d83
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian10-native-qemu-build.docker
> @@ -0,0 +1,15 @@
> +#
> +# Debain Native Build
> +#
> +# This docker target builds on the Debian Buster base image. It is
> +# deliberatly architecture agnostic as it can build on any Debian
> +# supported architecture.
> +#
> +FROM qemu:debian10
> +MAINTAINER Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +
> +# We use --arch-only as not all hosts have what's needed to build all
> +# the binpkg's that come with QEMU (roms etc).
> +RUN apt update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt build-dep --arch-only -yy qemu
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


