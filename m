Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B011C352A3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4886720838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYN3fVXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjRn-0000Bu-Fx
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izjR3-0007yp-5s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izjR1-0002EH-Px
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:51:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izjR1-0002D7-M2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581004279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xy5uieNumwcyMMc3mcWpUYPM3b/qOTxwHdCiCyLRL8o=;
 b=aYN3fVXSuToUrsUYk1ry3BODsxZ4M0hEJyc2Z5xfg7IzbN/0EKp7gdzyat0Aqb/MigOMAE
 WwqxG0S6To8l6tFSadFcCbXu1mwC37we2Qdq9qZyK9OUk3/cIsBECc9sZl2Ugv74Am1X34
 RTY+bzLBJE+nyk/HUuKIejfIBkxrt+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-6qg-ddm1NMaL4ZZaJEcnFQ-1; Thu, 06 Feb 2020 10:51:15 -0500
X-MC-Unique: 6qg-ddm1NMaL4ZZaJEcnFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26E6AA1A10;
 Thu,  6 Feb 2020 15:51:13 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 295DA27184;
 Thu,  6 Feb 2020 15:51:12 +0000 (UTC)
Date: Thu, 6 Feb 2020 16:51:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Message-ID: <20200206155110.GG4926@linux.fritz.box>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
 <20200206145825.GD4926@linux.fritz.box>
 <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 16:21 hat Max Reitz geschrieben:
> On 06.02.20 15:58, Kevin Wolf wrote:
> > Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
> >> On 05.02.20 16:38, Kevin Wolf wrote:
> >>> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
> >>>> We will need this to verify that Quorum can let one of its children =
be
> >>>> replaced without breaking anything else.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  block/quorum.c | 25 +++++++++++++++++++++++++
> >>>>  1 file changed, 25 insertions(+)
> >>>>
> >>>> diff --git a/block/quorum.c b/block/quorum.c
> >>>> index 59cd524502..6a7224c9e4 100644
> >>>> --- a/block/quorum.c
> >>>> +++ b/block/quorum.c
> >>>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
> >>>> =20
> >>>>  typedef struct QuorumChild {
> >>>>      BdrvChild *child;
> >>>> +
> >>>> +    /*
> >>>> +     * If set, check whether this node can be replaced without any
> >>>> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
> >>>> +     * WRITE permission.
> >>>> +     */
> >>>> +    bool to_be_replaced;
> >>>
> >>> I don't understand these permission changes. How does (preparing for)
> >>> detaching a node from quorum make its content invalid?
> >>
> >> It doesn=E2=80=99t, of course.  What we are preparing for is to replac=
e it by
> >> some other node with some other content.
> >>
> >>> And why do we
> >>> suddenly need WRITE permissions even if the quorum node is only used
> >>> read-only?
> >>>
> >>> The comment is a bit unclear, too. "check whether" implies that both
> >>> outcomes could be true, but it doesn't say what happens in either cas=
e.
> >>> Is this really "make sure that"?
> >>
> >> I think the comment is not only unclear, it is the problem.  (Well,
> >> maybe the code is also.)
> >>
> >> This series is about fixing at least some things about replacing nodes
> >> by mirroring.  The original use cases this was introduced for was to f=
ix
> >> broken quorum children: The other children are still intact, so you re=
ad
> >> from the quorum node and replace the broken child (which maybe shows
> >> invalid data, or maybe just EIO) by the fixed mirror result.
> >>
> >> Replacing that broken node by the fixed one changes the data that=E2=
=80=99s
> >> visible on that node.
> >=20
> > Hm, yes, that's true. But I wonder if this is really something that the
> > permission system must catch. Like other graph manipulations, it's
> > essentially the user saying "trust me, I know what I'm doing, this node
> > makes sense in this place".
> >=20
> > Because if you assume that the user could add a node with unsuitable
> > content and you want to prevent this, where do we stop?
> > blockdev-snapshot can insert a non-empty overlay, which would result in
> > visible data change. Should we therefore only allow snapshots when
> > shared writes are allowed? This doesn't work obviously.
> >=20
> > So I'm inclined to say that this is the user's responsibility and we
> > don't have to jump through hoops to prevent every possible way that the
> > user could mess up. (Which often also result in preventing legitimate
> > cases like here a quorum of read-only nodes.)
>=20
> Well, if you ask the question =E2=80=9Cwhere do we stop=E2=80=9D, we also=
 have to ask
> the question =E2=80=9Cwhere do we start=E2=80=9D.  If we say the user kno=
ws what they=E2=80=99re
> doing, we might as well drop the whole can_replace infrastructure
> altogether and just assume that you can replace any node by anything.

Well, I don't actually know if that would be completely unreasonable.
The idea was obviously to keep graph changes restricted to very specific
cases to avoid nasty surprises like triggering latent bugs. Meanwhile we
have quite a few more operations that allow changing the graph.

So if preventing some cases gives us headaches and is probably more work
than dealing with any bugs they might reveal, maybe preventing them is
wrong.

I'm just afraid that we might be overengineering this and waste time on
things that we don't actually get much use from.

> If the WRITE permission is the problem, then I suppose we can drop that.
>  Unsharing CONSISTENT_READ is bad enough that it effectively deters all
> other parents anyway.

WRITE is probably the more practical problem, though it's technically
the correct one to take.

CONSISTENT_READ is already a problem in theory because replacing a child
node with different content doesn't even match its definition:

    /**
     * A user that has the "permission" of consistent reads is guaranteed t=
hat
     * their view of the contents of the block device is complete and
     * self-consistent, representing the contents of a disk at a specific
     * point.
     *
     * For most block devices (including their backing files) this is true,=
 but
     * the property cannot be maintained in a few situations like for
     * intermediate nodes of a commit block job.
     */
    BLK_PERM_CONSISTENT_READ    =3D 0x01,

Replacing an image with a different image means that the node represents
the content of a different disk now, but it's probably still complete
and self-consistent.

Kevin

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePDXuAAoJEH8JsnLIjy/We8cP/jc0jXUMn+IxLK9XU8BvJKTR
H8siGQP628YadkS+Ox/oKFhE1vDTHlovi4vmsa2IxhGgRher1gqmV+rmmb2usfFV
zM2llwhhFI75H6yP7T6UOhPHyKhNI5WFWFiW/qdUJ01xHwaDF/OhLHJi3lufweCa
ntJBDJ6iw+zWoja6HvEE1M5lYC0xPrGCZg6rwjA2k/fWfF/vKJNwVQzPNqo2yvqp
EDaewCv+lAHBS/8b//r+QQqNASwpe7M+8RAGYZDeeQsjvmAZM3fhwWRWZFHPirH+
uVLvtTF8/GC4M4PZElTh1X4DwJnUi7xsXHcRAdf523AfU2gR+8qGKxeg253T7cCX
ET72hLN5Vryu/JwTioh2oqO0VbOHT13AkC0CCl1veQmnQOas/IFpcZXIhgaKot+n
Rk+44WgWvwTxq/ZV2itYqC33P98WdP7ifoiWvXzYIIFiip15MBtbmtKGECdvd5Nc
lck3SO9XlTIXfr5qbaU+6ogNPIiGbQjzAMg7MQiTkOVWhlwcFomA8PuirHmxylZy
8f04EH17CZPRziPFnXNmuCY3pEncb5ULVP5Xxj71qHeXAU05+Z6CV8PE1CuSPIJx
UOWAUJcJzcotKCWjwN/pZJIHYQNzO0IZ0yusnCMPY9oo9GsDa/7KaxmibNtK5iHb
1zJhtUX6P+3CYDMFoQyy
=HpVI
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--


