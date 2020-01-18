Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBEC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 21:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DE0246A5
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+CJLD9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DE0246A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isvcU-0006pO-4P
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 16:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1isvbq-0006Ns-Cr
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 16:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1isvbn-0000gI-MV
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 16:26:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25569
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1isvbn-0000fl-Gs
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 16:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579382778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WPNxkhbyDBG19TpO+FxtmkNNi3+lKVNiZnlBmcieVM=;
 b=T+CJLD9M6li0+Wm0OSW8K187H30x6tCDY+VyUCD7B3LUXDTTr9p8IppzYuWrwVD4WB8oC5
 y8VxWzEpXV8MyRdegFXXzLN4OU6GatTgQr5epvi+edDg09nLrH1K7k+WPLjpLW7aiuvYsK
 x+x3WsgJPPEbaZAqPzeI4z2pXd1rKak=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-Cd7KNCsWMXCnxdMq1bHIKg-1; Sat, 18 Jan 2020 16:26:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so12067717wrq.12
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 13:26:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ht/hiqhhw+SOTEezzslWhDUvxqQgFHowNfDAVZRzQgo=;
 b=BtWypg2pX5vKGFyAcW/CXtj2RVMX6lK/hFUrILGREwUidZVfb9PV9FjotSQu/o5HDL
 vT6FQbzgiefrk633lD0zzqMOkF5MDb2F44A7GvmIF5tmvAcr7eNuMuRmk7+Dn+lvfPix
 eYtX8FLnv6ZeJ4t8tmPeb4Jc1n8N68OqUDiQ5fAYNvzv04cTJqNjsZaDEor5q75Kn1R7
 SxJVxdUkUVPKHjEY9XZphsouJAQJ+HaoM6Cy53vG2fO0Ef94aRgPTSkL39PStrYUna7b
 /YtuQ/gv09TPJEgsIFTRHqq1b8mKIhipMu+KaRiVhj43iUqgyRUll7OLmDyjP0YKBmlY
 LtFA==
X-Gm-Message-State: APjAAAUWF7xiiNzioSvvSJ5aOWiHIf7GlbUzVY27vPacrGCllqcHO7+T
 Hq18wEf8cTy8aO6rHroW5XynpPThFVy1oaQP9fwstyBanzHLeLwLpf0L58X1D3t9JhqtW8m/VVC
 buOyJHDSSkOv3XUE=
X-Received: by 2002:a1c:a404:: with SMTP id n4mr10912786wme.109.1579382773773; 
 Sat, 18 Jan 2020 13:26:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDB288l6FvDewG48bthm45BllQAssNJOuyni3ShVnAFHYQ0WzFtiBTTDQ6ahG4g/qVUaO3pA==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr10912766wme.109.1579382773548; 
 Sat, 18 Jan 2020 13:26:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9?
 ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
 by smtp.gmail.com with ESMTPSA id s65sm4660677wmf.48.2020.01.18.13.26.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 13:26:13 -0800 (PST)
Subject: Re: [PATCH] qom/object: Display more helpful message when an
 interface is missing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200118162348.17823-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ccbaca59-eb9c-996c-7708-7c8438bda79f@redhat.com>
Date: Sat, 18 Jan 2020 22:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200118162348.17823-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: Cd7KNCsWMXCnxdMq1bHIKg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/01/20 17:23, Philippe Mathieu-Daud=C3=A9 wrote:
> When adding new devices implementing QOM interfaces, we might
> forgot to add the Kconfig dependency that pulls the required
> objects in when building.
>=20
> Since QOM dependencies are resolved at runtime, we don't get any
> link-time failures, and QEMU aborts while starting:
>=20
>   $ qemu ...
>   Segmentation fault (core dumped)
>=20
>   (gdb) bt
>   #0  0x00007ff6e96b1e35 in raise () from /lib64/libc.so.6
>   #1  0x00007ff6e969c895 in abort () from /lib64/libc.so.6
>   #2  0x00005572bc5051cf in type_initialize (ti=3D0x5572be6f1200) at qom/=
object.c:323
>   #3  0x00005572bc505074 in type_initialize (ti=3D0x5572be6f1800) at qom/=
object.c:301
>   #4  0x00005572bc505074 in type_initialize (ti=3D0x5572be6e48e0) at qom/=
object.c:301
>   #5  0x00005572bc506939 in object_class_by_name (typename=3D0x5572bc5610=
9a) at qom/object.c:959
>   #6  0x00005572bc503dd5 in cpu_class_by_name (typename=3D0x5572bc56109a,=
 cpu_model=3D0x5572be6d9930) at hw/core/cpu.c:286
>=20
> Since the caller has access to the qdev parent/interface names,
> we can simply display them to avoid starting a debugger:
>=20
>   $ qemu ...
>   qemu: missing interface 'fancy-if' for object 'fancy-dev'
>   Aborted (core dumped)
>=20
> This commit is similar to e02bdf1cecd2 ("Display more helpful message
> when an object type is missing").
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qom/object.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 0d971ca897..36123fb330 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -317,6 +317,11 @@ static void type_initialize(TypeImpl *ti)
> =20
>          for (i =3D 0; i < ti->num_interfaces; i++) {
>              TypeImpl *t =3D type_get_by_name(ti->interfaces[i].typename)=
;
> +            if (!t) {
> +                error_report("missing interface '%s' for object '%s'",
> +                             ti->interfaces[i].typename, parent->name);
> +                abort();
> +            }
>              for (e =3D ti->class->interfaces; e; e =3D e->next) {
>                  TypeImpl *target_type =3D OBJECT_CLASS(e->data)->type;
> =20
>=20

Queued, thanks.

Paolo


