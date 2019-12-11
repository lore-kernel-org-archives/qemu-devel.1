Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668FAC2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EA9208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYjTBMzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EA9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3uQ-0005gA-95
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1if3tV-0004mi-Pb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1if3tU-0007gn-Ig
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:27:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1if3tU-0007fE-Eo
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576078035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ic4OCtGrxM2ChkJX3DmMCPE5CaYTXgEooLA9ZxwOx34=;
 b=gYjTBMzBy0VZPVe9nJbAqxR8adknxR2EcDTBG7tgQ2AtGV5pSvDkg/0xqKnu1OuvowHOBU
 h/FHq3ZlQPuCgWlXXha9ZAoYOJiU0ib4AGQY1ILJtFMcMbuvpYSC2+mqQnVkgRT8Lhg4ZA
 z5wi4NltmmYE0JYOhZWGlJKIBm3BYTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-B3I6YegfP4ab4gZ0tKTZBA-1; Wed, 11 Dec 2019 10:27:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8641E106BF7E;
 Wed, 11 Dec 2019 15:27:08 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95D6F60303;
 Wed, 11 Dec 2019 15:27:04 +0000 (UTC)
Date: Wed, 11 Dec 2019 15:27:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] build-sys: build vhost-user-gpu only if CONFIG_TOOLS
Message-ID: <20191211152702.GB3876@work-vm>
References: <1576074210-52834-1-git-send-email-pbonzini@redhat.com>
 <20191211143119.GK955178@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211143119.GK955178@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: B3I6YegfP4ab4gZ0tKTZBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Dec 11, 2019 at 03:23:22PM +0100, Paolo Bonzini wrote:
> > From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > vhost-user-gpu is always built and installed, but it is not part of the=
 emulator
> > proper.  Cut it if --disable-tools is specified.
>=20
> I don't feel like this is something that people would really
> consider part of "tools" either.  This is something you'd
> only ever use in conjunction with the emulators, so I don't
> think controlling it with --disable-tools is appropriate.
>=20
> A new --(enable|disable)-vhost-backends  arg looks more
> desirable to me. Disabling the system emulators should
> automatically imply --disable-vhost-backends by default
> too

It feels to me that vhost-backends are a subset of tools.

Dave

> >=20
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  Makefile | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >=20
> > diff --git a/Makefile b/Makefile
> > index 53823c2..8d921c6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -321,14 +321,10 @@ HELPERS-y =3D
> > =20
> >  HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D qemu-bridge=
-helper$(EXESUF)
> > =20
> > -ifdef CONFIG_LINUX
> > -ifdef CONFIG_VIRGL
> > -ifdef CONFIG_GBM
> > +ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
> >  HELPERS-y +=3D vhost-user-gpu$(EXESUF)
> >  vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
> >  endif
> > -endif
> > -endif
> > =20
> >  # Sphinx does not allow building manuals into the same directory as
> >  # the source files, so if we're doing an in-tree QEMU build we must
> > --=20
> > 1.8.3.1
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


