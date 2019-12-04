Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B054DC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7352A2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rab7Musm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7352A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXH3-0005QT-Iy
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icWy4-0003Jj-Vl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icWy2-0003JY-4s
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48131
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icWy2-0003JB-0s
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Iu9USGZXWfNhDGS1xwUM/FRnoU0klkaFpH2157oUs0=;
 b=Rab7MusmJxoczKX0S0rFxrPc49julwofSHNFqXW72Eb2YWbTqHQMji7lYwRTrfXp7Z9v/V
 GkMZZHTlgDv02ugg7cY4Zwhfagibs/NUt4tjkaBIZxhjqy3bw7OQDx59+8h0NvrXd0k7f5
 Al1KCFhSEeU1newMqWTbcltijJtQrg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-AkSQN9xIMcuui0dyEOuv3Q-1; Wed, 04 Dec 2019 10:53:27 -0500
Received: by mail-wr1-f72.google.com with SMTP id r2so49429wrp.7
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RuO5cIW2DVEB8QTEFJsEpj+lgMQU1BAjMR47Wp5T0+8=;
 b=g3EaMYSm0+ZrjilyuhCkvwA0FtTnI5jTFtV9jB3VUANLTY9YuVyZ/YM6zPkOXP09Ny
 BgjVQ/7GoOQM6HK8nYq+joik74YiUDTpe5Cx5KwWEJ9v43Wydf/x18/2RwagewYkDUtc
 OWYKmxSdeXjYZTTrhImh/d6nm2zihSPQ+fIVgef0gGQdNic8gSxERaIqHyIMxEj39f/Q
 fN87akMEws/jlYP456IhpJI26HTBbgIgUUHbu/NwK2yHqUVs/hEwFDa16k8Oq993U6Qy
 Wy1FxH9uk0+B7kaBYAoEtxh8n6TelbEFNoCpH497zNRsl8zgOrUBFY4sJSOf1VCZ9ipa
 zjXw==
X-Gm-Message-State: APjAAAVJxZAMn+cfwNw7GshIQxNcjwsKf4Y6Zd72798ZxkjPEZiZScxQ
 ez3nBnVRbXC5f7oZGKMYaQ+AJasXpU2sIFE8BXtrmItNUmRIIJAa3K7XwSJ+rISMEM05GK7Z+vq
 hzjP3LhYuQp5wyO8=
X-Received: by 2002:a1c:7911:: with SMTP id l17mr210642wme.44.1575474805279;
 Wed, 04 Dec 2019 07:53:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+fRp79NjUx9Xh9XHYkwHZd8Sh3dJMaLaMaKuR+V8uvHlPHGExao0ftVUnfA4huhjuYshplw==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr210624wme.44.1575474805109;
 Wed, 04 Dec 2019 07:53:25 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id r15sm7263484wmh.21.2019.12.04.07.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 07:53:24 -0800 (PST)
Subject: Re: [PATCH v2 2/7] iotests: Skip test 060 if it is not possible to
 create large files
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bd49251b-6bc1-b321-cf6c-3e6b08cae95e@redhat.com>
Date: Wed, 4 Dec 2019 16:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-3-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: AkSQN9xIMcuui0dyEOuv3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-block@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 4:46 PM, Thomas Huth wrote:
> Test 060 fails in the arm64, s390x and ppc64le LXD containers on Travis
> (which we will hopefully enable in our CI soon). These containers
> apparently do not allow large files to be created. The repair process
> in test 060 creates a file of 64 GiB, so test first whether such large
> files are possible and skip the test if that's not the case.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/060 | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..d96f17a484 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -49,6 +49,9 @@ _supported_fmt qcow2
>   _supported_proto file
>   _supported_os Linux
>  =20
> +# The repair process will create a large file - so check for availabilit=
y first
> +_require_large_file 64G
> +
>   rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
>   rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
>   l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


