Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDABC432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 19:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DDC20833
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 19:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdMXuVP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DDC20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibUzG-0008HA-Id
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 14:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibUyN-0007Vv-6T
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibUyK-0006Mq-KG
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:33:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibUyK-0006MW-4w
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 14:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575228811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHvQDJqNp7ByjRu9V6eOMc7D3nINfkrxapMpImD91io=;
 b=HdMXuVP0KNcVzHmK9QPwoZLQ/8pG2+DyKabAyh3xxQ/hV6u9/cPEqaSqLfV8KPzMsznzyd
 d9y9Kwx/EQlTRH6STcnCm0qSCnReDCVO0e8+jpwJ6SF1MyVFYQK2XHHiBLYcMKJGdV+SKx
 Cn9hySHam8GhsqJirBl8XB4IYodq230=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-RyRTp6EuP-uDwrivlXgTkg-1; Sun, 01 Dec 2019 14:33:28 -0500
Received: by mail-wr1-f72.google.com with SMTP id z10so2633374wrt.21
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 11:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2URQXwPtf4xM7EktsSJn6PPkfN98ge1KQ5Iq4MDg5e4=;
 b=Nu6Cdzbsh28tzQy+NbBJ0sUOAIBviZZ24XzB+LP8MR8PZlpgi5r4oFXWh4ZkkWAi+G
 FrwaUTBF8b0PXYAfOWmBxzV/SSi9T1RD+jXWb99IL6fvMCfvy1JPy8SKGLAvu69awovh
 28MsMmb42WWKbIiNO/2srsjx81TPklycKQwy77Yz/eMB8UTKSkrdcD1rOX3WSOfF6n/A
 wsPWdL3DCwwAE7GwCbQEvWzFfuKumkRxBsb45GUWRXgIu8MHQMENKhj+ux89Ar32J3lX
 sGGB2KMQhZ1/hoH9mP3BlLsgsl+oXcbB4VTASGD/vNuJhY1hugdTxG7pawYArhmkeWnt
 EldQ==
X-Gm-Message-State: APjAAAUW5qodmHUP9ldwEPl45lGfhuJ1y/0zDat7FR9Ndst2YySxNZui
 OhGv1BCsB7htDFqoGJF+pE/s8dLJdqyDIAk4rdZL12GwmIPDD5n0fpycQS6PFzvU5A49lNxsaD6
 SCTA1JZjpx/lZwyw=
X-Received: by 2002:adf:9f52:: with SMTP id f18mr63781259wrg.51.1575228807193; 
 Sun, 01 Dec 2019 11:33:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1eDKWALVFTf8GfXBlfHXq0+7ePUkbyTvV/I+rEUYMCKAWdU77rb69l2ZSVF6kejqYqXaErQ==
X-Received: by 2002:adf:9f52:: with SMTP id f18mr63781250wrg.51.1575228807009; 
 Sun, 01 Dec 2019 11:33:27 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id f24sm19896682wmb.37.2019.12.01.11.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 11:33:26 -0800 (PST)
Subject: Re: [PATCH 01/26] object: add extra sanity checks
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191201111531.1136947-1-marcandre.lureau@redhat.com>
 <20191201111531.1136947-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f07b7096-bd31-feae-16d2-db0a548f9243@redhat.com>
Date: Sun, 1 Dec 2019 20:33:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191201111531.1136947-2-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: RyRTp6EuP-uDwrivlXgTkg-1
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 12:15 PM, Marc-Andr=C3=A9 Lureau wrote:
> Type system checked that children class_size >=3D parent class_size, but
> not instances. Fix that.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qom/object.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index d51b57fba1..935491d334 100644
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


