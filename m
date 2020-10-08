Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46180C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843C922200
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgrjDLrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843C922200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQdKD-0002No-BG
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQdId-0001uQ-NY
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kQdIb-0004Je-9M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602191884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HklCUJj3ebY0ZbV/anRIuCNx1RMlWT60ok4l58QKp7E=;
 b=JgrjDLrIAFdgorVM/JrCRh0GNsRFSr9UtvJa5eVBhcB1+lEad1ngvGvdN1ZOXJCEbg4K9v
 KDkZ6Qc5Hn/Vq/c1AzC7YPOZm55So6bWTJGjfGnr5P83zR5Qo72QaN7j5RVo9+dSkbg6Hu
 TUu2WPguAuPAqUVJCq5wIiQnF87jO1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-DflgVBX9OA2ahbGn6qvPDQ-1; Thu, 08 Oct 2020 17:18:02 -0400
X-MC-Unique: DflgVBX9OA2ahbGn6qvPDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 309851084D6F;
 Thu,  8 Oct 2020 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 810E31972A;
 Thu,  8 Oct 2020 21:17:57 +0000 (UTC)
Date: Thu, 8 Oct 2020 17:17:55 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 1/3] authz-list-file: Fix crash when filename is not set
Message-ID: <20201008211755.GJ240186@localhost.localdomain>
References: <20201008202713.1416823-1-ehabkost@redhat.com>
 <20201008202713.1416823-2-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201008202713.1416823-2-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8tZVdKiiYitVG083"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--8tZVdKiiYitVG083
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2020 at 04:27:11PM -0400, Eduardo Habkost wrote:
> Fix the following crash:
>=20
>   $ qemu-system-x86_64 -object authz-list-file,id=3Dobj0
>   qemu-system-x86_64: -object authz-list-file,id=3Dobj0: GLib: g_file_get=
_contents: assertion 'filename !=3D NULL' failed
>   Segmentation fault (core dumped)
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Daniel P. Berrang=E9" <berrange@redhat.com>
> Cc: qemu-devel@nongnu.org

Out of curiosity, are those notes intended for git-publish? (If so, I
didn't realize it would read them).

> ---
>  authz/listfile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/authz/listfile.c b/authz/listfile.c
> index cd6163aa40..aaf930453d 100644
> --- a/authz/listfile.c
> +++ b/authz/listfile.c
> @@ -122,6 +122,11 @@ qauthz_list_file_complete(UserCreatable *uc, Error *=
*errp)
>      QAuthZListFile *fauthz =3D QAUTHZ_LIST_FILE(uc);
>      gchar *dir =3D NULL, *file =3D NULL;
> =20
> +    if (!fauthz->filename) {
> +        error_setg(errp, "filename not provided");

Nitpick: all other similar error messages start capitalized.

- Cleber.

--8tZVdKiiYitVG083
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9/ggEACgkQZX6NM6Xy
CfOz5Q//Tb1GnfBa72fCZQtfP9sqbrqZExsydxjiE2kXy49hrUPM50Pld56/3IAG
enBpAyATB8v2d/HuvKCtKatwyRF1Q5M7Z86fu7EZgb5mIYzZXBOQsPLaw18VAV5E
4Hh8lrg+rWItbpGijaYvM8l1djRg8OfyaX4YCVHoiFq9nR22+rTMDuYMwdyQ+rQo
gj5Flp4hhBnP1G4Lri8ur2a3ifMgQxSDyORmuxMLFBCwBY46Mu41DVUuaHzbLWmX
JnXc0wLym52RusBShXxqM0rBtz/StpIShW2l0aN1D2qe9bWAe6QVwvN1G75WGUeW
XUc95Qs+nhoH2CxudqLIdwsFEVIozPG9qQxt4qRaBeYSMAKoTJXEjEEKB2l5rSLv
/EAvO3DJcpSb0po5EULYmZfMGfX0vKEbSyNF/4SFOF64ommB5RvR2HZlm+ufFe09
IRLvk2Q597L/8bXBroQHLnrM7x9fm4gwAELghZXHey/X1yUdD9Hk/er880K1BbgM
jmcCEmcwqsNFpq90mmaM4QO27FLF8f223zo1288mpe2UHOmXrRR4prneOkHk/2O6
tFZUinjbTzbMNjoyos+E33cgWlsFaopAEpUGvG3VVMWRNh6KtOn7njio1HeOp1E8
YlZw5WKf6JmMIjHagLW6/PSCaps2qWU7D7KDrO1jmebiDqIG4XU=
=Q8oc
-----END PGP SIGNATURE-----

--8tZVdKiiYitVG083--


