Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A783C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38CB206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAnUn0UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38CB206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGK1E-0004KD-4m
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGK09-0003Sx-Bp
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGK08-0001E8-73
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:08:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGK07-0001De-DO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584958087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LnxYeg44pRqF9TY70ARIsCleayylgC6Ck9l/c2f1GU=;
 b=QAnUn0UKkjstJ9MVJdbj1LJK3a0WQ1XX+eUnZ4PXDgKciJWcz3ejl9mqhK6xlviyGX5L6e
 wbSXwT+td7yP6W1woWWh6FZVtERacZfAe2fLhRn8B6YqGxuEgGu4wbT69TH+I1sR5qgWRB
 6pjvoqhy/py8UA3cKOCe5VZskO98tos=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-LPgObhfqNcaA5Erme-bhjA-1; Mon, 23 Mar 2020 06:08:05 -0400
X-MC-Unique: LPgObhfqNcaA5Erme-bhjA-1
Received: by mail-ed1-f70.google.com with SMTP id j10so2719163edy.21
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yT2uyp6s18Y5Z/g0bMchfP+JN+nQ64rUiNqeYtzBuNc=;
 b=k9ql0v5jIRmzcKrbAXk3yaQksiSuGKbQ8mbhhjEHEa7CkJWzkfufBBS2HpGuQbgi0f
 p1gMFiwSlJXOZlvNLkhbgJeKDWWzcmobehlidOmbUudUL8hWg36kA+cmSvKd5mzcMtSR
 Gc/Al3TW+ZvrV+lT5UF3C2YWVt2L2FXEYmRX4ZwqUufWwY8CHG2w8PhF/YTvGc3CCqjz
 PThKU2+f/F+92GG7jeYgOSPXBdpkLSmfnKwRwFULLXEfhTFfqXhxGxqfaFApF1Gbb7zX
 XcM1mJOI2nF2vFUUYSw3SCwYHY/x9YGX+DH0rXOHc2AVvgwGcdjit1MhVUyxgR+rQNn4
 z2TQ==
X-Gm-Message-State: ANhLgQ3FaXRWiB+5ldUmGs5dco5+RlrkgYLbiNlOWVzOWSTaceRropcT
 PixJQAzmmMw9o+EuaOpCxTjTHulkd+VMX/WY3a5iu7DWzt1XXSuXEvPi1As+efmX5MaDypELQIN
 Ex96kGwOanGnMfnM=
X-Received: by 2002:a17:907:4037:: with SMTP id
 nk7mr18487136ejb.227.1584958083898; 
 Mon, 23 Mar 2020 03:08:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvQVT3W/F45z0xfaIUEg47SDv5B1jQj6oW8uXyocaIgUPwkJIPZVafCKvU9mpLONM4ZrCM7nw==
X-Received: by 2002:a17:907:4037:: with SMTP id
 nk7mr18487117ejb.227.1584958083606; 
 Mon, 23 Mar 2020 03:08:03 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id z22sm858751ejo.17.2020.03.23.03.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 03:08:03 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 2/4] tests/docker: Install gcrypt devel package
 in Debian image
To: qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200322120104.21267-1-philmd@redhat.com>
 <20200322120104.21267-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b5291e8c-ea3a-0b8e-d596-d8698d17ada6@redhat.com>
Date: Mon, 23 Mar 2020 11:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322120104.21267-3-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/22/20 1:01 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> In commit 6f8bbb374be we enabled building with the gcrypt library
> on the the Debian 'x86 host', which was based on Debian Stretch.
> Later in commit 698a71edbed we upgraded the Debian base image to
> Buster.

Aleksandar, is this updated description OK with you?

>=20
> Apparently Debian Stretch was listing gcrypt as a QEMU dependency,
> but this is not the case anymore in Buster, so we need to install
> it manually (it it not listed by 'apt-get -s build-dep qemu' in
> the common debian10.docker anymore). This fixes:
>=20
>   $ ../configure $QEMU_CONFIGURE_OPTS
>=20
>    ERROR: User requested feature gcrypt
>           configure was not able to find it.
>           Install gcrypt devel >=3D 1.5.0
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Reword description, do not use 'Fixes:' tag (Aleksandar)
> ---
>   tests/docker/dockerfiles/debian-amd64.docker | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
> index d4849f509f..957f0bc2e7 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -16,6 +16,7 @@ RUN apt update && \
>       apt install -y --no-install-recommends \
>           libbz2-dev \
>           liblzo2-dev \
> +        libgcrypt20-dev \
>           librdmacm-dev \
>           libsasl2-dev \
>           libsnappy-dev \
>=20


