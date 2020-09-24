Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6AAC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924DF23772
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPvHc1X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924DF23772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQ9A-0007Ty-FD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLQ8X-0006oY-Aw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLQ8V-0002OQ-Dt
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600949646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1DuwRiiDD6FKlwMUp1JEva/SPhkPCebn4fJiMfY5feI=;
 b=ZPvHc1X/n23UO+4poSqUpeZLN17jZajvNfFoyhyMKNEnfBN0+5S17KuOEGHJYrs9TUMX0H
 5MiFy9Bw0yqPgIQ6NSAb8Qy5SXJUqW/bRMzNGhM1Uo4NkJhQAarg59FXzELWpfh5jSTk1A
 54ieQb/71Uos3DMK2qhFIz0oAhjev0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-g3s_FbwoMyOA_aeZf3z4ew-1; Thu, 24 Sep 2020 08:14:03 -0400
X-MC-Unique: g3s_FbwoMyOA_aeZf3z4ew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856EF1008550;
 Thu, 24 Sep 2020 12:14:02 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E97661002C0B;
 Thu, 24 Sep 2020 12:14:01 +0000 (UTC)
Date: Thu, 24 Sep 2020 13:14:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 5/7] block: generate coroutine-wrapper code
Message-ID: <20200924121400.GX62770@stefanha-x1.localdomain>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zuE2pCA56U4I9Fhk"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zuE2pCA56U4I9Fhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:44:09PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Use code generation implemented in previous commit to generated
> coroutine wrappers in block.c and block/io.c
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/coroutines.h    |   6 +-
>  include/block/block.h |  16 ++--
>  block.c               |  73 ---------------
>  block/io.c            | 212 ------------------------------------------
>  4 files changed, 13 insertions(+), 294 deletions(-)

Nice

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zuE2pCA56U4I9Fhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sjYgACgkQnKSrs4Gr
c8ghmQf+IBBCHcX8c+2cR3WiY5pmHzk3xWdXkiO0Jc5+wmm5YlzwaV0NwQKmFoW0
vqxX+cvvrGzenE/jSLv66FslGyXTqw+qu+c9fGabIbX7+f1hWILo5/aY0RqT1xJJ
qSN24Kug+mWyiMlCBbHeYnBij1s9MjZF01x/TMfNswtO+UtJqxgs4vq1sCYaXsro
6X0Yi9H9SI8a+h6esTIxN/mKPr6hMXPZP2ji3+gbVnMFGB+TGc10PyqGRdgJMAPN
jcUdAWQRE4TLO86EoMfYDTMj/zKqR1L3Dh5mP0MFszmLt/EXihS3U8wpUxCzDbDP
aAWSdFuiJJQPugUvjobfO5GPSF0AfA==
=jVh2
-----END PGP SIGNATURE-----

--zuE2pCA56U4I9Fhk--


