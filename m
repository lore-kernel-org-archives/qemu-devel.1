Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544BC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CAA23787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMsmzRRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CAA23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLM3B-0004eH-T1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLM2C-0004DU-Dm
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLM2A-0002ad-Jx
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600933877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWzu9Ac/m+WVjpegV1L7KUI1AqR7XNsHgiyQyRf6xso=;
 b=fMsmzRRYiWKuqbMRe9ixDp3htDTuvaQf9PwtnS++XRevRG15XIwAnYEFTdlGx2Dk7Tmm89
 9oD+krWvFlyZyGSOm2QLGP7nluPbmuD5cCAKyAhpsB2t60CHbYMMUaOfbw6Yndegote8m6
 JYiqma0ssyl5ghbV5pV0MY7yJqz5ybY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-T6CNR8sEOX-fvpF8u9FEDg-1; Thu, 24 Sep 2020 03:51:14 -0400
X-MC-Unique: T6CNR8sEOX-fvpF8u9FEDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E7E1007464;
 Thu, 24 Sep 2020 07:51:12 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFE9719930;
 Thu, 24 Sep 2020 07:51:06 +0000 (UTC)
Date: Thu, 24 Sep 2020 08:51:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 14/20] multi-process: PCI BAR read/write handling for
 proxy & remote endpoints
Message-ID: <20200924075105.GI62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-15-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-15-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:25AM -0700, elena.ufimtseva@oracle.com wrote:
> +static void process_bar_read(QIOChannel *ioc, MPQemuMsg *msg, Error **er=
rp)
> +{
> +    BarAccessMsg *bar_access =3D &msg->data.bar_access;
> +    MPQemuMsg ret =3D { 0 };
> +    MPQemuRequest req =3D { 0 };
> +    AddressSpace *as;
> +    MemTxResult res;
> +    uint64_t val =3D 0;
> +    Error *local_err =3D NULL;
> +
> +    as =3D bar_access->memory ? &address_space_memory : &address_space_i=
o;

Doesn't need to be changed yet but eventually this should directly
access BAR MemoryRegions instead of using global
address_space_memory/address_space_io. Then bar_access->addr can be
relative to the start of the BAR.

Isolating the device from global address spaces makes it possible to
support multiple devices running in the same device emulation process.

> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
> index 23aab44d8e..d332c63bf3 100644
> --- a/hw/pci/proxy.c
> +++ b/hw/pci/proxy.c
> @@ -61,7 +61,7 @@ static int config_op_send(PCIProxyDev *pdev, uint32_t a=
ddr, uint32_t *val,
>                            int l, unsigned int op)
>  {
>      MPQemuMsg msg =3D { 0 };
> -    long ret =3D -EINVAL;
> +    uint64_t ret =3D -EINVAL;
>      Error *local_err =3D NULL;
> =20
>      msg.cmd =3D op;
> @@ -72,7 +72,7 @@ static int config_op_send(PCIProxyDev *pdev, uint32_t a=
ddr, uint32_t *val,
> =20
>      ret =3D mpqemu_msg_send_and_await_reply(&msg, pdev, &local_err);
>      if (local_err) {
> -        error_report("Failed to exchange PCI_CONFIG message with remote"=
);
> +        error_report_err(local_err);
>      }
>      if (op =3D=3D PCI_CONFIG_READ) {
>          *val =3D (uint32_t)ret;

Unrelated fixes. Please squash them into the PCI_CONFIG_READ patch.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sT+kACgkQnKSrs4Gr
c8jqeggAiZa6R7LOhLpF/Qxn0ofvUTksrghXF+MDmKut2IvBMH6inXNbKeIoebF9
3y93RG/Xkvwb0p8V5fGJ3Ri2frotUR4V0B6kvShUZZBn3bsdgcYzSTjog2lyldOo
zV+1Mp3krAsAs35MA/qlx7J2CPCnHaigyKSW3tmtYiEIaRbggP1lvou6FXzP8rwT
/2T9rMb1C2ZU0Yw16j0PEB3pG+Hj4wSFiRKQnoVCkIgxNg0HlKzTHgqa3j+oWrHb
7b2R5xZLld7uMS58X7HDmUgc4Ld/Q+vTZQD0N+HdBhvEYxc55zdPOI5Y17WkxV1r
n9r+Ll/n2zza5Zx8VicB0dvqJlfucA==
=7A6A
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--


