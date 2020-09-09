Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D0DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F7E21532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHXc1gbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F7E21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvVm-0001WN-7J
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFvUg-0000Na-E3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:30:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFvUe-0005hp-T4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ps73P4v++rhsx29aKn9T1fdwUyuKJc1xOr4v4tZyI5Q=;
 b=GHXc1gbwrBYAEtSNiINynmjd3LYC3zi4aPQoHDdIpx5SQhgGN9qYvHBzpkVThicuWM7Pw8
 +cixqYrUuu6RiCxnZmyDEshGDMOg/Wmh8LcHg+NRNdbgqrPkZ1coleRHRzAW4ovY+/tg6A
 7InE/Rl/lyctRYHzRLW6vSZV45qcFgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-rAyi3OGgPpmgRLRw4S2Ovw-1; Wed, 09 Sep 2020 04:30:12 -0400
X-MC-Unique: rAyi3OGgPpmgRLRw4S2Ovw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2CE3801A9D;
 Wed,  9 Sep 2020 08:30:10 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A9BE838B8;
 Wed,  9 Sep 2020 08:30:10 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:30:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v4 1/2] logging: Fixes memory leak in test-logging.c
Message-ID: <20200909083001.GD12090@stefanha-x1.localdomain>
References: <20200908151052.713-1-luoyonggang@gmail.com>
 <20200908151052.713-2-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200908151052.713-2-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 11:10:51PM +0800, Yonggang Luo wrote:
> g_dir_make_tmp Returns the actual name used. This string should be
> freed with g_free() when not needed any longer and is is in the GLib
> file name encoding. In case of errors, NULL is returned and error will
> be set. Use g_autofree to free it properly
>=20
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/test-logging.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/test-logging.c b/tests/test-logging.c
> index 8a1161de1d..957f6c08cd 100644
> --- a/tests/test-logging.c
> +++ b/tests/test-logging.c
> @@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
> =20
>  int main(int argc, char **argv)
>  {
> -    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL)=
;
> +    g_autofree gchar *tmp_path =3D g_dir_make_tmp("qemu-test-logging.XXX=
XXX", NULL);
>      int rc;
> =20
>      g_test_init(&argc, &argv, NULL);

I don't see the memory leak. There is a g_free(tmp_path) at the bottom
of main().

Did I miss something?

Stefan

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9YkokACgkQnKSrs4Gr
c8hoBgf/XfLa3C2vHeMqaSGXU4e780AZfI7B1D7d7h2p2CbnT6DwFvvHWubCHM+c
lviey75V/tNfuqE4R6MyMZiYiLKpsazrAiJMlth2fIXLBXyRX4kb+05wg/PeRz5m
5/DuLY7LC+aUVJe/EqFR6bgC5ndrh9L+0Pq3CCb2hnwu45cmdDQ/jq7zZD7De3pS
MknfhB7QD1L2/6nLyUBXyCl6hx9lSxYGTSSa42eiXyPEyUlGIZPf6mKchJmU/95L
Hqs5BwB6gtMXBb7U5TmlSNhJoHc0uQQvootDj2g8WGSabNdcI4nxe+0cXAKABlD3
8ttFYfahcoLQQBWHkmNgZ7VGUCDxpg==
=Auys
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--


