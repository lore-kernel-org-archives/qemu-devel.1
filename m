Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE89C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1DD2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3SpGYJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1DD2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUFW-0004pH-H9
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1itUEE-0003hM-2L
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1itUEC-0004qn-6b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:24:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1itUEC-0004qH-2e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcZMYZyw2Qj9kNaFAavzhTqQn6UvzQn8N2WW2fHVHdo=;
 b=b3SpGYJIga46VjuB2St4qh2WAvWC/jlHtMQLt6R/YpxdYcZ9gtYZ83R7DgSMeOYcmu4jIh
 PerceznIi/69xEo2kYSyJyXNXM9+LRn0+Y6ilvCuNWLq3hFoiuS/RJU0895RkhO0QrsR+J
 lNKkdZf9FirbEu2QK7ikuTDUBjLcVKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-8dLViAvaOU-9cDxiQWrlYg-1; Mon, 20 Jan 2020 05:24:13 -0500
X-MC-Unique: 8dLViAvaOU-9cDxiQWrlYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCFA118A6EC0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:24:12 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D9384DAD;
 Mon, 20 Jan 2020 10:24:08 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-85-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 084/104] Virtiofsd: fix memory leak on fuse queueinfo
In-reply-to: <20191212163904.159893-85-dgilbert@redhat.com>
Date: Mon, 20 Jan 2020 11:24:05 +0100
Message-ID: <874kwq8lyy.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Liu Bo <bo.liu@linux.alibaba.com>
>
> For fuse's queueinfo, both queueinfo array and queueinfos are allocated i=
n
> fv_queue_set_started() but not cleaned up when the daemon process quits.
>
> This fixes the leak in proper places.
>
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
> ---
>  tools/virtiofsd/fuse_virtio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.=
c
> index 7b22ae8d4f..a364f23d5d 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -671,6 +671,8 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
>          }
>          close(ourqi->kill_fd);
>          ourqi->kick_fd =3D -1;
> +        free(vud->qi[qidx]);
> +        vud->qi[qidx] =3D NULL;
>      }
>  }
> =20
> @@ -878,6 +880,13 @@ int virtio_session_mount(struct fuse_session *se)
>  void virtio_session_close(struct fuse_session *se)
>  {
>      close(se->vu_socketfd);
> +
> +    if (!se->virtio_dev) {
> +        return;
> +    }
> +
> +    close(se->vu_socketfd);
> +    free(se->virtio_dev->qi);
>      free(se->virtio_dev);
>      se->virtio_dev =3D NULL;
>  }

There's a duplicated "close(se->vu_socketfd);" statement here.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4lf8UACgkQ9GknjS8M
AjVenQ/+L1HI/AqGOSyMsQTlEspSGMUjWGeur4Hi03ATfhd6XRI9KzRgYY3NuRZN
AQTs2tV6+E9cec9u6aeXpkjj+ufVAmPLRjpMXeIYGTdv8PJYXSJeHWKTBLJ+t4LE
O2DNATOD+D2OVe2IRW/9ZBm6HM3aUFR2f7Es0qZWkX1JsmHqjluhbSB+M+i+1eAT
tNuPMMCBG+4v6QE/EOBkJUwf36YDgV7iJ0dE8sAkLM3Vz6zMlTeuZkyLsKo2J6qo
yRZtCTPeYhFe1+0VutN4aZj8ydCpWPPZhvlxS3vjgzm9v+xMJcqpFUvrkukIcfb+
OgDUIq2cOlt1Nij3LG+tmkJsIxwW4IiY+rT2btYoTAOyjSIHfhC2dM+GAirjBxmS
CQNS8zwunFv7FSaezhqH1fjdCxR5gpZnAKJmthUOKHZG19JmjhoUWQ4vHnllUzFI
NTwvALKC3DLcEGSZhrOUOj4KI6JDpPdGipper9hnBGFGjdxMi5kxyqZtwM3ejHwt
fZTHZ6/OQ+MYfgVPZ8qjkIOSwHwbtx4JKwNrD/CJtPoXg3M+K3JWgLndshcSuEGz
lv72fjuOlk5HpiKlVLuQGvAnaBXu/bYZQyBmhLKLbetSFigNmXkR5hh/w0t10pDx
LSd4z89PqbwOcgQmvoYUNjFWAqVHMAEQsOuSJmhbk+m648uAg5Q=
=Klio
-----END PGP SIGNATURE-----
--=-=-=--


