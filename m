Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43823C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E76122CBB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThGXMxxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E76122CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3IHQ-0001on-B6
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3IGQ-0000yj-Iv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:11:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3IGK-0002Ga-RA
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 08:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596629475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1IsZNXNf3mVqq0aoAU//4j+yOHpCRSRHCLG6R7csmcg=;
 b=ThGXMxxz3zUPv/4mon03DG+6eGc6vXFoQ0ERPEQzH1r+0pDWfJPW6EvYASQOKJjZDEcTpJ
 4u9Zwlql1ne8vLCDyrX3SNjJWxB0V1CgK4d3jAk0DBKeQMdpZTT0GhTCpCtDsPSydokWNs
 9qapFAfLFjIsj7t+Xe3VdSTUitPtF3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-qpmk6hpINsmxK50gX0vEQQ-1; Wed, 05 Aug 2020 08:11:12 -0400
X-MC-Unique: qpmk6hpINsmxK50gX0vEQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD62C58;
 Wed,  5 Aug 2020 12:11:11 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 639705DA33;
 Wed,  5 Aug 2020 12:11:08 +0000 (UTC)
Date: Wed, 5 Aug 2020 13:11:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yajun Wu <yajunw@mellanox.com>
Subject: Re: Any reason VIRTQUEUE_MAX_SIZE is 1024? Can we increase this limit?
Message-ID: <20200805121107.GG361702@stefanha-x1.localdomain>
References: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM7PR05MB6695D4FF6766BF2942C345D6BB710@AM7PR05MB6695.eurprd05.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: jasowang@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 07:46:09AM +0000, Yajun Wu wrote:
> I'm doing iperf test on VIRTIO net through vhost-user(HW VDPA).
> Find maximal acceptable tx_queue_size/rx_queue_size is 1024.
> Basically increase queue size can get better RX rate for my case.
>=20
> Can we increase the limit(VIRTQUEUE_MAX_SIZE) to 8192 to possibly gain be=
tter performance?

Hi,
The VIRTIO 1.1 specification says the maximum number of descriptors is
32768 for both split and packed virtqueues.

The vhost kernel code seems to support 32768.

The 1024 limit is an implementation limit in QEMU. Increasing it would
require QEMU code changes. For example, VIRTQUEUE_MAX_SIZE is used as
the size of arrays.

I can't think of a fundamental reason why QEMU needs to limit itself to
1024 descriptors. Raising the limit would require fixing up the code and
ensuring that live migration remains compatible with older versions of
QEMU.

Stefan

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qodsACgkQnKSrs4Gr
c8glpwf/TelESYwOt3nw/8xamXzel4EAtoMfPdwPl/3SlfYO9bW/J9lCr+aqmcsD
FUQEXvtlOzsaDaAP5BOOXRS8qdoKvXDEZ/oDJGeP/FI3XhOtAyTB3u6zBDqsAryh
v/jVXb63UMOhuBfqkoiNgl00OSCcfr94IasyljUVtCs/TcaefvXxBYZ4SI0XR5aQ
IAvcYukL69TlSf/wg/ZRhEfYpqcmip0wJ47u4yZoLWxK++xae+HUK19McBqJRlGh
W+JHq74lda9Mv6sr6LlU705ddwdSAgAUhk+9+ZCNcY53Bdumcp95Dwc3LHk8zRI+
dVSnoKtQ1+qC+e1AR590+4p9srS2SQ==
=YuW9
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--


