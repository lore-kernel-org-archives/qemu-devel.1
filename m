Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC3BC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3CE246AD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d94EoOi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3CE246AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXkpQ-00010n-Tw
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 08:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXkoW-0000Xr-Do
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXkoU-0005Bt-Q3
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603889066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=erX8ZbWi1kdcAxnIUqiIsxD2JGFq7agTHnIoUcMt6gY=;
 b=d94EoOi+nAY4qzzdrLCZcnHSz14+n2Mcha6OP67Cs6L96BxHC4nKjl9WlRBJFlzwvsIbT7
 p3QD7TFSyDoBSFLznOwdjljJkBJ2nlSCtoB/jPfAUZWoy8y7SbXHyS/xKFzdXyxrMLKmkz
 A68q0aAIrJNEjJoCeP1zGzno2Ms36bU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-oRJWlXJsO8K70RZMQDmfPg-1; Wed, 28 Oct 2020 08:44:23 -0400
X-MC-Unique: oRJWlXJsO8K70RZMQDmfPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7822C107B47A;
 Wed, 28 Oct 2020 12:44:22 +0000 (UTC)
Received: from localhost (ovpn-115-29.ams2.redhat.com [10.36.115.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19F0E60FC2;
 Wed, 28 Oct 2020 12:44:16 +0000 (UTC)
Date: Wed, 28 Oct 2020 12:44:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: skip guest index check on device load
Message-ID: <20201028124415.GB231368@stefanha-x1.localdomain>
References: <20201026151328.77611-1-felipe@nutanix.com>
 <20201027113049.GH79063@stefanha-x1.localdomain>
 <20201027082337-mutt-send-email-mst@kernel.org>
 <12146644-5D22-4CAC-9B4F-F16E84ED56AE@nutanix.com>
 <20201027085447-mutt-send-email-mst@kernel.org>
 <AE57D4EC-2C3C-4C22-9203-38A61D87B31F@nutanix.com>
 <20201027090420-mutt-send-email-mst@kernel.org>
 <20201028110038.GE221115@stefanha-x1.localdomain>
 <20201028072812-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201028072812-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 07:30:55AM -0400, Michael S. Tsirkin wrote:
> On Wed, Oct 28, 2020 at 11:00:38AM +0000, Stefan Hajnoczi wrote:
> > On Tue, Oct 27, 2020 at 09:04:46AM -0400, Michael S. Tsirkin wrote:
> > > It's not a waste of time, it's just a lot of work
> > > within guests.
> >=20
> > Luckily it does no harm to set the NEEDS_RESET bit even if the guest
> > doesn't handle it.
> >=20
> > If the guest driver is unaware it may continue to submit requests to th=
e
> > device for a while. The device emulation code stops accepting new
> > requests though. This means the device will become unresponsive until
> > reset, which is not ideal but okay in the case where the device was put
> > into an invalid state.
>=20
> There is no actual rule that device must stop processing requests.
> Driver can only assume that is the case after it started the
> actual reset.

Right, I mean QEMU's implementation stops processing new requests once
the device has been marked "broken":

  void *virtqueue_pop(VirtQueue *vq, size_t sz)
  {
      if (virtio_device_disabled(vq->vdev)) { <---
          return NULL;

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZZ58ACgkQnKSrs4Gr
c8gGvwf/VIRF/ZrQekof6Akc4R8W/Xp+A0rUuNM/Sqq+zBQjFN7Hlf78lC4ReS+s
NW0DYIzEAQrA4oMbzQ1qBwTIB+kX3W8SMS9zlAzR4o1Ya0eXShJHKrPPjXjtvyAA
4vsRNPvIwq+M4/rMMdJ/orVmROHNwNO7i8i3MpXG4v9Skae+gc161m25wwvNOZh3
D5VlOwrSL1tBpYBjmU1iiMkhEzx5S4LVOHgn8KWRbKzpBddNUDKHse56A63yeKRM
gylX+772LxU1Gkbp2tD3tRRjb0FKbgk1x3raHfZVNoYc+zLGc8akZ6fKIAD7g1TC
1ROxXaHcRPh/GaeZkE+5gumyls2mgg==
=EjcG
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--


