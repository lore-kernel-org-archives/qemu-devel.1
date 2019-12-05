Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48EC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A0B224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wlb02j9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A0B224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrec-0001it-6W
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icrPV-0003Og-6M
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:43:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icrPT-0005xQ-5w
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:43:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icrPT-0005tR-15
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575553390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Vl10VaRdI7gdc7g4QauwPwBWfP3zccSRSKfmsB5N3I=;
 b=Wlb02j9GVYDjLZoe0PzMj15unGp51lHPC5l5VBZ26qKVyvaJj4YypaKdEaam5tM8jkQmgv
 VoJd7i4okLvT3GCy1e0HkmDhehdj89nThED6Ybcdm9PhIUh5+u3v8o4brp8FRrqNRe8mwD
 nvpy4Sz0TXgNtKahmNubQEM87CoWrBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-gGrBpgw3PHKrUU0yjfHdUw-1; Thu, 05 Dec 2019 08:12:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BCF564A83;
 Thu,  5 Dec 2019 13:12:18 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45A475D6A5;
 Thu,  5 Dec 2019 13:12:14 +0000 (UTC)
Date: Thu, 5 Dec 2019 14:12:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v3] qga: fence guest-set-time if hwclock not available
Message-ID: <20191205141212.6cb05ac7.cohuck@redhat.com>
In-Reply-To: <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
References: <20191205115350.18713-1-cohuck@redhat.com>
 <5aaa7f3a-e3d1-0057-5fe2-07dea4864bc7@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gGrBpgw3PHKrUU0yjfHdUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 14:05:19 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Cornelia,
>=20
> On 12/5/19 12:53 PM, Cornelia Huck wrote:
> > The Posix implementation of guest-set-time invokes hwclock to
> > set/retrieve the time to/from the hardware clock. If hwclock
> > is not available, the user is currently informed that "hwclock
> > failed to set hardware clock to system time", which is quite
> > misleading. This may happen e.g. on s390x, which has a different
> > timekeeping concept anyway.
> >=20
> > Let's check for the availability of the hwclock command and
> > return QERR_UNSUPPORTED for guest-set-time if it is not available.
> >=20
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
> > v2->v3:
> >    - added 'static' keyword to hwclock_path
> >=20
> > Not sure what tree this is going through; if there's no better place,
> > I can also take this through the s390 tree. =20
>=20
> s390 or trivial trees seems appropriate.
>=20
> >=20
> > ---
> >   qga/commands-posix.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 1c1a165daed8..0be301a4ea77 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -156,6 +156,17 @@ void qmp_guest_set_time(bool has_time, int64_t tim=
e_ns, Error **errp)
> >       pid_t pid;
> >       Error *local_err =3D NULL;
> >       struct timeval tv;
> > +    static const char hwclock_path[] =3D "/sbin/hwclock";
> > +    static int hwclock_available =3D -1;
> > +
> > +    if (hwclock_available < 0) {
> > +        hwclock_available =3D (access(hwclock_path, X_OK) =3D=3D 0);
> > +    }
> > +
> > +    if (!hwclock_available) {
> > +        error_setg(errp, QERR_UNSUPPORTED); =20
>=20
> In include/qapi/qmp/qerror.h we have:
>=20
> /*
>   * These macros will go away, please don't use in new code, and do not
>   * add new ones!
>   */

Sigh, it is really hard to keep track here :( I just copied from other
callers in this file...

>=20
> Maybe we can replace it by "this feature is not supported on this=20
> architecture"? (or without 'on this architecture').

This is not really architecture specific, you'd get this on any setup
that does not have /sbin/hwclock.

Q: Is libvirt doing anything with such an error message from QEMU? Do
we have the freedom to say e.g "guest-set-time is not supported" or so?
Or is it beneficial to print the same error message for any unsupported
feature?

>=20
> > +        return;
> > +    }
> >  =20
> >       /* If user has passed a time, validate and set it. */
> >       if (has_time) {
> > @@ -195,7 +206,7 @@ void qmp_guest_set_time(bool has_time, int64_t time=
_ns, Error **errp)
> >  =20
> >           /* Use '/sbin/hwclock -w' to set RTC from the system time,
> >            * or '/sbin/hwclock -s' to set the system time from RTC. */
> > -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> > +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
> >                  NULL, environ);
> >           _exit(EXIT_FAILURE);
> >       } else if (pid < 0) {
> >  =20
>=20


