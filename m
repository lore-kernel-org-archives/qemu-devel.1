Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D29CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BFF2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg9NTpoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BFF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCEC-0002hd-KL
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNC5c-0006IE-0f
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNC5a-0003RF-Il
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:33:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNC5a-0003QR-4e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5sAqzXouO31bHj6Puayn6PQgcdo7+EuOZ9tV622jIU=;
 b=Sg9NTpoCWK28E8y6vq/I9vxlA1Q64vm910CatMAkqo+IGit0hCA4YFwrhZPOKMBbTLdjwh
 89u8GSueZQmpl8cOHSwf8pgkqk44Bildao/3DS0HMG+TifDZnnimb2hQqMbZLriacuMrmt
 1m9EwZHyBZz2DG9eFKEN2ONdYguqLsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-BGEXVxeMPmS3UTfDqb2Z0w-1; Wed, 23 Oct 2019 04:33:51 -0400
X-MC-Unique: BGEXVxeMPmS3UTfDqb2Z0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3F581800D6B;
 Wed, 23 Oct 2019 08:33:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD6915DC18;
 Wed, 23 Oct 2019 08:33:45 +0000 (UTC)
Date: Wed, 23 Oct 2019 09:33:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 07/16] libqos: enforce Device Initialization order
Message-ID: <20191023083344.GA9574@stefanha-x1.localdomain>
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-8-stefanha@redhat.com>
 <158ef0b2-c478-1304-3128-8feb7cd943d4@redhat.com>
 <20191022154840.GE32186@stefanha-x1.localdomain>
 <a2c46a4f-7c60-f6ef-06b6-1e283053ea9f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a2c46a4f-7c60-f6ef-06b6-1e283053ea9f@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 slp@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 08:48:31PM +0200, Thomas Huth wrote:
> On 22/10/2019 17.48, Stefan Hajnoczi wrote:
> > On Mon, Oct 21, 2019 at 02:15:53PM +0200, Thomas Huth wrote:
> >> On 19/10/2019 08.38, Stefan Hajnoczi wrote:
> >>> According to VIRTIO 1.1 "3.1.1 Driver Requirements: Device
> >>> Initialization", configuration space and virtqueues cannot be accesse=
d
> >>> before features have been negotiated.  Enforce this requirement.
> >>>
> >>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> ---
> >>>  tests/libqos/virtio.c | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> >>> index 4f7e6bb8a1..2593996c98 100644
> >>> --- a/tests/libqos/virtio.c
> >>> +++ b/tests/libqos/virtio.c
> >>> @@ -13,23 +13,33 @@
> >>>  #include "standard-headers/linux/virtio_config.h"
> >>>  #include "standard-headers/linux/virtio_ring.h"
> >>> =20
> >>> +/* Features must be negotiated before config space or virtqueue acce=
ss */
> >>> +static void check_features_negotiated(QVirtioDevice *d)
> >>> +{
> >>> +    g_assert_cmphex(d->features, !=3D, 0);
> >>> +}
> >>
> >> Isn't it "legal" to negotiate 0 feature bits, too (for legacy devices)=
?
> >=20
> > Yes, it's possible for Legacy devices.  If someone ever does that
> > they'll need to extend this code, but it's unlikely so I'd rather not
> > complicate this.
>=20
> Could you please add at least a comment here with that explanation?

I'll try adding a bool field in v4 so there are no problems with a 0
feature bit set.

Stefan

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wEGgACgkQnKSrs4Gr
c8jEzwf/Q+iwO1rXUczT6UeNgy6mxwpbG2OPxFf70UP/iGHdwKT9k91U0lp+9M4i
Qy8Bo9JlsehxdiRnqnVfKBkyiSLdbW+yzpB/jw2tFWu7Fn+4lJhu+Ji8J8crTLkw
D+sP4bNGtpJ1h5ImGIcH0Kr5YaM1T465lcvsNfEa4Ml/UycuCTf0p9RP3c7XOWO+
9RiRhii1MwG1mDsX7Af80Pgl1Suk0W6hzZ54YRRn/dWa3WOV2ayUCkOZoI46zACq
UJWQdZc+m0v53n3FdPlE2rDGhhJYFguUANVaMtIRtl805oUdRsyEQ4ySwwQpNbQT
Z2UWuS47yUiIK9RQwtF/DAjNJMD3Cw==
=ko/o
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


