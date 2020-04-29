Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2174C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA73206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIAi+awV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA73206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgI9-0007tZ-Re
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTgHY-0007TE-SE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTgHW-0004XN-K8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:33:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTgHW-0004PE-6Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588141996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozNSTf9a2OAIoyI8Vuiax468877N86UUhoRUM8ifn6Y=;
 b=VIAi+awVRO6jkiA1pbKzKkwZ1E3gHyNnYabyAmyBO6UmxqSydKP/nlj7omwieBGFKy28/Y
 q2u+s088/NwnGse5pymBn4aqJx8efTeDTHXMlbESnsRRBWiTtMZvlnmEA6jU6JhUb25KyM
 p7lI5Sg/Tf45O+AHiT6HGYemtOwHs70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-LqzUJz5TPIqYMaF_YqUQsA-1; Wed, 29 Apr 2020 02:33:14 -0400
X-MC-Unique: LqzUJz5TPIqYMaF_YqUQsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F551899520;
 Wed, 29 Apr 2020 06:33:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA55C5D76B;
 Wed, 29 Apr 2020 06:33:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5487E11358BC; Wed, 29 Apr 2020 08:33:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/11] mips/boston: Fix boston_mach_init() error handling
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-9-armbru@redhat.com>
Date: Wed, 29 Apr 2020 08:33:11 +0200
In-Reply-To: <20200424192027.11404-9-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 24 Apr 2020 21:20:24 +0200")
Message-ID: <87h7x2vm1k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second

  call.

Whoops!

>
> boston_mach_init() is wrong that way.  The last calls treats an error
> as fatal.  Do that for the prior ones, too.
>
> Fixes: df1d8a1f29f567567b9d20be685a4241282e7005
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/mips/boston.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 98ecd25e8e..2832dfa6ae 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -458,14 +458,11 @@ static void boston_mach_init(MachineState *machine)
>      sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
>                            sizeof(s->cps), TYPE_MIPS_CPS);
>      object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-typ=
e",
> -                            &err);
> -    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp"=
, &err);
> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -
> -    if (err !=3D NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> -    }
> +                            &error_fatal);
> +    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp"=
,
> +                            &error_fatal);
> +    object_property_set_bool(OBJECT(&s->cps), true, "realized",
> +                             &error_fatal);
> =20
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);


