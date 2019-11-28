Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCF22176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtUaBPmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCF22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJUl-00039X-LC
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaJEz-0001Lh-8J
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaJEu-0007XB-Mu
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:49:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaJEt-0007Lg-4J
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574945377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWbEwNE5dX/q4JlmKwilYeuVLjux593GL+hLmoBhNAw=;
 b=TtUaBPmb4svF2R8ww3qyRT/cck/QXV5YNvOHLNdsT9AXlbxbu9UoLXGEnXY4JMuD07dzN4
 TGr4xeTI2N5GVMlK4nGFSIoOgETKP1WUbf/olUDPVFypJrtaJrq0CQVK7h23i+QPmCyy4X
 cl0dbtJ2zXeST6s5uTS0+C4sCkHj7lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-kbC3U64HPNeBtW8iiogvvg-1; Thu, 28 Nov 2019 07:49:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1178107ACC7;
 Thu, 28 Nov 2019 12:49:35 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF84560BE1;
 Thu, 28 Nov 2019 12:49:34 +0000 (UTC)
Date: Thu, 28 Nov 2019 13:49:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH RFC] qga: fence guest-set-time if hwclock not available
Message-ID: <20191128134932.5ef30a30.cohuck@redhat.com>
In-Reply-To: <20191128124532.GF248361@redhat.com>
References: <20191128123658.28351-1-cohuck@redhat.com>
 <20191128124532.GF248361@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kbC3U64HPNeBtW8iiogvvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 12:45:32 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Nov 28, 2019 at 01:36:58PM +0100, Cornelia Huck wrote:
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
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
> > Not sure if that is the correct approach, but the current error
> > message is really quite confusing. =20
>=20
> I guess the alternative is to just #ifndef __s390x__ the whole
> impl of the qmp_guest_set_time  method, but I don't have a
> strong opinion on which is best.

This hardcodes this as a s390x specialty, though, and I'm not sure that
assumption is and will stay correct.

>=20
> >=20
> > Gave it a quick test with an s390x and an x86_64 guest; invoking
> > 'virsh domtime <value>' now fails with 'not currently supported'
> > on s390x and continues to work as before on x86_64.
> >=20
> > ---
> >  qga/commands-posix.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > index 1c1a165daed8..bd298a38b716 100644
> > --- a/qga/commands-posix.c
> > +++ b/qga/commands-posix.c
> > @@ -149,6 +149,13 @@ int64_t qmp_guest_get_time(Error **errp)
> >     return tq.tv_sec * 1000000000LL + tq.tv_usec * 1000;
> >  }
> > =20
> > +static int check_hwclock_available(const char *path)
> > +{
> > +    struct stat st;
> > +
> > +    return (stat(path, &st) < 0) ? 0 : 1;
> > +}
> > +
> >  void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
> >  {
> >      int ret;
> > @@ -156,6 +163,17 @@ void qmp_guest_set_time(bool has_time, int64_t tim=
e_ns, Error **errp)
> >      pid_t pid;
> >      Error *local_err =3D NULL;
> >      struct timeval tv;
> > +    const char *hwclock_path =3D "/sbin/hwclock";
> > +    static int hwclock_available =3D -1;
> > +
> > +    if (hwclock_available < 0) {
> > +        hwclock_available =3D check_hwclock_available(hwclock_path); =
=20
>=20
> Could do this inline with:
>=20
>     hwclock_available =3D (access(hwclock_available, X_OK) =3D=3D 0);
>=20
> getting a slightly better result as this check for it being
> executable as well as existing.

Yes, that looks better. Can do if we agree on this approach.

>=20
> > +    }
> > +
> > +    if (!hwclock_available) {
> > +        error_setg(errp, QERR_UNSUPPORTED);
> > +        return;
> > +    }
> > =20
> >      /* If user has passed a time, validate and set it. */
> >      if (has_time) {
> > @@ -195,7 +213,7 @@ void qmp_guest_set_time(bool has_time, int64_t time=
_ns, Error **errp)
> > =20
> >          /* Use '/sbin/hwclock -w' to set RTC from the system time,
> >           * or '/sbin/hwclock -s' to set the system time from RTC. */
> > -        execle("/sbin/hwclock", "hwclock", has_time ? "-w" : "-s",
> > +        execle(hwclock_path, "hwclock", has_time ? "-w" : "-s",
> >                 NULL, environ);
> >          _exit(EXIT_FAILURE);
> >      } else if (pid < 0) {
> > --=20
> > 2.21.0
> >=20
> >  =20
>=20
> Regards,
> Daniel


