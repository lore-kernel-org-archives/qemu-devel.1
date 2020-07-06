Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21886C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02CB206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmnmD3kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02CB206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRuQ-0001RL-Ty
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jsRtf-0000Db-1m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:15:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jsRtd-0000ki-1p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594044900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kkOdc4C4aMB708eydZpFbPT/SSF5PxYMnIUpMnkrG6s=;
 b=RmnmD3kQGKMF+gvw8Kg86tuI0H4ik3T1XWv+KXuCLFTtYRZXkcSo/UDDPCwwP+CUeSZhY8
 fr9VSfKMrGBDG0eq9OlmDgKV6ZxUgsnwLiaR3XLxGgIsy5dTnAYF+JPBQ9Rw/LqN2qqbq4
 jk0huWIe4sFo5MU1XyjKqWlFMxvR5/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-noFgoTehOtmKGwx2DAX90Q-1; Mon, 06 Jul 2020 10:14:57 -0400
X-MC-Unique: noFgoTehOtmKGwx2DAX90Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B441009627;
 Mon,  6 Jul 2020 14:14:52 +0000 (UTC)
Received: from gondolin (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27DE75BAC5;
 Mon,  6 Jul 2020 14:14:49 +0000 (UTC)
Date: Mon, 6 Jul 2020 16:14:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 1/5] virtio-pci: add virtio_pci_optimal_num_queues()
 helper
Message-ID: <20200706161436.719a1729.cohuck@redhat.com>
In-Reply-To: <20200706132520.GA355463@stefanha-x1.localdomain>
References: <20200527102925.128013-1-stefanha@redhat.com>
 <20200527102925.128013-2-stefanha@redhat.com>
 <20200528173555.5f079b70.cohuck@redhat.com>
 <20200706132520.GA355463@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/qdIXh4YE3xrttvyeklcLHKR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/qdIXh4YE3xrttvyeklcLHKR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jul 2020 14:25:20 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, May 28, 2020 at 05:35:55PM +0200, Cornelia Huck wrote:
> > On Wed, 27 May 2020 11:29:21 +0100
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >  =20
> > > Multi-queue devices achieve the best performance when each vCPU has a
> > > dedicated queue. This ensures that virtqueue used notifications are
> > > handled on the same vCPU that submitted virtqueue buffers.  When anot=
her
> > > vCPU handles the the notification an IPI will be necessary to wake th=
e
> > > submission vCPU and this incurs a performance overhead.
> > >=20
> > > Provide a helper function that virtio-pci devices will use in later
> > > patches to automatically select the optimal number of queues.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  hw/virtio/virtio-pci.h | 9 +++++++++
> > >  hw/virtio/virtio-pci.c | 7 +++++++
> > >  2 files changed, 16 insertions(+) =20
> >=20
> > That looks like a good idea, since the policy can be easily tweaked in
> > one place later.
> >=20
> > For ccw, I don't see a good way to arrive at an optimal number of
> > queues. Is there something we should do for mmio? If yes, should this
> > be a callback in VirtioBusClass? =20
>=20
> I looked at this but virtio-pci devices need to do num_queues ->
> num_vectors -> .realize() in that order. It's hard to introduce a
> meaningful VirtioBusClass method. (The problem is that some devices
> automatically calculate the number of PCI MSI-X vectors based on the
> number of queues, but that needs to happen before .realize() and
> involves PCI-specific qdev properties.)
>=20
> Trying to go through a common interface for all transports doesn't
> simplify things here.

That makes sense, thanks for checking.

--Sig_/qdIXh4YE3xrttvyeklcLHKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl8DMcwACgkQ3s9rk8bw
L68LdQ/9EUE7thN3kdd1J32kTR4w7LcYqrVgcyagze+L9lRen/qguIYvOi0s0buS
8qPnirH1caIWlijsz5EUaAiRVHemuh1GkVUNIdRpfP5enbAnpTMNouExKsiCt5Rc
4wX3WCYnVMPzZ7CDMENBGlugiuxtMk4y7EttmY4xGH2QDbuejkp88g7ONUe4QXSD
XHNSGwKeiajhTbef4J47iOjKQ1JCd9A4p+sAagOEU7+nWlU8zkmvoJ+xejn61E7H
jm0RF3d+0oaYBsMFBcxNHrYE27oHd4IQJQ6IbOyeUxpkpI74J3FQNLln9ab5aAr1
71FvGn7VpMXW5fWWqyVSlpPhiEYICOOGl6g/8ym4xkuJViQOeWolaFWOk18L/4QW
9E31qxkI74V1Gpn8dyiY5N4dt6GRyWFQqPd043awkclp+ylSuRC6d7UfMSWAeAZT
EkVA5iwNNXWkin2k+VvSyUkt4YYqbHxtvcpf9B6Y2rujrDiYh6MVIk/Xt4jORX6J
gc+hBmPxfsvibAkxvSykvojnkWusBDOmJ2cMapDgv5UZz4wohArxawaCKbkQyMXB
keNIfuq4FXY+GCtEZR614ZPdNq33ZREgvWD3W2FNKTAHIjSHLvYhA1U+foJUJ/K0
wu9fBEU6eqgnuXR5Ewa/UEnmmeErWXU6Kb4zBQUfUe42W354p1o=
=727Y
-----END PGP SIGNATURE-----

--Sig_/qdIXh4YE3xrttvyeklcLHKR--


