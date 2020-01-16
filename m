Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38BCC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800BA20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeLLNswC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800BA20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is63B-00029R-HY
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1is60q-0007Pn-KZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1is60p-0002kO-D0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:20:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1is60p-0002kD-8j
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KV82TP5S+P7wuyAACEhbvlQE/N6SWhav9s6wXww4/tw=;
 b=CeLLNswCj/YLPvM9XHVKmuXx7CvWEQbPZulBRIox6vjNTkIROVhsecEYB1wS3hIDiQRsdi
 LtLNkOrC552KyV0Q+fg1uViHalX/3U/cGqKmt1ugorbwGO0F9vGWuYLsJpY/uW7GotsbkA
 OZKfJSM9OpoC9wDsDwZaaAN4QEP2BgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-tpwimXRvNP-mEH6MAXpMiQ-1; Thu, 16 Jan 2020 09:20:39 -0500
X-MC-Unique: tpwimXRvNP-mEH6MAXpMiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45308010D5;
 Thu, 16 Jan 2020 14:20:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A82E360F82;
 Thu, 16 Jan 2020 14:20:35 +0000 (UTC)
Date: Thu, 16 Jan 2020 15:20:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/5] vhost-user block device backend
Message-ID: <20200116142033.GF9470@linux.fritz.box>
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-2-coiby.xu@gmail.com>
 <20200116135122.GI163546@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200116135122.GI163546@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Coiby Xu <coiby.xu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.01.2020 um 14:51 hat Stefan Hajnoczi geschrieben:
> > +static void vu_set_unix_socket(Object *obj, const char *value,
> > +                                            Error **errp)
> > +{
> > +    VubDev *vus =3D VHOST_USER_SERVER(obj);;
> > +
> > +    if (vus->unix_socket) {
> > +        error_setg(errp, "unix_socket property already set");
> > +        return;
> > +    }
> > +
> > +    vus->unix_socket =3D g_strdup(value);
> > +    vhost_user_server_start(vus, value, vus->name,
> > +                            vus->writable, errp);
>=20
> Property setters should only perform input validation and store the
> data.  Actions like creating network connections, opening files, etc
> should happen later in a UserCreatableClass->complete() callback.
>=20
> This is necessary because vus->writable is also a property and may be
> set after unix_socket.  The ->complete() callback is called after all
> setters so it can access the final values of all properties.
>=20
> See iothread_class_init() and iothread_complete() for an example.

Ah, right, this is the correct way. I forgot about the existence of
.complete(), so please ignore what I wrote.

> > diff --git a/vl.c b/vl.c
> > index 86474a55c9..72ac506342 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2553,6 +2553,10 @@ static bool object_create_initial(const char *ty=
pe, QemuOpts *opts)
> >      }
> >  #endif
> >=20
> > +    /* Reason: vhost-user-server property "name" */
> > +    if (g_str_equal(type, "vhost-user-server")) {
> > +        return false;
> > +    }
>=20
> I don't understand why the "name" property introduces a creation order
> dependency.  It's just a string and has no dependency on other
> command-line objects.  Can you explain why this change is necessary?

I was confused at first, too, but it's just a naming problem: "name"
is what points to the block device to be exported. It should really be
"node-name".

> > +struct VuClient {
> > +    VuDev parent;
> > +    int refcount;
> > +    VubDev *blk;
> > +    QIOChannelSocket *sioc; /* The underlying data channel */
> > +    QIOChannel *ioc; /* The current I/O channel */
> > +    QTAILQ_ENTRY(VuClient) next;
> > +    bool closed;
> > +};
> > +VubDev *vub_dev_find(const char *name);
>=20
> All -object instances already have an id=3DID property.  There is no need
> to declare a separate "name" property.  Please look at iothread_by_id()
> and iothread_get_id() for examples.

It's questionable to me if this function is needed at all. It is only
used in vhost_user_server_start() to make sure that you don't export a
node twice - but what's even the problem with exporting it twice?

Kevin

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeIHExAAoJEH8JsnLIjy/W214QAK+n0TgS3qlWqo6nT+s/ZdW4
JtQ72r3Y9blipicMVPOv9JdLFOYNHkrZ4ZrRUkbMgRR3kxw+qy2WSMTtHPe9o8/7
ByYc10ND8bz20VwtMZ+ZUOVqb2saIe9IFdpU9GMDjxKZW9BdyI/1rVoE9cz+MGwW
fxdm6jVgDZTNYGYbVuNWXXScp/lubJs0qQNFZXGz/ew8GGLP5KxH5SAt9Td9/40F
nmgYcoVPXVrmz1tY5116ZqGm2r6bQxC66aNKHNHAlitr3tZfJgWQKZ7nj4/g5WUn
PO4sInwzE47MZhp2bgn5C53+QK+y7vUYWgNbvBiSTJvY0BUhlLG6+Egl1yyfSSyC
UjqWjhAIPIYjELPXaDTMSSYTG9XybWeEioRSoY8EGyxPgOURtxZu+GNOxI8yxBnp
7Qqa99rQcmeumI0/cbmoZiC4RV6tZ3+qgX9PT3yl9GnmpyNdsIJkfQm2v495Y/zJ
qAGq9pexHNO5zkVZMUqcnORVoQUg1ihpXVY11P06TRhXAn9gFzST4EdC4WY3kaWc
TwKryW2/FFEO4tvJ7A2enqfFOhQi5exgDVP5SzydvMbuv30HveM9V1IC8J2oKm9e
th439YIv51i5Mr6EJGe2MLpFKoWl5Wbo7bB5iq9CkGA+onzqBMuxQ3T6KlL4UIIt
n/WMKI0n/MmXqys6a62B
=FmHR
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


