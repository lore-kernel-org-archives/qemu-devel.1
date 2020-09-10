Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DDAC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A513A20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbwC2Ip0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A513A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKBI-0008Px-O4
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK9u-0006hH-C8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK9q-0005P5-AC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599735025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzT1UUOZZBq7gycfQzduS6z2Nwc3dJFT4H0gurz36Rc=;
 b=FbwC2Ip0IIZqPYyJULronUbIUYhtVIOieu61QLuzPDbJcxdXJJ0PHNpmERfOEc7kfTT+Mj
 jxUe9cFVimzjbGJHGTXLV83lPRc4SvCeUNKHbKoSOgLX/IYSCWv7h5ihyXMoD3p6fpj1dZ
 edwdQ+eGpnxp6hSZqISVGhrAHDqjRA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-GmgfNNYmPUShxYvuBzJ05A-1; Thu, 10 Sep 2020 06:50:21 -0400
X-MC-Unique: GmgfNNYmPUShxYvuBzJ05A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0760A425D8;
 Thu, 10 Sep 2020 10:50:20 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA4F37E731;
 Thu, 10 Sep 2020 10:50:16 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:50:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 2/4] util/vfio-helpers: Report error when IOMMU page
 size is not supported
Message-ID: <20200910105015.GC45048@stefanha-x1.localdomain>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909142354.334859-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 04:23:52PM +0200, Philippe Mathieu-Daud=E9 wrote:
> This driver uses the host page size to align its memory regions,
> but this size is not always compatible with the IOMMU. Add a
> check if the size matches, and bails out with listing the sizes
> the IOMMU supports.
>=20
> Example on Aarch64:
>=20
>  $ qemu-system-aarch64 -M virt -drive if=3Dnone,id=3Dnvme0,file=3Dnvme://=
0006:90:00.0/1,format=3Draw
>  qemu-system-aarch64: -drive if=3Dnone,id=3Dnvme0,file=3Dnvme://0006:90:0=
0.0/1,format=3Draw: Unsupported IOMMU page size: 4 KiB
>  Available page size:
>   64 KiB
>   512 MiB
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9aBOcACgkQnKSrs4Gr
c8jzawgAx7aog1pbrTdfsHTRyE2RQKi7mGVqLNSmCq+P/lS5/BGIePn/Sz5tt3Bf
GXAWmgtwG6+0VsbFHFnqD/owMbOaj7cDGjBd8XjTdJm3mOmt2tKtz26swVa3hS+X
aJH2KRF5Iu6V4j8LpCRJq7zzybzibXd+SNcQkoHeudRiaa/31/g2nNH3AwRRUxoO
+KxhFuQCoTJeIBhYltDLOmq3YJ4XUSPQbCgJJW/nUzooxMHZrn2j/z9OmS4NVdux
B/f4Jan9v63qvF4Uezn29CP3ndv/fc8zfoCUl1rNSNDpoEe0cR51/w1qs4mkLgrZ
bj6jWGQ1a8+CalxmpWhaq0904jT90Q==
=CCuq
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--


