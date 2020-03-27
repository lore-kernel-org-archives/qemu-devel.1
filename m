Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D697FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A080420658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqpD7iG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A080420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHpm3-0001W5-Q5
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHplD-0000qi-3G
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHplB-0004Jr-Ta
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:14:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51307)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHplB-0004H2-PV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585318497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7BYT4SskeMhzKnG3RX+c7+AAVuV7Kw8KTRaxp2Uh+Y=;
 b=IqpD7iG4cAniI844uALuATZixvr/ObEAP3DpRibIrE9EFdimNEePS+xqcLAkq+cTJfPDKA
 LBEfQWMzXwTUp8OmFdpWD9XEkNtFa6QbnSrECIraLUpKdr0Pfyr4LxGn4rc6+dDKOCGA59
 5D4DQiQtJ+oyhnnBOxbELSUZfyPf3TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-H-Ar3ZYyMYKUEOVT8D0RlA-1; Fri, 27 Mar 2020 10:14:53 -0400
X-MC-Unique: H-Ar3ZYyMYKUEOVT8D0RlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9F3F1922030;
 Fri, 27 Mar 2020 14:14:52 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F6223AB;
 Fri, 27 Mar 2020 14:14:44 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:14:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH v2] qcow2: Forbid discard in qcow2 v2 images with backing
 files
Message-ID: <20200327141442.GA6901@linux.fritz.box>
References: <20200324121636.24136-1-berto@igalia.com>
MIME-Version: 1.0
In-Reply-To: <20200324121636.24136-1-berto@igalia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.03.2020 um 13:16 hat Alberto Garcia geschrieben:
> A discard request deallocates the selected clusters so they read back
> as zeroes. This is done by clearing the cluster offset field and
> setting QCOW_OFLAG_ZERO in the L2 entry.
>=20
> This flag is however only supported when qcow_version >=3D 3. In older
> images the cluster is simply deallocated, exposing any possible stale
> data from the backing file.
>=20
> Since discard is an advisory operation it's safer to simply forbid it
> in this scenario.
>=20
> Note that we are adding this check to qcow2_co_pdiscard() and not to
> qcow2_cluster_discard() or discard_in_l2_slice() because the last
> two are also used by qcow2_snapshot_create() to discard the clusters
> used by the VM state. In this case there's no risk of exposing stale
> data to the guest and we really want that the clusters are always
> discarded.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>

The test number 289 is already taken, so this needs a rebase.

> +echo
> +echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing f=
ile"
> +echo
> +for qcow2_compat in 0.10 1.1; do
> +    echo "# Create an image with compat=3D$qcow2_compat without a backin=
g file"
> +    _make_test_img -o "compat=3D$qcow2_compat" 128k
> +
> +    echo "# Fill all clusters with data and then discard them"
> +    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
> +
> +    echo "# Read the data from the discarded clusters"
> +    $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
> +done

How about adding a 'qemu-img map' call just to have some more direct
information about what happened to the allocation status?

> +
> +echo
> +echo "### Test 'qemu-io -c discard' on a QCOW2 image with a backing file=
"
> +echo
> +
> +echo "# Create a backing image and fill it with data"
> +BACKING_IMG=3D"$TEST_IMG.base"
> +TEST_IMG=3D"$BACKING_IMG" _make_test_img 128k
> +$QEMU_IO -c 'write -P 0xff 0 128k' "$BACKING_IMG" | _filter_qemu_io
> +
> +for qcow2_compat in 0.10 1.1; do
> +    echo "# Create an image with compat=3D$qcow2_compat and a backing fi=
le"
> +    _make_test_img -o "compat=3D$qcow2_compat" -b "$BACKING_IMG"

I would write some non-zero data to the backing file so that you can
later distinguish zero clusters from unallocated clusters.

> +    echo "# Fill all clusters with data and then discard them"
> +    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
> +
> +    echo "# Read the data from the discarded clusters"
> +    if [ "$qcow2_compat" =3D "1.1" ]; then
> +        # In qcow2 v3 clusters are zeroed (with QCOW_OFLAG_ZERO)
> +        $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    else
> +        # In qcow2 v2 if there's a backing image we cannot zero the clus=
ters
> +        # without exposing the backing file data so discard does nothing
> +        $QEMU_IO -c 'read -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
> +    fi
> +done

Kevin


