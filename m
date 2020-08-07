Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9B320748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRSrKGOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9B320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zBZ-0001gK-9R
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3zAT-0000t2-Au
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3zAR-00062z-8A
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596794401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J/CD+TQeEYBTmluSgdrhYTDAaZsu4FTbtqsB4Lsglp0=;
 b=BRSrKGOyQPvrdW2TXq3z13vZ9uGFUIlkpDKhQV44f0Z18BAfGlC4Wktm+2A1nyV6gr64as
 ByFkKkjwXmB3tEINEZ/9zzpt+alHaJoUyvC6SIMKPHJQ5sXVQjUQLvRnLfZbX4tT/OpudB
 NDeT8uctYfFBly9oPnYLcsYhxzaXfZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-lpYnJP01MTm_1V-vaTwTVQ-1; Fri, 07 Aug 2020 05:59:58 -0400
X-MC-Unique: lpYnJP01MTm_1V-vaTwTVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF7B757;
 Fri,  7 Aug 2020 09:59:57 +0000 (UTC)
Received: from localhost (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7FCE87A78;
 Fri,  7 Aug 2020 09:59:54 +0000 (UTC)
Date: Fri, 7 Aug 2020 10:59:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this limit?
Message-ID: <20200807095953.GA600298@stefanha-x1.localdomain>
References: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
 <20200805121107.GG361702@stefanha-x1.localdomain>
 <20200805081144-mutt-send-email-mst@kernel.org>
 <20200806123708.GC379937@stefanha-x1.localdomain>
 <e9f6ae61-c2d5-e204-f9b0-5113ef7fc330@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e9f6ae61-c2d5-e204-f9b0-5113ef7fc330@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:20:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Yajun Wu <yajunw@mellanox.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 11:35:08AM +0800, Jason Wang wrote:
>=20
> On 2020/8/6 =E4=B8=8B=E5=8D=888:37, Stefan Hajnoczi wrote:
> > On Wed, Aug 05, 2020 at 08:13:29AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Aug 05, 2020 at 01:11:07PM +0100, Stefan Hajnoczi wrote:
> > > > On Thu, Jul 30, 2020 at 07:46:09AM +0000, Yajun Wu wrote:
> > > > > I'm doing iperf test on VIRTIO net through vhost-user(HW VDPA).
> > > > > Find maximal acceptable tx_queue_size/rx_queue_size is 1024.
> > > > > Basically increase queue size can get better RX rate for my case.
> > > > >=20
> > > > > Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 8192 to possibly=
 gain better performance?
> > > > Hi,
> > > > The VIRTIO 1.1 specification says the maximum number of descriptors=
 is
> > > > 32768 for both split and packed virtqueues.
> > > >=20
> > > > The vhost kernel code seems to support 32768.
> > > >=20
> > > > The 1024 limit is an implementation limit in QEMU. Increasing it wo=
uld
> > > > require QEMU code changes. For example, VIRTQUEUE_MAX_SIZE is used =
as
> > > > the size of arrays.
> > > >=20
> > > > I can't think of a fundamental reason why QEMU needs to limit itsel=
f to
> > > > 1024 descriptors. Raising the limit would require fixing up the cod=
e and
> > > > ensuring that live migration remains compatible with older versions=
 of
> > > > QEMU.
> > > >=20
> > > > Stefan
> > > There's actually a reason for a limit: in theory the vq size
> > > also sets a limit on the number of scatter/gather entries.
> > > both QEMU and vhost can't handle a packet split over > 1k chunks.
> > >=20
> > > We could add an extra limit for s/g size like block and scsi do,
> > > this will need spec, guest and host side work.
> > Interesting, thanks for explaining! This could be made explicit by
> > changing the QEMU code to:
> >=20
> > include/hw/virtio/virtio.h:#define VIRTQUEUE_MAX_SIZE IOV_MAX
> >=20
> > Looking more closely at the vhost kernel code I see that UIO_MAXIOV is
> > used in some places but not in vhost_vring_set_num() (ioctl
> > VHOST_SET_VRING_NUM). Is there a reason why UIO_MAXIOV isn't enforced
> > when the application sets the queue size?
>=20
>=20
> Actually three things:
>=20
> 1) queue size
> 2) #descriptors in a list
> 3) IOV size
>=20
> Spec limit the 2) to 1) but 2) may not equal to 3).
>=20
> So enforcing UIO_MAXIOV can not solve the problem completely.
>=20
> For vhost-net, it depends on socket to build skb which requires an iov ar=
ray
> to work. We need remove this limitation by:
>=20
> - build skb by vhost-net itself
> - do piecewise copying
>=20
> Then we're not limited with #iov and more and support up to what spec
> supports.

If I understand correctly, you are saying vhost_net.ko does not support
more than UIO_MAXIOV descriptors today but it could be fixed as you
described.

Thanks!

Stefan

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8tJhkACgkQnKSrs4Gr
c8hecQgAmCGB/vTSausyz5sg29IQC553G7CG6ZfAQiBmsQGE/hWVkS6wPvz6+90I
Pytv8I8ldVd6XUuH2Yix+JM1cbAm2mfV6T8VV7SUnrIxI7sGbuA5aFA1DfUB36F8
j8AT7Cs9LvvKA61JUOBtDN1+zDdo79N8IVbkA8OBdIfF5rPmiLeNjSFJvZ5llOtQ
It+8GBrp3+uhO1zADxPB9VXS5dv7lOiFw49auvRbOGcysoj1r5Il9a/VX3zWcslL
+fNDPsOU6NXaCA3jn/fVF4IpUX/vx+2TYK2pHEIHmR64IrFBhVC1Vr7pKGMdWjWR
ZeJ638+9+T5ne4POuRud0xG99K9eyA==
=oZXU
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--


