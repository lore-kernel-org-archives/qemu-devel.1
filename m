Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB5BC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011CC20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRIBS/9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011CC20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw18U-0006ne-BJ
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw17a-0005hq-En
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw17Z-0004Tu-Db
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:23:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw17Z-0004TI-4M
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:23:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id m125so933553wmm.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WHJW2o9zigOPE6Mq08bjgPX8Hpa1kkbV0Nh6Mvwf4do=;
 b=BRIBS/9cheZcR54I1Vaw0zaO9OIvBQjF2XZ6QxypVx14SGgWl4RxtvyA/ZcGg2J5Es
 B4l8ai7ocIMhm8MJNbHtY5KD5ZpqVsllPF/HPUEr/C9KlrGlgXKW1G2tkXUTQ4XXphtq
 6p6ZoCxEcFSZtMbS8fyp6+8vuPyUog5waYQcSthleotq4V6pMRPIR+M/Gzu0pgtbFXEo
 M/0r0APPSo9oNSFdreUk3XS9cQwFYiTvPqEzURTXX42rmjuA8/UAQghY4TP4qfZNM0AE
 UCq0+KbT9gmt6562n2SeeQeNbMzgfsJylSTNOCcpAARBEXSVXuwV0PcU1UnDkGog4wVS
 /70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WHJW2o9zigOPE6Mq08bjgPX8Hpa1kkbV0Nh6Mvwf4do=;
 b=IXiIBpixub++5rrcPksRil2QagR3muQhYpow7V82jG3ro8B0zxnmx1i68SjDEcgQ0T
 QF3uDiinatXxvgoKfnCNuGSIJR44DIOH8oWreqc4LKBu3s0Pd2OitJJaqq2zKyuedeTn
 Mp7KgdzKlPGLUZVZzS/W6wTdP5Y+X1E4GWwqkoyiL0MCnJCcYm9wcu8ZHyROr9lRBkqG
 JrzpxGqsOEek4kEvMKcfi/A9EHKkB9dIua6Xp7upUmHz7DLuFj0IaFwlCFyuOrXHvAD3
 QqbieHR78zwlmwblCcr4WV3kBFwmM3DhGo6jPGidYuJEi3iLX5bfnW/iorFblSfynEMF
 Kvrg==
X-Gm-Message-State: APjAAAVuDt+kgnf8cu0T+OYQ1tgiWEatXo2bVvsqEAapprB22Uv39enR
 g0rAIALPB4TYij0rYWxMlnOAX2XPSLrQug==
X-Google-Smtp-Source: APXvYqz//muCf8aspnyYBgLk1XfsMaGYXGh9U9XzyETzzyDDHGwBv1dUowR2nuOA1ASHfbq7re+J+Q==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr9335968wmj.174.1565342616220; 
 Fri, 09 Aug 2019 02:23:36 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n5sm4092926wmi.21.2019.08.09.02.23.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:23:35 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:23:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809092334.GI25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-6-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-6-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/17] fuzz: Add direct receive
 function for qtest server
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 07:11:06AM +0000, Oleinik, Alexander wrote:
> The direct receive function qtest_server_recv is directly invoked by the
> qtest client, when the server and client exist within the same process.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/sysemu/qtest.h |  4 ++++
>  qtest.c                | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)

qtest.c has two parts:
1. The qtest protocol handler
2. The chardev/qtest_init() code

This patch uses #ifdefs to leave most of the code unmodified, but this
is hacky since we need to pass around a NULL CharBackend pointer in
order to reuse the code.  There is a danger that someone will modify the
core code and operate on chr not knowing it will break fuzzing.

A cleaner approach is to refactor the qtest protocol handler code to be
transport-independent with a send(void *opaque, const char *str, size_t
len) function pointer provided by the actual transport.  That way the
core code doesn't know about CharBackend and can never accidentally
touch it.

One way of doing this is to introduce a global qtest_send() function
pointer and pass a void *opaque value through the core qtest protocol
handler code.

If you introduce a separate qtest-fuzz.c file then no #ifdefs are
necessary because the conditional compilation can be performed by
CONFIG_FUZZ in Makefile.objs:

  obj-$(CONFIG_FUZZ) +=3D qtest-fuzz.o

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NO5YACgkQnKSrs4Gr
c8gT4AgAwcg/7MHIkTYSKK0oSMMRMUUrhUIWolmESX9JOHAjRq1/bnHu7kEXKpi8
BkmcO/2f8I/+o11tYZgNVHmr1tu4CpU9oQzlOMGBtNA6PbMojbeKwqB0dcWJ1P1g
Sh/c9LEPossdThOzDFRXOvlrrIEhHdLdreoKJfQHTVJLyxraKlKZTgMWkw6ogcCr
EjTfkr5exxzazDE8ST3LtX/LwnDUTqk5p72m8T90I1LDbc/lXhsxNSGezzJpIHjj
hSv5NsT58yLmdUbhgeLEPTz5zU2oauMhhEJYnHe8Jm23ZAgJzZcifVerW6wd7Ghj
HNzz2QLKEBb3bHTkXFywKn7TdUNExw==
=VIkI
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--

