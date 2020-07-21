Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39537C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023AD2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6AoVeak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023AD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrjB-00049s-68
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxrhx-0002rs-EH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:49:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxrhu-0005qS-Ni
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595335757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UcDJQq7yypIfmXRQ5Q+hecpLDQfOt0saHjYdFJOHQVY=;
 b=W6AoVeakwrwOImtsZQnMviMCJtA23rpzE01rFub5YLN47r47H1VMUKNeFpjXNjzMqmAVo+
 M5f0i+kwNeFroGSzRyfWJYWSk4r40xmFDa/afr9nzKFBky5w7B05EIzESkIDM3A3bEQKAO
 p58zpQvRGA8zqT8QbWwU4Z+w83vM3FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-6eZF3wkeMpeSSYoMd_VloQ-1; Tue, 21 Jul 2020 08:49:08 -0400
X-MC-Unique: 6eZF3wkeMpeSSYoMd_VloQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F5C1083FA4;
 Tue, 21 Jul 2020 12:49:07 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48FF287B01;
 Tue, 21 Jul 2020 12:49:01 +0000 (UTC)
Date: Tue, 21 Jul 2020 13:48:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by the
 spec
Message-ID: <20200721124859.GF183198@stefanha-x1.localdomain>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200717092929.19453-3-mhartmay@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:
> Since virtio existed even before it got standardized, the virtio
> standard defines the following types of virtio devices:
>=20
>  + legacy device (pre-virtio 1.0)
>  + non-legacy or VIRTIO 1.0 device
>  + transitional device (which can act both as legacy and non-legacy)
>=20
> Virtio 1.0 defines the fields of the virtqueues as little endian,
> while legacy uses guest's native endian [1]. Currently libvhost-user
> does not handle virtio endianness at all, i.e. it works only if the
> native endianness matches with whatever is actually needed. That means
> things break spectacularly on big-endian targets. Let us handle virtio
> endianness for non-legacy as required by the virtio specification
> [1]. We will fence non-legacy virtio devices with the upcoming patch.
>=20
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.=
html#x1-210003
>=20
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>=20
> ---
> Note: As we don't support legacy virtio devices there is dead code in
> libvhost-access.h that could be removed. But for the sake of
> completeness, I left it in the code.

Please remove the dead code. It is unlikely that legacy device support
will be required in the future and it will just confuse people reading
the code.

> ---
>  contrib/libvhost-user/libvhost-access.h |  61 ++++++++++++
>  contrib/libvhost-user/libvhost-user.c   | 119 ++++++++++++------------
>  2 files changed, 121 insertions(+), 59 deletions(-)
>  create mode 100644 contrib/libvhost-user/libvhost-access.h
>=20
> diff --git a/contrib/libvhost-user/libvhost-access.h b/contrib/libvhost-u=
ser/libvhost-access.h
> new file mode 100644
> index 000000000000..868ba3e7bfb8
> --- /dev/null
> +++ b/contrib/libvhost-user/libvhost-access.h
> @@ -0,0 +1,61 @@
> +#ifndef LIBVHOST_ACCESS_H

License/copyright header?

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8W5DsACgkQnKSrs4Gr
c8hO0AgAg6voMDfAiLIlxBa1a3E5gbrfYFIDbffQ1Kh6UsHudIW5PIw7zHStcJiZ
APiM+2BpcAbXB6eh5ryPb6sxQt27eIULrfPBDSc/wxbkSyLrwCyNWpx8825wL3Zl
Sa3asC1xlyaCG9/fZHO1wZ6UTmrRNmapJtb3RWi9/Wi2rfhUOrB+TWJwIT3ytVMB
qNxeCOt/f17mr17tI12dwXxgkf07OPrVFC26zixZ2MJfpy3oWsJ9odWSWUQE9ZYI
rrcDCYvUPdpuAxtisZCcXQenZtcPySeYi6svQkg0ylcb6ye6SiDDxb8kG8NdfQYA
nTYofTCnSp6lL73KEEQkLHxPOEnABg==
=YD8S
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--


