Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10286C18E5B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C65208FE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A03OIWkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C65208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvYL-0004XR-VB
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJvXE-0003DH-EV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJvXD-0007Ap-C5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:49:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJvXD-000798-83
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585817349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XDEZ1pSqxPT8sDOjjV36n+WVrQyECeFCwEDdd6kKW4=;
 b=A03OIWkHGg06hSzJK+WxujtkeLkN4v2d08PNL/zMyNEtZtISoQDvq8itzdhtJREHjWJSGI
 JV+JK2H8ZTa/dDDqpkgaRdTgoygADqnyhH7XVXNGDx+LJB+rTvYJUyK24BoOZ37nYbJsUo
 2kU0c0mWE72pbHPBQwt6yTDj2C+j01c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-snTd0CHcMmuNUUaSClIBsg-1; Thu, 02 Apr 2020 04:49:07 -0400
X-MC-Unique: snTd0CHcMmuNUUaSClIBsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE02F13F7;
 Thu,  2 Apr 2020 08:49:05 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 337ED5D9CA;
 Thu,  2 Apr 2020 08:49:03 +0000 (UTC)
Date: Thu, 2 Apr 2020 09:49:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Questionable aspects of QEMU Error's design
Message-ID: <20200402084900.GC423991@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
 <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 08:11:11AM +0000, Peter Maydell wrote:
> On Thu, 2 Apr 2020 at 07:11, Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
> > Somehow, in general, especially with long function names and long param=
eter lists I prefer
> >
> > ret =3D func(..);
> > if (ret < 0) {
> >      return ret;
> > }
>=20
> Personally I prefer the other approach -- this one has an extra line
> in the source and
> needs an extra local variable.
>=20
> > Are you sure that adding a lot of boolean functions is a good idea? I s=
omehow feel better with more usual int functions with -errno on failure.
> >
> > Bool is a good return value for functions which are boolean by nature: =
checks, is something correspond to some criteria. But for reporting an erro=
r I'd prefer -errno.
>=20
> When would we want to return an errno? I thought the whole point of the
> Error* was that that was where information about the error was returned.
> If all your callsites are just going to do "if (ret < 0) { ... } then hav=
ing
> the functions pick an errno value to return is just extra work.

IMHO errno should only be returned if the callers are likely to have=20
a genuine need to take action based on the errno in a way that isn't
possible from the Error alone. I expect very few scenarios need that.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


