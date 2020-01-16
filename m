Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D951C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11568206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRL1Ai0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11568206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39379 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2F4-00083j-6Y
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is2EJ-0007RG-4j
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is2EF-0002lP-Fb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:18:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42236
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is2EF-0002l1-Bn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579169898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAatYQTNUTPdJ6d03tJcmCC/Xn+XsxgHaQaBOVtCAWk=;
 b=eRL1Ai0Z6HzbYabKLyq4iJwNq1vRft0r+/EwRryavFmrQs13BrF8dKHu68ApV2NkslEk9B
 wzvBSpfuWemBavT9KQUkcDKbuCPxpvSP1VY2I/8BxOjTlqAjxy61n6HQJVum58HxZuUoSX
 vXyZ9BEshY7H6CorLaP+PcySHGeS3dc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-_Lcts1gZOA-sRuTS1GWgiA-1; Thu, 16 Jan 2020 05:18:17 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so9062588wrn.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 02:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ykBfbSPQQu4tuR0Vtt/rxXrBmMQ6N/p5anJQxasXpAg=;
 b=M9c417sPUvSK+/AwT4vmJhtVLw2N4TnWNsgqfur5A9YO9Y/wqdvpBvKIYcwdj41O1b
 xnfB6T1Y/pB5UqnvtD9URWe/h46hSJtDAQmMlZxOmfkPLB7go0/bgUfvzrMPGba4uNq0
 1E6Yb0PIR45BSb4DzpqSxWxiBLOyg0KiCFlp0Ba0VKrBr0PtZnMn3gOTgUIgbD8uzuy0
 jlJVwrOzie/EVQ8z6aqGmP7NSKIsi57lt+I+SjwHlTk7l++7X0LAB1ENDW3JklusZtmQ
 5G60e/OZ010POe50lixxIUtzt9abeO1qLmn3hRkbUknc+tAv+A4P/9qRp6H92GVeHClM
 lY4g==
X-Gm-Message-State: APjAAAVwo7fxp7rmyPapKiy2pGWDcPzg2DC/2EWmxRlEsrKfKj2gTmys
 WDzlkyvvsVnYwMrC2vtAHEM74n28x3xMPLWg0r5Knbx4jGZk6RNT1rndrKbAkXKNiSauqZcq+9P
 MrTh+/25974r4SmQ=
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5054135wmk.131.1579169896272; 
 Thu, 16 Jan 2020 02:18:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPsP6g7rvou7kkiPJ4stcYjfvNO3ofRRsEITTv+FzHl/Rb8/zlKK1iC6sEdpGadzxcB2WyEA==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5054091wmk.131.1579169895880; 
 Thu, 16 Jan 2020 02:18:15 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id i8sm29579393wro.47.2020.01.16.02.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 02:18:15 -0800 (PST)
Subject: Re: [PATCH] Makefile: Keep trace-events-subdirs ordered
To: qemu-devel@nongnu.org
References: <20200116091314.25024-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21923d70-a19a-71ef-ab11-2b77214eab19@redhat.com>
Date: Thu, 16 Jan 2020 11:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116091314.25024-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: _Lcts1gZOA-sRuTS1GWgiA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-trivial@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Damien Hedde <damien.hedde@greensocs.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 10:13 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> To ease review and reduce likelihood of merge failures (see [*]),
> keep trace-events-subdirs ordered when possible, following eb7ccb3c0.
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg671007.html
>      Duplicate trace-events-subdirs entries generates duplicated
>      symbols when using the LTTng Userspace Tracer library.

If it seems useful/relevant we can add to this description UST backend=20
config and the error when using duplicate entries:

   $ ./configure --enable-trace-backends=3Dust && make
   [...]
     CC      trace-ust-all.o
   In file included from trace-ust-all.h:13,
                    from trace-ust-all.c:13:
   trace-ust-all.h:35151:1: error: redefinition of=20
=E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99
   35151 | TRACEPOINT_EVENT(
         | ^~~~~~~~~~~~~~~~
   trace-ust-all.h:31791:1: note: previous definition of=20
=E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99 was here
   31791 | TRACEPOINT_EVENT(
         | ^~~~~~~~~~~~~~~~

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> "Fixes: 26b8e6dc & 8d5d515a0"
>=20
> To be even safer we should use $(sort $(trace-events-subdirs))
> ---
>   Makefile.objs | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index 7c1e50f9d6..d62f908965 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -142,8 +142,8 @@ trace-events-subdirs +=3D nbd
>   trace-events-subdirs +=3D scsi
>   endif
>   ifeq ($(CONFIG_SOFTMMU),y)
> -trace-events-subdirs +=3D chardev
>   trace-events-subdirs +=3D audio
> +trace-events-subdirs +=3D chardev
>   trace-events-subdirs +=3D hw/9pfs
>   trace-events-subdirs +=3D hw/acpi
>   trace-events-subdirs +=3D hw/alpha
> @@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
>   trace-events-subdirs +=3D net
>   trace-events-subdirs +=3D ui
>   endif
> +trace-events-subdirs +=3D hw/core
>   trace-events-subdirs +=3D hw/display
>   trace-events-subdirs +=3D qapi
>   trace-events-subdirs +=3D qom
> @@ -203,7 +204,6 @@ trace-events-subdirs +=3D target/riscv
>   trace-events-subdirs +=3D target/s390x
>   trace-events-subdirs +=3D target/sparc
>   trace-events-subdirs +=3D util
> -trace-events-subdirs +=3D hw/core
>  =20
>   trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:=
%=3D$(SRC_PATH)/%/trace-events)
>  =20
>=20


