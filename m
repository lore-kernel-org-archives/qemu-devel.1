Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C3EC4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D98520732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B4N4Xe/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D98520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sVO-0000wF-68
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6sQh-0000eU-J1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6sQg-0002m4-CU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:52:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6sQg-0002l1-5X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1xNCtymxtj6oq1AZIuwVUL0tbu7yr3DTKwTvuS6YDg=;
 b=B4N4Xe/vteSqsWxZhCqJMIfAmRhEAYvFnU5j/kbpsnXuNXMbK1rHHUyYNn53av+Vd8p2aH
 nT9VOAxRSf08j+2hX2QH3fg1IxLOxAnelwCwXSEAXY8bvqEWri3GgMuoRThY+qSRxXTMKh
 O44qzxztYR8yuUC/91wI1RpfUy9S4s4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-qYFG_y6QNUS73S3hBeF4YQ-1; Wed, 26 Feb 2020 03:52:27 -0500
X-MC-Unique: qYFG_y6QNUS73S3hBeF4YQ-1
Received: by mail-wr1-f70.google.com with SMTP id s13so1166400wru.7
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+n9w1MLBMJGohIcxOdLeECKJqC7Wx8SbYRANQglwFl0=;
 b=KxEKNDZ0F64yAECWEmSAr1GCY17vtgrqD/G7k/PqBYFwHLjGBhQS7WHUyukIIEyMCv
 xzrrIOVYaXefL2i11dEByvFuUxHcnfFVc39Km42La69bAkcHKSbsnVgoTiwH6Xx7T6s5
 YLJeoxLk+Pz4r21vuN2znEu0Ujnswhh0qdQJTFxq+V/INtZC0vPlu33RFHjOhw3Upvqc
 eQ1lUV23aX9Tnaoi4NcMhcxkj5hYdeTDbug2F/UW+8NM9lcL0ep+QB2GUy0hWZRzzrPR
 V0vmGj5oOhJ2Ju0lfiPNih+DU3OaZ70Fcvy0zyXbaJi9cHDAAFvj4OZnm3MhZDyKG4tM
 HA4w==
X-Gm-Message-State: APjAAAVXum19Kv+RYw8DHDl3Bgxwa57wOLZycdDABsNAgzaRzZknMdUa
 +HOknM4nqehrcJA91whRdQkchl2zSsbFWdjci7oJ0qd5YA63WX9oSrPKW5Q5SI6lYSJCdSIiJ2/
 I7WVoSfpVsvB9Hgc=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr4329932wru.398.1582707146249; 
 Wed, 26 Feb 2020 00:52:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRBojHao0j2iVhjOC5b2oSR+bHRRgtH0gUVwYC9Qt9n4b4NKP8OV3FYhlqKo5aHh71JeHNSg==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr4329893wru.398.1582707145857; 
 Wed, 26 Feb 2020 00:52:25 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f1sm2303350wro.85.2020.02.26.00.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 00:52:25 -0800 (PST)
Subject: Re: [PATCH v2 13/13] monitor/hmp-cmds: Remove redundant statement in
 hmp_rocker_of_dpa_groups()
To: kuhn.chenqun@huawei.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-14-kuhn.chenqun@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8452ca98-a729-77c2-d79e-dcf0018f1836@redhat.com>
Date: Wed, 26 Feb 2020 09:52:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226084647.20636-14-kuhn.chenqun@huawei.com>
Content-Language: en-US
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 9:46 AM, kuhn.chenqun@huawei.com wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>=20
> Clang static code analyzer show warning:
> monitor/hmp-cmds.c:2867:17: warning: Value stored to 'set' is never read
>                  set =3D true;
>                  ^     ~~~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> v1->v2: move the 'set' declaration to the for() statement(Base on Philipp=
e's suggestion).
> ---
>   monitor/hmp-cmds.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 53bc3f76c4..c6b0495822 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -2808,7 +2808,6 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const Q=
Dict *qdict)
>       const char *name =3D qdict_get_str(qdict, "name");
>       uint8_t type =3D qdict_get_try_int(qdict, "type", 9);
>       Error *err =3D NULL;
> -    bool set =3D false;
>  =20
>       list =3D qmp_query_rocker_of_dpa_groups(name, type !=3D 9, type, &e=
rr);
>       if (err !=3D NULL) {
> @@ -2820,6 +2819,7 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const Q=
Dict *qdict)
>  =20
>       for (g =3D list; g; g =3D g->next) {
>           RockerOfDpaGroup *group =3D g->value;
> +        bool set =3D false;
>  =20
>           monitor_printf(mon, "0x%08x", group->id);
>  =20
> @@ -2864,14 +2864,11 @@ void hmp_rocker_of_dpa_groups(Monitor *mon, const=
 QDict *qdict)
>  =20
>           if (group->has_set_eth_dst) {
>               if (!set) {
> -                set =3D true;
>                   monitor_printf(mon, " set");
>               }
>               monitor_printf(mon, " dst %s", group->set_eth_dst);
>           }
>  =20
> -        set =3D false;
> -
>           if (group->has_ttl_check && group->ttl_check) {
>               monitor_printf(mon, " check TTL");
>           }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


