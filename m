Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6882C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD885239A1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVim8s8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD885239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdEZ-0006lG-6x
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKdD6-0006BS-BU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKdD3-00038Q-8z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600761572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0fQYLg2+p5zbjNiO5yL0pfajKcfknZCyyXTT1jnYqO0=;
 b=OVim8s8Y4yKuF4JCn9KKyhnhJ+GqMpEY99kHSuCy4KKVmL+Rlzd3k7bvHeB11g31b4Rvub
 G68GEbneAJtuHV1gyd2uv3i6aQnGU4WjqWLPW5eqpzfp9fvrzSmZpNZHXUE1T/jVfpkKxo
 9WBQ8A8sKyhavxJm284BsMnGs24re3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-pdo4IgcYOqa5BkTH3KJdUA-1; Tue, 22 Sep 2020 03:59:28 -0400
X-MC-Unique: pdo4IgcYOqa5BkTH3KJdUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 541EF8030C7;
 Tue, 22 Sep 2020 07:59:27 +0000 (UTC)
Received: from localhost (ovpn-112-243.ams2.redhat.com [10.36.112.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2BB05DA30;
 Tue, 22 Sep 2020 07:59:23 +0000 (UTC)
Date: Tue, 22 Sep 2020 08:59:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] virtio: restore elem->in/out_sg after
 iov_discard_front/back()
Message-ID: <20200922075922.GA201611@stefanha-x1.localdomain>
References: <20200917094455.822379-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200917094455.822379-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 10:44:52AM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Add missing undo in virtio-blk write zeroes error path [Li Qiang]
>=20
> Both virtio-blk and virtio-crypto use destructive iov_discard_front/back(=
)
> operations on elem->in/out_sg. virtqueue_push() calls dma_memory_unmap() =
on the
> modified iovec arrays. The memory addresses may not match those originall=
y
> mapped with dma_memory_map().
>=20
> This raises several issues:
> 1. MemoryRegion references can be leaked.
> 2. Dirty memory may not be tracked.
> 3. The non-RAM bounce buffer can be leaked.
>=20
> This patch series solves the issue in two ways:
> 1. virtio-blk uses a new iov_discard_undo() API to restore iovec arrays.
> 2. virtio-crypto uses g_memdup() to avoid modifying the original iovec ar=
rays.
>=20
> The g_memdup() approach is slower than iov_discard_undo() but less
> complex/fragile. I am less familiar with the virtio-crypto code and it us=
es
> more complex sequences of iov_discard_front/back() calls than virtio-blk.=
 If
> anyone feels like optimizing virtio-crypto, please go ahead.
>=20
> The virtio-blk bug was found by Alexander Bulekov's fuzzing effort. I fou=
nd the
> virtio-crypto bug through code inspection.
>=20
> Stefan Hajnoczi (3):
>   util/iov: add iov_discard_undo()
>   virtio-blk: undo destructive iov_discard_*() operations
>   virtio-crypto: don't modify elem->in/out_sg
>=20
>  include/hw/virtio/virtio-blk.h |   2 +
>  include/qemu/iov.h             |  23 +++++
>  hw/block/virtio-blk.c          |  11 ++-
>  hw/virtio/virtio-crypto.c      |  17 +++-
>  tests/test-iov.c               | 165 +++++++++++++++++++++++++++++++++
>  util/iov.c                     |  50 +++++++++-
>  6 files changed, 259 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9prtoACgkQnKSrs4Gr
c8hKDAf/RIWKzIAc/Tu6DQQcolRKyHr0ETFNkGepi+ABGLklu6+zi0u6K1oncrN6
hY03qWBWG1CP6WfnsNbKh7prr+9fQ3Nu0VwDAympBovrRN51x4JD0XzKb7pG93RN
NPTp6XguIc0xwywhrnc885nxdTb9AKystd8F2mOFWjtYz7al8HwRyLEf/mANmIEz
/jHtlt3l75rE7seKGr9B/wgpL7DU6+5RHPyzBmpjbiST2QV2OA/HaDiBYA7UuBXW
jmbAMlKSS9xX3mvnAu3gaQA6XQyrF0rcBEkfeZqlfneRe2Kwkpfcr9PNtQTfn+TZ
tIvRpQyqndZB4xYUvNqXNnbibjHI9A==
=uAnT
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


