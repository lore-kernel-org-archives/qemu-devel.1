Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DCC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DA120EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyBt/NMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DA120EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqwk-00064L-FQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpJ6-0001jy-Th
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpJ3-0000jt-24
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600093088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O7cVjCu5zBxlEnJRklyo3Hp2dtvxb5BW+bNNBH4qL4Q=;
 b=OyBt/NMcCpuNQU47x7wYVs4ATXfJVcQgi/a3dUzmu0Uf5M2Sw9A0kvJa1FmkR7zLiSgXeU
 vaFG81K9bEA0dgIHdCXTtCwwPUma9jZMBqjkW69R0cNIOKrmQL/d/IEFIgud9vWtEH7x3F
 9ziR0TMV8qCgIR5TJaNwoOdHVJu08zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-_7hDlD_NPPqUkoq2BZxXWA-1; Mon, 14 Sep 2020 10:17:59 -0400
X-MC-Unique: _7hDlD_NPPqUkoq2BZxXWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB9451800D42;
 Mon, 14 Sep 2020 14:17:57 +0000 (UTC)
Received: from localhost (ovpn-114-32.ams2.redhat.com [10.36.114.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34EA027BDD;
 Mon, 14 Sep 2020 14:17:57 +0000 (UTC)
Date: Mon, 14 Sep 2020 14:13:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v8 0/6] block: seriously improve savevm/loadvm performance
Message-ID: <20200914131304.GJ579094@stefanha-x1.localdomain>
References: <20200709132644.28470-1-den@openvz.org>
MIME-Version: 1.0
In-Reply-To: <20200709132644.28470-1-den@openvz.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 04:26:38PM +0300, Denis V. Lunev wrote:
> This series do standard basic things:
> - it creates intermediate buffer for all writes from QEMU migration code
>   to QCOW2 image,
> - this buffer is sent to disk asynchronously, allowing several writes to
>   run in parallel.
>=20
> In general, migration code is fantastically inefficent (by observation),
> buffers are not aligned and sent with arbitrary pieces, a lot of time
> less than 100 bytes at a chunk, which results in read-modify-write
> operations with non-cached operations. It should also be noted that all
> operations are performed into unallocated image blocks, which also suffer
> due to partial writes to such new clusters.
>=20
> This patch series is an implementation of idea discussed in the RFC
> posted by Denis Plotnikov
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg01925.html
> Results with this series over NVME are better than original code
>                 original     rfc    this
> cached:          1.79s      2.38s   1.27s
> non-cached:      3.29s      1.31s   0.81s

Kevin and Max: Is this going through one of your trees?

Stefan

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fbGAACgkQnKSrs4Gr
c8ipPwf8CMtq39/DtgRM4BgFY42YQ1Px8cGLFi+fVRu2iP8SoOLn5N/hGAy3MFU3
tmstBxaNrvcAarU6JET61pA9t7yW4vz5Y7zm1FphHKlXwu6t9D5TlHoExJK3KxE1
yLn+0LHXJO2rUwBYwSIAfeYXpes9KTlzv5u/1aOWfkC4eTgExv0w/AiA3CVmfFLO
8fqgpB5qknXyKBWdO4m8t8DT8EuFXgodP0FvbsfCfUuQmH6ipgQkINOGO3l0KSjD
i4BtHJYKZxyGWXFBAdW+HdTHl67ozIXW+acz3kQwAQptO/6qDhypTwe1/rLj4+KK
G+ZKHmCGBliA/5JbLVTip3YQsO/4uw==
=ibL+
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--


