Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB7AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A8C206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C86XTgIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A8C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsR8Y-0004kt-T7
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsR7i-0004AQ-Hz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:25:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsR7g-0001kg-Du
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594041927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fDSHGr4ReZKIR7mZcXWDYiZE+sjInCihedPNtOlYbwc=;
 b=C86XTgItFYeTT+JzQ66OS8MeceZ+n1tvkmOPMGT2FvbdejQwGwzNGc8prm3ELeT3xVBFwx
 WiyH1HCdfg4L0qRFJzJvfIwwv6ExftAa9Kv0TJYftW4F5g55kflWc/2X6e8J7WzaGfk1gA
 wW/kDWzZKxlljNR/kKU7GjBUe5cnzz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-D4XDMWaOP2eRI1WYSsONmg-1; Mon, 06 Jul 2020 09:25:23 -0400
X-MC-Unique: D4XDMWaOP2eRI1WYSsONmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D72DEC1A2;
 Mon,  6 Jul 2020 13:25:22 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96AE360BEC;
 Mon,  6 Jul 2020 13:25:21 +0000 (UTC)
Date: Mon, 6 Jul 2020 14:25:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 1/5] virtio-pci: add virtio_pci_optimal_num_queues()
 helper
Message-ID: <20200706132520.GA355463@stefanha-x1.localdomain>
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-2-stefanha@redhat.com>
 <20200528173555.5f079b70.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200528173555.5f079b70.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 05:35:55PM +0200, Cornelia Huck wrote:
> On Wed, 27 May 2020 11:29:21 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > Multi-queue devices achieve the best performance when each vCPU has a
> > dedicated queue. This ensures that virtqueue used notifications are
> > handled on the same vCPU that submitted virtqueue buffers.  When anothe=
r
> > vCPU handles the the notification an IPI will be necessary to wake the
> > submission vCPU and this incurs a performance overhead.
> >=20
> > Provide a helper function that virtio-pci devices will use in later
> > patches to automatically select the optimal number of queues.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.h | 9 +++++++++
> >  hw/virtio/virtio-pci.c | 7 +++++++
> >  2 files changed, 16 insertions(+)
>=20
> That looks like a good idea, since the policy can be easily tweaked in
> one place later.
>=20
> For ccw, I don't see a good way to arrive at an optimal number of
> queues. Is there something we should do for mmio? If yes, should this
> be a callback in VirtioBusClass?

I looked at this but virtio-pci devices need to do num_queues ->
num_vectors -> .realize() in that order. It's hard to introduce a
meaningful VirtioBusClass method. (The problem is that some devices
automatically calculate the number of PCI MSI-X vectors based on the
number of queues, but that needs to happen before .realize() and
involves PCI-specific qdev properties.)

Trying to go through a common interface for all transports doesn't
simplify things here.

Stefan

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8DJkAACgkQnKSrs4Gr
c8iBJgf9EONg6RGGkKkYyNCT4BdiNEAOAXX3AR5celHavqJadoeHd8r4b++dg44P
EXae+lAWaZowgsuH72qk8a0zc8JLnN66K07Zr672Cy4AdVdtLItDJstqv9o2eQyb
gLyFWEADkxhb3X2VowUrzzpVfR6Ec/ZglSI+FXoOvL0gLbyrceNWX7914LfnHDC3
RJyD4llfLcOQP3mUFVg/TCEfVY241gODkUcZ8kIGP2yIwxi3vivugoRJsElBbLKj
S8KjhtrxejixbYNLizGwsbIG3TpyTixcLwI5zbb5vsOYIBs/xmX7mZk0voSM6frD
U+xQKfpodtacMciBCIBLWsLL/uG6jg==
=Gwd0
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


