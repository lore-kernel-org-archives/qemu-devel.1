Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC464ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923A821D56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnfAa3ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923A821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIs19-0002Oz-PE
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iIrzz-0001bT-FS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iIrzy-0006DK-Cj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iIrzy-0006D1-4T
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id p14so11258931wro.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=K7xcca4gwjVguayB6hrZ/M+wS6P4975y/VIPM2nFhLI=;
 b=XnfAa3ixfOOtcG9+dfEUK7T3qoEhZi8pqdMWYv2rRjH9in/nc90/P5GhtzIaAAsdYn
 J/4a2UGdnMyRutf4kOQ4IeEcJdPxyOLpA3aOFa4K4OkQTNOWGDVKsPVoYzMJMy/Y26NB
 FSrIFXazrvKI+PhXiZDvlswDv4IbFK5A/sXqC1a8eCnd2s0wTVrggdeWRcy3zvCKUSmu
 Y5Cp2kyXp/5uB0Dndi7pjPFRm4PR9NmjMEiySjgQbjtR4ixID6M2uLL4F0iVUo5Qnc5r
 +NAv1DYaRgcyuUpWlTl6qO5593OdT4WxTsy33HsKyYS3it/oU+NfHv0+itCuPu4jF2lG
 UhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K7xcca4gwjVguayB6hrZ/M+wS6P4975y/VIPM2nFhLI=;
 b=qSF0SBBApmC/v6GP66vt+uhenATW6pZHrw2u3oUYTy9AzTa7kEbq30pIuc/RNsLaLF
 2Tuitl8dBUvXbe3J2su8XTXkw7mTVGuBSXY8bn79FWfQv5NYxfgiwoX47uUlcw6OvMkP
 hL8MDj6QrScMM97L1lmw6kJTKv/5IETpfXQTiCmVYw7Y76RKKuuLt0IjagZ+gvrrUko5
 9yWhM9xRBEH279IAVKAeXSsf7Rnjoa3Wv/S4UudsAflh9LW5fVzvw7vBmSPBY1Vn/WMg
 sX07O3LytMpbB9u6S5s1DVOPlyGEcSONz6Z82Z0+tThrm6aKpuXe0HKkPq8XLroM2PWh
 0ErQ==
X-Gm-Message-State: APjAAAVHHJg8wPe6MXFVmNKNcmbMLseKBUPHabWZub9vxYlg8TXBbJYP
 lxoRgkIftBrfeY0MOtN6W2k=
X-Google-Smtp-Source: APXvYqyr19wglSOxkhdHBnW/3kgJQWFuNc4L+DoAVOBJSTaQRToSvIh73lcFZ8DEgyC+TIj+gYf65g==
X-Received: by 2002:adf:dfce:: with SMTP id q14mr12062921wrn.14.1570789092689; 
 Fri, 11 Oct 2019 03:18:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r6sm10074106wmh.38.2019.10.11.03.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 03:18:11 -0700 (PDT)
Date: Fri, 11 Oct 2019 11:18:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Tianjia Zhang <77389867@qq.com>
Subject: Re: [PATCH] tests: fix counting typo error
Message-ID: <20191011101810.GA6896@stefanha-x1.localdomain>
References: <20191010121702.90142-1-77389867@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20191010121702.90142-1-77389867@qq.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 08:17:02PM +0800, Tianjia Zhang wrote:
> Instead of global variables, local variables should be incrementing,
> This is a typo fix.
>=20
> Signed-off-by: Tianjia Zhang <77389867@qq.com>
> ---
>  tests/test-rcu-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

CCing Paolo Bonzini, author of the RCU code.

>=20
> diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
> index 6f076473e0..c0fc47ded4 100644
> --- a/tests/test-rcu-list.c
> +++ b/tests/test-rcu-list.c
> @@ -219,7 +219,7 @@ static void *rcu_q_updater(void *arg)
>              j++;
>              if (target_el =3D=3D j) {
>                  struct list_element *new_el =3D g_new(struct list_elemen=
t, 1);
> -                n_nodes +=3D n_nodes_local;
> +                n_nodes_local++;
>                  TEST_LIST_INSERT_AFTER_RCU(el, new_el, entry);
>                  break;
>              }
> --=20
> 2.17.1
>=20
>=20

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2gVuIACgkQnKSrs4Gr
c8hHYwf/av6VLrMnnZ9fi3KFbZOcICw6iHXxPmixAksf3rmk9z52iX0H7rKa1iX/
3DheG5TxKVlRrvzpTC+Sm6Cbf1yu7jkxfWhlBalNXzHkqeOMS/TRhmh78+1rNNFG
XlmxkGy5WX+6SdJxwIJuFQtZq3bTE7sHjpM99KZMj627Q6ihVzwVMYCfnOt39vvG
Lp4S6J15fbzBUt/k1s7XYX9ndOUjQt3om3dBCWmOIdxfNSHrP+4dMNN+escayk4B
p5hSDO+ycJWCTYulkQ7sjp/gIkPNrmHxAsRzXkU7MQwaPbOpcUOWTw55xf3ZVGNi
80SORvWHUfWc112o67iqMef5lapndg==
=iYt4
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

