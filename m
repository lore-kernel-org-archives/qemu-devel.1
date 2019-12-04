Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4A3C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7402F206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItS6DlsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7402F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icW2P-0001lr-Lv
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icW1m-0001Mb-6o
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icW1j-0003i6-MX
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:53:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27421
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icW1j-0003hl-8L
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575471194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CiEHqC6aFPhTzJEEp6MzIEQldBgZz94IPg5Tb6/ceuE=;
 b=ItS6DlsD04BzzbqJfn4WcydAz7+dPLuQJ2p9MPDWGSNI58Nln79Gh7rqzJbpkldXdKG+l4
 hJ1w+/ogbOobKqFcLDsvi+WMq1/OyS1/QHBxq1Kyk9JBpD8CPdaG0cRrntUCdIKx/kj5Hx
 52HZcN/mfofmFwaKGdOo1cDa06zwGP8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353--JiJzSyyOiG_xgRr4DerOA-1; Wed, 04 Dec 2019 09:53:13 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so3717933wrm.16
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F43yghNVsQGUwgtnMuk6EepJC4p+nnAtkdwZBFC1RXo=;
 b=O/iBM0LZptX0grnN6cDLM1iXUF+4PbhH5QbwJzCrZSxUNoeREHqAeiPhoBkJ4SNh28
 iuQzotR00dk2VdR0Lq6D8IHHZdRIGMOtXO1tiPRb6qsonCTHc4FoO0rOkBPb/qyWDltL
 k0Wo7bS8tYQ8eJqxIBwAyUO9ozYRjfD57fmuVmJyLdH8zXZQ+N/3yMwVVY8dx9L+OxYD
 5uSsXpmkv5z9zyBkzoSiwzKuBOiIcBfIryqTsV2GZWB1HY07s0zY3LrIEwVwPAY+SrlW
 Nh4VW8vzvh4K//u1MMxTRtPff/JdmZccSbfQVGeaz/ibsM81EsdXgv/i+VMoiShcRVFC
 UKCQ==
X-Gm-Message-State: APjAAAVioWkLxiBr7rFqkz0zxCD8pZjAXNCWnFeO6iRB7eyOHw7pjXJU
 IGj0Q4MyIwJMNLNzugM9+c3Zv+Agw7TER9CfU0qGaFgMoT8YQ7JAKCbueeboptDeqhvk1tv2tiq
 rOcdr7HpBZ3eUnR4=
X-Received: by 2002:adf:e609:: with SMTP id p9mr4282830wrm.397.1575471191906; 
 Wed, 04 Dec 2019 06:53:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqyELtyexmPZry3erdTrSFHCw1hrgSb/axnYjUFv8Ml9MM/7KhRYT8T1NofRUsQGNodTVQQxXg==
X-Received: by 2002:adf:e609:: with SMTP id p9mr4282812wrm.397.1575471191712; 
 Wed, 04 Dec 2019 06:53:11 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id s65sm7176820wmf.48.2019.12.04.06.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 06:53:11 -0800 (PST)
Subject: Re: [PATCH v2 05/18] exec: Fix file_ram_alloc() error API violations
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9002a45-efe2-bd83-aebb-78d53a0f9a70@redhat.com>
Date: Wed, 4 Dec 2019 15:53:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-6-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: -JiJzSyyOiG_xgRr4DerOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 10:36 AM, Markus Armbruster wrote:
> When os_mem_prealloc() fails, file_ram_alloc() calls qemu_ram_munmap()
> and returns null.  Except it doesn't when its @errp argument is null,
> because it checks for failure with (errp && *errp).  Introduced in
> commit 056b68af77 "fix qemu exit on memory hotplug when allocation
> fails at prealloc time".
>=20
> No caller actually passes null.
>=20
> Fix anyway: splice in a local Error *err, and error_propagate().
>=20
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   exec.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index ffdb518535..45695a5f2d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1841,6 +1841,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                               bool truncate,
>                               Error **errp)
>   {
> +    Error *err =3D NULL;
>       MachineState *ms =3D MACHINE(qdev_get_machine());
>       void *area;
>  =20
> @@ -1898,8 +1899,9 @@ static void *file_ram_alloc(RAMBlock *block,
>       }
>  =20
>       if (mem_prealloc) {
> -        os_mem_prealloc(fd, area, memory, ms->smp.cpus, errp);
> -        if (errp && *errp) {
> +        os_mem_prealloc(fd, area, memory, ms->smp.cpus, &err);
> +        if (err) {
> +            error_propagate(errp, err);
>               qemu_ram_munmap(fd, area, memory);
>               return NULL;
>           }
>=20


