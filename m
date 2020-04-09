Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C91FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B2520753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+eCiCrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMZGa-0004vO-9i
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jMZA1-0003Pb-SZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jMZ9z-0004zY-HZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:32:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jMZ9z-0004ys-Cr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586446327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEWkL23L15Yiofk4qf00p3NvZ31mMznDK9tBMDat3oo=;
 b=K+eCiCrAcMwFtTUZdWBBN5y8psWtsOEXz3hl3QvmD8N0Wa4nvqJimdXNaOCB9bwnVgoJ00
 /VLOpIgCgGcU/0nmzw961n4fbb0KKHjqOyChqOXQ8IiuCexMjT477VgY3nv2eWM70l1Zb2
 VnS7K82ZB9n5YuRhzKXdv/OwKwRaymU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-mF-gmR7-OvSHbh9PpugtQA-1; Thu, 09 Apr 2020 11:32:02 -0400
X-MC-Unique: mF-gmR7-OvSHbh9PpugtQA-1
Received: by mail-wm1-f69.google.com with SMTP id 14so79792wmo.9
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 08:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kKle+iTuz3A0uVk7GyX7jjKljPLpj5YjAAcv2ahgx7g=;
 b=JSja14VJXb7lkTQGjwZpiWfAFxTS9JPMhLis+D005eMrr7gIRgUmVdnOQJ2eAUlFk5
 CSlShLMD1wJm9fu1ZmRlzJdZFSovU9h3DupXy3OId3DExnRLmcHbxx9AE0O9xBFFbEMD
 W9hmHDUTjNjP0U/nXzeP4p3kM1kL6SpL2DKGznGHe1Exn7MwSToSEs+28ImmEPYr247c
 Jz9ZD2N2PQMXC8nhCpbaKR2/7WJulgIZp2L9/KpMGeg3Jg76GqR7fjYKldzUTDGPETXr
 Cmax6feek40ZMQrAJPqOiQIyvbaVWVp4J2kICwQila+w3g3LBzsRIJ45LdsMIJYAywZD
 xyCg==
X-Gm-Message-State: AGi0PuYFACPJvdFJyeX6kdwiK2oR+akp4OXG2K8GbbKhvCgb1VdoyEFc
 BkhxYtLIPVEDwUjHofcnVI+s2rmVc4uVsHkOWt1S6OlVCAywYfbzu3+Cf/ohepESMhBtqNpn1Y2
 15wYWqR+5N/1lPjo=
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr14529618wrv.348.1586446320597; 
 Thu, 09 Apr 2020 08:32:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLBEDehdzCU47kuq+ryxzCL5+hbk4vxgpAXkul2cMUiTdYZMnALgmhDWLDzCX/tqPW5HZescg==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr14529537wrv.348.1586446319526; 
 Thu, 09 Apr 2020 08:31:59 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id f3sm4393619wmj.24.2020.04.09.08.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 08:31:59 -0700 (PDT)
Date: Thu, 9 Apr 2020 17:31:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH for-5.0] aio-posix: signal-proof fdmon-io_uring
Message-ID: <20200409153156.qgjxmbmlh7be637z@steredhat>
References: <20200408091139.273851-1-stefanha@redhat.com>
 <20200408100603.wxhvodbbwivvstxh@steredhat>
 <20200409145709.GC317045@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200409145709.GC317045@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 03:57:09PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 08, 2020 at 12:06:03PM +0200, Stefano Garzarella wrote:
> > On Wed, Apr 08, 2020 at 10:11:39AM +0100, Stefan Hajnoczi wrote:
> > > The io_uring_enter(2) syscall returns with errno=3DEINTR when interru=
pted
> > > by a signal.  Retry the syscall in this case.
> > >=20
> > > It's essential to do this in the io_uring_submit_and_wait() case.  My
> > > interpretation of the Linux v5.5 io_uring_enter(2) code is that it
> > > shouldn't affect the io_uring_submit() case, but there is no guarante=
e
> > > this will always be the case.  Let's check for -EINTR around both API=
s.
> > >=20
> > > Note that the liburing APIs have -errno return values.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  util/fdmon-io_uring.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > The patch LGTM:
> >=20
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >=20
> > Not related to this patch, looking at block/io_uring.c, should we retry
> > if the io_uring_submit() fails with EINTR?
> >=20
> > I mean something like this:
> >=20
> > diff --git a/block/io_uring.c b/block/io_uring.c
> > index a3142ca989..9765681f7c 100644
> > --- a/block/io_uring.c
> > +++ b/block/io_uring.c
> > @@ -231,7 +231,7 @@ static int ioq_submit(LuringState *s)
> >          trace_luring_io_uring_submit(s, ret);
> >          /* Prevent infinite loop if submission is refused */
> >          if (ret <=3D 0) {
> > -            if (ret =3D=3D -EAGAIN) {
> > +            if (ret =3D=3D -EAGAIN || ret =3D=3D -EINTR) {
> >                  continue;
> >              }
> >              break;
>=20
> Thanks!
>=20
> I didn't do that for the reason described in the commit message.

Yeah, I agree and it was not well documented in io_uring_enter(2)!

> Philippe also mentioned that EINTR isn't listed on the io_uring_enter(2)
> man page,

FYI there was a discussion on io-uring list just few days ago [1] about
that and now it is documented [2]. :-)

>          although that is a bug because it does occur with
> IORING_ENTER_GETEVENTS and min_complete > 0.

I think we are safe for now.
IIUC io_uring_submit() sets min_complete to 0 and IORING_ENTER_GETEVENTS
is set only if IOPOLL is enabled (or min_complete > 0), but it is not
our case (for now).

>=20
> Feel free to send a separate patch.  It's probably not something that
> needs to go into QEMU 5.0.

Sure, I'll send it after the freeze.

Thanks,
Stefano

[1] https://lore.kernel.org/io-uring/43b339d3dc0c4b6ab15652faf12afa30@cert.=
org/t/#u
[2] https://github.com/axboe/liburing/commit/344355ec6619de8f4e64584c973653=
0b5346e4f4


