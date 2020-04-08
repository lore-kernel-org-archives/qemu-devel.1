Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D34AC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FB920747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLzeK5rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FB920747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7bx-0000Jo-52
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jM7b3-00089E-Qn
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jM7b2-0005nM-8H
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:06:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46325
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jM7b2-0005mL-0Z
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586340370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/91RpyqCXQnAMBo28Dxa8jjVmWxZUNReHl1pyGaorcU=;
 b=YLzeK5rBBGWDjJD4BLdziskoJ576RTM8ISHv1i7pAYAn4FHxRYaTCZMXzd/N/cTFaUTi9+
 iKlFyHGJSHQA5JjwvSOloSjDBb1RKvFywMuy/KNv/Mxf2tbETQWYFFW+LjiYPJwIjLXJIP
 p+C4oF6O+a/zed3XcDeQwTQhUTKLJS8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Yw1dQ_nvPoCjiRFE0nmgCg-1; Wed, 08 Apr 2020 06:06:09 -0400
X-MC-Unique: Yw1dQ_nvPoCjiRFE0nmgCg-1
Received: by mail-wr1-f69.google.com with SMTP id h14so3722953wrr.12
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 03:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uGcGZLv+kiFpn+Gsepta3Dt57g00kkyx6w51rhLem7g=;
 b=JjiU4MONXbKA4eM0gR97QFHN5DraIRW8or1vdQO3cVcVtdZxQd5Qn/1OJaWk8Qpn1m
 OgO4UuNfeg4KRhg6K0Pql/JZPMuX465NXNUYdKZem5h4NfHvXQngJgW0ACl/eRnmAjtt
 wvT6XxuX/Kj471SHunpOkXVmKbqN5FIqKEJcE1uNUuyRcTwJuxda2+jy5jxAzvuEYk9u
 o+0RZZJ3wUR+HO8RyDmHYJMAH91kT5wVpHcyOh+NKiHumNlhFcOlNnXsGJqNzCZ3IRap
 1QCRGJPG8AsU4g2gi0qGRhiWfti95M24I7MJYdtRN5EuzBKlm5ospnIrvwXclrlLC0lu
 nWaw==
X-Gm-Message-State: AGi0PubD2C9z4AlRB8ZZ4wl60aL42jsywxorDGEqeGavjQBfRAqzeBti
 aixwbc4MbFgRVdTmcx/RZLCecJQSWS66do2WW+dwX2kw0zSJi2fVSkgJtx1AAHzoTbtf+d6C8bH
 6noU3bLfFYvLAUSY=
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr3630201wmc.29.1586340367534; 
 Wed, 08 Apr 2020 03:06:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKkjLp7VWrl/4jZSLzf0buczmFkQ1YOFOljW2pKZP9B55tCdnaNCuUVxqg+F2H1ZY2Kno3+xg==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr3630179wmc.29.1586340367271; 
 Wed, 08 Apr 2020 03:06:07 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id k184sm6091669wmf.9.2020.04.08.03.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 03:06:06 -0700 (PDT)
Date: Wed, 8 Apr 2020 12:06:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.0] aio-posix: signal-proof fdmon-io_uring
Message-ID: <20200408100603.wxhvodbbwivvstxh@steredhat>
References: <20200408091139.273851-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200408091139.273851-1-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 08, 2020 at 10:11:39AM +0100, Stefan Hajnoczi wrote:
> The io_uring_enter(2) syscall returns with errno=3DEINTR when interrupted
> by a signal.  Retry the syscall in this case.
>=20
> It's essential to do this in the io_uring_submit_and_wait() case.  My
> interpretation of the Linux v5.5 io_uring_enter(2) code is that it
> shouldn't affect the io_uring_submit() case, but there is no guarantee
> this will always be the case.  Let's check for -EINTR around both APIs.
>=20
> Note that the liburing APIs have -errno return values.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Not related to this patch, looking at block/io_uring.c, should we retry
if the io_uring_submit() fails with EINTR?

I mean something like this:

diff --git a/block/io_uring.c b/block/io_uring.c
index a3142ca989..9765681f7c 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -231,7 +231,7 @@ static int ioq_submit(LuringState *s)
         trace_luring_io_uring_submit(s, ret);
         /* Prevent infinite loop if submission is refused */
         if (ret <=3D 0) {
-            if (ret =3D=3D -EAGAIN) {
+            if (ret =3D=3D -EAGAIN || ret =3D=3D -EINTR) {
                 continue;
             }
             break;

Thanks,
Stefano


