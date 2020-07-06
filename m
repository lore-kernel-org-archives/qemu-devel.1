Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D99620739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzL1It/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D99620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsON7-0001nd-Bm
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsOHm-00045L-La
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:23:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsOHk-000754-AF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594031019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7lEmMYN+o5ltYyBHvwWHyN3STBUY3oftm7QMnv6Gv4=;
 b=HzL1It/+mbDMR6Zito3dDY0xvdHssNldGPkNxl0J136ZEtGxG/SveMp5j6sV+sp+0UR7Lk
 ck0UX++cFrNufh5obJcqjCBY5HAl3s9w4N/YqqxFx1IzGtPYwSawEOtTJqdE7LP05UnHxf
 lJWkIyfXO/BtCdcEg1VY/GMjpmQLMM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-AnIZO5mePMSS7TDt3ka3zA-1; Mon, 06 Jul 2020 06:23:36 -0400
X-MC-Unique: AnIZO5mePMSS7TDt3ka3zA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 336AC91164;
 Mon,  6 Jul 2020 10:23:34 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46C6C71662;
 Mon,  6 Jul 2020 10:23:25 +0000 (UTC)
Date: Mon, 6 Jul 2020 11:23:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 4/7] vhost: involve device backends in feature
 negotiation
Message-ID: <20200706102324.GB328186@stefanha-x1.localdomain>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-5-stefanha@redhat.com>
 <20200609135007-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200609135007-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 02:07:44PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2020 at 06:02:15PM +0100, Stefan Hajnoczi wrote:
> > Many vhost devices in QEMU currently do not involve the device backend
> > in feature negotiation. This seems fine at first glance when no
> > device-specific feature bits are defined (virtio-net has many but some
> > devices have none).
> >=20
> > Unfortunately this causes problems when QEMU's virtqueue implementation
> > and the device backend's implementation support different features.
> > QEMU must not report features to the guest that aren't supported by the
> > device backend.
> >=20
> > For example, QEMU supports VIRTIO 1.1 packed virtqueues while many
> > existing vhost device backends do not. The device backend breaks when
> > the user sets packed=3Don. This should have been handled gracefully by
> > feature negotiation instead of resulting in a cryptic failure when the
> > device backend cannot parse the vring.
> >=20
> > Introduce the vhost_old_default_feature_bits[] array so existing
> > devices can involve the device backend in feature negotiation.
> > libvhost-user does not report VIRTIO_RING_F_INDIRECT_DESC and other cor=
e
> > feature bits even though it implements them. Therefore
> > vhost_old_default_feature_bits[] only includes feature bits that can be
> > explicitly negotiated without breaking existing libvhost-user device
> > backends.
>=20
> libvhost-user is in contrib. Can't we just fix it as appropriate?
> Work arounds have their cost ..

libvhost-user's behavior is unfortunate but the bigger problem is that
QEMU does not include backends in feature negotiation. Existing backends
for devices touched in this patch may have a broken
VHOST_USER_GET_FEATURES implementations and changing QEMU's behavior
will break them.

If you feel confident that third-party vhost-user backends will work,
then we can simplify this patch series. I think we should be very
careful but it's up to you.

Stefan

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8C+5wACgkQnKSrs4Gr
c8hjxAf+LPWcTIlC2XeAfMQ6jEJzgRIRSmpxooh6RkK3Tb6ezLiMn44/UcEKW6cv
sp4ihxJEFrfsYwnsS82GORjMxd3MzX3+kkh9hUP24PVVLyBeCTKXTfENJ49rMBVo
LT9rPtO4PQol9YNJMRZrbpsO6Ojh7axilLK+mPJtdjSgtBWbWXty2/szISoNv95B
Jd9F7c363MTOEHAZLzFarZz5I0jE4U1GZouQfif9lVHAjE21l+DlapGBSOqnoF1k
UjRfXQUJzjxdo4YNLcI/RP85XIUBKGRvIV3nBoqeclwfHcxiUqrkwIdi/xcOAEtu
hTuOLh3CxkZYRHPl693J62IqMsMfsQ==
=pMw8
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--


