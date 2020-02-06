Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EDCC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434CB218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fplqjP/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434CB218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkVG-00089U-Gn
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izkUf-0007gU-AP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izkUd-0000aG-VN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:59:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42011
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izkUd-0000ZH-Rc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581008347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OIzChtgJ7TYymfltfkniTAtP04SjMOcy2FQ9aUWHGyc=;
 b=fplqjP/s3LXc3DE70qTgqUzivdH99iCYVwupiEFN+fgr4acfoHcMh81fWT94aUG5uDlKPx
 nxQKusgTvm5X9uF31iBpHCuwQwQfbulxG6V+sH+BM0osgwIgxMHyj3NhbeK/7Got/CsvCU
 P2Ky+rHX8SqqHZqS9RaJpZzbNR9PwsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-2uSF6XlxPt6wWsV9Apsjfw-1; Thu, 06 Feb 2020 11:59:02 -0500
X-MC-Unique: 2uSF6XlxPt6wWsV9Apsjfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB0FB1440;
 Thu,  6 Feb 2020 16:59:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DA978DC2C;
 Thu,  6 Feb 2020 16:59:00 +0000 (UTC)
Date: Thu, 6 Feb 2020 17:58:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Message-ID: <20200206165859.GI4926@linux.fritz.box>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
 <20200206145825.GD4926@linux.fritz.box>
 <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
 <20200206155110.GG4926@linux.fritz.box>
 <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
 <8a3c03db-3808-0194-ee03-fef6f28667d8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8a3c03db-3808-0194-ee03-fef6f28667d8@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 17:47 hat Max Reitz geschrieben:
> On 06.02.20 17:43, Max Reitz wrote:
> > On 06.02.20 16:51, Kevin Wolf wrote:
> >> Am 06.02.2020 um 16:21 hat Max Reitz geschrieben:
> >>> On 06.02.20 15:58, Kevin Wolf wrote:
> >>>> Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
> >>>>> On 05.02.20 16:38, Kevin Wolf wrote:
> >>>>>> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
> >>>>>>> We will need this to verify that Quorum can let one of its childr=
en be
> >>>>>>> replaced without breaking anything else.
> >>>>>>>
> >>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>>>>> ---
> >>>>>>>  block/quorum.c | 25 +++++++++++++++++++++++++
> >>>>>>>  1 file changed, 25 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/block/quorum.c b/block/quorum.c
> >>>>>>> index 59cd524502..6a7224c9e4 100644
> >>>>>>> --- a/block/quorum.c
> >>>>>>> +++ b/block/quorum.c
> >>>>>>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
> >>>>>>> =20
> >>>>>>>  typedef struct QuorumChild {
> >>>>>>>      BdrvChild *child;
> >>>>>>> +
> >>>>>>> +    /*
> >>>>>>> +     * If set, check whether this node can be replaced without a=
ny
> >>>>>>> +     * other parent noticing: Unshare CONSISTENT_READ, and take =
the
> >>>>>>> +     * WRITE permission.
> >>>>>>> +     */
> >>>>>>> +    bool to_be_replaced;
> >>>>>>
> >>>>>> I don't understand these permission changes. How does (preparing f=
or)
> >>>>>> detaching a node from quorum make its content invalid?
> >>>>>
> >>>>> It doesn=E2=80=99t, of course.  What we are preparing for is to rep=
lace it by
> >>>>> some other node with some other content.
> >>>>>
> >>>>>> And why do we
> >>>>>> suddenly need WRITE permissions even if the quorum node is only us=
ed
> >>>>>> read-only?
> >>>>>>
> >>>>>> The comment is a bit unclear, too. "check whether" implies that bo=
th
> >>>>>> outcomes could be true, but it doesn't say what happens in either =
case.
> >>>>>> Is this really "make sure that"?
> >>>>>
> >>>>> I think the comment is not only unclear, it is the problem.  (Well,
> >>>>> maybe the code is also.)
> >>>>>
> >>>>> This series is about fixing at least some things about replacing no=
des
> >>>>> by mirroring.  The original use cases this was introduced for was t=
o fix
> >>>>> broken quorum children: The other children are still intact, so you=
 read
> >>>>> from the quorum node and replace the broken child (which maybe show=
s
> >>>>> invalid data, or maybe just EIO) by the fixed mirror result.
> >>>>>
> >>>>> Replacing that broken node by the fixed one changes the data that=
=E2=80=99s
> >>>>> visible on that node.
> >>>>
> >>>> Hm, yes, that's true. But I wonder if this is really something that =
the
> >>>> permission system must catch. Like other graph manipulations, it's
> >>>> essentially the user saying "trust me, I know what I'm doing, this n=
ode
> >>>> makes sense in this place".
> >>>>
> >>>> Because if you assume that the user could add a node with unsuitable
> >>>> content and you want to prevent this, where do we stop?
> >>>> blockdev-snapshot can insert a non-empty overlay, which would result=
 in
> >>>> visible data change. Should we therefore only allow snapshots when
> >>>> shared writes are allowed? This doesn't work obviously.
> >>>>
> >>>> So I'm inclined to say that this is the user's responsibility and we
> >>>> don't have to jump through hoops to prevent every possible way that =
the
> >>>> user could mess up. (Which often also result in preventing legitimat=
e
> >>>> cases like here a quorum of read-only nodes.)
> >>>
> >>> Well, if you ask the question =E2=80=9Cwhere do we stop=E2=80=9D, we =
also have to ask
> >>> the question =E2=80=9Cwhere do we start=E2=80=9D.  If we say the user=
 knows what they=E2=80=99re
> >>> doing, we might as well drop the whole can_replace infrastructure
> >>> altogether and just assume that you can replace any node by anything.
> >>
> >> Well, I don't actually know if that would be completely unreasonable.
> >> The idea was obviously to keep graph changes restricted to very specif=
ic
> >> cases to avoid nasty surprises like triggering latent bugs. Meanwhile =
we
> >> have quite a few more operations that allow changing the graph.
> >>
> >> So if preventing some cases gives us headaches and is probably more wo=
rk
> >> than dealing with any bugs they might reveal, maybe preventing them is
> >> wrong.
> >>
> >> I'm just afraid that we might be overengineering this and waste time o=
n
> >> things that we don't actually get much use from.
> >=20
> > That=E2=80=99s why I=E2=80=99m asking.
>=20
> (One thing to consider here, though, is that this series exists and has
> been reviewed by Vladimir in full, so most of the engineering effort has
> already been done.  In contrast, writing a new series to drop the whole
> can_replace infrastructure with no replacement may actually cost more.)

Fair enough. If the artificial permission changes didn't feel so wrong,
I think I would just say "let's merge it and forget about it". But they
do feel wrong, so I'm not as sure.

Kevin

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePEXTAAoJEH8JsnLIjy/WkcUP/i4qc/hwbznSzQ60qrZX2Cba
txml0qOIUK0psJZRIWS+bK/AmKwmdju2iIa5QT5h8GgUXz9Vz+r2DkwOw3lX79sF
TrRGC5RHRGFcFtUhlgZSvUfCzCsHfMUzpn4z8qhE9CS6CDF+Kt/ppKM5awluJ3Mi
y5gGhTP24Fu8zc3GGcvjHIpcjxp4WO/34sLj0xRK9YcpQ20Sko0oUGjhgmcZC3my
lpsECbl2wo5CiLBSiwEdSyY+MU4CUtVQanLXvzAzTNj7V35G9K0izY51oah2Enpt
nyrmztAQERMLMAYPw/a6/b0w/vbm0h/8vjANopD64iP8zuQZblCVZrJ/fheDRzrV
CNoo1i9y4V6SaeJ3XxfksB2UDsArJ79nHcAhi7yP3rlYO2+bwiVH3IHLgSclhKaA
ysI6N1Hf5Tv5aFEDpFWOsD3LwvxRZXnKgDE86v8yqtL3MfvjvxY0j3pCc6Jh6olV
4JAJREjjfcNnqeylelcGeb/m7/IKArmyOomFm1wdjoZxbz/5ipSeup9olu5k5YzF
8wenfnBNpDbSnWX9pq7iz6XLiFVHvll4bFzi4lxLQKlza4yvvfFboRCMjRgQJmCh
4VMhQN4LwdDpRaAkVWVMIXXqeF5bb9sgnAkRTQFlvmb6R1vJkv8aHXSXEvoOJuOE
0dtd2lxQvq3aHQTQn1Se
=fJ0k
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--


