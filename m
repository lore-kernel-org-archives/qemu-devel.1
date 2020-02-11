Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B7C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262322051A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LioFDl14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262322051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Rkv-0001n2-GU
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 04:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j1RkH-00014T-4y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j1RkE-0002Dl-UE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:22:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j1RkE-0002Cn-Ps
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 04:22:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581412934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwWoIqZ7jy0neCAXzYyHq2cpqAjTTAJQhGK9Eb3Od+U=;
 b=LioFDl14w93v039r34LOLmaaZFFuqXMlPS8FX9L1momcPb2KpoLmMG/i5v5Y549m7EX0f0
 w1mM0YJDM3n58JAVBG3mZRmIkC7lG+1u+M1RYN8UzgZjj1+6EHkKiC1H2k1ogESoSh5nXS
 1BaSSAOj0KrZPk3328YKezWInQtqy54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-RAPNOavgM2amdVqBvxEIVQ-1; Tue, 11 Feb 2020 04:22:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71719107ACC5
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:22:11 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73EAC5C1D6;
 Tue, 11 Feb 2020 09:22:02 +0000 (UTC)
Date: Tue, 11 Feb 2020 09:22:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] migration/rdma: rdma_accept_incoming_migration fix error
 handling
Message-ID: <20200211092200.GC2751@work-vm>
References: <20200210194459.112085-1-dgilbert@redhat.com>
 <20200210223347.GC984290@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200210223347.GC984290@xz-x1>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: RAPNOavgM2amdVqBvxEIVQ-1
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Feb 10, 2020 at 07:44:59PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > rdma_accept_incoming_migration is called from an fd handler and
> > can't return an Error * anywhere.
> > Currently it's leaking Error's in errp/local_err - there's
> > no point putting them in there unless we can report them.
> >=20
> > Turn most into fprintf's, and the last into an error_reportf_err
> > where it's coming up from another function.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/rdma.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >=20
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
>=20
> Is there any reason to explictly use stderr instead of the
> error_reportf_err() below (then we simply jump to that for error
> paths)?  The only difference of error_reportf_err() and stderr should
> be when there's one HMP, while shall we always suggest to use
> error_reportf_err() rather than stderr?

Because the error_reportf_err is taking an Error* (from an error
reported by migration_fd_process_incoming) where as we don't have an
Error* at the earlier points.

Dave

> Thanks,
>=20
> >          return;
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
> > --=20
> > 2.24.1
> >=20
>=20
> --=20
> Peter Xu
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


