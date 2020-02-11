Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B1F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSoHB/EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B1F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TWi-0002s2-H2
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 06:16:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1TVd-0001xe-Iq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1TVc-0002eP-Bw
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:15:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1TVc-0002cP-7T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581419715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kX02dkb8cCYomK4GCTIYnuD0bhGwJDl0XnJklUnh3HQ=;
 b=gSoHB/ELUxbbZZ8DldruKNSiqCHrl7UyejvkCPIRlW9c1K2gFIXYi+luBsQ/WACkv3ytLh
 RrX06l+uvyor1fAgNINL0/vn68Co+g+guLD1pGXFcWSObL+w7QbX7zkwIo8iosA/LOKabN
 qEJXBhhBjFO++QbSDMcQzS14OazdJX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-dzU3L2D6Mvqz0rveiYlCTQ-1; Tue, 11 Feb 2020 06:15:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF0351851FE2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:15:12 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF7AA5C120;
 Tue, 11 Feb 2020 11:15:08 +0000 (UTC)
Date: Tue, 11 Feb 2020 11:15:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migration/rdma: rdma_accept_incoming_migration fix error
 handling
Message-ID: <20200211111506.GF2751@work-vm>
References: <20200210194459.112085-1-dgilbert@redhat.com>
 <871rr1gz1v.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <871rr1gz1v.fsf@secure.laptop>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dzU3L2D6Mvqz0rveiYlCTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > rdma_accept_incoming_migration is called from an fd handler and
> > can't return an Error * anywhere.
> > Currently it's leaking Error's in errp/local_err - there's
> > no point putting them in there unless we can report them.
> >
> > Turn most into fprintf's, and the last into an error_reportf_err
> > where it's coming up from another function.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/rdma.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 2379b8345b..f67161c98f 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -3980,13 +3980,13 @@ static void rdma_accept_incoming_migration(void=
 *opaque)
> >      RDMAContext *rdma =3D opaque;
> >      int ret;
> >      QEMUFile *f;
> > -    Error *local_err =3D NULL, **errp =3D &local_err;
> > +    Error *local_err =3D NULL;
> > =20
> >      trace_qemu_rdma_accept_incoming_migration();
> >      ret =3D qemu_rdma_accept(rdma);
> > =20
> >      if (ret) {
> > -        ERROR(errp, "RDMA Migration initialization failed!");
> > +        fprintf(stderr, "RDMA ERROR: Migration initialization failed")=
;
> >          return;
>=20
> this should end in "\n" right?

Oops thanks; and in the one below.

> Appart from that.
>=20
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>=20
> BTW, I can include the \n when I queue the patch, no need to resend

Thanks

Dave

>=20
> >      }
> > =20
> > @@ -3998,13 +3998,16 @@ static void rdma_accept_incoming_migration(void=
 *opaque)
> > =20
> >      f =3D qemu_fopen_rdma(rdma, "rb");
> >      if (f =3D=3D NULL) {
> > -        ERROR(errp, "could not qemu_fopen_rdma!");
> > +        fprintf(stderr, "RDMA ERROR: could not qemu_fopen_rdma");
> >          qemu_rdma_cleanup(rdma);
> >          return;
> >      }
> > =20
> >      rdma->migration_started_on_destination =3D 1;
> > -    migration_fd_process_incoming(f, errp);
> > +    migration_fd_process_incoming(f, &local_err);
> > +    if (local_err) {
> > +        error_reportf_err(local_err, "RDMA ERROR:");
> > +    }
> >  }
> > =20
> >  void rdma_start_incoming_migration(const char *host_port, Error **errp=
)
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


