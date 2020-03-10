Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9B8C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781412465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFKr2Jb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781412465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbMn-0004Pu-Ib
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBbM3-0003fL-BE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBbM1-0007gD-W0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:39:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jBbM1-0007bP-OQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:39:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id t11so14908911wrw.5
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yJyHq74z3B7YWvmtwnDx2TgHOG5eMnWNMqe1KqoxD3o=;
 b=VFKr2Jb2mm7Wa4QER/EHBMsBpH1dVcR/NSNXnH+NnY5A93r3bP7eusZ0ilQ7HOhR/I
 wFMrkasqThD7SWsdZNkELI8pmtNOpcNdB78JJpaNk2FGD+8p3hcFc/r2QBFPTGyxYSm6
 e2vrOM/ZoJnaoiXULiJ3vhPVfScJAXMyF/dvhUIrg3rVDL7lSgrlihKT77Aihm/xxmZR
 xKHMPFQ+eDF+dJeF//90YkfnrFMNZstHubEro7oEG+GXqdcM2mv52DH0g30cHZlHX7NJ
 pnwCjSjjXavtR06Y6ktoszFWHDfl8vB3yzvJzO0ZJ3d84DO+H5jmBvcWZZHAmunOvy6s
 ienQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yJyHq74z3B7YWvmtwnDx2TgHOG5eMnWNMqe1KqoxD3o=;
 b=PqlHDeiVuytZA5f8LSzeizqv+iPl5X/ORiHp8iAl1uTJjfstQEGAfSycLdmslM4QCr
 ccyU3Hw0jYxpe/+bBcg86KKiVbauVLZY8+4KoAXFyjhAptfjDTT4CiG1K+Y4ziRRkysf
 TptrGohd5L43JaAUnCL7YTDrwHX+Hce2/5gweU4GH/jFOyfprYwDAUWT77TAMUXDqkDY
 j2ySZQZJGAFQnl2kQx87ka3vIZOyBFlam/xuchigcIItQAmqf6gPge2PIsc2WCPpA1Mx
 uoEA60Gao8EK+7/Brj3O2kOrb0fXSFNEu4qORNlTYb9kD5cSWvQdA5H4vT9K0CGQZLdN
 CWBg==
X-Gm-Message-State: ANhLgQ3HbyNkl8JIw3rVnBk8TtgsOYOZQGGJ4madmVc2Ffdxs3j/UzCw
 mXyNGWt4omVogL0+zuJ352w=
X-Google-Smtp-Source: ADFU+vsQC4aWmlpyDtusRFPUsE+xHgp46spAXWwZrJRjcJgTo4L/EnYls9j8JglHe4L2WXdICAhowA==
X-Received: by 2002:a5d:67c3:: with SMTP id n3mr21185693wrw.156.1583833152661; 
 Tue, 10 Mar 2020 02:39:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u20sm3434770wmj.14.2020.03.10.02.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 02:39:11 -0700 (PDT)
Date: Tue, 10 Mar 2020 09:39:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
Message-ID: <20200310093910.GB140737@stefanha-x1.localdomain>
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, pkg-qemu-devel@lists.alioth.debian.org,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 02:26:48PM +0100, Christian Ehrhardt wrote:
> On upgrades the old .so files usually are replaced. But on the other
> hand since a qemu process represents a guest instance it is usually kept
> around.
>=20
> That makes late addition of dynamic features e.g. 'hot-attach of a ceph
> disk' fail by trying to load a new version of e.f. block-rbd.so into an
> old still running qemu binary.
>=20
> This adds a fallback to also load modules from a versioned directory in t=
he
> temporary /var/run path. That way qemu is providing a way for packaging
> to store modules of an upgraded qemu package as needed until the next reb=
oot.
>=20
> An example how that can then be used in packaging can be seen in:
> https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-18473=
61-miss-old-so-on-upgrade-UBUNTU
>=20
> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> ---
>  util/module.c | 7 +++++++
>  1 file changed, 7 insertions(+)

CCing Debian, Fedora, and Red Hat package maintainers in case they have
comments.

The use of /var/run makes me a little uneasy.  I guess it's related to
wanting to uninstall the old package so the .so in their original
location cannot be used (even if they had a versioned path)?

I'm not a package maintainer though so I hope the others will make
suggestions if there are other solutions :).

>=20
> diff --git a/util/module.c b/util/module.c
> index 236a7bb52a..d2446104be 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -19,6 +19,7 @@
>  #endif
>  #include "qemu/queue.h"
>  #include "qemu/module.h"
> +#include "qemu-version.h"
> =20
>  typedef struct ModuleEntry
>  {
> @@ -170,6 +171,7 @@ bool module_load_one(const char *prefix, const char *=
lib_name)
>  #ifdef CONFIG_MODULES
>      char *fname =3D NULL;
>      char *exec_dir;
> +    char *version_dir;
>      const char *search_dir;
>      char *dirs[4];
>      char *module_name;
> @@ -201,6 +203,11 @@ bool module_load_one(const char *prefix, const char =
*lib_name)
>      dirs[n_dirs++] =3D g_strdup_printf("%s", CONFIG_QEMU_MODDIR);
>      dirs[n_dirs++] =3D g_strdup_printf("%s/..", exec_dir ? : "");
>      dirs[n_dirs++] =3D g_strdup_printf("%s", exec_dir ? : "");
> +    version_dir =3D g_strcanon(g_strdup(QEMU_PKGVERSION),
> +                             G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-=
=2E~",
> +                             '_');
> +    dirs[n_dirs++] =3D g_strdup_printf("/var/run/qemu/%s", version_dir);
> +
>      assert(n_dirs <=3D ARRAY_SIZE(dirs));
> =20
>      g_free(exec_dir);
> --=20
> 2.25.1
>=20
>=20

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5nYD4ACgkQnKSrs4Gr
c8hSzgf9FFCPQlq9QpkCuXqUF7df/ofCHITtk4pdfVIRyxZpQjaFsz6p8HX5tj+0
qXPMl9OzrbGAItR5+VedBfUgD2Cvq+8fRm24FdlVDMX6UoKTs1TdLGmp+MxoMReY
HgT+qMggMKjxF85SQPJNI1sbu7GEYMbkK4HkNIwUALz5DAMqb9SFYSXhbQCTDAcB
rZ8EFqe04Eop82XOkG68Y1r9BOl3Pv7zbQNqqda7SYEjD0h1m/1SqbHm2xrsNXwj
rNNxE/TzVJK9a7WUT1DkIaBd2614WJo/eoIW8aYQvu18iumyBbvjYpFLZRtO/G45
K8WkStZiZJNjmsd/v1YyqbWytCqx+Q==
=wwRy
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

