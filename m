Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1FFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F4D24125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 18:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUpc9BgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F4D24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuKkf-0004IB-Ch
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 13:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuKjx-0003qR-JL
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuKju-0002ii-TJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:28:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuKju-0002iQ-PW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 13:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579717709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hSTXfFbr432svVNmNwNIeIPIjw9e6NeKkllFKyDXP8=;
 b=dUpc9BgPZN7DD8Wwn6yUzQRJHEaEOQLwFxub4pO3joMSrWwrNMFaZy5wu8gIdb6gybNvzE
 Qqn9gRK/zn39I8N8YKxC7Yr1mmKaX1p26lbX9f44PytitMonCk9UjA4FUC7C6DMxYPBdre
 GmemqoE9fA75NfV+gMNC2ESvWfSwVGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-WCJSGF98M2uMwJLPk-3KUg-1; Wed, 22 Jan 2020 13:28:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5B510054E3;
 Wed, 22 Jan 2020 18:28:24 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EE145DA80;
 Wed, 22 Jan 2020 18:28:20 +0000 (UTC)
Date: Wed, 22 Jan 2020 18:28:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [PATCH 062/104] virtiofsd: Handle hard reboot
Message-ID: <20200122182818.GQ3263@work-vm>
References: <20191212163904.159893-63-dgilbert@redhat.com>
 <20200120064656.12828-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200120064656.12828-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: WCJSGF98M2uMwJLPk-3KUg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Misono Tomohiro (misono.tomohiro@jp.fujitsu.com) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Handle a
> >   mount
> >   hard reboot (without unmount)
> >   mount
> >=20
> > we get another 'init' which FUSE doesn't normally expect.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_lowlevel.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index 2d1d1a2e59..45125ef66a 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -2436,7 +2436,21 @@ void fuse_session_process_buf_int(struct fuse_se=
ssion *se,
> >              goto reply_err;
> >          }
> >      } else if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_I=
NIT) {
> > -        goto reply_err;
> > +        if (fuse_lowlevel_is_virtio(se)) {
>=20
> > +            /*
> > +             * TODO: This is after a hard reboot typically, we need to=
 do
> > +             * a destroy, but we can't reply to this request yet so
> > +             * we can't use do_destroy
> > +             */
>=20
> Hi,
>=20
> I wonder what is the TODO actually. Is this just to provide a common
> function for both here and do_destroy() or more than that?

Yes, we really need to combine it somehow; but do_destroy is based
n responding to a request, but we don't have a normal request at this
point.

Dave

> Thanks
> Misono
>=20
> > +            fuse_log(FUSE_LOG_DEBUG, "%s: reinit\n", __func__);
> > +            se->got_destroy =3D 1;
> > +            se->got_init =3D 0;
> > +            if (se->op.destroy) {
> > +                se->op.destroy(se->userdata);
> > +            }
> > +        } else {
> > +            goto reply_err;
> > +        }
> >      }
> > =20
> >      err =3D EACCES;
> > --=20
> > 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


