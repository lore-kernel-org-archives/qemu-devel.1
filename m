Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA311C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954EB20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk9sENSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954EB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9er-0004TQ-RZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9bv-0008Ig-FW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9bu-0005k8-Ar
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:38:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9bu-0005ho-5a
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aY6Yw2QDAfMjMG+L1v9ThQm+2RKRa67z1Cw7XV+GEAg=;
 b=Sk9sENSmNwpyFDO3TNpMYYggxkycaEXuMdm+pDms8qena+45utM0gtZmWnHYachep3P9DM
 8m4O7OsRLMRKmgYOMPqPfma+6mha3CSOunEPWKD7nn9NVhwy97BunTYz9HVo+osY11uNV9
 EpZVDeAjbbRRyYAmAXUU14RDmkeSSmg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-bY4Qzeq0N7G7xmr7GeDZzA-1; Tue, 17 Mar 2020 06:38:08 -0400
X-MC-Unique: bY4Qzeq0N7G7xmr7GeDZzA-1
Received: by mail-wr1-f72.google.com with SMTP id b12so10554116wro.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D6MNZXtfliGuRPR44K0/eF6ufdgPIGArj9GgKKpb86M=;
 b=LnMLtF0PlP6uBoqNA9ctiRJZ9o5sVugOVXAdvNuf2GDdeifCLfcqBPyg3MTe8keFep
 sjiwMRdkZmuiwmxGecJZfIqp1M6IOVMsE1XaWQ4urMf/9Oj172leRlDdutB4rnoIH74d
 8Merqh857oxCMhfIOO4H1/SZS5QArbkHmLQ11fwc0hf81UtHADGTmh49HYoUecvBtT2A
 JYMWVnsjldVMQDb3B+iOGFLCJvrKYv10fwoautpeYWdXcortJCogVsqricNdo8g3Na9Z
 e5/+MjrBqzei3Mo9snqRC51y0QJ+2+R+JHyERPLzkMVbY5c87CeD/aCFjJgZzYUwvPhm
 ax7A==
X-Gm-Message-State: ANhLgQ0V3jBg2P2OLnFzWpaugasPKR+3u+PrSwABiQCoS7UbFpVR5xRQ
 QhCdR9HOMVZP4mil4nb+vHUbr6SUE3l/dKjO0m0XU+IHxye7oXuH9DPkbQ4xzjHI3N/gTPZqP10
 OMPdmEUCXSXu8fQE=
X-Received: by 2002:a5d:4707:: with SMTP id y7mr5122521wrq.278.1584441486896; 
 Tue, 17 Mar 2020 03:38:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsjPl8ByKi9IRPnbZ8YkdIxDC25O7XOJRegXic4qM5HtkOwrcZkPHOFbkSaLUDHaJwAbbuCZQ==
X-Received: by 2002:a5d:4707:: with SMTP id y7mr5122512wrq.278.1584441486742; 
 Tue, 17 Mar 2020 03:38:06 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id u7sm3308451wme.43.2020.03.17.03.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:38:06 -0700 (PDT)
Subject: Re: [PATCH v8 03/11] iotests: ignore import warnings from pylint
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200317004105.27059-1-jsnow@redhat.com>
 <20200317004105.27059-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ce04abc-341d-12ed-61cb-1f9b45387178@redhat.com>
Date: Tue, 17 Mar 2020 11:38:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317004105.27059-4-jsnow@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 1:40 AM, John Snow wrote:
> The right way to solve this is to come up with a virtual environment
> infrastructure that sets all the paths correctly, and/or to create
> installable python modules that can be imported normally.
>=20
> That's hard, so just silence this error for now.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index a6b2889932..cb9c2cd05d 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -29,6 +29,7 @@
>   import io
>   from collections import OrderedDict
>  =20
> +# pylint: disable=3Dimport-error, wrong-import-position
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>   from qemu import qtest
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


