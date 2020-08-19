Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2AEC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039F2207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPmTcck2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039F2207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PpK-0001Rm-J5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PoF-0000ZM-44
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:15:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PoB-0007jY-Gs
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597850121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGDN36iSprbpUOwUpxH8mCSKUAVJlvCMMNYnkENeKQA=;
 b=SPmTcck2orokj5EFNjrIOsNv1/uTMKsZ0yxF5fmknCxoeS8EOF17TxMSongBwtM45vON1n
 qjlZgkNcY497ZAFgdInrfN+wO+ydRNr4p+Q0C/QI6BKhHwqhARBKjo6bK9WQDWHvemdcF7
 sohSdAtnQn8cGnIjPslnqAVGp3l0uNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-Q5t00C_IPvy2M9Beq7sjTA-1; Wed, 19 Aug 2020 11:15:18 -0400
X-MC-Unique: Q5t00C_IPvy2M9Beq7sjTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E423A186A56B;
 Wed, 19 Aug 2020 15:15:16 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4748A10013C2;
 Wed, 19 Aug 2020 15:15:16 +0000 (UTC)
Date: Wed, 19 Aug 2020 16:15:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 12/12] block/qcow2: automatically insert preallocate
 filter when on FUSE
Message-ID: <20200819151515.GO366841@stefanha-x1.localdomain>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-13-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200817091553.283155-13-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 12:15:53PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> vstorage has slow allocation, so this patch detect vstorage
> (I hope, we don't use other FUSE filesystems) and inserts preallocate
> filter between qcow2 node and its file child.
>=20
> The following test executes more than 10 times faster
> (43.2s -> 3.9s for me) with this patch. (/newssd3 is mount point of
> vstorage, both cs and mds are on same ssd local ssd disk)
>=20
>     IMG=3D/newssd3/z
>     FILE_OPTS=3Dfile.filename=3D$IMG
>     COUNT=3D15000
>     CHUNK=3D64K
>     CLUSTER=3D1M
>     rm -f $IMG
>     ./qemu-img create -f qcow2 -o cluster_size=3D$CLUSTER $IMG 1G
>     ./qemu-img bench -c $COUNT -d 1 -s $CHUNK -w -t none -f qcow2 $IMG

Kevin's input is needed here. I think the philosophy is that nodes are
not automatically inserted. The user should define the graph explicitly.
The management tool would be responsible for configuring a preallocate
filter node.

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89QgIACgkQnKSrs4Gr
c8jx6Qf+JWMzYZSyLAwENRuMSXzCo4Lf9Ty9jrEZzvEKsoHjZ0IOzpgDDityqsly
GJOR5xSpmXzwChVKxahd7mZvLFb/YNd9ii408AhgdEaoUHZJPG0UrkQRxrCBeyrj
VL1YY8yPSWoLYIoXK/0J7+6X1qGHHLDN4jKKx+ofwAocElSaASghwRMyWHu7ULtU
2TRSNoLi+s1jTxlNRIpO3Xk4U0GigsNgHJBxilJVWV7noquVA4xPYzWae+OWjhK8
CZaCzULl1T+uuaMl5WrPXwruZxleuSNqc1lWbtekKZdTD+m8ZrIH9EWuMBrXcStO
hNBZ38qQTvnGXGWFQI8faWM7CrmNiA==
=JTTN
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--


