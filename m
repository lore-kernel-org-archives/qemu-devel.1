Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0FC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D4F2051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmUjIbg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D4F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzoj-0006Jl-0d
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipznN-0005Ru-HJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipznM-0005uW-H3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipznM-0005qy-CK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578683887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJMRTmD73YrvtDcmHBaxB3g/Hq9FirRR2LL7d+2izCE=;
 b=hmUjIbg/sCcOQ6MgCRXDh05EmcVZdd2xfWteK+qzfmaNhg1EtQiLcP00LwtK3ShB1vHGYb
 Ol9mgqLQv8t2EjaH55eFR6La3eD4CevqHKyNs4HzmTrzNeObcyYGYV7cjSQF54dESkdW+4
 KQPaBXtc9DrPiZ1qqAT2DHrhWuUy5AM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-U2saWNCvMn-MpRhDW2_JcA-1; Fri, 10 Jan 2020 14:18:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so1333360wrq.12
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VMDMKhJEm+cwbf2c+qwNVU7aiK8IAMsRfX307bf8tKE=;
 b=U9992tSp9BG8uZhoBz2NjKE7VD9VIvAZYu8SnzkxlyCh1yais6edifzxlQ9Li1y5oE
 7RhY6eg7dB2G0oacDevEko9ce3xwb1n8xKkIeIPJc7qDc30vnds5ft/DVZwxMTvqdX4X
 OhZZ4Hx0W5w/EC18isFLQxqcnyQ8YBaRwq13dwz9ZpTqWj/fDNbG4vhe5M0J6vwIb+nF
 AYzYeyNotif9uHFOwGIf+39iCKD5lxAq7IZv0TJLkZoruhDWfT9NvWHqC2lKKVLmRjPU
 rLxw1GIxsTpuVcnW9/3qzLbFSbqj+DBp+lJzfs+9Ede5nl0jn+OWeYopuGMVfzgCiHgt
 dr1A==
X-Gm-Message-State: APjAAAWIm0et0pQYOzzDeM42f3A9oon6s7PlyqWTcnLy5SlGyrPuwrdb
 6F2AftsTb9GEbeflbzKAgXU18l6WjHy7qHpEbaWreMwXyGcfgMdcshH4xjvagAibtKpuXgWpj74
 nCjOhxhmxbRfvaQg=
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr6089839wmd.112.1578683883313; 
 Fri, 10 Jan 2020 11:18:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKsuOUCOCh1EXnkFOru4Om9WFY+xu5gGoMpghF9sboOvvIDx/ZvJIVJNAVmQQURHx1+VzJtw==
X-Received: by 2002:a1c:96c4:: with SMTP id y187mr6089826wmd.112.1578683883143; 
 Fri, 10 Jan 2020 11:18:03 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id u1sm3302970wmc.5.2020.01.10.11.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 11:18:02 -0800 (PST)
Subject: Re: [PATCH 01/26] object: add extra sanity checks
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c5f7b584-b48e-7366-e766-48e7f28c7be9@redhat.com>
Date: Fri, 10 Jan 2020 20:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110153039.1379601-2-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: U2saWNCvMn-MpRhDW2_JcA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 4:30 PM, Marc-Andr=C3=A9 Lureau wrote:
> Type system checked that children class_size >=3D parent class_size, but
> not instances. Fix that.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qom/object.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 0d971ca897..8453e4ac91 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -303,6 +303,7 @@ static void type_initialize(TypeImpl *ti)
>           int i;
>  =20
>           g_assert(parent->class_size <=3D ti->class_size);
> +        g_assert(parent->instance_size <=3D ti->instance_size);
>           memcpy(ti->class, parent->class, parent->class_size);
>           ti->class->interfaces =3D NULL;
>           ti->class->properties =3D g_hash_table_new_full(
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


