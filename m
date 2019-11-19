Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736D9C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426A320679
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1tGkopr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426A320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1pW-0006jo-BA
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iX1nL-0005pC-0L
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iX1nJ-0006or-Ag
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:35:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iX1nJ-0006o7-7g
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574163340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pv2UNIYhY0cSiuMJ342VQc43ndsZYKC1KybBDnzcrcM=;
 b=X1tGkopr5KnLiCdXvU/YplhIBYk02nzAZn51kU1YOf7SEatBB1VDtlHSfhlBF7wc87/Mjo
 WeanyiNE/JvZKwL4hmXFY/UErggmRdHKXHndL/lKUBVaSai9sLzVxtAOxlBfRs1VC5ENzD
 GGMAJirGIEjhlkhvpLa+HXhgg9/7vh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-KFdkgTGvN9O9HPDR5n1uNA-1; Tue, 19 Nov 2019 06:35:37 -0500
X-MC-Unique: KFdkgTGvN9O9HPDR5n1uNA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE6E6802696;
 Tue, 19 Nov 2019 11:35:36 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 207F34D;
 Tue, 19 Nov 2019 11:35:34 +0000 (UTC)
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
 <87pnhwt9xm.fsf@redhat.com> <87h837ucxa.fsf@redhat.com>
 <34ffd31f-66c4-59f5-ead1-b2df449ecee6@redhat.com> <87d0docf0s.fsf@redhat.com>
 <20191119111840.GA5910@linux.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
In-reply-to: <20191119111840.GA5910@linux.fritz.box>
Date: Tue, 19 Nov 2019 12:35:32 +0100
Message-ID: <87blt8cd4r.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 19.11.2019 um 11:54 hat Sergio Lopez geschrieben:
>>=20
>> Max Reitz <mreitz@redhat.com> writes:
>>=20
>> > On 13.11.19 14:24, Sergio Lopez wrote:
>> >>=20
>> >> Sergio Lopez <slp@redhat.com> writes:
>> >>=20
>> >>> no-reply@patchew.org writes:
>> >>>
>> >>>> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp@re=
dhat.com/
>> >>>>
>> >>>>
>> >>>>
>> >>>> Hi,
>> >>>>
>> >>>> This series failed the docker-quick@centos7 build test. Please find=
 the testing commands and
>> >>>> their output below. If you have Docker installed, you can probably =
reproduce it
>> >>>> locally.
>> >>>>
>> >>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> >>>> #!/bin/bash
>> >>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>> >>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>> >>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>> >>>>
>> >>>>   TEST    iotest-qcow2: 268
>> >>>> Failures: 141
>> >>>
>> >>> Hm... 141 didn't fail in my test machine. I'm going to have a look.
>> >>=20
>> >> So here's the output:
>> >>=20
>> >> --- /root/qemu/tests/qemu-iotests/141.out=092019-11-12 04:43:27.65155=
7587 -0500
>> >> +++ /root/qemu/build/tests/qemu-iotests/141.out.bad=092019-11-13 08:1=
2:06.575967337 -0500
>> >> @@ -10,6 +10,8 @@
>> >>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_=
file=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
>> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>> >> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
>> >> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>> >>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: no=
de is used as backing hd of 'NODE_NAME'"}}
>> >>  {"return": {}}
>> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "=
event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
>> >>=20
>> >> Those extra lines, the "paused" and "running", are a result of the jo=
b
>> >> being done in a transaction, within a drained section.
>> >>=20
>> >> We can update 141.out, but now I'm wondering, was it safe creating th=
e
>> >> job at do_drive_backup() outside of a drained section, as
>> >> qmp_drive_backup was doing?
>> >
>> > I think it is.  Someone needs to drain the source node before attachin=
g
>> > the job filter (which intercepts writes), and bdrv_backup_top_append()
>> > does precisely this.
>> >
>> > If the source node is in an I/O thread, you could argue that the drain
>> > starts later than when the user has invoked the backup command, and so
>> > some writes might slip through.  That=E2=80=99s correct.  But at the s=
ame time,
>> > it=E2=80=99s impossible to drain it the instant the command is receive=
d.  So
>> > some writes might always slip through (and the drain will not stop the=
m
>> > either, it will just let them happen).
>> >
>> > Therefore, I think it=E2=80=99s fine the way it is.
>> >
>> >> Do you think there may be any potential drawbacks as a result of alwa=
ys
>> >> doing it now inside a drained section?
>> >
>> > Well, one drawback is clearly visible.  The job goes to paused for no
>> > reason.
>>=20
>> This is something that already happens when requesting the drive-backup
>> through a transaction:
>>=20
>> {"execute":"transaction","arguments":{"actions":[{"type":"drive-backup",=
"data":{"device":"drv0","target":"o.qcow2","sync":"full","format":"qcow2"}}=
]}}
>>=20
>> I don't think it makes sense to have two different behaviors for the
>> same action. So we either accept the additional pause+resume iteration
>> for qmp_drive_backup, or we remove the drained section from the
>> transaction based one.
>>=20
>> What do you think?
>
> Draining all involved nodes is necessary for transactions, because you
> want a consistent backup across all involved disks. That is, you want it
> to be a snapshot at the same point in time for all of them - no requests
> may happen between starting backup on the first and the second disk.
>
> For a single device operation, this requirement doesn't exist, because
> there is nothing else that must happen at the same point in time.

This poses a problem with the unification strategy you suggested for qmp
commands and transactions. I guess that, if we really want to preserve
the original behavior, we can extend DriveBackup to add a flag to
indicate whether the transaction should create a drained section or not.

Does this sound reasonable to you?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3T04QACgkQ9GknjS8M
AjXmpg//aaV0U0pAxszLbHLNS/J8kSwwdX9IWYHLHBipvyCa24zXgdLiyscDc1sC
Ep53F8emmf7O2sU5wr06tiP+CB/ffMb08kn4vR1E4Vw0t4B8YYGKzb6UdSmK+xGz
KwxF7LVLdSveWoivyewINfJHVV2J68D8aFDTq2mjZnKaYKZUxKOtn08Carq9eTbB
+TwGh2WRSXuItyXtRtME4gW07z21VpYnnJV/25w9TjACcTx9MLdt+vu00Pj4ZyDd
OeJGQs9nKwdwnQblgeCtd/OANAPQrXTGIstma5csDz9PMMRXjCjQnIogzFD/VWQa
PtJqbm7HDW/JFkiIbzkTZi1N2/zS3NjiOV+Sbgr4FfrBWpqIJuD0NWyx7uEH5jLD
G3uDSUKuQM2nj1YGhMklfqlVw3tGhBJdqs85GeeHLEfTgOS+PrOnAHthk+Y5nKpD
lYWP06HEUJhXJ64f/xDQvpfJL4qhxBB3/B1WVVVKx/wH2gIp1yL0cWEHkT2nQWwB
d1KZXbR191oPjT0ZxT0hI96vZEp8ATXMgZ2qJ7sbkTBXjqlwW9jYeWDLuSmh1mTE
Bn/ZH5LB8cjRiFPNhSCm21nd/Un8ZZXm68McTq5+rESyCbjARYVcz6jPFyICg/EG
gbFIM8oNIO7PLvQBJXFoVE8ouHSWVEmX4T+gpU9An91aodCtzfA=
=Kyyg
-----END PGP SIGNATURE-----
--=-=-=--


