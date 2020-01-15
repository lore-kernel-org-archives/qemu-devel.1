Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9986EC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664F1214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax7fNLWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664F1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irjb8-0000NW-BK
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 09:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irja8-0007hU-36
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irja4-00047i-ME
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:23:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irja4-00044K-EH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 09:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579098215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JdCxw6XnCicowe4RJszEpJSP82yT9nfuPX2ijwQgyY=;
 b=Ax7fNLWIbOgFVwml1J4Ufa/MqXv5fnFsi4EkTJenkzbThAB6VEr13clkFzqIvpS7k38KhZ
 DK1ma3gc4+48K+L0v9c8g24kzidtDHoni5nt37Mh2qfMFWdaycE2u7JQ84BR4iJ5cPOIFt
 sjt7/O4accvA7u6frPSHvpnvlqoafAE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-MQLB4CkxPrChoZxqw71zAg-1; Wed, 15 Jan 2020 09:23:34 -0500
Received: by mail-wm1-f71.google.com with SMTP id o24so6813wmh.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 06:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yvRind2xOdehdgIcHXbQasR8YkR9F+Ogl7BUp6rPWOs=;
 b=Y/TmqCwyVMabkhIMRHeQ2n7mAAYDBNPopOsVI7SCQbxGsuBp90YG9NxFNs3weUIHoj
 Zva667Pqf29+ETVD0uVfw5kBYFRt2QLY1B+4Yg2zTXAxV5OUSaXBkoJRVhYYkwwP0oJA
 A89u1MferiVvTAxBRL6YXEtw7hSfGtipcG4vP9EPk1IanaZDq3jxBJTPN9ULlBdQjVLQ
 v0EAhkQMgDqbrzlT0Fm6tGyulXfHC7qW5khsH/ozIdXw6qJGAAusKqfRwI6upylXoqMd
 DcBpehID/1dio446fdSL1PF8C1sl7EmomgpbPC++ZAsOptbMm370S5Nc3Yqfm25KAvea
 hpvA==
X-Gm-Message-State: APjAAAVuKK7hBrjcACfAvWFJPHIanGBR1pRBjV19mRCMmQa3MbtAu3cf
 q8U3y/CxCL2uM7HjrbmLSrBcoYXq6VcOy2vIheNUEYioPXm0I+VapcWcmkpoOCWeQNZdEshLKTF
 N3eMhGi6H7F6g/C8=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr32323532wrq.206.1579098213195; 
 Wed, 15 Jan 2020 06:23:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfcLeRpOF4J7SCGNzK+uAsugk9T85Q866o23B8BmZp2iOyoOZPLKpDbgCBAa8bt6mXUT2oGg==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr32323505wrq.206.1579098212895; 
 Wed, 15 Jan 2020 06:23:32 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id n14sm22612428wmi.26.2020.01.15.06.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 06:23:32 -0800 (PST)
Subject: Re: [PATCH v2] qcow2: Use a GString in report_unsupported_feature()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200115135626.19442-1-berto@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <413ac14e-306d-5e57-fa54-10fce9a5a058@redhat.com>
Date: Wed, 15 Jan 2020 15:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115135626.19442-1-berto@igalia.com>
Content-Language: en-US
X-MC-Unique: MQLB4CkxPrChoZxqw71zAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 2:56 PM, Alberto Garcia wrote:
> This is a bit more efficient than having to allocate and free memory
> for each item.
>=20
> The default size (60) is enough for all the existing incompatible
> features or the "Unknown incompatible feature" message.
>=20
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   block/qcow2.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
>=20
> v2: Use g_autoptr and update commit message
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index cef9d72b3a..e29fc07068 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -453,16 +453,15 @@ static void cleanup_unknown_header_ext(BlockDriverS=
tate *bs)
>   static void report_unsupported_feature(Error **errp, Qcow2Feature *tabl=
e,
>                                          uint64_t mask)
>   {
> -    char *features =3D g_strdup("");
> -    char *old;
> +    g_autoptr(GString) features =3D g_string_sized_new(60);
>  =20
>       while (table && table->name[0] !=3D '\0') {
>           if (table->type =3D=3D QCOW2_FEAT_TYPE_INCOMPATIBLE) {
>               if (mask & (1ULL << table->bit)) {
> -                old =3D features;
> -                features =3D g_strdup_printf("%s%s%.46s", old, *old ? ",=
 " : "",
> -                                           table->name);
> -                g_free(old);
> +                if (features->len > 0) {
> +                    g_string_append(features, ", ");
> +                }
> +                g_string_append_printf(features, "%.46s", table->name);
>                   mask &=3D ~(1ULL << table->bit);
>               }
>           }
> @@ -470,14 +469,14 @@ static void report_unsupported_feature(Error **errp=
, Qcow2Feature *table,
>       }
>  =20
>       if (mask) {
> -        old =3D features;
> -        features =3D g_strdup_printf("%s%sUnknown incompatible feature: =
%" PRIx64,
> -                                   old, *old ? ", " : "", mask);
> -        g_free(old);
> +        if (features->len > 0) {
> +            g_string_append(features, ", ");
> +        }
> +        g_string_append_printf(features,
> +                               "Unknown incompatible feature: %" PRIx64,=
 mask);
>       }
>  =20
> -    error_setg(errp, "Unsupported qcow2 feature(s): %s", features);
> -    g_free(features);
> +    error_setg(errp, "Unsupported qcow2 feature(s): %s", features->str);
>   }
>  =20
>   /*
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


