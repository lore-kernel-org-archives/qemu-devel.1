Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ACC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6642218D4
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 13:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6Nq0E4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6642218D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzyM-0008RT-U5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 09:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqzyC-0007vF-8E
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqzyB-0003Fl-5L
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:09:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqzyA-0003F6-UO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 09:09:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id w9so37991545wmd.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uhpZBgs7xvhNOcj1Wre9kWc7PQN5uPOX886KjVXN7/s=;
 b=j6Nq0E4VqW0wgf6nWTWe15IOf/fSd4wW/QauCIGPGKHFkb0oq+uC18okGiy6GAdWKd
 dxg82XMqpRPCnGanUC1/Tvx90GVteB9WOXzXbjcg26s+dZcQtpm8NiB38S52jzsIKcS+
 daPNT3oO7M2Ox4avGzQ9f8ym3V48CR2sAsiYL7I5K/eKr45tbxRKufY/3aBtT5pehfsd
 n57lOa/uZw7AjZ2rsqmk7hzT42aue1WR5mwsHryp3imddtQf8W3q75BLeLxGZHRUee9H
 y4PJlKE0H7OIfgLTTcHgFDOJmEVCoh3t9BWFHSVpqYw5VT0ZL8ytbrnWh8y7VxeSu8nr
 ZHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uhpZBgs7xvhNOcj1Wre9kWc7PQN5uPOX886KjVXN7/s=;
 b=RD2FSHY3+1Rn8HsQ+NwdXRSHc6sHiizhJUgOKFa+j3Dyn4+DXe6cM6O7L7jrf+GvY+
 j3vwf27yWreP5y6SrPB9fXCP2H+IiFpAWgS6wQnJtvtUjWhjYjqB2tzoS3w1Nd3FTGNO
 65QppT9t9t6ocQw7e5dJEsQ2QkkhaSt/NOz2xXGZ+i4G8hkuptg8n20sg4sBsdTRPxMR
 5BuZWQV/fbGl4xGRaYRzOSXgnDJfRPPZVo9d9ha4tHNu1izgF3OKeEUx6PssX7uE6V9o
 R18tkxFkfhN2L5XUI+h8IJvPlz2CpmOtXje9gPlhiOk0HXrUU7W2h0MoYm7piAgSfk9l
 MqIw==
X-Gm-Message-State: APjAAAXPLSTGZHQirtPQj5sc6GMR5N67b8RoZaUD7+O0+YTsVx8hu740
 DsYDTSR4JrBXDNXys91y8tA=
X-Google-Smtp-Source: APXvYqw2K7SjhXDh7n8pjki/S8eZc2tDBjwoXXM0btxOcd92dzp8GPiRdefYw/UdPK+XUh70WihvqA==
X-Received: by 2002:a1c:a584:: with SMTP id
 o126mr87056826wme.147.1564146549692; 
 Fri, 26 Jul 2019 06:09:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x83sm55615771wmb.42.2019.07.26.06.09.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 06:09:08 -0700 (PDT)
Date: Fri, 26 Jul 2019 14:09:07 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726130907.GH25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-14-alxndr@bu.edu>
 <51cc86ad-0dda-ada0-1c44-a6ac365bc4cf@redhat.com>
 <b2503c69ad82bd13c1bab518154c6168e7eeb1cc.camel@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <b2503c69ad82bd13c1bab518154c6168e7eeb1cc.camel@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC 13/19] fuzz: add ctrl vq support to
 virtio-net in libqos
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 05:05:25PM +0000, Oleinik, Alexander wrote:
> On Thu, 2019-07-25 at 12:25 -0400, John Snow wrote:
> >=20
> > On 7/24/19 11:23 PM, Oleinik, Alexander wrote:
> > > Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> >=20
> > Is there some explanation for why the below patch does what the
> > subject
> > line claims for the uninitiated?
> When multiqueue mode (VIRTIO_NET_F_MQ) is disabled, virtio-net sets up
> three queues. 0:receiveq, 1:transmitq and 2:controlq.=20
> > I don't know why increasing the number of queues from 2 to 3 here is
> > correct in the general case, OR why it would "add ctrl vq support".
> > (Or what it has to do with fuzzing, in general.)
>=20
> Prior to the change, accessing the ctrl vq through QOS, would trigger a
> segfault, since only two queues were allocated to QVirtioDevice*
> interface->queues.
>=20
> Also, when VIRTIO_NET_F_MQ is enabled, the number of queues is 2*N + 1,
> so I think in that case n->n_queues is also short by one in the code
> below.

I think the patch could be changed to:

> > [Only responding because this landed in tests/libqos, which I do try
> > to
> > keep an eye on, but this patch is opaque to me. --js]
> >=20
> > > ---
> > >  tests/libqos/virtio-net.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tests/libqos/virtio-net.c b/tests/libqos/virtio-net.c
> > > index 66405b646e..247a0a17a8 100644
> > > --- a/tests/libqos/virtio-net.c
> > > +++ b/tests/libqos/virtio-net.c
> > > @@ -51,7 +51,7 @@ static void virtio_net_setup(QVirtioNet
> > > *interface)
> > >      if (features & (1u << VIRTIO_NET_F_MQ)) {
> > >          interface->n_queues =3D qvirtio_config_readw(vdev, 8) * 2;
> > >      } else {
> > > -        interface->n_queues =3D 2;
> > > +        interface->n_queues =3D 3;
> > >      }

interface->n_queues++; /* ctrl vq */

And a comment added to the QVirtQueue::n_queues field definition:

  /* total number of virtqueues (rx, tx, ctrl) */

This will prevent confusion about whether the ctrl queue is counted or
not.

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl06+3MACgkQnKSrs4Gr
c8j5nAgAo3aN3gdWaKUXOfbi90RvYuuh7QvbgpZhb3ToTnPUIPNidAFcMk3JnPv8
zW6j8oAKeVt5n/PPQoyPg8r6nwweYjEhL25cqrURkIz6AqaIdft+KeeL62KdsO3C
l/IMLuup0WK8MYm1aT7PUc0b2gBq+Nl5Inl+COa/JUiYw2A1lY/Hb/H2DwPe5U6Q
B7v36AdjgCBmlEHJG/K6sASqm3uU0ByOJdQv0zgUxIehR+9a1uPbt0GkN3xBTsAx
/b7bdhV/nEINRdhxVpEg5rKRMUe49YMGEql+snCuEDTS5CopBQuWhqlcvF55bUzq
tkB2swwpyKw82UgVBOa5Kv/AQZh4hA==
=iL8y
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--

