Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738C32078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9xAIsB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738C32078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKvD-0003Q9-L3
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jKKsP-0007jL-5R
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jKKsO-00032Z-2v
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jKKsN-00031z-Uf
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585914763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+/43r3WABavf+jF9O3BMNG10CRhYaIOq9X1EI+IJ6/4=;
 b=d9xAIsB87DqGScMksR0HccwbR0YzMV8PvwZgfkv2b1qX2XBOiahwvBK3p4EJc3tK/KXRZE
 47jCrMV1IOT7IGIdYoNXYaNXmji0vHY6DRx++d3Hu4XN945Ei4Q3JTHGY/2FehuQjKhO29
 ftcKeFd707AYiMhPwsYBt3erkJTeM0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-lfmKKYc0Oq233sMUG5i2_g-1; Fri, 03 Apr 2020 07:52:39 -0400
X-MC-Unique: lfmKKYc0Oq233sMUG5i2_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D2CF1005509;
 Fri,  3 Apr 2020 11:52:38 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFFB61000322;
 Fri,  3 Apr 2020 11:52:34 +0000 (UTC)
Date: Fri, 3 Apr 2020 12:52:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.0] aio-posix: fix test-aio /aio/event/wait with
 fdmon-io_uring
Message-ID: <20200403115233.GB135040@stefanha-x1.localdomain>
References: <20200402145434.99349-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200402145434.99349-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Julia Suvorova <jusual@redhat.com>, qemu-block@nongnu.org,
 Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 03:54:34PM +0100, Stefan Hajnoczi wrote:
> When a file descriptor becomes ready we must re-arm POLL_ADD.  This is
> done by adding an sqe to the io_uring sq ring.  The ->need_wait()
> function wasn't taking pending sqes into account and therefore
> io_uring_submit_and_wait() was not being called.  Polling for cqes
> failed to detect fd readiness since we hadn't submitted the sqe to
> io_uring.
>=20
> This patch fixes the following tests/test-aio -p /aio/event/wait
> failure:
>=20
>   ok 11 /aio/event/wait
>   **
>   ERROR:tests/test-aio.c:374:test_flush_event_notifier: assertion failed:=
 (aio_poll(ctx, false))
>=20
> Reported-by: Cole Robinson <crobinso@redhat.com>
> Fixes: 73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf
>        ("aio-posix: add io_uring fd monitoring implementation")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HI4EACgkQnKSrs4Gr
c8iiuwgAlFv1i6j77ZeoUPvtkJDMP9YEA/YYIENXrtW/e0Va57X/YFDMIWEzSR8h
hoHrGZDZtL97Tp/ENDcmd9zWMjFzRcAzJ9Ey26v0ec7TEXhGydh4rocE9G4HIjXf
KIVZpV0LMl09kovlqIwbRO5BNe+q8UOFmKdogKAXUB2p4u5K2ODYC+lJSlwWGFW8
RNiWNOsTzTX0YQokrN7KC8T4FbuhuLciF6UuhjrsRRELLmNkAicfd4wd2rsoSddT
9uuVhbzierZKt5uBLVi7H9AeNEuuDkkCKm88BOxWMQ5Z0YcTyDoX7VDBPe0x9ZbP
IR8kLq2gpzS4wHatNevtiQp1ghDIjg==
=HS5t
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--


