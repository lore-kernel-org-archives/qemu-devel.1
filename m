Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE786C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB0120673
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUZ3rd3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB0120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhrp0-0001LL-Qz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hhroJ-0000tJ-Gh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hhroI-0006wN-L4
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:37:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hhroI-0006vQ-Bg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:37:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id x4so12766067wrt.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2TpYr2gT+GJ+Pj0IA9foDmp39dw5q/dpDkv118+ciUw=;
 b=FUZ3rd3dOzWNHxG6D/m0pYxpXZBxynfkZ+bsIf69CS+FzjO9TU9R7dJirOP8aGBFvj
 VcwPX+Eh2BNK42phlH3wgfsTY2cYaIIzdJqwKZv+2ep8b5f87ttly1xPG9yuV0t6NKw6
 iM2A2EQwBveCVD6+rH0KF+rkUN2yfvSN/X3wKrEhz/4U1J+KuM1qTambw8qNtXy34xjI
 Kl7kRfmXfjTYek/NdOGbew806d3R3nARWAavGTyyeIZsxj7lDN+pfvR6SIPRbA4+VA6h
 Z7pqp/72TK5GDtzV9/dV7BUH1eeO3V3+aVJJne9gurEyG1yFay9ySU/+aqsyHgMjR3nU
 7ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2TpYr2gT+GJ+Pj0IA9foDmp39dw5q/dpDkv118+ciUw=;
 b=WnzrKaHtRZu1TT8tVzbSiCuLHkqhZ2pylrwmKA7y9dZZSh0SY/vt+PQ14rb7VsN+Rk
 N1q8OtFKPXCDBuBTSfKwBpRdLJrx+WRd0K+DxftJyeDZJ1KSt5WuLdCcZZzs/ofIR1O5
 CLXgON4Vn41yugRa+js2L9nnC50cLR2fKFQMU/RdTW5KYt7jSmz4q89hGU4+VM9Xk25E
 0SjVxsomfMZ0WXx8/eETTjQI2J5rkSp/ieG2tAXzjonoNpK1iBXYwxiUfnQgijxEtoDw
 3/9XuFaKJ9MB/Y3jb+FzbYwg2kKfiKFGCkwtkwf/m1J5/hpsEPkwKeWKN4/NhSSJK4Pb
 mqlQ==
X-Gm-Message-State: APjAAAW30Y5gCPsKS7mz35P0D6FQpsBoBP6SjXGCz2lBrZ39smhzlecI
 MxCOQYFXbbxl+Yh0azSyyC4=
X-Google-Smtp-Source: APXvYqxcNJAoUHkKO3Y4OsZ78yYltL/51GXQZ4MMF7jm6JgMtnCfjj0XpB291Oy/bYzq+VqC8ZA9lw==
X-Received: by 2002:a5d:4251:: with SMTP id s17mr13055017wrr.95.1561970232423; 
 Mon, 01 Jul 2019 01:37:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n125sm14105733wmf.6.2019.07.01.01.37.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 01:37:11 -0700 (PDT)
Date: Mon, 1 Jul 2019 09:37:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190701083710.GA18173@stefanha-x1.localdomain>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20190628124534.10679-1-damien.hedde@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
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
Cc: ehabkost@redhat.com, sakisp@xilinx.com, mark.burton@greensocs.com,
 armbru@redhat.com, qemu-devel@nongnu.org, edgari@xilinx.com, crosa@redhat.com,
 pbonzini@redhat.com, luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 02:45:29PM +0200, Damien Hedde wrote:
> This series adds a python framework aiming to provide some ways to do fau=
lt
> injection in a running vm. In its current state, it allows to easily inte=
ract
> with memory, change gpios and qom properties.
>=20
> The framework consists in a python script based on the qmp existing module
> which allows to interact with the vm.

How does this compare to qtest?  There seems to be a lot of overlap
between them.

Why is it called "fault injection"?  The commands seem to be
general-purpose device testing functions (like qtest and libqos), not
functions for testing error code paths as would be expected from a fault
injection framework.

Stefan

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0ZxjYACgkQnKSrs4Gr
c8hcPggAr+86/TL2VgUhM/2fIMHnlHhrYiJZD9i14rliLqlbPail14DSLR6RFcWD
5RFXk5XS8j6JI9L7qRMWY4LYBqZ77yG/w2Hyd+DH6z9J59o2bGymNIi+K6yjeKG3
+vMsXpn3Z2eXLBV7GMRJYui14tslqn5/b4pHLjNhahdL3EPcZ1dkKTtlryyfhvFG
+I6EFYowTmeM9lxSSDL4WDGjQwWkG1MRTbwjCDDuElmCLAp/UOK8PBV9ksqG1MVm
c3D9xZJPJoNlQaIk2SXtSB3fkXYjNwReD+DflMn54k1jNPOj75XDpeRjtkE8zx4W
O9LPHdDH6ySy+6xy4lb7f0oHhJt/WQ==
=yx7K
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--

