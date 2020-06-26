Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA2AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E343E20C09
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW+Xvnj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E343E20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jomOk-00008P-6Q
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jomO3-00081x-03
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jomO0-00031n-2F
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593170350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbPTMqSw6btJSLMPpuwp0I/fsrmAEMNPMpTogpB+hjQ=;
 b=YW+Xvnj7X7UpvVQWnbBpYgmQn9w2xZDJshQeAdqVWm+yzed2rb5At99bPpomBXjfAp1Ncd
 ADV6Cec9p5BDDHH4Ay+Tdz9BocqBGmjcGjds3PGUjEyn9CKSTZ6lnbokyggo04Ead9ke/E
 5gictSsxxk7npaMR+4c2SD3X80vnLSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-XN3fSyQUOO2czpKflvBE3g-1; Fri, 26 Jun 2020 07:19:08 -0400
X-MC-Unique: XN3fSyQUOO2czpKflvBE3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E2187950B;
 Fri, 26 Jun 2020 11:19:07 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF74E5C1D4;
 Fri, 26 Jun 2020 11:19:06 +0000 (UTC)
Date: Fri, 26 Jun 2020 12:19:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 04/17] block/nvme: Be explicit we share NvmeIdCtrl /
 NvmeIdNs structures
Message-ID: <20200626111905.GK281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-5-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:25PM +0200, Philippe Mathieu-Daud=E9 wrote:
> We allocate an unique chunk of memory then use it for two
> different structures. Introduce the 'idsz_max' variable to
> hold the maximum size, to make it clearer the size is enough
> to hold the two structures.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> FIXME: reword with something that makes more sense...
> ---
>  block/nvme.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 71f8cf27a8..ffda804a8e 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -438,6 +438,7 @@ static void nvme_identify(BlockDriverState *bs, int n=
amespace, Error **errp)
>      BDRVNVMeState *s =3D bs->opaque;
>      NvmeIdCtrl *idctrl;
>      NvmeIdNs *idns;
> +    size_t idsz_max;
>      NvmeLBAF *lbaf;
>      uint8_t *resp;
>      uint16_t oncs;
> @@ -448,14 +449,15 @@ static void nvme_identify(BlockDriverState *bs, int=
 namespace, Error **errp)
>          .cdw10 =3D cpu_to_le32(0x1),
>      };
> =20
> -    resp =3D qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
> +    idsz_max =3D MAX_CONST(sizeof(NvmeIdCtrl), sizeof(NvmeIdNs));
> +    resp =3D qemu_try_blockalign0(bs, idsz_max);
>      if (!resp) {
>          error_setg(errp, "Cannot allocate buffer for identify response")=
;
>          goto out;
>      }
>      idctrl =3D (NvmeIdCtrl *)resp;
>      idns =3D (NvmeIdNs *)resp;
> -    r =3D qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &io=
va);
> +    r =3D qemu_vfio_dma_map(s->vfio, resp, idsz_max, true, &iova);

_nvme_check_size() has compile-time asserts that check
sizeof(NvmeIdCtrl) =3D=3D sizeof(NvmeIdNs) =3D=3D 4096.

I suggest the following cleanup:

  union {
      NvmeIdCtrl ctrl;
      NvmeIdNs ns;
  } *id;
  ...
  id =3D qemu_try_blockalign0(bs, sizeof(*id));
  ...
  r =3D qemu_vfio_dma_map(s->vfio, resp, sizeof(*id), true, &iova);

and accesses to idctl are replaced with id->ctrl and idns with id->ns.

This eliminates the casts, makes it clear that this data is overlapping,
and avoids the need for idsz_max.

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl712akACgkQnKSrs4Gr
c8hM/ggAxJqSFcfZVnvaUiSnGoeVcKD4uFrhHf+bORKHpuYYFiUewr6Tyz28GK/0
Q7vfuk5CW1dDQOqGH9PgT5rtnk4K+90NlmLSNWdT3lFK5G0jMTR+ADX36CWkqzIX
QH6ntAH3zJdlmxW1bEDduTH+PzkJ2iZ2yUfV1ZKjx+CFUTDIZhH6jnZ4XN/U2oDE
k3y45zH8Susdb7yQdu42922qGOG+JlL2//Nw8OkwUtPWFPxQm89YajCH3wmsv+gF
HSdqDA1gVf+WbIiR9JzNj7xWMXX3vRfpiUWlxgAw1o7ZuYSIvwmNmVYRMeLgPV5n
8gAZpfYlhGNhPDDVQV8EGKwreXtmHQ==
=QSEK
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--


