Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167D7C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5496206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDRoDKFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5496206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3pM-0000NW-1X
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX3kg-0003TJ-3H
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX3ke-00085t-UJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:41:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX3ke-00085E-RD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574170864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvLEma868VerfcY9cGL/XZHbyX6+aMoYXkvfMFpv2HA=;
 b=jDRoDKFD5vWVYpca5zQ9eRx15xCuM1RLvEa82ov2SfUdeqq00My4v2lFPE6VCJDcxSz2i9
 XdxLwArOoHlSUfwwzNUUc/dI2Z/PWbz4+P6KdGDdQsk3m+F1wTHAWqLZUczzAugxABO2pM
 U/PlRrd/zDaVJ2kZfJEkBXT6e/prjTM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Q0xfBkXqP_CGs6K6I6ISTA-1; Tue, 19 Nov 2019 08:41:00 -0500
Received: by mail-wm1-f70.google.com with SMTP id m68so2431641wme.7
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=caSvQYXVu5p8CaLM5JD5sNI7gfZU9ArDc9kdEyBZJFo=;
 b=jlhJ8FQ8ac5mwwJdoar0MgPblgiAzrZcJOe3QBIjTVeAykB3KoDG4jIIMH3kDETTiA
 6lZi21mVfBFvZt12oqD6HHWGdSRexErf4hMfkpsNKV1p4lfdt06W8UHggTs5m0boXXKj
 vunVsXkRQZjyIMtPu2oCOPt4UtDZzPD13YsVqtaIm1CfoWf1U5ENuEDK7dNGMSlGjLlN
 i3fQ4oV6hSHXi5Ti1fSnn26egM0A7j4Ufuzf5WCapOFSSLmM2CUGe3XzKpwpsXqllGBv
 K6W9UigqLvpvuk0jhT7o3BtouOHz053PvXs8VsNzLG87UrwI8s3C/Du9qa6y3GG2YQIn
 ZfTA==
X-Gm-Message-State: APjAAAXc8/hmyVCDMeZd4MzKjuGxV3ms+UgAeSRVhbJO4tN3bSHcZa/j
 FKo+jiEXVJYb7dCvFVofn5jfWJI8WUCyYVdkRs3A+poAZ9XgNsHVv83tRQghHOHmIvkDTP7DkQZ
 /2fCOb7aQIEIvBKk=
X-Received: by 2002:a5d:4142:: with SMTP id c2mr10102720wrq.60.1574170859302; 
 Tue, 19 Nov 2019 05:40:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXbxF8Szt+fFPoBeKoGCW5nMpyrJ/yJhyiGso0sfxuG0PmRNjMm4NW1NSUN2Q/6Kd/jjYugg==
X-Received: by 2002:a5d:4142:: with SMTP id c2mr10102700wrq.60.1574170859128; 
 Tue, 19 Nov 2019 05:40:59 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id w19sm3089247wmk.36.2019.11.19.05.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 05:40:58 -0800 (PST)
Subject: Re: [PATCH] monitor: Remove unused define
To: Yury Kotov <yury-kotov@yandex-team.ru>, qemu-devel@nongnu.org
References: <20191119110709.13827-1-yury-kotov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1368c05d-a7ba-4a62-8325-8d49d33f6e84@redhat.com>
Date: Tue, 19 Nov 2019 14:40:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119110709.13827-1-yury-kotov@yandex-team.ru>
Content-Language: en-US
X-MC-Unique: Q0xfBkXqP_CGs6K6I6ISTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 12:07 PM, Yury Kotov wrote:
> Remove the definition of QMP_ACCEPT_UNKNOWNS as it is unused since
> refactoring 5c678ee8d940
>=20
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>   monitor/misc.c | 3 ---
>   1 file changed, 3 deletions(-)
>=20
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 3baa15f3bf..6680734ea1 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -106,9 +106,6 @@ struct MonFdset {
>       QLIST_ENTRY(MonFdset) next;
>   };
>  =20
> -/* QMP checker flags */
> -#define QMP_ACCEPT_UNKNOWNS 1
> -
>   /* Protects mon_fdsets */
>   static QemuMutex mon_fdsets_lock;
>   static QLIST_HEAD(, MonFdset) mon_fdsets;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


