Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7B9C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0976F2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQf6N/qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0976F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPQr0-0005zv-9i
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jPQpB-0005Er-C1
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jPQp8-0004Fa-Rx
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:14:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jPQp7-0004E5-Nf
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587129263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VX5/TH+JxmH7jCnuU8/OfK6dohWLjQjKfz0Z5tBKLCI=;
 b=aQf6N/qIcHQ3dL+BK0MOlWSY6YCxd0h9QtwlW244Jzi8e+be/I9TwJg/bLGECeetN/h/v9
 8Zb2OHA8e4iKoKNslhGV5tm8J0IMW5ClP1+26B8Xh44Mnvg7nBvNDfod4TtxJsU1Df2yXG
 rzah4xr6llYWce4IqrNgKcvQ5IW56U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-zWDDhNF5NFulvob5kMsM7Q-1; Fri, 17 Apr 2020 09:14:05 -0400
X-MC-Unique: zWDDhNF5NFulvob5kMsM7Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 474821005510;
 Fri, 17 Apr 2020 13:14:04 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B2F5C1C3;
 Fri, 17 Apr 2020 13:14:01 +0000 (UTC)
Date: Fri, 17 Apr 2020 14:13:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] chardev/char-socket: Properly make qio connections non
 blocking
Message-ID: <20200417131359.GC69711@redhat.com>
References: <1587126653-5839-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAJ+F1CKCjv6rY3t0Lk9sTUFcop2xgjf=TjmkEGM54AzWCwx-XQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKCjv6rY3t0Lk9sTUFcop2xgjf=TjmkEGM54AzWCwx-XQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, edgari@xilinx.com,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 03:01:09PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Apr 17, 2020 at 2:38 PM Sai Pavan Boddu
> <sai.pavan.boddu@xilinx.com> wrote:
> >
> > In tcp_chr_sync_read function, there is a possibility of socket
> > disconnection during read, then tcp_chr_hup function would clean up
> > the qio channel pointers(i.e ioc, sioc).
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  chardev/char-socket.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 185fe38..30f2b2b 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -549,11 +549,13 @@ static int tcp_chr_sync_read(Chardev *chr, const =
uint8_t *buf, int len)
> >
> >      qio_channel_set_blocking(s->ioc, true, NULL);
> >      size =3D tcp_chr_recv(chr, (void *) buf, len);
> > -    qio_channel_set_blocking(s->ioc, false, NULL);
>=20
> But here it calls tcp_chr_recv(). And I can't find cleanup there.
> Nevertheless, I think this patch should be harmless.
>=20
> I'd ask Daniel to have a second look.

I don't see any bug that needs fixing here, and I prefer the current
code as it gives confidence that nothing tcp_chr_disconnect does
will accidentally block.


> >      if (size =3D=3D 0) {
> >          /* connection closed */
> >          tcp_chr_disconnect(chr);
> > +        return 0;
> >      }
> > +    /* Connection is good */
> > +    qio_channel_set_blocking(s->ioc, false, NULL);
> >
> >      return size;
> >  }
> > --
> > 2.7.4
> >
> >
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


