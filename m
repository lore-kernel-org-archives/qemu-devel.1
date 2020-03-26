Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E975920714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3uYE/AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E975920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHP2V-00059A-36
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHP1m-0004ju-If
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHP1k-0003jP-RG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:42:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53595)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHP1i-0003hs-FQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585215733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHeJ25yucrWfVSSwTZnK8xfYhJ3ZneLyhAjxf7sX8gw=;
 b=L3uYE/ASiEGPSbqrUzf5cq2NlFZ8y3XmTgk1Uqwe84kFjGGUZakqlXE4aVSO8q4rq3Lhva
 IP0P7Zlh6yzAZcQV+607dvnj88rhR7hcMDxR00LPdQhR1zdEvgyIdXv7bbHHoOAS0cyHN0
 4/c0h1eqgBhtOXwnGMLM+Lmzjl3ns4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-pv6AfaqiNcmLlJKe9I9zRA-1; Thu, 26 Mar 2020 05:42:11 -0400
X-MC-Unique: pv6AfaqiNcmLlJKe9I9zRA-1
Received: by mail-wr1-f71.google.com with SMTP id c8so874093wru.20
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 02:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7e6efzqn4OaNi+c/lXTdVZQOm6z1BmL8vJVJvIU9tg0=;
 b=WKTQVcpT4xM9J/os2fcV9XYj45f4PlzU2GpqS+maaQsCVdqbIJTRwv9zpPea1dj2IA
 ntCKW30UwDz3k//pbp2x946kJwKF+sZcMzz6AcKZN1mZEoAn7W95jVz1Fy5FXCwCshnY
 I7YlmsT6wye8ATsyaKEyHHUV5czqBf827tDpZdF++GlRnvg3I670s1jYp/azMPWyfvJN
 QuidsMe3ZU5oFspr5YpMTV4HfRo/eeK355Wk1pMnsvzKBRIawh8YpFiHy3fFMGiTeHRU
 Qw+WPhf+bkB4cnWZ7kOZgJQRrBz5LvyVHN9C4J3OS3HJTxStmIzQF8K4QEmefniIK0mT
 dmbw==
X-Gm-Message-State: ANhLgQ2/PRbxzkBGxxQsr1h91AtPuy5YqcVMyWsv0h2GckdglqC5R0bz
 L5e2oxwCjcdmeUkphb6ifulbAGF3vXUYMFadY9uWFO27+oh1S4ZPjzWeiOpFjfLTUYEp5Uz7ZaV
 e9FamscMzS/GgUGM=
X-Received: by 2002:a5d:4091:: with SMTP id o17mr8875283wrp.254.1585215730399; 
 Thu, 26 Mar 2020 02:42:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvixOgQZ/lz+SpT6WJrO8smCfufIIqNtWiss/K7LQ1vj5rWp6hmUVTv+kN7sh5nKWq5D14aKQ==
X-Received: by 2002:a5d:4091:: with SMTP id o17mr8875252wrp.254.1585215730138; 
 Thu, 26 Mar 2020 02:42:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc?
 ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
 by smtp.gmail.com with ESMTPSA id 71sm2970757wrc.53.2020.03.26.02.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 02:42:09 -0700 (PDT)
Subject: Re: [PATCH for-5.0 3/3] object-add: don't create return value if
 failed
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
 <20200325184723.2029630-4-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c408ed09-3740-bc5d-2e39-318bb5beff3f@redhat.com>
Date: Thu, 26 Mar 2020 10:42:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325184723.2029630-4-marcandre.lureau@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/03/20 19:47, Marc-Andr=C3=A9 Lureau wrote:
> If object-add failed, no need to create a return value that may later
> be leaked.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qom/qom-qmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 435193b036..6bd137ccbf 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data,=
 Error **errp)
>      visit_free(v);
>      if (obj) {
>          object_unref(obj);
> +        *ret_data =3D QOBJECT(qdict_new());
>      }
> -    *ret_data =3D QOBJECT(qdict_new());
>  }
> =20
>  void qmp_object_del(const char *id, Error **errp)
>=20

It can be slightly simplified:

------------------- 8< ----------------------
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] object-add: don't create return value if failed
   =20
No need to return an empty value from object-add (it would also leak
if the command failed).  While at it, remove the "if" around object_unref
since object_unref handles NULL arguments just fine.
   =20
Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 435193b036..e47ebe8ed1 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -285,10 +285,7 @@ void qmp_object_add(QDict *qdict, QObject **ret_data, =
Error **errp)
     v =3D qobject_input_visitor_new(QOBJECT(qdict));
     obj =3D user_creatable_add_type(type, id, qdict, v, errp);
     visit_free(v);
-    if (obj) {
-        object_unref(obj);
-    }
-    *ret_data =3D QOBJECT(qdict_new());
+    object_unref(obj);
 }
=20
 void qmp_object_del(const char *id, Error **errp)


I queued this patch and your other two.  Thanks,

Paolo


