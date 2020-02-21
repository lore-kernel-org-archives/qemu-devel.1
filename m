Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84450C35669
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5052E20578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 20:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUQZhhKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5052E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5EeD-0005F4-F7
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 15:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j5Ed0-0003XM-S1
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j5Ecz-0007yB-Jx
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46004
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j5Ecz-0007xx-En
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 15:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582315825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zde20pgsMLHMvVL3qmplhL/PnwnuNoaKndBghhwWpA=;
 b=gUQZhhKkq+PWkih7xeS3rWjmL7xsSf0SDMPIawxKfnCZmSzjHEmozrihyXj05ad7kFzvA/
 BXrGqxqVAu2P3WHUP49wnJ8b8jgchuHe5ehdniouyKo6mjmmeV274m6K44ublMdiid/xmf
 N7UdaHERyCvjlem9Eahu0Z3NwQBtB68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-3Oj7uv-0OqCQflE6sGzLqw-1; Fri, 21 Feb 2020 15:10:23 -0500
X-MC-Unique: 3Oj7uv-0OqCQflE6sGzLqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB23C107ACC7;
 Fri, 21 Feb 2020 20:10:21 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA12E5C1D4;
 Fri, 21 Feb 2020 20:10:15 +0000 (UTC)
Subject: Re: [PATCH v7 02/11] error: auto propagated local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-3-vsementsov@virtuozzo.com>
 <87mu9c70x1.fsf@dusky.pond.sub.org>
 <278458e5-c62c-8eaa-672f-cc70bbc15304@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0e367f8d-2292-a493-a65a-06e92d7b779e@redhat.com>
Date: Fri, 21 Feb 2020 08:29:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <278458e5-c62c-8eaa-672f-cc70bbc15304@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 3:42 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +#define ERRP_AUTO_PROPAGATE()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =
=3D errp};=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 errp =3D ((errp =3D=3D NULL || *errp =3D=3D error_f=
atal)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? &=
_auto_errp_prop.local_err : errp)
>>> +
>>> =C2=A0 /*
>>> =C2=A0=C2=A0 * Special error destination to abort on error.
>>> =C2=A0=C2=A0 * See error_setg() and error_propagate() for details.
>>
>> *errp =3D=3D error_fatal tests *errp =3D=3D NULL, which is not what you =
want.
>> You need to test errp =3D=3D &error_fatal, just like error_handle_fatal(=
).
>=20
> Oops, great bug) And nobody noticed before) Of course, you are right.

Sorry I missed it in my earlier looks.

>=20
>>
>> Superfluous parenthesis around the first operand of ?:.
>>
>> Wouldn't
>>
>> =C2=A0=C2=A0=C2=A0 #define ERRP_AUTO_PROPAGATE()=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_auto(ErrorPropagator) _auto=
_errp_prop =3D {.errp =3D errp};=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!errp || errp =3D=3D &err=
or_fatal) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp =
=3D &_auto_errp_prop.local_err;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> be clearer?
>>
>=20
> Hmm, notation with "if" will allow omitting ';' after macro invocation,=
=20
> which seems not good..

Then wrap it:

g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp}; \
do { \
   if (!errp || errp =3D=3D &error_fata) {
     errp =3D &_auto_errp_prop.local_err; \
   } \
while (0)


> And if I'm not wrong we've already discussed it somewhere in previous=20
> versions.

The original use of ?: stems from my suggestion on an earlier revision=20
when we were still trying to pack everything into two consecutive=20
declaration lines, rather than a declaration and a statement (as ?: is=20
necessary for conditionals in declarations).  But since then, we decided=20
to go with a statement (we require a C99 compiler, so declaration after=20
statement is supported by our compiler, even if our coding style=20
currently avoids it where possible), so as long as we support=20
statements, we might as well go with a legible statement instead of=20
insisting on the compact ?: form.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


