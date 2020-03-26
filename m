Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87694C2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548052070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gstQ98iN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548052070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHR5u-0007ag-H2
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1jHR53-0006oH-3H
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1jHR51-0003sI-NA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:53:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1jHR51-0003rE-J9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585223624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zs0Dp2eLiUC5tksz18a1vRMqGYk7nLQVPvUHg3ukkwY=;
 b=gstQ98iN9e8vSVc6V/rUy5F3tknoPFoLPnN8G4Ih4sNFof33465iKIKRxFTbqtfVqNfL4Z
 j02BOAfTbV6mYUT29zzhevwsiKuxdZbT2Bwcw29+gH598UXk9Uduj9fVgZvws2h/vHJk7h
 UZTIQxuj7DjB3jzifsC/AyMUAM30sCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-Vm3s6Mu1MeiARlf7tDTq7Q-1; Thu, 26 Mar 2020 07:53:40 -0400
X-MC-Unique: Vm3s6Mu1MeiARlf7tDTq7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 562A01052BA8;
 Thu, 26 Mar 2020 11:53:35 +0000 (UTC)
Received: from localhost (unknown [10.33.36.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC6593A1;
 Thu, 26 Mar 2020 11:53:30 +0000 (UTC)
Date: Thu, 26 Mar 2020 12:53:29 +0100
From: Sergio Lopez <slp@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] backup: don't acquire aio_context in backup_clean
Message-ID: <20200326115329.p5s7fapofwwfdg5c@dritchie>
References: <76edbead-7ccf-833b-a3f2-15dff7f0748c@virtuozzo.com>
 <20200325155055.730633-1-s.reiter@proxmox.com>
 <2b288000-7c09-ba31-82a7-02c5ed55f4e7@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <2b288000-7c09-ba31-82a7-02c5ed55f4e7@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lpr46wv43mntnlri"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lpr46wv43mntnlri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 08:54:53AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 25.03.2020 18:50, Stefan Reiter wrote:
> > backup_clean is only ever called as a handler via job_exit, which
>=20
> Hmm.. I'm afraid it's not quite correct.
>=20
> job_clean
>=20
>   job_finalize_single
>=20
>      job_completed_txn_abort (lock aio context)
>=20
>      job_do_finalize
>=20
>=20
> Hmm. job_do_finalize calls job_completed_txn_abort, which cares to lock a=
io context..
> And on the same time, it directaly calls job_txn_apply(job->txn, job_fina=
lize_single)
> without locking. Is it a bug?

Indeed, looks like a bug to me. In fact, that's the one causing the
issue that Dietmar initially reported.

In think the proper fix is drop the context acquisition/release that
in backup_clean that I added in 0abf2581717a19, as Stefan proposed,
and also acquire the context of "foreign" jobs at job_txn_apply, just
as job_completed_txn_abort does.

Thanks,
Sergio.

> And, even if job_do_finalize called always with locked context, where is =
guarantee that all
> context of all jobs in txn are locked?
>=20
> Still, let's look through its callers.
>=20
> =09  job_finalize
>=20
>                qmp_block_job_finalize (lock aio context)
>                qmp_job_finalize (lock aio context)
>                test_cancel_concluded (doesn't lock, but it's a test)
>=20
>           job_completed_txn_success
>=20
>                job_completed
>=20
>                     job_exit (lock aio context)
>=20
>                     job_cancel
> =09 =09
>                          blockdev_mark_auto_del (lock aio context)
>=20
>                          job_user_cancel
>=20
>                              qmp_block_job_cancel (locks context)
>                              qmp_job_cancel  (locks context)
>=20
>                          job_cancel_err
>=20
>                               job_cancel_sync (return job_finish_sync(job=
, &job_cancel_err, NULL);, job_finish_sync just calls callback)
>=20
>                                    replication_close (it's .bdrv_close.. =
Hmm, I don't see context locking, where is it ?)
>=20
>                                    replication_stop (locks context)
>=20
>                                    drive_backup_abort (locks context)
>=20
>                                    blockdev_backup_abort (locks context)
>=20
>                                    job_cancel_sync_all (locks context)
>=20
>                                    cancel_common (locks context)
>=20
>                          test_* (I don't care)
>=20
> > already acquires the job's context. The job's context is guaranteed to
> > be the same as the one used by backup_top via backup_job_create.
> >=20
> > Since the previous logic effectively acquired the lock twice, this
> > broke cleanup of backups for disks using IO threads, since the BDRV_POL=
L_WHILE
> > in bdrv_backup_top_drop -> bdrv_do_drained_begin would only release the=
 lock
> > once, thus deadlocking with the IO thread.
> >=20
> > Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
>=20
> Just note, that this thing were recently touched by 0abf2581717a19 , so a=
dd Sergio (its author) to CC.
>=20
> > ---
> >=20
> > This is a fix for the issue discussed in this part of the thread:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07639.html
> > ...not the original problem (core dump) posted by Dietmar.
> >=20
> > I've still seen it occasionally hang during a backup abort. I'm trying =
to figure
> > out why that happens, stack trace indicates a similar problem with the =
main
> > thread hanging at bdrv_do_drained_begin, though I have no clue why as o=
f yet.
> >=20
> >   block/backup.c | 4 ----
> >   1 file changed, 4 deletions(-)
> >=20
> > diff --git a/block/backup.c b/block/backup.c
> > index 7430ca5883..a7a7dcaf4c 100644
> > --- a/block/backup.c
> > +++ b/block/backup.c
> > @@ -126,11 +126,7 @@ static void backup_abort(Job *job)
> >   static void backup_clean(Job *job)
> >   {
> >       BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.jo=
b);
> > -    AioContext *aio_context =3D bdrv_get_aio_context(s->backup_top);
> > -
> > -    aio_context_acquire(aio_context);
> >       bdrv_backup_top_drop(s->backup_top);
> > -    aio_context_release(aio_context);
> >   }
> >   void backup_do_checkpoint(BlockJob *job, Error **errp)
> >=20
>=20
>=20
> --=20
> Best regards,
> Vladimir
>=20

--lpr46wv43mntnlri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl58l7kACgkQ9GknjS8M
AjWwMxAAhUU+/RtQZ74hpf2k7LL2b1naQ0mU0Qy5XlCvizsyoz386nn2KOfVgwWf
lOKi0RVyCLEBUN1CcNbu0R7eJiBy5hHq2GR/moFBB+yw+zJUp033oM4l0/iJvCdZ
7d2T/kZOadtRx8jiIHXUMa1PNFj/yKrwUN7vlevfY6tqQkqrXnNWm+OP9sAirNWc
PyuzgMrizz4oF2ImKdTXDb+w9cZ428CeJlOMrBmWSlKJ4lxA9rE/S+9TDnEXGI4c
sZ8K+UqrP1Bo5aCgkF0v2ZTaTLbezUQyJ73RTtsREVgs+F6+uqUj+g0fSonFVeQ7
rY+cQ8EToOL2BIgzY0sTxCPsnRaVcNWG4i0TNYI04V+uc6D5u47fu6uslxvy2XQ3
Tcca8M5jOxGbxILgsobztObmRdgmZSalqqfy1F3muCCTL3QhDETb3/JlwHdYDiAz
uU2NY3ZVJVsF0/qU03ysCT8Ph4fhbOHm2E21e6zKxJrlk4BPLzzB9g1HxHKYpb/C
h8Xg6r+jX5nPYbQPyBBREdppKRJdFCzUNTNCelxdnwFFthxSEvfxwXvnB0vaTktS
7VUWWC1yPH9t4dq7ndSxe64Ig0Hvo9SEy/6A1H6qe0fliST0Lih/OTPo0sqBa2Wf
hyLYm0mi86J7xU5DfCce7o/HyOlbNH7g/QNDTS1RqDQIkmIUjFA=
=20EW
-----END PGP SIGNATURE-----

--lpr46wv43mntnlri--


