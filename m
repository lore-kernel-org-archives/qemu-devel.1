Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF7CC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D304C222D1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGRJg7tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D304C222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2QN-00076a-Gx
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iX2OZ-0005i0-16
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iX2OX-0007NK-4l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:14:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52388
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iX2OV-0007Lf-Aw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574165645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AuqKTh7+DingBS9xY0Qfn/4sTmmRJnYJGYuvwC7nfvs=;
 b=QGRJg7tX77EpPCNWEX0HEc5Y+SldusMRTXYbfwN1/H7VYX3qFu9dMf4d2YSpNju5sxMlFf
 H1VW4TuOOFXMnG/pv20U2ITh9hn7hjmShVxNjTAIq+yadzJo+vAKcAnLtL4dfXkPjw/1T2
 xz0KMJJr5oiiTmA06Qz1dQHteA4CBcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-FDiwU43SN1asX_aXRGQcnQ-1; Tue, 19 Nov 2019 07:14:04 -0500
X-MC-Unique: FDiwU43SN1asX_aXRGQcnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A9C1883524;
 Tue, 19 Nov 2019 12:14:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-75.ams2.redhat.com [10.36.116.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 144105033E;
 Tue, 19 Nov 2019 12:13:59 +0000 (UTC)
Date: Tue, 19 Nov 2019 13:13:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice
 at do_drive_backup and do_blockdev_backup
Message-ID: <20191119121357.GC5910@linux.fritz.box>
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
 <87pnhwt9xm.fsf@redhat.com> <87h837ucxa.fsf@redhat.com>
 <34ffd31f-66c4-59f5-ead1-b2df449ecee6@redhat.com>
 <87d0docf0s.fsf@redhat.com> <20191119111840.GA5910@linux.fritz.box>
 <87blt8cd4r.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87blt8cd4r.fsf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 19.11.2019 um 12:35 hat Sergio Lopez geschrieben:
>=20
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 19.11.2019 um 11:54 hat Sergio Lopez geschrieben:
> >>=20
> >> Max Reitz <mreitz@redhat.com> writes:
> >>=20
> >> > On 13.11.19 14:24, Sergio Lopez wrote:
> >> >>=20
> >> >> Sergio Lopez <slp@redhat.com> writes:
> >> >>=20
> >> >>> no-reply@patchew.org writes:
> >> >>>
> >> >>>> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp@=
redhat.com/
> >> >>>>
> >> >>>>
> >> >>>>
> >> >>>> Hi,
> >> >>>>
> >> >>>> This series failed the docker-quick@centos7 build test. Please fi=
nd the testing commands and
> >> >>>> their output below. If you have Docker installed, you can probabl=
y reproduce it
> >> >>>> locally.
> >> >>>>
> >> >>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> >> >>>> #!/bin/bash
> >> >>>> make docker-image-centos7 V=3D1 NETWORK=3D1
> >> >>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=
=3D1
> >> >>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >> >>>>
> >> >>>>   TEST    iotest-qcow2: 268
> >> >>>> Failures: 141
> >> >>>
> >> >>> Hm... 141 didn't fail in my test machine. I'm going to have a look=
.
> >> >>=20
> >> >> So here's the output:
> >> >>=20
> >> >> --- /root/qemu/tests/qemu-iotests/141.out=092019-11-12 04:43:27.651=
557587 -0500
> >> >> +++ /root/qemu/build/tests/qemu-iotests/141.out.bad=092019-11-13 08=
:12:06.575967337 -0500
> >> >> @@ -10,6 +10,8 @@
> >> >>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backin=
g_file=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
> >> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},=
 "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
> >> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},=
 "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
> >> >> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},=
 "event": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
> >> >> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},=
 "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
> >> >>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: =
node is used as backing hd of 'NODE_NAME'"}}
> >> >>  {"return": {}}
> >> >>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},=
 "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}=
}
> >> >>=20
> >> >> Those extra lines, the "paused" and "running", are a result of the =
job
> >> >> being done in a transaction, within a drained section.
> >> >>=20
> >> >> We can update 141.out, but now I'm wondering, was it safe creating =
the
> >> >> job at do_drive_backup() outside of a drained section, as
> >> >> qmp_drive_backup was doing?
> >> >
> >> > I think it is.  Someone needs to drain the source node before attach=
ing
> >> > the job filter (which intercepts writes), and bdrv_backup_top_append=
()
> >> > does precisely this.
> >> >
> >> > If the source node is in an I/O thread, you could argue that the dra=
in
> >> > starts later than when the user has invoked the backup command, and =
so
> >> > some writes might slip through.  That=E2=80=99s correct.  But at the=
 same time,
> >> > it=E2=80=99s impossible to drain it the instant the command is recei=
ved.  So
> >> > some writes might always slip through (and the drain will not stop t=
hem
> >> > either, it will just let them happen).
> >> >
> >> > Therefore, I think it=E2=80=99s fine the way it is.
> >> >
> >> >> Do you think there may be any potential drawbacks as a result of al=
ways
> >> >> doing it now inside a drained section?
> >> >
> >> > Well, one drawback is clearly visible.  The job goes to paused for n=
o
> >> > reason.
> >>=20
> >> This is something that already happens when requesting the drive-backu=
p
> >> through a transaction:
> >>=20
> >> {"execute":"transaction","arguments":{"actions":[{"type":"drive-backup=
","data":{"device":"drv0","target":"o.qcow2","sync":"full","format":"qcow2"=
}}]}}
> >>=20
> >> I don't think it makes sense to have two different behaviors for the
> >> same action. So we either accept the additional pause+resume iteration
> >> for qmp_drive_backup, or we remove the drained section from the
> >> transaction based one.
> >>=20
> >> What do you think?
> >
> > Draining all involved nodes is necessary for transactions, because you
> > want a consistent backup across all involved disks. That is, you want i=
t
> > to be a snapshot at the same point in time for all of them - no request=
s
> > may happen between starting backup on the first and the second disk.
> >
> > For a single device operation, this requirement doesn't exist, because
> > there is nothing else that must happen at the same point in time.
>=20
> This poses a problem with the unification strategy you suggested for qmp
> commands and transactions. I guess that, if we really want to preserve
> the original behavior, we can extend DriveBackup to add a flag to
> indicate whether the transaction should create a drained section or not.
>=20
> Does this sound reasonable to you?

I think we can accept an unnecessary drain for the single-device case.
It's only minimally worse than not draining early (because, as Max said,
we'll drain the node anyway later).

I'm not sure what the code looks like, but does the job go to paused
even when it's already created inside the drained section? (As opposed
to first creating the job and then draining.) I assume that this is what
you're already doing, just double-checking.

If this is how things work, I'd just adjust the test output and explain
the change in the commit message.

Kevin

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd09yFAAoJEH8JsnLIjy/WOV0P/1HppJ2qYhplpCthkezFS0X4
U7G+190u35FWOqQc6ATcTbXGZNtwHkjKam38WD1u9ZfFeJz/pD9cedhL+R/2lGAR
AenU1hpAr4cLLJTHMYbjrFlYSuRNkskD9OiQ/6T6Oq/Ra4OIe8g/ObRA9KQG1uu9
p8dr9fuvROBSupYQ8IE3NMuUKBdB8H81h5RvyaIJiyCA03oMGD0EmpwUrTRyFNK2
CanT6bhDTGeC83GR5TMZ8imYU0yYYPLDk4MdtvDX4c+Q4PzOJ9QaqZ0d6qNCir7l
cDIR+/Wbrlg/j9hFJZZ0LssmijZQzOnUObQ6MQU1SDbhdBYqMneOFlca3ww9Zawb
FUBIMsxBNSZhOtQyNeo8Ipg5dqMG3s551f1SrRbSuzNgXUahl4zX51NPHLTqWeBt
JEdlOC6J1zOMimpPt3wG76hgf1mE1mTeSTOYVApEUKTMt6XPNrYd/ZtNauOquQy1
EVIoyJ3NKtjaJW9Tla2VxDElo29dlryZ0aqzpFh5TcLReSxFZkvohi12mCEsMDak
kngmQphVnNtHZxgYmBIF9XY7rsUJLMgZLHCVji7lBpBIS+eFEktVq+TKGeUjXiXh
U6onaD49ngNlyWnf0ypYPwS8vZn6RALnqVGdB7hKEx7t0Ftmxq09Xn4o3ZtLSGsI
z4usJJBKZDlTGvL3iyN+
=Hj5X
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--


