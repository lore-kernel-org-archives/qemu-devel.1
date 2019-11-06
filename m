Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D547C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB14B207FA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8+6VGto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB14B207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSONt-0007kv-1j
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSONE-00077R-JX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSOND-000634-Hw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:41:36 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSOND-00061G-9i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:41:35 -0500
Received: by mail-wr1-x442.google.com with SMTP id j15so6018393wrw.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GUVJcgPjztw/uCiXcvdg5kajCQantDWhhSELpLlZZL4=;
 b=A8+6VGtoXaOU84ze1Ey5ayTnz/SvHAJH+3IMQbrOUGLsTAGnnCCPc9j05gX2MVFajz
 +O86L0yJiAywS3U41dkL3/JU8NrcpZQoNarPtbxIM0U2cwJWWvbFr0K4x/GlFLi+I+JP
 xZjJtVzxUwmYiipWvHnBqUtUO8Z03AYOsKn3wqZWd2Ud4ghsYWhfiAeejXEDH6MgVYGO
 yZrJjnLjJSjYgkRQF4M1JCgXp0mwzDhN5iT3QA8noimw6/P3UfjFtSDm/LFpO0M0D3tZ
 tInGkJ+sPKR1aZvgxsVAbW2f97Rt1/f885yJc8dOHPAEdsAeAa0EMabBrdQ2616/OYYI
 z0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GUVJcgPjztw/uCiXcvdg5kajCQantDWhhSELpLlZZL4=;
 b=cjO1P+GA6J08v1/+R3+IGzwNVCRJVE0inmkxeXbIneLa/EG4DGk+HzIJ6QQXArY7g3
 QKueW/wvPYp6HnkgvqgktScYLB8/u6IM8XXcRKKfYgDHE7Z2gLlw3cFbACK/rCZKEP/7
 ZKiBcmJGRUuhaalpbroYQa62GfwEJR8WqDcdPY2XRSDWQBz8FMyqsnX4skOZW7m9y6/5
 wufaD7AlHZCnnpE9588XZXBY6TBknixgWQb+56sCAtz1IZhmzLmxTAwUvQADzti9n3QZ
 9q5QgyNA1IoHM5xPGRLP7tiFS35IibQJHlmkR2CDOgFhEMNsvacXEV8xZ4ciJqIfFVuV
 5yVg==
X-Gm-Message-State: APjAAAVKjItRwFGWRy60BLmgioz/tfS97aQhJyGzdhqQP4P1Tba1AFBQ
 9uZyakYQN/cFtTJGwBRP5OA=
X-Google-Smtp-Source: APXvYqykFinE1gL8ZHE6EW+BetPwmhnXeHbnrPjKs1jxOrWfwzGvPrJLmXSnuPOIqmstHKZal/3MzA==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr1566129wrr.87.1573058493951;
 Wed, 06 Nov 2019 08:41:33 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id p12sm27591419wrm.62.2019.11.06.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:41:33 -0800 (PST)
Date: Wed, 6 Nov 2019 17:41:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 10/20] libqos: move useful qos-test funcs to
 qos_external
Message-ID: <20191106164131.GI340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-11-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-11-alxndr@bu.edu>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:56PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> The moved functions are not specific to qos-test and might be useful
> elsewhere. For example the virtual-device fuzzer makes use of them for
> qos-assisted fuzz-targets.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/Makefile.include      |   1 +
>  tests/libqos/qos_external.c | 168 ++++++++++++++++++++++++++++++++++++
>  tests/libqos/qos_external.h |  28 ++++++
>  tests/qos-test.c            | 140 ++----------------------------
>  4 files changed, 202 insertions(+), 135 deletions(-)
>  create mode 100644 tests/libqos/qos_external.c
>  create mode 100644 tests/libqos/qos_external.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C97sACgkQnKSrs4Gr
c8hhHwgAyLGwxK70ukGi595swKI+S80xzHyPNW9v9wCamvqJDDzbPR2dHRW8vyz8
zVLfkCviYugOzPud4SDUK8eUcQoItJ1BUejlMC6ndpJ0/4Cgwu+1NZaz/HrFTmho
4sDqV1j1EJ2trz1Dx1nICHI/bUJxf3FYakhX3aLOEu+lxIzvlbYrqNVJE9RAD5mP
DrDIRq+jirXuuVNmtol1kJgC/cQRjaErCL3sSTaGLqEbO+sZU+CJ3A+Ro4q172tW
cFNEsyUntNe3qJyMXisC+sjg0vMUR/OWNYqffFrOrgaMwq3ZKwR5bDY1YRvMZxri
wI8hLE4JteVMEKJCf7v4Mb3mctBvGA==
=zKa7
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--

