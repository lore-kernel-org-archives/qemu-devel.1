Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4EFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3360D2467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfMbuIOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3360D2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFCs-0002gD-CR
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iiFC0-000218-FC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iiFBy-00014X-Kp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:07:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iiFBy-0000yd-DC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576836449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lQoF79TsdBGxcT9fbUUAvhf6d9EN4Eviy5NhT3X+5Q=;
 b=IfMbuIOHAGfGIv1I7zYSJN8OQqxXQeauumudC1yk8XGpKISNaqj4LQ0EmID3AUNY6/tt93
 qyZzk5h1jVPKUeS83/GFwZYKd3yfWqyq/gq8rO5uWCns/YpfXbe7bqdNV/OeQVUTuRZPh8
 kUlLhTorn5a+cvjCfLACusVsK4Oe+Fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-k4GB9qepO-uoHKTfF_nqYw-1; Fri, 20 Dec 2019 05:07:25 -0500
X-MC-Unique: k4GB9qepO-uoHKTfF_nqYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DC8D10120B5;
 Fri, 20 Dec 2019 10:07:24 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A301463B89;
 Fri, 20 Dec 2019 10:07:23 +0000 (UTC)
Date: Fri, 20 Dec 2019 11:07:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2] iotests.py: Let wait_migration wait even more
Message-ID: <20191220100722.GC4019@dhcp-200-226.str.redhat.com>
References: <20191219183617.213637-1-mreitz@redhat.com>
 <20191220093258.GB4019@dhcp-200-226.str.redhat.com>
 <ae410084-8100-de49-4576-d13da3f6adee@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ae410084-8100-de49-4576-d13da3f6adee@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.12.2019 um 10:52 hat Max Reitz geschrieben:
> On 20.12.19 10:32, Kevin Wolf wrote:
> > Am 19.12.2019 um 19:36 hat Max Reitz geschrieben:
> >> The "migration completed" event may be sent (on the source, to be
> >> specific) before the migration is actually completed, so the VM runsta=
te
> >> will still be "finish-migrate" instead of "postmigrate".  So ask the
> >> users of VM.wait_migration() to specify the final runstate they desire
> >> and then poll the VM until it has reached that state.  (This should be
> >> over very quickly, so busy polling is fine.)
> >>
> >> Without this patch, I see intermittent failures in the new iotest 280
> >> under high system load.  I have not yet seen such failures with other
> >> iotests that use VM.wait_migration() and query-status afterwards, but
> >> maybe they just occur even more rarely, or it is because they also wai=
t
> >> on the destination VM to be running.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >=20
> >> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
> >> index 13fd8b5cd2..0b62c42851 100644
> >> --- a/tests/qemu-iotests/iotests.py
> >> +++ b/tests/qemu-iotests/iotests.py
> >> @@ -668,12 +668,16 @@ class VM(qtest.QEMUQtestMachine):
> >>              }
> >>          ]))
> >> =20
> >> -    def wait_migration(self):
> >> +    def wait_migration(self, expect_runstate):
> >>          while True:
> >>              event =3D self.event_wait('MIGRATION')
> >>              log(event, filters=3D[filter_qmp_event])
> >>              if event['data']['status'] =3D=3D 'completed':
> >>                  break
> >> +        # The event may occur in finish-migrate, so wait for the expe=
cted
> >> +        # post-migration runstate
> >=20
> > That's a bit too specific now that you have expect_runstate.
>=20
> Can you be more specific? :-)
>=20
> If you mean the fact of mentioning =E2=80=9Cpost-migration runstate=E2=80=
=9D, I simply
> meant that as =E2=80=9Cthe runstate after the migration=E2=80=9D.  The sp=
ecific runstate
> on the source VM is called =E2=80=9Cpostmigrate=E2=80=9D.

Oh, yes, "postmigrate" is what I had in mind.

> I wouldn=E2=80=99t mind changing it to =E2=80=9Cafter-migration runstate=
=E2=80=9D or something
> similar, if that=E2=80=99s what you mean.

"runstate after migration"?

Kevin

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd/J1aAAoJEH8JsnLIjy/WE2sP/AxUBdU/of+joUeCq4nco0/C
7Au4NEvxwulemmWx0WTwZx3rzMvhJrx3d1I+szRIoohlFs3Fgutazedit4+4WL8S
GI0ST2QdPyIPSbSEmEqoQFUhuA/ExcSn1kB+jUmOKOZBj1v3yTy9+eDmuOpPGAFZ
k5Gm08TvyMQTdvIp3QbXi+w2DIi/zjzTGp5vTLfNJ8Rm/sKJ9Z6WI9W4wkPwJWD4
Ke10k6V7zcGTSRNQidT5LS5byLpyc4v+RQbp35PhVi+QNXB2UAfu3smGBvesLIN1
eQnyvnzARhdEjB1jQv7Xj6OekuMUFiyG5w79IXDfnRiHz6hyA+FmUHwdT/xdQIac
FE53FXGAovNnHaCyINxFOW1+7Dqgumy9zsIUI/Mctf4db/z/eLaApF7PHGDAj5w0
9GDsUoFoaa+Q1YAG+pOStAdo4f5jGVtMGCeYNNKuHgkod0Sm9TbLk1AhWHW3s5le
VKTKLV5PbVpknDCbIguOtH1/knrnlNpwULeg3UGMX5YSyaUOvwXp4EQxl92plmJN
lw2ifFlN8v0Hok3dN8XT21/okrppewye/aExcnpJ60UvpBXqJvgemi95sXUJPimV
x6wNUztzCRzsIZZrvCDyYMQnvvZMLY8OQxJiWpGUlMEKS/dMmIZKgmTW/si4FWCC
upc2Y1d2Iam5RZ2Zc6mN
=lALL
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


