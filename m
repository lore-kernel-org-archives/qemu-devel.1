Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A24C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15A520720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG4lZd6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15A520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsXk-0007u7-QV
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtsXD-0007Oq-4j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:53:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtsXB-0007dr-JQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594385624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sRyELt3ufqrxLdbZ+E3frAKACa20tM74SsSCN7u2eFg=;
 b=RG4lZd6p6mUAlHCFI32grv/1+nbBdxy8T/UZJ9c9mKuS0MRbdoQR8p4jLPIaDxqdErYU3L
 maP0tloPdwj2LkaNu5DhLnXJs9eNOx4ffbQWgp51+yUhPFM11ASFrv3VmnEjgdq5781Bp6
 7JGujlSx7NUoOfuJoVs48bcBS5/y+WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-7ItG1wJwOWeJZv-NCTOQhQ-1; Fri, 10 Jul 2020 08:53:40 -0400
X-MC-Unique: 7ItG1wJwOWeJZv-NCTOQhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F24FA80BCA7;
 Fri, 10 Jul 2020 12:53:38 +0000 (UTC)
Received: from localhost (ovpn-114-251.ams2.redhat.com [10.36.114.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6BEA761E1;
 Fri, 10 Jul 2020 12:53:35 +0000 (UTC)
Date: Fri, 10 Jul 2020 13:53:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v5 5/5] vhost-user-blk: default num_queues to -smp N
Message-ID: <20200710125334.GB8433@stefanha-x1.localdomain>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-6-stefanha@redhat.com>
 <CAFubqFsSTv_j_46sq=+Kz7uDnk8eYvB+moCLNeuV8nG9YKzb7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFsSTv_j_46sq=+Kz7uDnk8eYvB+moCLNeuV8nG9YKzb7A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 11:02:24AM -0700, Raphael Norwitz wrote:
> On Mon, Jul 6, 2020 at 7:00 AM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > index a00b854736..39aec42dae 100644
> > --- a/hw/block/vhost-user-blk.c
> > +++ b/hw/block/vhost-user-blk.c
> > @@ -420,6 +420,9 @@ static void vhost_user_blk_device_realize(DeviceSta=
te *dev, Error **errp)
> >          return;
> >      }
> >
> > +    if (s->num_queues =3D=3D VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> > +        s->num_queues =3D 1;
> > +    }
>=20
> What is this check for? Is it just a backstop to ensure that
> num_queues is set to 1 if vhost-user-blk-pci doesn't update it?

For the non-PCI VIRTIO transports that do not handle num_queues =3D=3D
VHOST_USER_BLK_AUTO_NUM_QUEUES themselves.

Stefan

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8IZM4ACgkQnKSrs4Gr
c8gVBgf7Bxq7Oi+m44Ldvw3CQGCXsXZGFLyVksKSyHtsNtkHIWBs8hoYzIibbfiT
3mBpdfa7HUDlaKzpJHWFCDUZrZeZO3S5w6w/BKvVFiCuLIGDhuRnnnuypHI2BoXj
Fkhwo/wv/Wx9VMLagLGNgsgwsFDQGpO3iXIwGeE4CG0OmhfqWLIN6KApFzjPhapR
nPAwEUz10BrvvY4n/74xIJXc91iZqG37CKLHNpVhEy52TwPI0WIbutcEu0Fyr1yG
bipijtLgEC7r8JH5GM46d8nvFB6Pk8yEP+3ZmBlgR1XBqC+z8EUJmll9MIpZ1bNz
LgPPcgas+aepE6TNVveDfsSgte8s2Q==
=BTlk
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--


