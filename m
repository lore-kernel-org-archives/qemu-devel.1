Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05848C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1901206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge15Vv+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1901206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVx6b-0006Cn-Q1
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 08:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVx5b-0005Hq-15
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:54:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVx5Y-00084q-Iq
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBgOlWWb+7B33xR59yif+CEP/7vETRFmEvtu8e0QEKY=;
 b=ge15Vv+KXAk2kU3NxqO5hfar76wpV+fyiMjy/kLE5xjGXPH831aygiUSzK4TN2konBlo3M
 qYmUEbb2owgI6p/7h5bIMnAdpJVfF7svJvIo8yUrwt1nmBtVY8zo7V5YHh2HXXPY6N0Rk3
 5s7jmVb0mdRES8iMb8eVbtyWu9H6MUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-e3bT5SVwOWqzYS6Fd_QNag-1; Tue, 05 May 2020 08:54:17 -0400
X-MC-Unique: e3bT5SVwOWqzYS6Fd_QNag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18FD2835B42;
 Tue,  5 May 2020 12:54:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB4887052E;
 Tue,  5 May 2020 12:54:14 +0000 (UTC)
Date: Tue, 5 May 2020 14:54:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 03/33] block: Add BdrvChildRole and BdrvChildRoleBits
Message-ID: <20200505125413.GK5759@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-4-mreitz@redhat.com>
 <20200505111936.GJ5759@linux.fritz.box>
 <aa2c60ac-0e41-bf3b-d81d-fe504c42c172@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aa2c60ac-0e41-bf3b-d81d-fe504c42c172@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.05.2020 um 13:59 hat Max Reitz geschrieben:
> On 05.05.20 13:19, Kevin Wolf wrote:
> > Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> >> This mask will supplement BdrvChildClass when it comes to what role (o=
r
> >> combination of roles) a child takes for its parent.  It consists of
> >> BdrvChildRoleBits values (which is an enum).
> >>
> >> Because empty enums are not allowed, let us just start with it filled.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/include/block/block.h b/include/block/block.h
> >> index fd89eb6c75..8c23948d08 100644
> >> --- a/include/block/block.h
> >> +++ b/include/block/block.h
> >> @@ -268,6 +268,44 @@ enum {
> >>      DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASS=
THROUGH,
> >>  };
> >> =20
> >> +enum BdrvChildRoleBits {
> >> +    /* Child stores data */
> >> +    BDRV_CHILD_DATA         =3D (1 << 0),
> >> +
> >> +    /* Child stores metadata */
> >> +    BDRV_CHILD_METADATA     =3D (1 << 1),
> >> +
> >> +    /*
> >> +     * A child to which the parent forwards all reads and writes.  It
> >=20
> > Is "_all_ reads and writes" really required? Imagine a caching block
> > driver, should it not be considered a filter because it may just
> > complete the requests from its cache rather than asking the child?
>=20
> Hm.  The important thing is that parent and child always show exactly
> the same data, which is the second part of the definition given here.
> So maybe we should flip both sentences, e.g.:
>=20
> =E2=80=9CA child which always presents exactly the same visibile data as =
the
> parent, e.g. by virtue of the parent forwarding all reads and writes.=E2=
=80=9D
>
> ?

Turns it into an example, which is a good way of explaining things that
are commonly, but not universally true. I like it.

> >> +     * must present exactly the same visible data as the parent.
> >> +     * Any node may have at most one filtered child at a time.
> >> +     */
> >> +    BDRV_CHILD_FILTERED     =3D (1 << 2),
> >> +
> >> +    /*
> >> +     * Child from which to read all data that isn=E2=80=99t allocated=
 in the
> >> +     * parent (i.e., the backing child); such data is copied to the
> >> +     * parent through COW (and optionally COR).
> >> +     */
> >> +    BDRV_CHILD_COW          =3D (1 << 3),
> >> +
> >> +    /*
> >> +     * The primary child.  For most drivers, this is the child whose
> >> +     * filename applies best to the parent node.
> >> +     * Each parent must give this flag to no more than one child at a
> >> +     * time.
> >> +     */
> >> +    BDRV_CHILD_PRIMARY      =3D (1 << 4),
> >=20
> > And I assume some drivers like quorum don't set it on any child.
>=20
> I thought =E2=80=9Cno more than one=E2=80=9D implies that.

Technically no, though it's probably the first assumption of most
people. It's just a suggestion for clarification, feel free to ignore
it.

> >> +    /* Useful combination of flags */
> >> +    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
> >> +                              | BDRV_CHILD_METADATA
> >> +                              | BDRV_CHILD_PRIMARY,
> >> +};
> >> +
> >> +/* Mask of BdrvChildRoleBits values */
> >> +typedef unsigned int BdrvChildRole;
> >> +
> >>  char *bdrv_perm_names(uint64_t perm);
> >>  uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
> >=20
> > The list intuitively makes sense to me. Let me try to think of some
> > interesting cases to see whether the documentation is complete or
> > whether it could be improved.
> >=20
> >=20
> > qcow2 is what everyone has in mind, so it should be obvious:
> >=20
> > * Without a data file:
> >   * file: BDRV_CHILD_IMAGE
> >   * backing: BDRV_CHILD_COW
> >=20
> > * With a data file:
> >   * file: BDRV_CHILD_PRIMARY | BDRV_CHILD_METADATA
> >   * data-file: BDRV_CHILD_DATA
> >   * backing: BDRV_CHILD_COW
> >=20
> >=20
> > We can use VMDK to make things a bit more interesting:
> >=20
> > * file: BDRV_CHILD_PRIMARY | BDRV_CHILD_METADATA
> > * extents.*: BDRV_CHILD_METADATA | BDRV_CHILD_DATA
> > * backing: BDRV_CHILD_COW
> >=20
> > In other words, we can have multiple data and metadata children. Is thi=
s
> > correct or should extents not be marked as metadata? (Checked the final
> > code: yes we do have multiple of them in vmdk.) Should this be mentione=
d
> > in the documentation?
>=20
> If the extents contain metadata (I thought not, but I think I was just
> wrong; sparse extents must contain their respective mapping structures),
> then yes, they should all be marked as metadata children.
>=20
> I=E2=80=99m not sure whether that needs to be mentioned explicitly in the=
 doc,
> because =E2=80=9CChild stores metadata=E2=80=9D seems sufficient to me.

When you're the author, the meaning of everything is clear to you. :-)

In case of doubt, I would be more explicit so that the comment gives a
clear guideline for which role to use in which scenario.

> > Do we then also want to allow multiple BDRV_CHILD_COW children? We don'=
t
> > currently have a driver that needs it, but maybe it would be consistent
> > with DATA and METADATA then. However, it would contradict the
> > documentation that it's the "Child from which to read all data".
>=20
> Yes.  I would revisit that problem when the need arises.
>=20
> It seems to me like this would open a whole can of worms, just like
> allowing multiple filtered children does.

Okay. Shall we document it explicitly like we do for the filter role?

> > blkverify:
> >=20
> > * x-image: BDRV_CHILD_PRIMARY | BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
> > * x-raw: BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
> >=20
> > Hm, according to the documentation, this doesn't work, FILTERED can be
> > set only for one node. But the condition ("the parent forwards all read=
s
> > and writes") applies to both children. I think the documentation should
> > mention what needs to be done in such cases.
>=20
> I don=E2=80=99t know.  blkverify is a rare exception by design, because i=
t can
> abort when both children don=E2=80=99t match.  (I suppose we could theore=
tically
> have a quorum mode where a child gets ejected once a mismatch is
> detected, but that isn=E2=80=99t the case now.)

Well, yes, this is exceptional. I would ignore that property for
assigning roles because when it comes to play, roles don't matter any
more because the whole process is gone. So...

> Furthermore, I would argue that blkverify actually expects the formatted
> image to sometimes differ from the raw image, if anything, because the
> format driver is to be tested.  This is the reason why I chose x-raw to
> be the filtered child.

...I don't think this case is relevant. If blkverify returns something,
both children have the same data.

> So there is no general instruction on what to do in such cases that I
> followed here, I specifically chose one child based on what blkverify is
> and what it=E2=80=99s supposed to do.  Therefore, I can=E2=80=99t really =
give a general
> instruction on =E2=80=9Cwhat needs to be done in such cases=E2=80=9D.

Maybe the missing part for me is what FILTERED is even used for. I
assume it's for skipping over filters in certain functions in the
generic block layer?

In this case, maybe the right answer is that...

> > For blkverify, both
> > children are not equal in intention, so I guess the "real" filtered
> > child is x-image. But for quorum, you can't make any such distinction. =
I
> > assume the recommendation should be not to set FILTERED for any child
> > then.
>=20
> Quorum just isn=E2=80=99t a filter driver.

...blkverify isn't one either because performing an operation on only
one child usually won't be correct.

> > Looking at the final code... Hm, your choice looks quite different: You
> > don't have DATA for x-raw, but you make it the PRIMARY and FILTERED
> > child. I think PRIMARY/FILTERED is just a bug (e.g. getlength and flush
> > being forwarded only to x-image show that it's primary).
>=20
> I rather consider getlength() a special case.  Ideally, we=E2=80=99d forw=
ard
> getlength() to both and compare the results; however, image formats
> might have different size resolution than raw files, so there could be a
> difference, but it=E2=80=99d be irrelevant.
>=20
> It makes then sense to forward it to the formatted image, because
> generally formats have byte resolution for the disk size, whereas for
> raw files it depends on caching and the filesystem, I think.
>=20
> As for flush, yes, why do we forward it only to x-image?  Why is =E2=80=
=9Cthe
> raw file not important=E2=80=9D?

Because it's the copy that is used to check whether the main image is
correct. If things break, you just create a new copy. At least that's
how blkverify was supposed to be used.

In fact, I guess in the typical use cases for blkverify, cache=3Dunsafe is
enough anyway because you would start over from scratch, so... not a
strong argument.

> > I do wonder
> > whether I have a different interpretation of DATA than you, though.
>=20
> I never set DATA for FILTERED, because I consider FILTERED to be
> stronger than DATA, so once FILTERED is set, it doesn=E2=80=99t matter wh=
ether
> DATA is set or not.  I suppose that should either be mentioned in the
> documentation, or we decide that we should always set DATA regardless.

Either option should be fine. I guess documenting it is less work.

> > Also, the comparison makes me wonder whether FILTERED always implies
> > PRIMARY? Would there ever be a scenario where a child is FILTERED, but
> > not PRIMARY?
>=20
> I don=E2=80=99t know.  I suppose it does.  But what=E2=80=99s the implica=
tion?

*shrug* I was just asking to see if I understand things right. We could
document it, but I don't have a good reason why we must do that.

Maybe the more relevant question would be if a FILTERED child must be
the only child to avoid the problems we're discussing for blkverify. But
I think I already answered that question for myself with "no", so
probably not much use asking it.

Kevin

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6xYfUACgkQfwmycsiP
L9aKjg//Sr1BEkpy0FNbWu1tRvmWgMPbYpLRepN1fhrC7ASLap3YzM5nY6Kzikfy
AJApXXQ66Q8N21rsFCRR4EzITR6CL7sIdreyAfIPT0v9Gdszx3C/IlDzfezdtMHL
bTEDtzRO7xvfVrXZk+z6+0e4QIHq3y9phXamI+d19ebOefUcuB2CM4v2+wQtBamX
3codwfmrvWeXgMCYzJ3HW6O7ZftR2NfQQuaHfUmhQg9uVodwvW/yT/lH0h/RTib5
t/ANU0n+9Cgyqm/og9MBPbv1F67XeZ6XoEwq6VH/DWtBLDB7l89EAhAcbAiFD3F5
XAm0mEr+DGvnQYJB/cpam+XWI32Xe/X2IsQ/I7Sy/Vb74k5jKsXAUSS0JWuzu4Yv
tx++YUjdafyvolvM4CLE65o3vv9hr5JQ9oGUfa/78eg1iQbCZ8+CpP7gZQTGotFi
xVLxAVSpsJAkC0e9CuEjJVN4Ouc4EOYypVlI547uQ2dUn3ZpiRAr3hroGEezUIqj
HpBZguNNJIZQUp9c9Yow9fPae+AKXcnvxzAERKD5uDSIDZMpPLGvY6pgzZll8POK
d8S3Cy50Q4UjX9z7sqArw6zLgTyOWcADEq3+cHBWmCzF541QX+k3FuqiUe2qCRq8
rARd2aYenilAl5sPGEa1br5fr8psZMlg08pdV7v/pKNLMohLzDM=
=IB7t
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--


