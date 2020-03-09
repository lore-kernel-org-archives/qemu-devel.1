Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6410FC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F56F22522
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLuS11t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F56F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLa5-0006iV-EQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jBLYa-0005nw-Pn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jBLYZ-0000Xp-By
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:47:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jBLYZ-0000XH-7h
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583772426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gRUGZ/FD/zzl1f5b5Aor8IWsJgIvW8VVbyzafCy5N9A=;
 b=HLuS11t0kjtGMJUk0ZJVGjQGleX6TEnvwiNb//m3Q0QIMNoMMp5xTL9Ssmd19XpMeGOdCk
 XJnOr9ECOj2464BpX1K1K5MiV06wPxbVCrt3td32Oitxw3cxL4xVMc9AHrJeeRZz/R+aMf
 pDoJ2b0sQE5S6BRXx/Qs88ctvNqtKVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-MMMaW3pBMhSM-8lhUBC5gw-1; Mon, 09 Mar 2020 12:47:03 -0400
X-MC-Unique: MMMaW3pBMhSM-8lhUBC5gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B39F801E53;
 Mon,  9 Mar 2020 16:47:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CC755D9C5;
 Mon,  9 Mar 2020 16:47:01 +0000 (UTC)
Date: Mon, 9 Mar 2020 16:47:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/7] aio-posix: polling scalability improvements
Message-ID: <20200309164701.GA46812@stefanha-x1.localdomain>
References: <20200305170806.1313245-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305170806.1313245-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 05:07:59PM +0000, Stefan Hajnoczi wrote:
> A guest with 100 virtio-blk-pci,num-queues=3D32 devices only reaches 10k =
IOPS
> while a guest with a single device reaches 105k IOPS
> (rw=3Drandread,bs=3D4k,iodepth=3D1,ioengine=3Dlibaio).
>=20
> The bottleneck is that aio_poll() userspace polling iterates over all
> AioHandlers to invoke their ->io_poll() callbacks.  All AioHandlers are p=
olled
> even if only one of them was recently active.  Therefore a guest with man=
y
> disks is slower than a guest with a single disk even when the workload on=
ly
> accesses a single disk.
>=20
> This patch series solves this scalability problem so that IOPS is unaffec=
ted by
> the number of devices.  The trick is to poll only AioHandlers that were
> recently active so that userspace polling scales well.
>=20
> Unfortunately it's not possible to accomplish this with the existing epol=
l(7)
> fd monitoring implementation.  This patch series adds a Linux io_uring fd
> monitoring implementation.  The critical feature is that io_uring can che=
ck the
> readiness of file descriptors through userspace polling.  This makes it
> possible to safely poll a subset of AioHandlers from userspace without ri=
sk of
> starving the other AioHandlers.
>=20
> Stefan Hajnoczi (7):
>   aio-posix: completely stop polling when disabled
>   aio-posix: move RCU_READ_LOCK() into run_poll_handlers()
>   aio-posix: extract ppoll(2) and epoll(7) fd monitoring
>   aio-posix: simplify FDMonOps->update() prototype
>   aio-posix: add io_uring fd monitoring implementation
>   aio-posix: support userspace polling of fd monitoring
>   aio-posix: remove idle poll handlers to improve scalability
>=20
>  MAINTAINERS           |   2 +
>  configure             |   5 +
>  include/block/aio.h   |  70 ++++++-
>  util/Makefile.objs    |   3 +
>  util/aio-posix.c      | 449 ++++++++++++++----------------------------
>  util/aio-posix.h      |  81 ++++++++
>  util/fdmon-epoll.c    | 155 +++++++++++++++
>  util/fdmon-io_uring.c | 332 +++++++++++++++++++++++++++++++
>  util/fdmon-poll.c     | 107 ++++++++++
>  util/trace-events     |   2 +
>  10 files changed, 898 insertions(+), 308 deletions(-)
>  create mode 100644 util/aio-posix.h
>  create mode 100644 util/fdmon-epoll.c
>  create mode 100644 util/fdmon-io_uring.c
>  create mode 100644 util/fdmon-poll.c
>=20
> --=20
> 2.24.1
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5mcwQACgkQnKSrs4Gr
c8jZdAf/ZF6YjSPyatQBzxCTzkdY0mWzJtnWnXDCUfnv04yq45wvjSMX7eCJ1Hn4
+B27HIfhzpaWKylf6yVJ/Op988ZZNWTv0amhou5xuUK1Ri3MCuz7X7wWttAJdwQg
2yE9r+Z16hygqkgp0OeGfN+GDcKBONZ8SyngsquSZ1xKbA5lF8tdi4zL3fBMP22S
mG1vQnwQm7Yvi37vCKf2jjDK/nJfLrtHNcPpWPgIyPObRfWSqkmGOjyvZoCL3gTT
Ph9I6bi+Aj4yy+ik6Q25o2JymsP9gQstt5IuP0AMnTVcJMT5JfOgNFqrPzUCtc2s
JcoSdCRmRjFW4bgjpS8+nn4igSADBQ==
=90HN
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


