Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D2C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C36620B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOqqZFxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C36620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1LE-0006w5-IM
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50883)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw1Kr-0006WO-CL
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw1Kq-0006GS-DQ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:37:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw1Kq-0006G2-6k
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:37:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id t16so7493520wra.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UutAEop/4HfYOAV2CL9Si2AmIP/NQsgo1n7IDS8BycE=;
 b=rOqqZFxGyqnnnizrSXgHaoxF6jhQ3LSxLo0EJc+SEJDTOnFGLcG3JqF6YOUpakb5/H
 b3UpWrcvrwUmkUsGjamjIIZMn1xWrLfzvZNlQxtmHtZ4O9dyefJdllz2j5FTpkLVn4Co
 wVzl6hWMpzQwnbMQ5h9kzQiGONmpr5nP+yJXzriC+w4CrGSqLzkmMclFBYmEI7VlYGx+
 zc3WyWWmHJiGballoYxhvmAQtaHvi84DQinzp+fb3aW50Q0/JHZua49NblxethFBVofC
 UNnY1CIebLB9WFbzQ/tVV/KQKfwd0g+tOcwTU+uTbyb7tHoMOIj52gG77vaWg6nCd1bW
 aP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UutAEop/4HfYOAV2CL9Si2AmIP/NQsgo1n7IDS8BycE=;
 b=ex58rcWgnxMCoLPql29KSVNSCqqlitqfllWasP6edVtOYJfviZmh1pNcyBDDrSJ87u
 RQ5m2/QKlpwOIbePVrW315GwEot5X/2ZHnY650QSMuXTkwvWmFZgfIy/zDF9TmU9rXKU
 daFkpbD6TxNTJwpLoxqyvBTR1PugyskFIpJt3svfvIzdjfCqQKGz9hINcSTSNUBtECCH
 XiUu3IZ0kL6CIl6Y3NpqBWrOsXj88UXi+hmUdmL7OteQSIQp/nvcK/Xy7iOaMVkB/Z44
 wFTVgRs2OG129Wx4PsTFvDM7MH+P1NAcjxFJnuM+9iin2uJWF37rRgljLMbWU7ZbUg+S
 Jmpw==
X-Gm-Message-State: APjAAAUEU3d+1fVztCj6dfppJnAeCbTsS87z+R2XS85PZNzA4KYdYmQ9
 kcLej6XDwkEldPzwVPWxbkQ=
X-Google-Smtp-Source: APXvYqw+d+8vqU5RXPsBnin2I3/qHS5xrGyxL4lp6dVXBPYTpHzUHxzJ41qMFrizodJH6BGsIUOSzg==
X-Received: by 2002:adf:db49:: with SMTP id f9mr20688121wrj.112.1565343438981; 
 Fri, 09 Aug 2019 02:37:18 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c7sm90603961wro.70.2019.08.09.02.37.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:37:18 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:37:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809093717.GK25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-11-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9a9Vq1BJdYBEXpLG"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-11-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/17] fuzz: qtest client directly
 interacts with server
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


--9a9Vq1BJdYBEXpLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2019 at 07:11:11AM +0000, Oleinik, Alexander wrote:
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/libqtest.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++--
>  tests/libqtest.h |  6 +++++
>  2 files changed, 65 insertions(+), 2 deletions(-)

Please refactor the code instead of adding #ifdefs.  Most of the code
doesn't care whether it is communicating over a socket or in-process.

> @@ -317,6 +323,21 @@ QTestState *qtest_initf(const char *fmt, ...)
>      return s;
>  }
> =20
> +#ifdef CONFIG_FUZZ
> +QTestState *qtest_fuzz_init(const char *extra_args, int *sock_fd)

This isn't really specific to fuzzing.  It's just an in-process qtest
client for QEMU.  Please name it qtest_inproc_client_init() or similar.

--9a9Vq1BJdYBEXpLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NPs0ACgkQnKSrs4Gr
c8jxEwgAlJ3MkDDLpr5a5n0n/hRrnPTQrgvtxK9O3aTDsEaaw2DC4lxcsULHnoLY
rX+WuTV1zp2OMWDd/2y8zdb4Awo59oBExc+glLedwXHgfvcPmdh6B1q4OEBFatk/
cMqoB0D95RsY73wj+1Lqj8i1+99ZwvKMibEMkbgPntJQsMSh8f09RHMBlZNlQ0Rk
Bw3Qc2QxDEzAiG4nYp1v2bwoL73JygASYg3eZKPqcbLuZxhWmINQ87veM1RRm/tm
rwIy6IiQ0QegoTwrlfe4/yJJuFWfzXJKckdXwHGrq/ZTgSDIEUw838ozUEsw8wW5
GcFgSf6mlEjQ8VsxS4mntShD1TAZ3A==
=aqak
-----END PGP SIGNATURE-----

--9a9Vq1BJdYBEXpLG--

