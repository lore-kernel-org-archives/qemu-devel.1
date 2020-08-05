Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D130C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F362245C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfPPYaya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F362245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Hyz-00057I-Br
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 07:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3HyJ-0004I7-VC
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 07:52:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20895
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3HyI-0007Cl-9Y
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 07:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596628357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISAclRtUGLvmb1HaQUFlqSPJQmbRE3KWCXGeoPAjnVI=;
 b=GfPPYaya4q58/MAAJxCEG3b/C3NC6MrEx8vZrDTOrYCJespvc8JiYJwsLCWEyGwmMKFljy
 tCToYAtWpK+8QUT6Qvj3VV04+kDV7qBUMdDb3VDrXbDaTrfSHia97+KfURmX1KpM9iZBfQ
 9ejB6eSTsgudmXyHDjnl+JuWoe/vXeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-yTTa66aNOq2cvAQWJJcTjw-1; Wed, 05 Aug 2020 07:52:35 -0400
X-MC-Unique: yTTa66aNOq2cvAQWJJcTjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BB9A80183C;
 Wed,  5 Aug 2020 11:52:34 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6DEA5F21A;
 Wed,  5 Aug 2020 11:52:30 +0000 (UTC)
Date: Wed, 5 Aug 2020 12:52:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Derek Su <jwsu1986@gmail.com>
Subject: Re: virtio-fs performance
Message-ID: <20200805115229.GF361702@stefanha-x1.localdomain>
References: <CAFKS8hWbckrE_cyJCf0pgFresD-JQk66wo-6uJA=Gu2MhReHVw@mail.gmail.com>
 <20200728134936.GA21660@stefanha-x1.localdomain>
 <CAFKS8hVwajyBFrVSURs1bS0F+ig8PSUAi1+YPUpe6=KYH8TjmA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFKS8hVwajyBFrVSURs1bS0F+ig8PSUAi1+YPUpe6=KYH8TjmA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SnV5plBeK2Ge1I9g"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SnV5plBeK2Ge1I9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 03:37:26PM +0800, Derek Su wrote:
> Set the cache=3Dnone in virtiofsd and direct=3D1 in fio,
> here are the results and kvm-exit count in 5 seconds.
>=20
> --thread-pool-size=3D64 (default)
>     seq read: 307 MB/s (kvm-exit count=3D1076463)
>     seq write: 430 MB/s (kvm-exit count=3D1302493)
>     rand 4KB read: 65.2k IOPS (kvm-exit count=3D1322899)
>     rand 4KB write: 97.2k IOPS (kvm-exit count=3D1568618)
>=20
> --thread-pool-size=3D1
>     seq read: 303 MB/s (kvm-exit count=3D1034614)
>     seq write: 358 MB/s. (kvm-exit count=3D1537735)
>     rand 4KB read: 7995 IOPS (kvm-exit count=3D438348)
>     rand 4KB write: 97.7k IOPS (kvm-exit count=3D1907585)
>=20
> The thread-pool-size=3D64 improves the rand 4KB read performance largely,
> but doesn't increases the kvm-exit count too much.
>=20
> In addition, the fio avg. clat of rand 4K write are 960us for
> thread-pool-size=3D64 and 7700us for thread-pool-size=3D1.

These numbers make sense to me. The thread pool is generally faster.

Note that virtiofsd opens files without O_DIRECT, even if with the
cache=3Dnone option. This explains why rand 4KB write reaches 97.7K but
rand 4KB read only does 7885 IOPS (random reads result in page cache
misses on the host).

I don't have a good explanation of why the thread pool was slower with
direct=3D0 though :(. One way to investigate that is by checking whether
the I/O pattern submitted by the guest is comparable between
--thread-pool-size=3D64 and --thread-pool-size=3D1. You could try to observ=
e
this by tracing virtiofsd preadv()/pwritev() system calls.

If you find that --thread-pool-size=3D64 made more I/O requests and with
smaller block sizes, then it's probably a timing issue where the guest
page cache responds differently because the virtiofsd thread pool
completes requests at a different rate. Maybe it affects how the guest
page cache is populated and a slower virtiofsd leads to more efficient
page cache activity in the guest (-> fewer and bigger FUSE read/write
requests)?

Stefan

--SnV5plBeK2Ge1I9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qnX0ACgkQnKSrs4Gr
c8hVrAf9FfJqBahHMhq7wxLOV5zfxam1rcnDhEpaDL68RpdXZ9jXO4RPOB7+nP3T
a3dhz/0sz7V4ribDPUgU/iTXg6Zn4j9MNwV/dN8rfVRy/J0DPqqViI7yXOu6ICz2
vzhKtoRHSksAjWjqgYI+DKBGGKXjdMjoq1VqyOucVA18qgVJTBquKr0e6YdoZ5SX
+JtteOmyOcp2AXUIyBswTqWfBthlDonnTl53oKWyGydV4NxWVB7jdaL0F1K5/XYU
TfMBT1udLN1ceudRRLbqA34pjpJ0cz+McLoM9AkSKUihaKEaIg8YA4cjFTXwhg69
VSFCHrpjJx7ctOroURO1s5adWLQxng==
=gfxr
-----END PGP SIGNATURE-----

--SnV5plBeK2Ge1I9g--


