Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB5C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 06:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DD6206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 06:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEQFY1z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DD6206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioiq5-0007lj-3R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 01:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioika-00077F-Cv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioikZ-0001kQ-6m
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:54:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioikZ-0001k5-2w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 01:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578380038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0z8s7inqPti53d0DxeLpcWos8iVLQQpcUsiMQ0VTNw=;
 b=KEQFY1z1TyQX+X1OeyOkdTiOpYh9jJ5lQi5iNkv2ZaQEEI44Bymbpp8gBvapVq0HgcSHve
 6EYMs1e42sM2AmVRbjJf/NSMBr8uReMTM2/j5vGfZstvND5KIWOcxajVK1jWC8A7VSOoNi
 VF6mNhJZeQ2C7IRuVWnrWhCCRrwPaC8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-1bt_dA2NPbyy8UCsleAUdQ-1; Tue, 07 Jan 2020 01:53:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so24004740wrt.21
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 22:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dzs0OkxOzmXTEn6EoTe06Ew8wnWIXkT7FoNjhS0sZ5M=;
 b=l7b3N8qK/J2+YeZUnzmzO6EMB/96YnguShvTUc6a7pAq+ZCpA9bK5OU88EIltkCpFl
 p3sypWvZNycGO3mTEevVnx2YMrJZDI+hj7yqbWKbqKrA3fcCEG4jfwic2EbVA49C05g9
 kpXwaV/P8/XyJVfGB4rSZJknkas8AV700EFKc5NqMqB33Wx5GLGn16hB2xcZbu7h0q9M
 H0PwK3p31sHc5aeWBX3Q1/ISqoR6FFcxYLPLTiWiIix2pZKa9GCd/k5D+GraiWjyCpS5
 UzdkCSI4fLpP/WsHpULsBtsQ6OY66ThqesNGSwzWLT+7w6WBS7sxsBeU1yMz7NNjLoX3
 0o+Q==
X-Gm-Message-State: APjAAAWqcLJooW+JwZuuXA0uMRJin2TPhAWnSNBxHQCGhUCdkDpzW6sM
 xfmcXNhGcH3con1lEJiEDzWECWWGia8dOeWSXlgFH3J71ju8G96h+tng8yQK0zjtBFyV8+JcYWL
 gStR4kXiFfTUdUvY=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr111710602wrv.0.1578380036112; 
 Mon, 06 Jan 2020 22:53:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4bqDSESASD66T0iraqarQ9LkWer/zDViuMkKCd0sHAsIHPpvcNrVf+zNfIjP+1M9e3CXCBQ==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr111710587wrv.0.1578380035934; 
 Mon, 06 Jan 2020 22:53:55 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id 18sm25206502wmf.1.2020.01.06.22.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 22:53:55 -0800 (PST)
Subject: Re: [PATCH v1 29/59] cryptodev-vhost.c: remove unneeded 'err' label
 in cryptodev_vhost_start
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-30-danielhb413@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8ed44d4-d56f-1e2e-92eb-24830d20696c@redhat.com>
Date: Tue, 7 Jan 2020 07:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-30-danielhb413@gmail.com>
Content-Language: en-US
X-MC-Unique: 1bt_dA2NPbyy8UCsleAUdQ-1
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
Cc: qemu-trivial@nongnu.org, Gonglei <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 7:23 PM, Daniel Henrique Barboza wrote:
> 'err' can be replaced by 'return r'.
>=20
> CC: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   backends/cryptodev-vhost.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index 8337c9a495..907ca21fa7 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -201,7 +201,7 @@ int cryptodev_vhost_start(VirtIODevice *dev, int tota=
l_queues)
>       r =3D k->set_guest_notifiers(qbus->parent, total_queues, true);
>       if (r < 0) {
>           error_report("error binding guest notifier: %d", -r);
> -        goto err;
> +        return r;
>       }
>  =20
>       for (i =3D 0; i < total_queues; i++) {
> @@ -236,7 +236,7 @@ err_start:
>       if (e < 0) {
>           error_report("vhost guest notifier cleanup failed: %d", e);
>       }
> -err:
> +
>       return r;
>   }
>  =20
>=20


