Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8FDC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311992465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 01:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Goq9HWPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311992465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii6q8-0000qe-CK
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 20:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ii6oz-00007e-Qs
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ii6ox-0000cU-33
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:11:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24714
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ii6ow-0000VA-GF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 20:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576804269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8++OILG2TTrNwL/Z0xpS2F6Qqjr6SUsjxZ0rkj+sXc=;
 b=Goq9HWPZs6KOAIfBYHroP+pntkXY6osFTmikqScJoaAXNVNRthQKqWEBqI/8tICmO7L6JS
 95XEy2XOhgnrNH+XYDGZYQ+eCsl42JnEeaT8FivLHlI8vuZrSQ/3TZ2BKDjFKdUjW66EQM
 nynIR/2cDWBUbD9QDAhy4+6SmH+gAzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-PViVPTvKM4OcC8cri4EJ9g-1; Thu, 19 Dec 2019 20:11:08 -0500
Received: by mail-wm1-f69.google.com with SMTP id m133so443876wmf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 17:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uhdesa4goZtiQXEevP0fj8oxsWWgu8BLTmzyOL1QJ94=;
 b=Xm2wj9SSoP41TYE661fCIlkE+FdnbHzDu0zhrb30T9qe1GoKEtUGJ82Ln/3OAU0PPQ
 oFSAEE29c+U6vb82AWXTJ/b3X8CZVvh3SzGt86RVbJbLUenL8DBxGjsy0ofzdO8SR/vj
 XIEzLo5rRpbYClkdBj7mQhFAMmpHNDctos3+SQqJ8Pf8FdKEJF62JPDC9s16nXApSdHE
 zjAXqeybRoQlEtoieypkw0CWknppbyEYzIfOswdOb5dBG2V9qXIxUUGwE+YmfvvbzPm5
 iDAndwzzTIZJ9N1P3sU/k8VfJHVk7//lPkdbpK8HnaywfGr3ZIUUNywoNT0YLhUWVksp
 jWpg==
X-Gm-Message-State: APjAAAWm5Ol8NuEe3+3xWyhwPZW2taRQFbfgCgkdhDGZGrxh1aFityf7
 HJtxjfnrYJFWWzyO7VPPOs4wTvvMj9qPutxHzArKBvVeTCv5fA66j6JoBvvCzYnUpjNeGDibTID
 PEWoPReXMA27sekg=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr12062340wrp.321.1576804266572; 
 Thu, 19 Dec 2019 17:11:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwk23S3lEKX3ZWrK2NgH/xzcjkmUYTcZJ8ANxta9deW2Ornu5QMUPocid9db3rls9jans0Wig==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr12062321wrp.321.1576804266372; 
 Thu, 19 Dec 2019 17:11:06 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c2sm8231845wrp.46.2019.12.19.17.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 17:11:05 -0800 (PST)
Subject: Re: [PATCH v4 3/4] ich9: Simplify ich9_lpc_initfn
To: Felipe Franciosi <felipe@nutanix.com>,
 Marc-Andre Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20191219180205.25191-1-felipe@nutanix.com>
 <20191219180205.25191-4-felipe@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be03dc6d-73fb-e9c3-64ca-c457d5cfc213@redhat.com>
Date: Fri, 20 Dec 2019 02:11:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219180205.25191-4-felipe@nutanix.com>
Content-Language: en-US
X-MC-Unique: PViVPTvKM4OcC8cri4EJ9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 7:02 PM, Felipe Franciosi wrote:
> Currently, ich9_lpc_initfn simply serves as a caller to
> ich9_lpc_add_properties. This simplifies the code a bit by eliminating
> ich9_lpc_add_properties altogether and executing its logic in the parent
> object initialiser function.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> ---
>   hw/isa/lpc_ich9.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 9f4e00dddd..c40bb3c420 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -634,12 +634,14 @@ static void ich9_lpc_get_sci_int(Object *obj, Visit=
or *v, const char *name,
>       visit_type_uint8(v, name, &lpc->sci_gsi, errp);
>   }
>  =20
> -static void ich9_lpc_add_properties(ICH9LPCState *lpc)
> +static void ich9_lpc_initfn(Object *obj)
>   {
> +    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> +
>       static const uint8_t acpi_enable_cmd =3D ICH9_APM_ACPI_ENABLE;
>       static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
>  =20
> -    object_property_add(OBJECT(lpc), ACPI_PM_PROP_SCI_INT, "uint8",
> +    object_property_add(obj, ACPI_PM_PROP_SCI_INT, "uint8",
>                           ich9_lpc_get_sci_int,
>                           NULL, NULL, NULL, NULL);
>       object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE=
_CMD,
> @@ -647,14 +649,7 @@ static void ich9_lpc_add_properties(ICH9LPCState *lp=
c)
>       object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABL=
E_CMD,
>                                     &acpi_disable_cmd, OBJ_PROP_FLAG_READ=
, NULL);
>  =20
> -    ich9_pm_add_properties(OBJECT(lpc), &lpc->pm, NULL);
> -}
> -
> -static void ich9_lpc_initfn(Object *obj)
> -{
> -    ICH9LPCState *lpc =3D ICH9_LPC_DEVICE(obj);
> -
> -    ich9_lpc_add_properties(lpc);
> +    ich9_pm_add_properties(obj, &lpc->pm, NULL);
>   }
>  =20
>   static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


