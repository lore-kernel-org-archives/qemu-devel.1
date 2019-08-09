Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990F5C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B4720C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMTCxShO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B4720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1ID-0003qM-Le
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw1Hf-0002rW-Of
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw1He-0004vq-Q8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:34:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw1He-0004vX-HL
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:34:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id p13so23020354wru.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8aczG4m8gE3gdnQdrDxzXnoBjqwTM+ZDlyJXAN1GAP4=;
 b=FMTCxShOXBZ1u6WqLYwBBxmFK4eWkhYjdkTN3gJ8ykgs9vR8n2bMr5fo+sQgAg0IHp
 MurZMuQC8hVpA22Oo0D5QFfO2hVsAi7O/taq/LxFc/14FfU2cA0ysZSF08EIi7eBHt22
 4LOcbtHGeKn6ZpnZ5T9nQuw5unZ2oOxjwQJX174tq4RkEJI6WN7T1Iw6ga2DjpaxkeFv
 619P8agTJLjNbwlO+jdxluc+9VUyB5cazxIf66LeVNSMj+te8t3A7V+oLZSSe63BzBGP
 jyV0dXtEgd3xbhb6OBSBLXVkhnZfHv3gzO+JG+OBijjHux3H61yj0Ygf+9nwWEeKfAMc
 WT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8aczG4m8gE3gdnQdrDxzXnoBjqwTM+ZDlyJXAN1GAP4=;
 b=XBghYxLtz8zuWimzcO5AE6iOjLoqrD6QK9Pwnfqx2w2INtAPmeKcF1kCIMEQETL74t
 AiES7mVGDVj0ikF+x0USRCeJnZpIdnrSdJsP52fUMIUYf1YbP7P0P9cT9BOV0BcT/a+H
 9UebyZvDnW5GCn6Y5XFQDwxqKlU6Lh6zl7/CNrGyWqPj47hTGcXXkZ7QTBH3L/Fu0r9D
 Drs67fgzPH/iPOAcBbkcgGV9QoXptOoyI1VUWePRewN9iTqmxN8n/TKZ9g7D6NIPXTTF
 rFrT8zXovg76Q3zvXC0TDg9bcyNt1I2dJTiy6oa5cNLRRSPTZzHJ00elhIRZ5hbZtNXa
 L4Kw==
X-Gm-Message-State: APjAAAX8TBf9SZ8DCV0yRPHWl7c9DxPN2UGEv66+uzRuEA26rtYjEI94
 bv9RnJuplmeZgaBcVpHtE9A=
X-Google-Smtp-Source: APXvYqyXVvmE+JovINO3661cQPh6j+TPeUCcxkDXmQEl3bvoTbsQ85D0eib+pAMhSSvTrnG8TCOHKQ==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr22682489wrv.180.1565343241289; 
 Fri, 09 Aug 2019 02:34:01 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l14sm955417wrn.42.2019.08.09.02.34.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:34:00 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:33:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809093359.GJ25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-10-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-10-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/17] fuzz: hardcode needed objects
 into i386 target
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 07:11:10AM +0000, Oleinik, Alexander wrote:
> Temporary solution until there is a better build solution for fuzzers in
> tests/Makefile.include
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  target/i386/Makefile.objs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 48e0c28434..1b8976c0a6 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -18,5 +18,25 @@ endif
>  obj-$(CONFIG_HVF) +=3D hvf/
>  obj-$(CONFIG_WHPX) +=3D whpx-all.o
>  endif
> +
> +# Need to link against target, qtest and qos.. Just list everything here=
, until
> +# I find a better way to integrate into the build system

There are two similar solutions:

1. Use tests/Makefile.include, e.g. libqos-obj-y.
2. Build a .a archive file in tests/Makefile.include and link against it.

In both cases it is no longer necessary to list ../../tests/ object
files in target/i386/Makefile.objs.

> +ifeq ($(CONFIG_FUZZ),y)

ifeq isn't necessary since obj-$(CONFIG_FUZZ) is already conditional
below.

> +obj-$(CONFIG_FUZZ) +=3D ../../accel/fuzz.o ../../tests/libqos/qos_extern=
al.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/fuzz.o ../../tests/fuzz/fuzzer_=
hooks.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/virtio-net-fuzz.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/snapshotting.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/qtest_fuzz.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/libqtest.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/libqos/qgraph.o ../../tests/libqos/l=
ibqos.o
> +obj-$(CONFIG_FUZZ) +=3D ../../tests/fuzz/qos_fuzz.o ../../tests/fuzz/qos=
_helpers.o
> +obj-$(CONFIG_FUZZ) +=3D  ../../tests/libqos/malloc.o ../../tests/libqos/=
pci-pc.o \
> +	../../tests/libqos/virtio-pci.o ../../tests/libqos/malloc-pc.o \
> +	../../tests/libqos/libqos-pc.o ../../tests/libqos/fw_cfg.o \
> +	../../tests/libqos/e1000e.o ../../tests/libqos/pci.o \
> +	../../tests/libqos/pci-pc.o ../../tests/libqos/virtio.o \
> +	../../tests/libqos/virtio-net.o ../../tests/libqos/x86_64_pc-machine.o

I see filenames here that are not in the tree yet at this point in the
patch series.  Please make sure that QEMU builds at each point in the
patch series so that git-bisect(1) works.

Stefan

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NPgcACgkQnKSrs4Gr
c8h9aQf/VjfNX3A7WbzRFOTY/NIeQ1/jsIuIPDg9zFBS7sprqDLi1xU8T2NczrbH
QBFIsBUuaiX/cKpyFlhxp8570ZymZyyCQkOoqmvpOygKPEozUtMIr8SsZNllHtOl
UcRkzVFAx9ljCM0KxTR+dGLGb5+YghsaRWHn1C9fGae5aA8e+/MMe2vn8qvpgDIO
2aa8NAaeRAqEHQs8FWtF/QaKCJN1hLYJwiR2Q2aS4r7jw9QP9T7TSxQQoTXsr3i/
0H7KZreaApCFI6jL5L8O3kCLlov1xyALcTgMvCbWaRQhjNVTVTZazcgkSLpO1EXA
uVFZhtafO7q2lHgVA8rWmCC/+lDF7A==
=DyAZ
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--

