Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD4A20774
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux7v2aRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD4A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEX0L-0001Ii-86
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEWza-0000tG-1Q
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEWzZ-0002Gs-2t
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:36:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEWzY-0002FE-Vw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584531368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0EN50PpirPuAzriyjWE+bSkUoFZfq+5a7TDRlk6F0E=;
 b=Ux7v2aRky/Juacsx1m92YeBJE7lVgpsTZUPr4Ip+lr3OMYi6PlY2uV0nkYkVG6oFmRO0Li
 ZmG0ErNfER/Gq1Tt97O0jEk58r08rGYHUs9/wQkEtRmDAJMkv6eFNv9cDBCxpeE27QRxzj
 77LKgzR9AkR7YA+yylHNoT+WiN70kk4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-LNFOYNtIPESAZp6AAyoC7Q-1; Wed, 18 Mar 2020 07:36:06 -0400
X-MC-Unique: LNFOYNtIPESAZp6AAyoC7Q-1
Received: by mail-wr1-f69.google.com with SMTP id q18so12171397wrw.5
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 04:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Z5JwuEqykuNtz9ABdEwLGvhJdpzuX9wqPiURWqkI3k=;
 b=XBCN0fMc68YOdgSHefZX2nqNuWjVkFoFG5AO17uugnB7FU4TndSZIVwib8qMnFOm/E
 ozCnHoNJgDNCa5sIey9aN5QcYNRdAVaWCbKZTdRehnlbvuX4IvmR9D54TEoRimb3AM/k
 THor18SrjxMWw+4N10X0ZMo5dx9w6+pdOJLYP7eYFJ7KPAszCb35ZduAqPi2y5vFVxo4
 JKvXxyzfxKuMh8ffxGkbefekUWO74mWM0vPw+GmUkUOMh7LwySP35qZwk+9jegfxX12D
 dJrAR/04t+p4daP+9ky2+Y6NTxa41NNqcAYxj8Ps2sKnnoeYC50ePA1ABLWQ7oLREWrK
 ZF0A==
X-Gm-Message-State: ANhLgQ2S1rdBl+8GDXdzMG8PU8JWZIyQDfR3nE3awMwzb+OI3QwsOG+g
 KBD862ASwJttJhVCaD96015kLou9N52XyGtQbZwpN6v4sGFin/Ti+U4HI7KGTVmqs6IPKXVYZD3
 fpK8SqGarhkAi7V8=
X-Received: by 2002:a1c:2786:: with SMTP id n128mr4638520wmn.47.1584531365618; 
 Wed, 18 Mar 2020 04:36:05 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsmmLeSTVe7n2U8N4PpQOmDZYuuu+e12SDkmfUEV5DP1Hd0+IIFpKT31tQcBF7quREY8aoqEw==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr4638497wmn.47.1584531365413; 
 Wed, 18 Mar 2020 04:36:05 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id k3sm1232181wmf.16.2020.03.18.04.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 04:36:04 -0700 (PDT)
Subject: Re: [PATCH] hmp-cmd: fix a missing_break warning
To: Pan Nengyuan <pannengyuan@huawei.com>, dgilbert@redhat.com
References: <20200318071620.59748-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <739d3652-bfd6-cd35-7f68-01d916d62e0a@redhat.com>
Date: Wed, 18 Mar 2020 12:36:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318071620.59748-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: zhanghailiang@huawei.com, zhukeqian1@huawei.com, qemu-devel@nongnu.org,
 euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 8:16 AM, Pan Nengyuan wrote:
> This fix coverity issues 94417686:
>      1260        break;
>      CID 94417686: (MISSING_BREAK)
>      1261. unterminated_case: The case for value "MIGRATION_PARAMETER_THR=
OTTLE_TRIGGER_THRESHOLD" is not terminated by a 'break' statement.
>      1261    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>      1262        p->has_throttle_trigger_threshold =3D true;
>      1263        visit_type_int(v, param, &p->throttle_trigger_threshold,=
 &err);
>      1264    case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>=20
> Fixes: dc14a470763c96fd9d360e1028ce38e8c3613a77
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: zhukeqian1@huawei.com
> ---
>   monitor/hmp-cmds.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 58724031ea..c882c9f3cc 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1261,6 +1261,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
>       case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
>           p->has_throttle_trigger_threshold =3D true;
>           visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
> +        break;
>       case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
>           p->has_cpu_throttle_initial =3D true;
>           visit_type_int(v, param, &p->cpu_throttle_initial, &err);
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


