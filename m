Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E55AC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C38921775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qzb4sQtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C38921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSeI-0005F7-D0
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxSdM-0004Ox-4l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:02:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jxSdK-0007ou-JT
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595239373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AJlrCIn0zLNAOlT71qGNa4prvgmmTm1RhbLt1h0Pd1Q=;
 b=Qzb4sQtngNrtCFt8JVD6l7Fhp/t83IhoVQww3bL0O+HDuR5olUjaiA+waDFYSM8sQFn9S4
 iy26FBj4c4mvyW7DEmfO7eIlX9z+HIWVYJNVZFf5rMisqQ6+5YhFZo12RsF1xC2aGqKRCU
 dJmgLUEJUw2q+DZXFAebXS/FPUasXWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-1u5M7A5CPMGYq21SY-V6iA-1; Mon, 20 Jul 2020 06:02:49 -0400
X-MC-Unique: 1u5M7A5CPMGYq21SY-V6iA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DABD1DE0;
 Mon, 20 Jul 2020 10:02:48 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1247A5D9DD;
 Mon, 20 Jul 2020 10:02:47 +0000 (UTC)
Date: Mon, 20 Jul 2020 11:02:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH-for-5.1] hw/ide: Do not block for AIO while resetting
 a drive
Message-ID: <20200720100246.GA24159@stefanha-x1.localdomain>
References: <20200717171938.1249-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200717171938.1249-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 07:19:38PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Last minute chat:
> 19:01 <stefanha> f4bug: use bdrv_aio_cancel_async() if possible because i=
t won't block the current thread.
> 19:02 <stefanha> f4bug: For example, in device emulation code where the g=
uest has requested to cancel an I/O request it's often possible to use the =
async version.
> 19:02 <stefanha> f4bug: But in synchronous code like device reset it may =
be necessary to use the synchronous (blocking) bdrv_aio_cancel() API instea=
d. :(
> 19:14 <stefanha> f4bug: The way to decide is: will the current function r=
eturn to the event loop and is there someone who will handle the request co=
mpletion callback when cancel finishes?
> 19:14 <stefanha> f4bug: If the next line of code requires the request to =
finished then async cancel cannot be used.
> 19:15 <stefanha> f4bug: On the other hand, if the function can return and=
 it's okay for the request to cancel at some future time then you can use a=
sync.
>=20
> So I'll revisit this patch :)
> ---
>  hw/ide/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index d997a78e47..e3a9ce7d25 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -1315,7 +1315,8 @@ static void ide_reset(IDEState *s)
>      trace_ide_reset(s);
> =20
>      if (s->pio_aiocb) {
> -        blk_aio_cancel(s->pio_aiocb);
> +        /* If there is a pending AIO callback, invoke it now. */
> +        blk_aio_cancel_async(s->pio_aiocb);

This is a place where an async call is not allowed. The completion
function must be called right away (synchronously) before we can
continue resetting the device.

I sent a patch that allows bdrv_aio_cancel() to find the AioContext so
it can call aio_poll().

Stefan

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Va8QACgkQnKSrs4Gr
c8jUKAgAueuu9GaGkvcRgaEPKb/WwT0G6dI4Lpk6Q5DHxVeLQOA95PeqwGaNtphP
SOecf9Ex4f09SjV0m1NK1O7Kqn2K98F+kO3ItyXdy78yyGJLMndhIMUTmjXbkOTR
D5a5hWTRwbtpbK1KXQqkbIG0FxxBtDLqaDDyNaJ+kB/t+160MoYLrhzhAwE5GdaX
s5TBJaZsjfO7eXkFvxlLQph+msfZyetvRKUCYcKLB9hVGcf6yw3MgGkHDn495zUK
gE3vBeHDMhLlwyrCxSsuBdt4KZ+JqaNd/dAQ6YnBCRTnQVO0KJ0UAhUVcxbI5kRd
m4/wjQ2rDnSgDQeKWlfg0BjhkReRbg==
=fs0p
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


