Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F08C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32F52068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZ0l7+gB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32F52068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqQ5-0003vx-Qe
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXqPQ-0003X9-Ki
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXqPN-0008JE-83
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:38:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXqPM-0008IR-KU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574357899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzfjVyrl/0EVD+fkuifWwW69o0EKbyFzcZGSSbSJO6Y=;
 b=QZ0l7+gB41cZ3/mwj/htSlbWzfiO70zFEK/btIxZX5jqUVZC1CmVl8tgq/xgRP8b+2vFiP
 qxCjc1jFtEcLtERcfEsF7CwU/HocUf4TX7BMj6BdXAkeN/RW1WedJtzSREdrpI7YQIliLN
 yCtH1PwCWzjtkzio7wHBnEwq91T2Wps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-UGzDavQsNtOzygJAQPPxLg-1; Thu, 21 Nov 2019 12:38:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70473801E6A;
 Thu, 21 Nov 2019 17:38:15 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 036D75DDAB;
 Thu, 21 Nov 2019 17:38:14 +0000 (UTC)
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
To: Fangrui Song <i@maskray.me>, Markus Armbruster <armbru@redhat.com>
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <20191119204932.5gdzlsplijveqwju@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e456fd62-95d7-4a52-9e14-cf0dbe01f995@redhat.com>
Date: Thu, 21 Nov 2019 11:38:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119204932.5gdzlsplijveqwju@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UGzDavQsNtOzygJAQPPxLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 2:49 PM, Fangrui Song wrote:

>>
>> Can we simply drop the offending line statement instead?
>=20
> Fixed in the new patch.
>=20

>> The first val * mul above this range is 0x1p64.=A0 Rejecting it is
>> correct, because it overflows yint64_t.
>=20
> I am not subscribed, so apologize that this email may be off the thread.
>=20
> (The binutils mailing list allows a user to download the raw email so I
> can still reply to a specific email, but this list does not provide such
> feature.)

Actually, it's better to post a v2 patch as a new top-level thread,=20
rather than buried as an attachment to a reply to v1, because our CI=20
tooling doesn't see through the attachment (nor was it easy for me to=20
reply to the v2 patch - I had to open the attachment to paste its text=20
inline below...).

More patch submission hints at https://wiki.qemu.org/Contribute/SubmitAPatc=
h

>>From 5f1c5a42794ddcbabb63d9af920d9f437ea90a9f Mon Sep 17 00:00:00 2001
> From: Fangrui Song <i@maskray.me>
> Date: Fri, 15 Nov 2019 16:27:47 -0800
> Subject: [PATCH] Fix incorrect integer->float conversions caught by clang
>  -Wimplicit-int-float-conversion
> To: qemu-devel@nongnu.org
>=20
> The warning will be enabled by default in clang 10. It is not available f=
or clang <=3D 9.
>=20

> +++ b/migration/migration.c
> @@ -2035,11 +2035,10 @@ void qmp_migrate_set_downtime(double value, Error=
 **errp)
>      }
> =20
>      value *=3D 1000; /* Convert to milliseconds */
> -    value =3D MAX(0, MIN(INT64_MAX, value));
> =20
>      MigrateSetParameters p =3D {
>          .has_downtime_limit =3D true,
> -        .downtime_limit =3D value,
> +        .downtime_limit =3D (int64_t)value,
>      };

The explicit cast looks odd without a comment (generally, we try to=20
avoid casts, so a comment such as /* explicit cast to silence compiler=20
*/ can be useful)

> =20
>      qmp_migrate_set_parameters(&p, errp);
> diff --git a/util/cutils.c b/util/cutils.c
> index fd591cadf0..2b4484c015 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char =
**end,
>          goto out;
>      }
>      /*
> -     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their trip
> +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>       * through double (53 bits of precision).

I thought we agreed on more text than just this (in particular, that the=20
nextafter() call represents 2^64 rounded towards zero).

>       */
> -    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {
> +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>          retval =3D -ERANGE;
>          goto out;
>      }
> --=20
> 2.24.0


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


