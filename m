Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD7C2D0E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85587206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i07hCYtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85587206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHt24-0002iU-OX
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 13:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jHt1F-00022R-Vd
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jHt1D-0003QW-Id
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:43:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jHt1D-0003PY-F3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 13:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585331023;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Df1wmJPe7pcCZDy7Uotd2ese4fGEJREVBHPfFC5JNag=;
 b=i07hCYtJ+3juBA8AyYYFBrkZHcrBSVPEWI7MviDQhHR9sy5/mwc/Q2UvyTcG/NlWM1d/l8
 qWsxdXscx8knqlv7TiGWUmJsaGzTYQ4fEPnfgqGqvR7gONaXPkJW1jC1pKqm9CVGjD0BiP
 UQjkSB9SCz/DrYM93ZCcKxx/uOaxMWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-y0GMzuXKMzCejmGE9RbKRw-1; Fri, 27 Mar 2020 13:43:41 -0400
X-MC-Unique: y0GMzuXKMzCejmGE9RbKRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D01477;
 Fri, 27 Mar 2020 17:43:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A01E15C1C3;
 Fri, 27 Mar 2020 17:43:38 +0000 (UTC)
Date: Fri, 27 Mar 2020 17:43:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 2/3] io: Support shutdown of TLS channel
Message-ID: <20200327174334.GT1619@redhat.com>
References: <20200327161936.2225989-1-eblake@redhat.com>
 <20200327161936.2225989-3-eblake@redhat.com>
 <20200327164040.GQ1619@redhat.com>
 <aa9f40ee-450e-20f3-e860-2a56e5fd0b75@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aa9f40ee-450e-20f3-e860-2a56e5fd0b75@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 12:29:39PM -0500, Eric Blake wrote:
> On 3/27/20 11:40 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Mar 27, 2020 at 11:19:35AM -0500, Eric Blake wrote:
> > > Gnutls documents that while many apps simply yank out the underlying
> > > transport at the end of communication in the name of efficiency, this
> > > is indistinguishable from a malicious actor terminating the connectio=
n
> > > prematurely.  Since our channel I/O code already supports the notion =
of
> > > a graceful shutdown request, it is time to plumb that through to the
> > > TLS layer, and wait for TLS to give the all clear before then
> > > terminating traffic on the underlying channel.
> > >=20
> > > Note that channel-tls now always advertises shutdown support,
> > > regardless of whether the underlying channel also has that support.
> > >=20
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >   io/channel-tls.c | 27 ++++++++++++++++++++++++++-
> > >   1 file changed, 26 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > > index 7ec8ceff2f01..f90905823e1d 100644
> > > --- a/io/channel-tls.c
> > > +++ b/io/channel-tls.c
> > > @@ -360,10 +360,35 @@ static int qio_channel_tls_shutdown(QIOChannel =
*ioc,
> > >                                       Error **errp)
> > >   {
> > >       QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(ioc);
> > > +    int ret =3D 0;
> > >=20
> > >       tioc->shutdown |=3D how;
> > >=20
> > > -    return qio_channel_shutdown(tioc->master, how, errp);
> > > +    do {
> > > +        switch (how) {
> > > +        case QIO_CHANNEL_SHUTDOWN_READ:
> > > +            /* No TLS counterpart */
> > > +            break;
> > > +        case QIO_CHANNEL_SHUTDOWN_WRITE:
> > > +            ret =3D qcrypto_tls_session_shutdown(tioc->session, QCRY=
PTO_SHUT_WR);
> > > +            break;
> > > +        case QIO_CHANNEL_SHUTDOWN_BOTH:
> > > +            ret =3D qcrypto_tls_session_shutdown(tioc->session,
> > > +                                               QCRYPTO_SHUT_RDWR);
> > > +            break;
> > > +        default:
> > > +            abort();
> > > +        }
> > > +    } while (ret =3D=3D -EAGAIN);
> >=20
> > I don't think it is acceptable to do this loop here. The gnutls_bye()
> > function triggers several I/O operations which could block. Looping
> > like this means we busy-wait, blocking this thread for as long as I/O
> > is blocking on the socket.
>=20
> Hmm, good point.  Should we give qio_channel_tls_shutdown a bool paramete=
r
> that says whether it should wait (good for use when we are being run in a
> coroutine and can deal with the additional I/O) or just fail with -EAGAIN
> (which the caller can ignore if it is not worried)?

A bool would not be sufficient, because the caller would need to know
which direction to wait for I/O on.

Looking at the code it does a flush of outstanding data, then sends
some bytes, and then receives some bytes. The write will probably
work most of the time, but the receive is almost always going to
return -EAGAIN. So I don't think that failing with EGAIN is going
to be much of a benefit.

> > If we must call gnutls_bye(), then it needs to be done in a way that
> > can integrate with the main loop so it poll()'s / unblocks the current
> > coroutine/thread.  This makes the whole thing significantly more
> > complex to deal with, especially if the shutdown is being done in
> > cleanup paths which ordinarily are expected to execute without
> > blocking on I/O.  This is the big reason why i never made any attempt
> > to use gnutls_bye().
>=20
> We _are_ using gnutls_bye(GNUTLS_SHUT_RDWR) on the close() path (which is

Are you sure ?  AFAIK there is no existing usage of gnutls_bye() at all
in QEMU.

> indeed a cleanup path where not blocking is worthwhile) even without this
> patch, but the question is whether using gnutls_bye(GNUTLS_SHUT_WR) in th=
e
> normal data path, where we are already using coroutines to manage callbac=
ks,
> can benefit the remote endpoint, giving them a chance to see clean shutdo=
wn
> instead of abrupt termination.

I'm not convinced the clean shutdown at the TLS level does anything importa=
nt
given that we already have done a clean shutdown at the NBD level.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


