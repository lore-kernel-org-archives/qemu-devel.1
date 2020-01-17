Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876DBC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B182073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKm47zsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B182073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isTYv-00069q-E1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 10:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isTXw-0005ee-HZ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isTXt-0002CO-SL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:28:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isTXt-0002BI-Nr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 10:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579274904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETfzR2G4pR33+Bd5R5O3RKHOcfgUEUmc7TXBrVbUz04=;
 b=OKm47zswj2k9mT2575wh+2a+cqbd5XUZkH0opCHif2x/FuohMi7uf/xwd22FNGqYdft8Yi
 CRHN8I1zZ8Lr610OmFsBf2Qaxif+aH+wm5O/CsxI1UP9N9z6SqK7em1dv2huMP4sP7GOVB
 9oDs8qiWCaPQX3NkhjA3Rn1JL2ozZTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-S7R0ddQ8OFauJSYaY48JUw-1; Fri, 17 Jan 2020 10:28:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7541005513
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 15:28:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE6E0101F942;
 Fri, 17 Jan 2020 15:28:14 +0000 (UTC)
Date: Fri, 17 Jan 2020 15:28:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 101/104] virtiofsd: prevent FUSE_INIT/FUSE_DESTROY races
Message-ID: <20200117152811.GJ3209@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-102-dgilbert@redhat.com>
 <73aa1b6c-612e-363e-dd49-04d1ba4f88f8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <73aa1b6c-612e-363e-dd49-04d1ba4f88f8@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: S7R0ddQ8OFauJSYaY48JUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 12/12/19 5:39 PM, Dr. David Alan Gilbert (git) wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > When running with multiple threads it can be tricky to handle
> > FUSE_INIT/FUSE_DESTROY in parallel with other request types or in
> > parallel with themselves.  Serialize FUSE_INIT and FUSE_DESTROY so that
> > malicious clients cannot trigger race conditions.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   tools/virtiofsd/fuse_i.h        |  1 +
> >   tools/virtiofsd/fuse_lowlevel.c | 18 ++++++++++++++++++
> >   2 files changed, 19 insertions(+)
> >=20
> > diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> > index d0679508cd..8a4a05b319 100644
> > --- a/tools/virtiofsd/fuse_i.h
> > +++ b/tools/virtiofsd/fuse_i.h
> > @@ -61,6 +61,7 @@ struct fuse_session {
> >       struct fuse_req list;
> >       struct fuse_req interrupts;
> >       pthread_mutex_t lock;
> > +    pthread_rwlock_t init_rwlock;
> >       int got_destroy;
> >       int broken_splice_nonblock;
> >       uint64_t notify_ctr;
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index 10f478b00c..9f01c05e3e 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -2431,6 +2431,19 @@ void fuse_session_process_buf_int(struct fuse_se=
ssion *se,
> >       req->ctx.pid =3D in->pid;
> >       req->ch =3D ch ? fuse_chan_get(ch) : NULL;
> > +    /*
> > +     * INIT and DESTROY requests are serialized, all other request typ=
es
> > +     * run in parallel.  This prevents races between FUSE_INIT and ord=
inary
> > +     * requests, FUSE_INIT and FUSE_INIT, FUSE_INIT and FUSE_DESTROY, =
and
>=20
> typo "FUSE_INIT and FUSE_INIT" -> "FUSE_INIT and CUSE_INIT"?

No, don't think so; I think it's suggesting a race between two
FUSE_INIT's.

Dave

> > +     * FUSE_DESTROY and FUSE_DESTROY.
> > +     */
> > +    if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT ||
> > +        in->opcode =3D=3D FUSE_DESTROY) {
> > +        pthread_rwlock_wrlock(&se->init_rwlock);
> > +    } else {
> > +        pthread_rwlock_rdlock(&se->init_rwlock);
> > +    }
> > +
> >       err =3D EIO;
> >       if (!se->got_init) {
> >           enum fuse_opcode expected;
> > @@ -2488,10 +2501,13 @@ void fuse_session_process_buf_int(struct fuse_s=
ession *se,
> >       } else {
> >           fuse_ll_ops[in->opcode].func(req, in->nodeid, &iter);
> >       }
> > +
> > +    pthread_rwlock_unlock(&se->init_rwlock);
> >       return;
> >   reply_err:
> >       fuse_reply_err(req, err);
> > +    pthread_rwlock_unlock(&se->init_rwlock);
> >   }
> >   #define LL_OPTION(n, o, v)                     \
> > @@ -2538,6 +2554,7 @@ void fuse_session_destroy(struct fuse_session *se=
)
> >               se->op.destroy(se->userdata);
> >           }
> >       }
> > +    pthread_rwlock_destroy(&se->init_rwlock);
> >       pthread_mutex_destroy(&se->lock);
> >       free(se->cuse_data);
> >       if (se->fd !=3D -1) {
> > @@ -2631,6 +2648,7 @@ struct fuse_session *fuse_session_new(struct fuse=
_args *args,
> >       list_init_req(&se->list);
> >       list_init_req(&se->interrupts);
> >       fuse_mutex_init(&se->lock);
> > +    pthread_rwlock_init(&se->init_rwlock, NULL);
> >       memcpy(&se->op, op, op_size);
> >       se->owner =3D getuid();
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


