Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8141C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804382054F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1b9kuv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804382054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO5N-0006Qj-1A
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieNqO-0004k7-96
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieNqM-00011y-Ji
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:33:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56894
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieNqM-0000za-Fs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575916393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7P5xYY9el4punVpYo+yrDkrNA/uRaCIa9324lwY6xlg=;
 b=C1b9kuv4/4oePwljgut/bpAoXxU4aQdacuUSTRVtYytOGSe1g4rZVVGz4kxsx6xINEI2UM
 8A+7vC+MhemmzanaVkSNeUp9PQQkjdrVjA2quEJ//OuxJp1UAK8aMhfZ74VLV+PIgDolHy
 PAPZFRYuCu+uSYH25aMRX1ath1PYHLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-6sEHXDwgOcuOqJBneSG0ow-1; Mon, 09 Dec 2019 13:33:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC0531007271;
 Mon,  9 Dec 2019 18:33:11 +0000 (UTC)
Received: from gondolin (ovpn-116-43.ams2.redhat.com [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3CF45D9D6;
 Mon,  9 Dec 2019 18:33:07 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:33:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
Message-ID: <20191209193305.7108b3e9.cohuck@redhat.com>
In-Reply-To: <87d0d1orco.fsf@dusky.pond.sub.org>
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
 <20191205141212.6cb05ac7.cohuck@redhat.com>
 <87d0d1orco.fsf@dusky.pond.sub.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 6sEHXDwgOcuOqJBneSG0ow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 06 Dec 2019 08:17:27 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Cornelia Huck <cohuck@redhat.com> writes:
>=20
> > On Thu, 5 Dec 2019 14:05:19 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > =20
> >> Hi Cornelia,
> >>=20
> >> On 12/5/19 12:53 PM, Cornelia Huck wrote: =20
> >> > The Posix implementation of guest-set-time invokes hwclock to
> >> > set/retrieve the time to/from the hardware clock. If hwclock
> >> > is not available, the user is currently informed that "hwclock
> >> > failed to set hardware clock to system time", which is quite
> >> > misleading. This may happen e.g. on s390x, which has a different
> >> > timekeeping concept anyway.
> >> >=20
> >> > Let's check for the availability of the hwclock command and
> >> > return QERR_UNSUPPORTED for guest-set-time if it is not available.
> >> >=20
> >> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> >> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> > ---
> >> >=20
> >> > v2->v3:
> >> >    - added 'static' keyword to hwclock_path
> >> >=20
> >> > Not sure what tree this is going through; if there's no better place=
,
> >> > I can also take this through the s390 tree.   =20
> >>=20
> >> s390 or trivial trees seems appropriate.
> >>  =20
> >> >=20
> >> > ---
> >> >   qga/commands-posix.c | 13 ++++++++++++-
> >> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >> >=20
> >> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> >> > index 1c1a165daed8..0be301a4ea77 100644
> >> > --- a/qga/commands-posix.c
> >> > +++ b/qga/commands-posix.c
> >> > @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t =
time_ns, Error **errp)
> >> >       pid_t pid;
> >> >       Error *local_err =3D NULL;
> >> >       struct timeval tv;
> >> > +    static const char hwclock_path[] =3D "/sbin/hwclock";
> >> > +    static int hwclock_available =3D -1;
> >> > +
> >> > +    if (hwclock_available < 0) {
> >> > +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0)=
;
> >> > +    }
> >> > +
> >> > +    if (!hwclock_available) {
> >> > +        error_setg(errp, QERR_UNSUPPORTED);   =20
> >>=20
> >> In include/qapi/qmp/qerror.h we have:
> >>=20
> >> /*
> >>   * These macros will go away, please don't use in new code, and do no=
t
> >>   * add new ones!
> >>   */ =20
> >
> > Sigh, it is really hard to keep track here :( I just copied from other
> > callers in this file... =20
>=20
> I'm not faulting you for that.
>=20
> I think this new use is acceptable.  For details, see my other reply in
> this thread.

Ok, thanks for your explanation there.

I guess I'll queue this on s390-next... Philippe, any objections to
adding your R-b to the unmodified patch?


