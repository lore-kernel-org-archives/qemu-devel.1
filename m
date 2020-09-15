Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585CC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD2520735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+n5fCxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD2520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICfR-0008Ae-BB
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICac-0001du-3w
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICaa-0008Pv-KB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600182587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0l6rLvEFGDBQ1LPhxUKsSVzOQCwG1h2RxbloQnnjzX4=;
 b=X+n5fCxcfVlSzs76o1EuWZ55EvMHlyNgthYbcgtjSvqeQyMwC1hsbcoe4IAx1Z1N/Vf9my
 ySHYntRAZ+zuJgSfB6dWYc6vlsl71bPoclZdW1DUcp9GA6QbN0WReuxA9rVcMXZBgonFkO
 W6ILFzx2nuy8fYgQRcues9542W6Ja+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-sq7xYwPvMaawMU_hmn48Hg-1; Tue, 15 Sep 2020 11:09:40 -0400
X-MC-Unique: sq7xYwPvMaawMU_hmn48Hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCE5A8C44BD;
 Tue, 15 Sep 2020 15:08:59 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80FB660BE2;
 Tue, 15 Sep 2020 15:08:59 +0000 (UTC)
Date: Tue, 15 Sep 2020 15:25:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 11/13] util/async: Add aio_co_reschedule_self()
Message-ID: <20200915142519.GD629589@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-12-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909151149.490589-12-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 05:11:47PM +0200, Kevin Wolf wrote:
> Add a function that can be used to move the currently running coroutine
> to a different AioContext (and therefore potentially a different
> thread).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/aio.h | 10 ++++++++++
>  util/async.c        | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9gzs8ACgkQnKSrs4Gr
c8gp/gf+O86mnyHBqb4wQBPyD8yRHUM9qPs/OlFmr5iPjAvMKSvYglkXmIa701CJ
m4h3+0B19EReCkfV3OTQ7ePDhJRAa68LK9HNWMNcMAylzOWM4q0wGO9n287eJu+v
7bzExiS3+ciwDHDlImHV4zPF1qM4NqXHR607hFsNFeWeVkHre59Fvj1qTd7ccPbi
D05w+umHlQho9l7Ms7nKKJSGj2vYZy0XJuacXyQKu1tMPGvXZssvxfGy+q9kcoZ5
D1GWoHGRg/p1D/9dx3/ahMrMHbatYY3FC8tXWbO29ODFhqqro/Aj0H3sUJuhCDYw
L/G9lxGXStWz+KNUy7VzkEiiGW04YA==
=Wt+S
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--


