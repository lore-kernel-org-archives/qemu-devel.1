Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96922C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6318120721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/s036gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6318120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwXj-0004T3-7m
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipwSJ-00076M-BS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipwSI-0002JP-2J
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:44:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipwSH-0002Hf-SF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578671049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4x4BxsET7gPo2+t+isJ34uT7paifFc8+d+aqpS8J6hg=;
 b=J/s036gxJallhZzwB++1fpuWtaq0ffN0YWif+pggt+UI7rZ8T34QuuuGOBP5uJEgVStJ6o
 f5RiElQC02aWQ0SDPEa375G3hiCXtAyxHdDWVApZZs5OLOFg8SYjuxbV17DSZ8B+NgV4/4
 lbuTTVdTs8EiEjXaxPKNlwgNTLDP9NI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-QFBUWIJ3PTuELeWXnmMvQQ-1; Fri, 10 Jan 2020 10:44:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB5368024D2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:44:05 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7AA10016E8;
 Fri, 10 Jan 2020 15:44:02 +0000 (UTC)
Date: Fri, 10 Jan 2020 15:43:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 062/104] virtiofsd: Handle hard reboot
Message-ID: <20200110154359.GI3901@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-63-dgilbert@redhat.com>
 <20200107111437.GF3368802@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107111437.GF3368802@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QFBUWIJ3PTuELeWXnmMvQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Dec 12, 2019 at 04:38:22PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
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
> > +            /*
> > +             * TODO: This is after a hard reboot typically, we need to=
 do
> > +             * a destroy, but we can't reply to this request yet so
> > +             * we can't use do_destroy
> > +             */
> > +            fuse_log(FUSE_LOG_DEBUG, "%s: reinit\n", __func__);
> > +            se->got_destroy =3D 1;
> > +            se->got_init =3D 0;
> > +            if (se->op.destroy) {
> > +                se->op.destroy(se->userdata);
> > +            }
> > +        } else {
> > +            goto reply_err;
> > +        }
>=20
> In doing this, is there any danger we're exposed to from a malicious
> guest which does
>=20
>    mount
>    mount
>=20
> without a reboot in between ?

I don't think so - or at least not from the daemon side of things; if it
were to do that (and get two FUSE_INIT's) then the state of it's first
mount would be rather messed up; but the only thing to suffer would be
the kernel doing that odd re-init, so I don't think the maliciousness
should break anyone else.


> I'm thinking not so if its ok, then
>=20
>  Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks.

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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


