Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2325C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9628206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwTJyDFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9628206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFki-0004bY-DA
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1idEs5-0007x5-Rn
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1idEs3-0002fZ-TW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:46:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1idEs1-0002bt-QX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYG0H8Hz6hv1dbVPFMIVNOMdJde2au8aPJzKbEaOC9s=;
 b=XwTJyDFxIs3wGq2F9yTUIpAPLHJt0LzzOnTzwwrF487mgq8VEJJlC99wQnRIVXQXaqgZ7I
 tma+j3CRPvYhXzx7k+2+mPGMQVuob5oZ4wMCbHfNBtWWOTuwZzg85MesO13z/7Gs2IFHig
 bDAflSrGjfzx/eetj9ALfGKJ0xSzqz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-42qT7cLxOU-frLTbBophmQ-1; Fri, 06 Dec 2019 09:46:10 -0500
X-MC-Unique: 42qT7cLxOU-frLTbBophmQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E124593A0;
 Fri,  6 Dec 2019 14:46:08 +0000 (UTC)
Received: from dhcp-17-72.bos.redhat.com (dhcp-17-72.bos.redhat.com
 [10.18.17.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5723B5D6BB;
 Fri,  6 Dec 2019 14:46:07 +0000 (UTC)
Date: Fri, 6 Dec 2019 09:46:05 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-4.2? v2 1/2] tests/boot_linux_console: Fetch assets
 from Debian snapshot archives
Message-ID: <20191206144605.GB5020@dhcp-17-72.bos.redhat.com>
References: <20191126223810.20180-1-philmd@redhat.com>
 <20191126223810.20180-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191126223810.20180-2-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2019 at 11:38:09PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The kernel packaged was fetched from an unstable repository.
> Use the stable snapshot archive instead.
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> v2:
> - Rebased
> - Dropped Alex's Tested-by tag, since commit 2ecde8b2fb got merged
>   since and it changed the tested kernel version.
> ---
>  tests/acceptance/boot_linux_console.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 7e41cebd47..752f776f68 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -479,7 +479,8 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:m68k
>          :avocado: tags=3Dmachine:q800
>          """
> -        deb_url =3D ('http://ftp.ports.debian.org/debian-ports/pool-m68k=
/main'
> +        deb_url =3D ('https://snapshot.debian.org/archive/debian-ports'
> +                   '/20191021T083923Z/pool-m68k/main'
>                     '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.u=
deb')
>          deb_hash =3D '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
>          try:
> --=20
> 2.21.0
>=20

Works great, sorry for not picking it up earlier.  Now with rc-4, I'll
check with Peter if we can still have this on 4.2 and send a PR.

Thanks!
- Cleber.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3qaagACgkQZX6NM6Xy
CfPVOA//R85ys9EGuH0eMGuZ2IDlPCHUYpadJ7CGMRGF9d1RZLXzrER0kciE5mJ1
Sp+umhFHHHFxV0Y/OMWwQ2PHIC6We8Da2Jqh+a7+4dZlfXWmZd6dYdAlst0Aj+Tl
5C+nQZJHly+7zWg1Vm8FQS3dhiRi4XZ4PiiBr3O4OK1OV3sX8mrb3McNygl95Q/V
bOtmesbGsFg0JNs6iH+PC/i7xhMXVudt7IM2VJbhWjNkEzIMCVK+SeB5GAMDTMIM
jplHyYYwnN5Q4cHJRyY6tPXZYvqtjQWt/2z6Nc3SQ3ykB3KGB6JjRaacUiXwAl2+
b/nRu7a1w9uc4H5dTXcqIYO7oicVS8aN1TRfyNJHkxCBmTfB4RJgiRSLyH6VzCkI
fu0QjtcHCxeuVgCRuhv/WXuEfr8rlEs9w+VC1LkXsiK/V+JxvU3/P0uL8VRbLF8U
pLXOecZX9czq9TbbWONnoyrkaGFu8ul8r4gFDql2j8W1k8PyxMJbV1gXynh8xQZm
7gfnu9C+YjILyhtmh86OmQ4mQVQk5WQYE+ux9nZEbX1Ex5UsfZSfoWXdZBy1KtKs
c3dsXoYhYq7Pat68oM3NefKrp+7QZgPcv3fnp9oY3fZ0vQTtlzm/cooVM7QRcgZA
I+IZQyQjzVSIK4nGkJY36qdE/4G+mhuZwX+y10KuPLLNKwo0nX4=
=tdnI
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--


