Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701AFC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B42B206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7vVmfhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B42B206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqQk-0003dF-7k
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jIqPp-0002yZ-Ib
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jIqPn-0005Gq-Qf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:09:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jIqPn-0005Ag-Kd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585559343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mgm7dkzU96qHvtvICenV4ybCNYmWZCvzW5mut0PHz2I=;
 b=O7vVmfhGzcqMhNAvqmrjPlZU5MtfARUm+ruyWl+zT4TMc19MeKcqtR4ZoLL3+EGPuyMi77
 FApdOf43q4OPT1devqz8yM5IufEgbSlvFHIwXVzjIWAFvT083l+7+q/tjRVCM6Ocz6IstN
 j2cJPzx9G/1+jQrkqRbzUVMR6EF+0dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-j4BbSrWlMreUUonI7d6cBA-1; Mon, 30 Mar 2020 05:09:00 -0400
X-MC-Unique: j4BbSrWlMreUUonI7d6cBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968FB1005512;
 Mon, 30 Mar 2020 09:08:59 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B84A760BE2;
 Mon, 30 Mar 2020 09:08:58 +0000 (UTC)
Date: Mon, 30 Mar 2020 10:08:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: AIO_WAIT_WHILE questions
Message-ID: <20200330090857.GD73285@stefanha-x1.localdomain>
References: <1242491200.59.1585326983523@webmail.proxmox.com>
 <87o8sexnzq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8sexnzq.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 10:09:45AM +0200, Markus Armbruster wrote:
> Cc'ing people based on output of "scripts/get_maintainer.pl -f
> include/block/aio-wait.h".
>=20
> Dietmar Maurer <dietmar@proxmox.com> writes:
>=20
> > Hi all,
> >
> > I have a question about AIO_WAIT_WHILE. The docs inside the code say:
> >
> >  * The caller's thread must be the IOThread that owns @ctx or the main =
loop
> >  * thread (with @ctx acquired exactly once).
> >
> > I wonder if that "with @ctx acquired exactly once" is always required?
> >
> > I have done a quick test (see code below) and this reveals that the con=
dition is not
> > always met.
> >
> > Or is my test wrong (or the docs)?
> >
> > ---debug helper---
> > diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> > index afeeb18f95..cf78dca9f9 100644
> > --- a/include/block/aio-wait.h
> > +++ b/include/block/aio-wait.h
> > @@ -82,6 +82,8 @@ extern AioWait global_aio_wait;
> >      atomic_inc(&wait_->num_waiters);                               \
> >      if (ctx_ && in_aio_context_home_thread(ctx_)) {                \
> >          while ((cond)) {                                           \
> > +            printf("AIO_WAIT_WHILE %p %d\n", ctx, ctx_->lock_count);  =
   \
> > +            assert(ctx_->lock_count =3D=3D 1);                   \
> >              aio_poll(ctx_, true);                                  \
> >              waited_ =3D true;                                        \
> >          }                                                          \

In this case it doesn't matter.  Handlers invoked by aio_poll() that
acquire ctx's recursive mutex will succeed.

The "exactly once" requirement is there because nested locking is not
supported when waiting for an AioContext that runs in a different
thread:

    } else {                                                       \
        assert(qemu_get_current_aio_context() =3D=3D                   \
               qemu_get_aio_context());                            \
        while ((cond)) {                                           \
            if (ctx_) {                                            \
                aio_context_release(ctx_);                         \
=09=09^--- doesn't work if we have acquired it multiple times

I think it would be okay to update the documentation to make this clear.

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6BtykACgkQnKSrs4Gr
c8h5Rgf+PuuSS4D0jUkI8wY8TK9WZfUNvOyEs+FU9RoCDofA9wJP+2cvA9RbTpH+
wbGPnhV+5Izim+CQIqe6ThdknDEcnLqFpH/40qCZ1aw9IeVM8wHFajWIKalRey1J
bXVOPd/oarfnxGm9vMsURuzeEw7Sw6grCmnOagenV8YerxfeJ4GQXMBIYbDb/b6k
RBdjaokGrHHZqF4eBq+3KkJA9755Kt5monWgwS5xKRuST3i/znPtwmj5pT+V2dgL
opaaFBIGXGMAyvuoa1lffP0IA5cJOfxpQKweNbZgGrNzzY/DSqiNzbBiaOY9Ckbx
MHGtAenuYrl+lurNoC2w5Uq/6UUfnQ==
=lP8J
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--


