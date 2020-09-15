Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2B6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BC282067C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b85qHSAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC282067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICim-0001tS-Pi
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICaj-0001jG-2f
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICaf-0008RB-KU
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600182593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mU6q4JigiPt7h7z7kE8tOvEP9emSXYb65/7XKVJDe8=;
 b=b85qHSAL/ADoh8+a+ViBimwpH20aGuwj+vNGTSoOM2O2AhmSchshXJJcZRcU9t8WFjB7S9
 wgLhiku5FPlLW6cSueIUcv2EMvwGROkEVQrniFBvzcn4okecINYYiPG1+nJKHenfFCpgr2
 Kdi9tOYEId+3clpd0TtXt+nFT2XFUYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-IXlEhCLANzCrOXGQROiKNw-1; Tue, 15 Sep 2020 11:09:46 -0400
X-MC-Unique: IXlEhCLANzCrOXGQROiKNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E7836D371;
 Tue, 15 Sep 2020 15:09:01 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02E89702E7;
 Tue, 15 Sep 2020 15:09:00 +0000 (UTC)
Date: Tue, 15 Sep 2020 15:31:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 12/13] block: Add bdrv_co_move_to_aio_context()
Message-ID: <20200915143142.GE629589@stefanha-x1.localdomain>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-13-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909151149.490589-13-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 05:11:48PM +0200, Kevin Wolf wrote:
> Add a function to move the current coroutine to the AioContext of a
> given BlockDriverState.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  6 ++++++
>  block.c               | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 981ab5b314..80ab322f11 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -626,6 +626,12 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, c=
onst char *tag);
>   */
>  AioContext *bdrv_get_aio_context(BlockDriverState *bs);
> =20
> +/**
> + * Move the current coroutine to the AioContext of @bs and return the ol=
d
> + * AioContext of the coroutine.
> + */
> +AioContext *coroutine_fn bdrv_co_move_to_aio_context(BlockDriverState *b=
s);

I'm not sure this function handles all cases:
1. Being called without the BQL (i.e. from an IOThread).
2. Being called while a device stops using its IOThread.

The races that come to mind are fetching the AioContext for bs and then
scheduling a BH. The BH is executed later on by the event loop. There
might be cases where the AioContext for bs is updated before the BH
runs.

I didn't investigate these cases but wanted to mention them in case you
want to add doc comments about when this function can be used or if
you'd like to verify them yourself.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9g0E4ACgkQnKSrs4Gr
c8hELQgAwU+bD5+Azdz07W8AtVOMilw6AquUfO6yHIsjI9taygMHGZhdDg4B4w0y
O1lQ0yPwRsXieiAM7jlmZUqehwXDRPIH4FYhXe+zN8xRH1dIS11uHPE2DFSN3jz8
rgjmVl+YUZsaKrhFN4OAYyMmwM8OezVITnsXgfoIIlVDcQHNru/FEuqstGV8Bd8Q
kAaH0kFZNQfmcIs6h3rNOJyf+3rs0lMIxlOjOl8ImXivmUfb0OyQ5BpL3p5ZIZAm
qKfN7XCthf/sxAZa8IIMnGWh+XzHOumXNM18Y8pcDKa+ZFH5bFEpZxAaOwHlAIuN
wphQZCodksnSR15ugQhIyXhpUUYZyw==
=AiWn
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--


