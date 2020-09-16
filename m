Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2276FC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE1A2087D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIanAG7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE1A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITID-0007sH-DM
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kITHR-00071y-ST
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kITHP-0001QX-GO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600246745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MNrvx9f1poRDIYyM3CZCe6/KL1YPFra6VgVMbX1gbCg=;
 b=IIanAG7/nYrnnGAYu+EuKPY+Wi91mlefxWtGdcB+bXj+1enC9mqjSk2CDI6Sq1EA1gOnT4
 3RzGtLzOyzm9ghv+xwYIzjrXmB3tjrGTEULhoRFKx5Pu7cDvpvE18kIbzmaRV51fRYrSev
 YU3tZYKBGrIXVCj9srT/a7xmIDYutO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-i2J25fqNPLqP3ivxs2h-ug-1; Wed, 16 Sep 2020 04:59:01 -0400
X-MC-Unique: i2J25fqNPLqP3ivxs2h-ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C99D710BBEC3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:59:00 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7474E75144;
 Wed, 16 Sep 2020 08:59:00 +0000 (UTC)
Date: Wed, 16 Sep 2020 09:58:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] configure: move malloc_trim/tcmalloc/jemalloc to meson
Message-ID: <20200916085859.GA748884@stefanha-x1.localdomain>
References: <20200916080608.17689-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916080608.17689-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 04:06:08AM -0400, Paolo Bonzini wrote:
> Because LIBS is not used anymore, tcmalloc/jemalloc does
> not work with binaries whose description is in Meson.
> The fix is simply to move them to Meson too.
>=20
> For consistency with other configure options, specifying
> --enable-malloc-trim together with --enable-{tc,je}malloc
> becomes a fatal error.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure         | 84 +++++------------------------------------------
>  meson.build       | 28 +++++++++++++---
>  meson_options.txt |  5 +++
>  3 files changed, 38 insertions(+), 79 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9h09MACgkQnKSrs4Gr
c8hv0wf/XJgpgVYXdCORQiyWu7Ur3AS8X274uvGb4lJhL1/460yKNyloQ0ZBBlPB
SYbHU+dPIxXfHuubRMAXzI5hyww6ujPgKhUR6n2NvnveDU9dQsHcCmH59etVMm7B
0LcirWL+Z1+tlmVUHDyt40TpN7o35GdR2s7+mOqxw+/lXqR1O10v6O5316JfdLUX
44pzKbTsJ3Z4pa6CecwN8SzZXB++Bxi7hRG80WbGuxuEgfyLHU9A8TPsADB4jz/l
8xeZ5SHIXlrwggtvsF+Ue9bHrxmHZcfGZAz2iqLskkHvSBt6LIZUQOmDK3ruUTwR
RBNgbx8yYx8ynsfOLlTghuAGgxH7sQ==
=xnKA
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--


