Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55467C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4ED206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHOq60sD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4ED206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYcx-0000fX-BB
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 10:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jMYcL-00009V-PO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jMYcK-0003mF-O8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:57:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jMYcK-0003lr-Js
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 10:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586444240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaMOuS+frALBLyb6f2i8fPOQ33Oh4ACjUbJT3/X9sj8=;
 b=PHOq60sDyeZB/RJdOC9RVjhNDq1Uq9Podlp0r9hUMTnZM2Il8kf4OgXNPU0z3+2Lu8JJWK
 z8UcgoY+P1KoMK5WNuOIJ2iTQbwGJ3O4u2oejthvFo3+4A0bRAgBnJ51f2Ng/c0bgltDBR
 cEQyI1Yi/Tz1sxW5tCXkrcZEQmSI3Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Ku8IfF8sM6mUQeqhmG96ew-1; Thu, 09 Apr 2020 10:57:15 -0400
X-MC-Unique: Ku8IfF8sM6mUQeqhmG96ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01AE78010F0;
 Thu,  9 Apr 2020 14:57:14 +0000 (UTC)
Received: from localhost (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD26196B9B;
 Thu,  9 Apr 2020 14:57:10 +0000 (UTC)
Date: Thu, 9 Apr 2020 15:57:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for-5.0] aio-posix: signal-proof fdmon-io_uring
Message-ID: <20200409145709.GC317045@stefanha-x1.localdomain>
References: <20200408091139.273851-1-stefanha@redhat.com>
 <20200408100603.wxhvodbbwivvstxh@steredhat>
MIME-Version: 1.0
In-Reply-To: <20200408100603.wxhvodbbwivvstxh@steredhat>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:06:03PM +0200, Stefano Garzarella wrote:
> On Wed, Apr 08, 2020 at 10:11:39AM +0100, Stefan Hajnoczi wrote:
> > The io_uring_enter(2) syscall returns with errno=3DEINTR when interrupt=
ed
> > by a signal.  Retry the syscall in this case.
> >=20
> > It's essential to do this in the io_uring_submit_and_wait() case.  My
> > interpretation of the Linux v5.5 io_uring_enter(2) code is that it
> > shouldn't affect the io_uring_submit() case, but there is no guarantee
> > this will always be the case.  Let's check for -EINTR around both APIs.
> >=20
> > Note that the liburing APIs have -errno return values.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  util/fdmon-io_uring.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> The patch LGTM:
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Not related to this patch, looking at block/io_uring.c, should we retry
> if the io_uring_submit() fails with EINTR?
>=20
> I mean something like this:
>=20
> diff --git a/block/io_uring.c b/block/io_uring.c
> index a3142ca989..9765681f7c 100644
> --- a/block/io_uring.c
> +++ b/block/io_uring.c
> @@ -231,7 +231,7 @@ static int ioq_submit(LuringState *s)
>          trace_luring_io_uring_submit(s, ret);
>          /* Prevent infinite loop if submission is refused */
>          if (ret <=3D 0) {
> -            if (ret =3D=3D -EAGAIN) {
> +            if (ret =3D=3D -EAGAIN || ret =3D=3D -EINTR) {
>                  continue;
>              }
>              break;

Thanks!

I didn't do that for the reason described in the commit message.
Philippe also mentioned that EINTR isn't listed on the io_uring_enter(2)
man page, although that is a bug because it does occur with
IORING_ENTER_GETEVENTS and min_complete > 0.

Feel free to send a separate patch.  It's probably not something that
needs to go into QEMU 5.0.

Stefan

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6PN8UACgkQnKSrs4Gr
c8gO+wf/dyLFvytXNZpdZvoqGMnEQSqx5LLopiLod6BCMHPGp1hy2SfAPyQVh5rW
gHqqhu7lPMtYBo/QyNC0SPTffAlYIVtp260p756b7LksZkoOOOszpeGXWZL7a0+S
vH1uxlawZt00y2/y0fKyypKC6Sgia6Gd8KtWYk301Nq2TaMo1Z7Wr2OBktun+KBv
tgE9QbKxV5QjbofUBn8NAcvnNRG5Gs49UsXKSQgbzTu1c0kXxQtqfH0iDhEWcfkj
FTt+uMzABWaZn1IDtXax1rNE/1jIosTJO3NJDb7ipbQvFocrk3wznHZykWnUquye
oX8FniyGBpIMNBdXnTLB7gu1NRi+FA==
=eXs4
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--


