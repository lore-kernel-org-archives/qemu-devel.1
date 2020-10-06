Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA3AC4727F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA7D20674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1TdRouV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA7D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPjqV-0001Xo-Nl
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPjmG-000640-Ik
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPjmE-0004du-Ka
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601978457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cq3HWoW6PFwueeJpZ8nhV2TqTLOzLdleyzBU3GaC+EE=;
 b=a1TdRouVLGDy65R3LhCr0yxWIVWPeKOjkJJw8zOdfP8Da/IlUq2A3pb2uwdYRTZ90cDunf
 n772L1n8uC3zKyvYBll4DtH1ZjvngYTHvNy7gVaU+602hrygBy8aQvU9gmMvIxseIcg9oE
 iEzwV95vZpMmJ0TnK3hLhaI1dchWDUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-L9GXKPmfPs6Z9Kdj1wI2HQ-1; Tue, 06 Oct 2020 06:00:55 -0400
X-MC-Unique: L9GXKPmfPs6Z9Kdj1wI2HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D30564080
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 10:00:54 +0000 (UTC)
Received: from localhost (ovpn-112-180.ams2.redhat.com [10.36.112.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ED8510013BD;
 Tue,  6 Oct 2020 10:00:48 +0000 (UTC)
Date: Tue, 6 Oct 2020 11:00:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [RFC 1/1] tools/virtiofsd: create temporary directory in /tmp
Message-ID: <20201006100047.GA50478@stefanha-x1.localdomain>
References: <20201001061519.636959-1-jfreimann@redhat.com>
 <20201001061519.636959-2-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201001061519.636959-2-jfreimann@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fidencio@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 08:15:19AM +0200, Jens Freimann wrote:
> mkdtemp() will try to create a current directory in the working
> directory of the process. In this case it's trying to create it in /.
> This is a problem when the process doesn't have write access there.
>=20
> This patch changes the template string and prepends "/tmp" which is
> typically writable.
>=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 0b229ebd57..f79bcce0d7 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2393,7 +2393,7 @@ static void setup_wait_parent_capabilities(void)
>  static void setup_namespaces(struct lo_data *lo, struct fuse_session *se=
)
>  {
>      pid_t child;
> -    char template[] =3D "virtiofsd-XXXXXX";
> +    char template[] =3D "/tmp/virtiofsd-XXXXXX";

Hi Jens,
Let's get rid of the temporary directory completely. I have sent a patch
that bind-mounts /proc/self/fd on top of /proc (which we don't need
anymore).

Stefan

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl98QE8ACgkQnKSrs4Gr
c8gWBgf/fZ3PGaXZbEDrKOR3d2Nb5mRRd2q6kI3cUlxkDKbCCpP684TwPk3Hzho9
L8C3uwrzc6Bnzv2fwxVCT4MQ9b/lkrn6TxVeI4u4MwTtqSshShMBHM/4SWnf6aqB
c/OaDbIijcGE6ImC1zYK5ygmjPs0LL71yrAT0LpBV6DogVI3rHxqZhs0x8kaK5nB
82a0VaXYfrzdvTm0bAFIC2MyAGSM93gzUUiFKMdaZT2OEY47snx2E+vNyL0UpIDh
vU6VhFa+2EVTx695dIRtHVbDhVUnd0x+2Gp5uomzlpQVLVhQ+3PfcjYJiAkxIZ08
XW9et5FsXPfgwvAv2QuLfaVn+kt9rg==
=k5lZ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


