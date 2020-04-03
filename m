Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB7920659
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Ok14Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB7920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLpa-0007CS-LR
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jKLoq-0006Q7-K9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jKLop-00064l-JO
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:53:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jKLon-00063R-Cv; Fri, 03 Apr 2020 08:53:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so8386876wrt.6;
 Fri, 03 Apr 2020 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=o7/hZKmPC/OCtVWf1ZKVf9rFl5J6uMyMvtdJvK7UDmo=;
 b=D4Ok14Lj6umSjIPEW+0474ZWvztJj1hf0rdN2dgbWDF82REnUmAL9aibi1+dck8JEp
 5kr/GwqV4/95QLC0wqP2DlDODsxysBMn/yIlwzSjHEUEL2otzlo6GBVSR0+LeLm35QV5
 MVn075jT9L1RPBOXmlIoKTa8EdA9aP5kdAGWFjGWXPXmy1JMgAbVR8rdupax4PMSyUo+
 t5ECulrzHxJDLhWhU4mw1dlYqQrt1uqk9X4v7kLgt0KUQVXoHfX0CaedRifntG9uhSL8
 JqN7ViZLBdabBppELSEQ2DWue3X6j4s/ly8lZLrvOZD0SnRWCfub/kP0xcs2GiEWN1pF
 6UTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o7/hZKmPC/OCtVWf1ZKVf9rFl5J6uMyMvtdJvK7UDmo=;
 b=hJhjXMS9mDfH5nl1cGsPq+Pg2kHZ+Wdgt22JjJo7F+bRrvcBP4eD7TnzB/SVi1LM05
 /QuVsBl1PJtIoGu3Tqs/St9ioX6/L2dI7r+N1BoB8cr99GYAZiS31FD3MdHUIYmWWkIy
 RmJlSp+YQxTsiOsj5iDWTB9QUkzDt2hiND6PCF21JHyjBP+pHmCqtDmX7oN3VkmE/jGY
 8GqAA/vZ0/imicFouJLf/QlzkAX2dnB6A6h5lsu5cgyz5Us5nfFm87WHWQKn0SHqBRM4
 uuD3AD/r2oIikBowcylLSm9x4FQ1dIWg/ukcpqiyvJt6gb7bUPmX9OasxTdZ4hkwm4v6
 QDwA==
X-Gm-Message-State: AGi0PuZFNLahgwFCHPJ8OHb7MybF+YuPPstzwNLl5vo1QtaqVl9e3Dk1
 95whGnB6FGv4FSysVMCwIdg=
X-Google-Smtp-Source: APiQypJqA2kIVJH9lUQOUeoaVz+SCak/sLx6utw53Jsu6EXXDDUpBzF3CNESWfwK1MJdKIoAqx13VQ==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr1099748wrm.22.1585918384447; 
 Fri, 03 Apr 2020 05:53:04 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z17sm2029572wru.39.2020.04.03.05.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 05:53:03 -0700 (PDT)
Date: Fri, 3 Apr 2020 13:53:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Simran Singhal <singhalsimran0@gmail.com>
Subject: Re: [PATCH v2] Compress lines for immediate return
Message-ID: <20200403125301.GD146016@stefanha-x1.localdomain>
References: <20200401165314.GA3213@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20200401165314.GA3213@simran-Inspiron-5558>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 10:23:14PM +0530, Simran Singhal wrote:
> Compress two lines into a single line if immediate return statement is fo=
und.
>=20
> It also remove variables progress, val, data, ret and sock
> as they are no longer needed.
>=20
> Remove space between function "mixer_load" and '(' to fix the
> checkpatch.pl error:-
> ERROR: space prohibited between function name and open parenthesis '('
>=20
> Done using following coccinelle script:
> @@
> local idexpression ret;
> expression e;
> @@
>=20
> -ret =3D
> +return
>      e;
> -return ret;
>=20
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
> Changes in v2:
> 	-Added coccinelle script wrote for changes in commit message.
>=20
>  block/file-posix.c      | 3 +--
>  block/nfs.c             | 3 +--
>  block/nvme.c            | 4 +---
>  block/vhdx.c            | 3 +--
>  hw/audio/ac97.c         | 4 +---
>  hw/audio/adlib.c        | 5 +----
>  hw/display/cirrus_vga.c | 4 +---
>  migration/ram.c         | 4 +---
>  ui/gtk.c                | 3 +--
>  util/qemu-sockets.c     | 5 +----
>  10 files changed, 10 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HMa0ACgkQnKSrs4Gr
c8jcJgf/cWxTV2jyHVycQm9E0N8K/chNkY1Qr8/y4iR399Zo8NLy7qfUcncU5x7+
D9X6ni0mT5OUZ86WULhTcGc8JVKYV2um43suBW+o3vqnyL9vLReictGLx7NjdK5k
1OijuuDsDKiwQJ3lB4F0LSq2xotRb8vS/gxxnAZlIA9rw3avazSJj0GYXKtX6Od9
+MMEBzhOpXaVRcsNl1h9Lamh3qbqvi3IJNfHfYCVaGeCnlVCvEfFsYtkV7nrkZP1
v0wMwWP/aINMHoeJBXLLX9q7GJGcYaC/tCflNK/gVHuLoqCaWALlkMXHd8xVlT5I
EfFXY0LED3bXhHfAobYT1PczxFol1A==
=ir9p
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

