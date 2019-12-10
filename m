Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57630C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2174920726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 11:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APQF3pV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2174920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iee6O-0005bQ-5Y
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 06:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iee5d-00056N-Uu
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iee5a-0001pl-Oi
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:54:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iee5a-0001pG-AV
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 06:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575978841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpJdsIGeUaFlhK4GRp6HzFJ//qS+0uxiv6XuY5vv3dI=;
 b=APQF3pV0mAX9fpYJtSGc4GEa6YxNaziiD1bAKsuv3aIAwmi1hd2sp1p0MU4vht4fWD3mDz
 VEXCMMBt9h/At2I+Y26OrXmT3wZkNpzEofrUo9c6nK6hsVCSoUcck2kzF5Gpqar2RL6nJI
 S/U0NmLk559ltSmoeubKF/3DetTwC24=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-wkW0JMEVOYe5ZygfZBX6Ww-1; Tue, 10 Dec 2019 06:53:58 -0500
Received: by mail-wm1-f70.google.com with SMTP id l13so904528wmj.8
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 03:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oj5xwjLd1gtZg6O1NgqsP3cBJczDsHthJUQyQa0qg8c=;
 b=GH3cRF2KzHIuZzN0VNGhWFV0Yv7CcCI0VSCQbD4jh4euqqBopgsfBvVNxeBZzskw+v
 U046LiEfFX86yyKP90fsEBsv/y6aGuLhvXNl7f8su5L4914Ju7zGlm/GgJCMEKWAevSq
 2KrVUboPShvyOo/mnYaUPhdW5MS9K2JE4YH3xugD9enF5lTkBt5xLRrcGoM2nuw++15d
 2hTbWlWpABPQFBhzRNzgOU+MYzDxoRESfTa2T/wmp+SVFlVTF6kRfYyADBQcPktjrW3t
 u2V85xGf+QKU/sTEOEs0Q4L8C/Vz69uaDAHSXkAZ2cLiUVdbmCpTDMgxEhP2gRA4JL6V
 6qog==
X-Gm-Message-State: APjAAAVV1LcKd6u0nb0RLq2L1z87R8k9PHwhz+jLCJAJGA6zQH/FQTAh
 E85S1w+kBVvEPhS9Jh+vX33NtregDwDR5g3jZdJAaVcjYMG2hcJ124FIRba+ZKlrKeN4tyEFpFz
 eOusIBMGrLC/jE9M=
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr2635702wmc.108.1575978837042; 
 Tue, 10 Dec 2019 03:53:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxldvopJJhem9YTUm9izE2+g+NbJGd8ayqv86Y2FwEUdCZl7hd4BsHrWUp9/Ic2Q+b4NYJfBg==
X-Received: by 2002:a1c:e90e:: with SMTP id q14mr2635686wmc.108.1575978836808; 
 Tue, 10 Dec 2019 03:53:56 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id p5sm2980274wrt.79.2019.12.10.03.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 03:53:56 -0800 (PST)
Subject: Re: [PATCH v2 07/18] vl: introduce object_parse_property_opt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-8-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <74c59c68-2314-d1c0-014d-1fb9cb911f87@redhat.com>
Date: Tue, 10 Dec 2019 12:53:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-8-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: wkW0JMEVOYe5ZygfZBX6Ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 4:01 PM, Paolo Bonzini wrote:
> We will reuse the parsing loop of machine_set_property soon for "-accel",
> but we do not want the "_" -> "-" conversion since "-accel" can just
> standardize on dashes.  We will also add a bunch of legacy option handlin=
g
> to keep the QOM machine object clean.  Extract the loop into a separate
> function, and keep the legacy handling in machine_set_property.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   vl.c | 35 ++++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 15 deletions(-)
>=20
> diff --git a/vl.c b/vl.c
> index 19c77b4..66dff1b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2615,27 +2615,17 @@ static MachineClass *select_machine(void)
>       return machine_class;
>   }
>  =20
> -static int machine_set_property(void *opaque,
> -                                const char *name, const char *value,
> -                                Error **errp)
> +static int object_parse_property_opt(Object *obj,
> +                                     const char *name, const char *value=
,
> +                                     const char *skip, Error **errp)

Can you document the 'skip' argument?

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>   {
> -    Object *obj =3D OBJECT(opaque);
>       Error *local_err =3D NULL;
> -    char *p, *qom_name;
>  =20
> -    if (strcmp(name, "type") =3D=3D 0) {
> +    if (g_str_equal(name, skip)) {
>           return 0;
>       }
>  =20
> -    qom_name =3D g_strdup(name);
> -    for (p =3D qom_name; *p; p++) {
> -        if (*p =3D=3D '_') {
> -            *p =3D '-';
> -        }
> -    }
> -
> -    object_property_parse(obj, value, qom_name, &local_err);
> -    g_free(qom_name);
> +    object_property_parse(obj, value, name, &local_err);
>  =20
>       if (local_err) {
>           error_propagate(errp, local_err);
> @@ -2645,6 +2635,21 @@ static int machine_set_property(void *opaque,
>       return 0;
>   }
>  =20
> +static int machine_set_property(void *opaque,
> +                                const char *name, const char *value,
> +                                Error **errp)
> +{
> +    g_autofree char *qom_name =3D g_strdup(name);
> +    char *p;
> +
> +    for (p =3D qom_name; *p; p++) {
> +        if (*p =3D=3D '_') {
> +            *p =3D '-';
> +        }
> +    }
> +
> +    return object_parse_property_opt(opaque, name, value, "type", errp);
> +}
>  =20
>   /*
>    * Initial object creation happens before all other
>=20


