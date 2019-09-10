Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3BBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65D7206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahvIxUjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65D7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bOX-00039i-Ry
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i7bNW-0002Ea-NV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i7bNV-0004C6-AL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:19:58 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i7bNV-0004Bu-3R; Tue, 10 Sep 2019 04:19:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so18230410wrd.3;
 Tue, 10 Sep 2019 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/28G+p51mLKZR9gae3F5XQ0gmepee57ZX1/hR4W/fNU=;
 b=ahvIxUjQbTZU1j7V7/IIxSOfNtHpDQEumh4TaUCSjz5B1k4eUya5MQ2OQ6xUX+70Xn
 JLAHK5PUN3cuEkP4pPgvheqi89ckUDwj9gHiGZithmKJ0n7IjRN5DYDOu1aT3LURod+y
 9J0VPsk3Yd0vDHBGMHvUnl09YBeMZDwupeEB4RP6MkoJGO3M7jNdrN3ZvU4tCbChENIJ
 qS9fAXokltwF0XHQmDUEWQqn+l3WvkxS1+KTNT1uxmD+Wgp4BSyg4HSlRJV320zqntkJ
 rQHZdm7g9UdCc7no5h8vR+DQScPTewazYjCz/44SJ8G3VySDmXp2L54IDwNLSVXz1b1i
 lq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/28G+p51mLKZR9gae3F5XQ0gmepee57ZX1/hR4W/fNU=;
 b=Go73LsiS6APGnS9z7w3OzYYIKiZMK8/9hoKNN8ui+dA1y2WngdQYDwVKU5ECPboDCQ
 6u8kmthdEIhM5urzKHoVkKwOsw1wcrc8N2kiBv2D5pS8H5wawe8WwW0ARMNg6D51iqxh
 2C1LbcG19XVUQ9e4k1xVw4PjN+tUYF6Mp5KVpfXqxR3H2YAnQIMOcynVdnHZVMO0jPjE
 d1St53iP4V62HWQnsPJQhWlO1UyTngVjMcmXHP5yjIU8b3KfEGo3uBmDJHlYeLrNqUB9
 5/q/G3g7HNWJTRpy+o4Ark/+gaIYkf7CVb8Iv2vGWGYD/A2Z7j1gUZc5geqzwkSxaUJU
 Ya/g==
X-Gm-Message-State: APjAAAVzUCrZxPj7zeBISQn47NQ89/6CbgIiBZ7ixbpPZqhQ5Bq2oIcT
 FOD9yFUlrSI31eiFPjtfX7w=
X-Google-Smtp-Source: APXvYqy9to5FezD/ZvEKG7cwcHlttujeOTLy+0JGHk65JUKwMfauEUQ17NLPv3yE048Q8AEzIWHtwA==
X-Received: by 2002:adf:ec48:: with SMTP id w8mr23707286wrn.198.1568103595613; 
 Tue, 10 Sep 2019 01:19:55 -0700 (PDT)
Received: from localhost (178.115.129.86.wireless.dyn.drei.com.
 [178.115.129.86])
 by smtp.gmail.com with ESMTPSA id f197sm1987695wme.22.2019.09.10.01.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:19:54 -0700 (PDT)
Date: Tue, 10 Sep 2019 10:19:42 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190910081942.GA23976@stefanha-x1.localdomain>
References: <20190809201333.29033-1-jsnow@redhat.com>
 <b85698e6-cd79-a9c5-554c-c92487060280@virtuozzo.com>
 <154bc276-d782-443f-3db6-38d87992d609@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <154bc276-d782-443f-3db6-38d87992d609@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/backup: install
 notifier during creation
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2019 at 04:01:52PM -0400, John Snow wrote:
>=20
>=20
> On 8/21/19 10:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> > 09.08.2019 23:13, John Snow wrote:
> >> Backup jobs may yield prior to installing their handler, because of the
> >> job_co_entry shim which guarantees that a job won't begin work until
> >> we are ready to start an entire transaction.
> >>
> >> Unfortunately, this makes proving correctness about transactional
> >> points-in-time for backup hard to reason about. Make it explicitly cle=
ar
> >> by moving the handler registration to creation time, and changing the
> >> write notifier to a no-op until the job is started.
> >>
> >> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>   block/backup.c     | 32 +++++++++++++++++++++++---------
> >>   include/qemu/job.h |  5 +++++
> >>   job.c              |  2 +-
> >>   3 files changed, 29 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/block/backup.c b/block/backup.c
> >> index 07d751aea4..4df5b95415 100644
> >> --- a/block/backup.c
> >> +++ b/block/backup.c
> >> @@ -344,6 +344,13 @@ static int coroutine_fn backup_before_write_notif=
y(
> >>       assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
> >>       assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
> >>  =20
> >> +    /* The handler is installed at creation time; the actual point-in=
-time
> >> +     * starts at job_start(). Transactions guarantee those two points=
 are
> >> +     * the same point in time. */
> >> +    if (!job_started(&job->common.job)) {
> >> +        return 0;
> >> +    }
> >=20
> > Hmm, sorry if it is a stupid question, I'm not good in multiprocessing =
and in
> > Qemu iothreads..
> >=20
> > job_started just reads job->co. If bs runs in iothread, and therefore w=
rite-notifier
> > is in iothread, when job_start is called from main thread.. Is it guara=
nteed that
> > write-notifier will see job->co variable change early enough to not mis=
s guest write?
> > Should not job->co be volatile for example or something like this?
> >=20
> > If not think about this patch looks good for me.
> >=20
>=20
> You know, it's a really good question.
> So good, in fact, that I have no idea.
>=20
> =C2=AF\_(=E3=83=84)_/=C2=AF
>=20
> I'm fairly certain that IO will not come in until the .clean phase of a
> qmp_transaction, because bdrv_drained_begin(bs) is called during
> .prepare, and we activate the handler (by starting the job) in .commit.
> We do not end the drained section until .clean.
>=20
> I'm not fully clear on what threading guarantees we have otherwise,
> though; is it possible that "Thread A" would somehow lift the bdrv_drain
> on an IO thread ("Thread B") and, after that, "Thread B" would somehow
> still be able to see an outdated version of job->co that was set by
> "Thread A"?
>=20
> I doubt it; but I can't prove it.

In the qmp_backup() case (not qmp_transaction()) there is:

  void qmp_drive_backup(DriveBackup *arg, Error **errp)
  {

      BlockJob *job;
      job =3D do_drive_backup(arg, NULL, errp);
      if (job) {
          job_start(&job->job);
      }
  }

job_start() is called without any thread synchronization, which is
usually fine because the coroutine doesn't run until job_start() calls
aio_co_enter().

Now that the before write notifier has been installed early, there is
indeed a race between job_start() and the write notifier accessing
job->co from an IOThread.

The write before notifier might see job->co !=3D NULL before job_start()
has finished.  This could lead to issues if job_*() APIs are invoked by
the write notifier and access an in-between job state.

A safer approach is to set a BackupBlockJob variable at the beginning of
backup_run() and check it from the before write notifier.

That said, I don't understand the benefit of this patch and IMO it makes
the code harder to understand because now we need to think about the
created but not started state too.

Stefan

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl13XJ4ACgkQnKSrs4Gr
c8h8qAf/WcJ2LxH4yw/oZrL87UHNfxFXYtL1mmnYjWUZrCxNJZamEYJ5ziSR7IzH
Qui8G7If6PbNsyGS5aBevMA9Pftj6BIBiNvXfbSFnKOgVajemboM4u0mV3pNtmAF
DT/m+JiBY5kpo/BrmBK+A1WDbW/ef39vvMiLUBsRs6NukeUN9Lg8xInXqSBhl5Zr
Fru19lfuu9iLHkNfgOzKWePLqdLvXL6gmlIv93hoK78nS5jwY2ZQ3nlWnEfUC7If
rqZZjPUDxjz4qnywylGBsJiUUyM5MRu8a9gN0Ue690pH2D+f+B6VfTrjCmysJwNZ
frOyQuwZDvvzvDhZkygJ5iRKmHOIiA==
=haRb
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

