Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D40C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDB8206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyQnvHwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDB8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAD9F-00050C-IB
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAD8W-0004Xn-Dh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAD8U-0007zk-32
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598278064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3pQ85GE5ZcSA2p29exgQZP9v0/Jvy+WLgE0ff/3LgXY=;
 b=FyQnvHwCF2VBgDZxWf9FGgX0OAEn/n2EINCXb/6RE/xlHET2xjLCOqbgPJXSo4NLDigZsI
 R07jzZ3rNAYrgeku8WdgEdYJBE6vAGM7DNy+awUG2HaFfbsQdN099po0gd2PESvZdxBOKV
 TbFmu51SKTTiF3Cdw8pFhKyM7lG4MWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224--U7UqJc9N7SUdcOhGlvvqw-1; Mon, 24 Aug 2020 10:07:42 -0400
X-MC-Unique: -U7UqJc9N7SUdcOhGlvvqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8381B807336;
 Mon, 24 Aug 2020 14:07:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8831762A2D;
 Mon, 24 Aug 2020 14:07:40 +0000 (UTC)
Date: Mon, 24 Aug 2020 16:07:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 39/47] blockdev: Fix active commit choice
Message-ID: <20200824140739.GB10708@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-40-mreitz@redhat.com>
 <20200821155011.GA26691@linux.fritz.box>
 <74e6ed51-d610-0982-d265-c8168b5f958c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <74e6ed51-d610-0982-d265-c8168b5f958c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.08.2020 um 15:18 hat Max Reitz geschrieben:
> On 21.08.20 17:50, Kevin Wolf wrote:
> > Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> >> We have to perform an active commit whenever the top node has a parent
> >> that has taken the WRITE permission on it.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>  blockdev.c | 24 +++++++++++++++++++++---
> >>  1 file changed, 21 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/blockdev.c b/blockdev.c
> >> index 402f1d1df1..237fffbe53 100644
> >> --- a/blockdev.c
> >> +++ b/blockdev.c
> >> @@ -2589,6 +2589,7 @@ void qmp_block_commit(bool has_job_id, const cha=
r *job_id, const char *device,
> >>      AioContext *aio_context;
> >>      Error *local_err =3D NULL;
> >>      int job_flags =3D JOB_DEFAULT;
> >> +    uint64_t top_perm, top_shared;
> >> =20
> >>      if (!has_speed) {
> >>          speed =3D 0;
> >> @@ -2704,14 +2705,31 @@ void qmp_block_commit(bool has_job_id, const c=
har *job_id, const char *device,
> >>          goto out;
> >>      }
> >> =20
> >> -    if (top_bs =3D=3D bs) {
> >> +    /*
> >> +     * Active commit is required if and only if someone has taken a
> >> +     * WRITE permission on the top node.
> >=20
> > ...or if someone wants to take a WRITE permission while the job is
> > running.
> >=20
> > Future intentions of the user is something that we can't know, so maybe
> > this should become an option in the future (not in this series, of
> > course).
> >=20
> >>                                            Historically, we have alway=
s
> >> +     * used active commit for top nodes, so continue that practice.
> >> +     * (Active commit is never really wrong.)
> >> +     */
> >=20
> > Changing the practice would break compatibility with clients that start
> > an active commit job and then attach it to a read-write device, so we
> > must continue the practice. I think the comment should be clearer about
> > this, it sounds more like "no reason, but why not".
>=20
> I think that=E2=80=99s what I meant by =E2=80=9Chistorically=E2=80=9D.  I=
s =E2=80=9Clegacily=E2=80=9D a word?
>=20
> But sure, I can make it more explicit.
>=20
> > This is even more problematic because the commit job doesn't unshare
> > BLK_PERM_WRITE yet, so it would lead to silent corruption rather than a=
n
> > error.
> >=20
> >> +    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
> >> +    if (top_perm & BLK_PERM_WRITE ||
> >> +        bdrv_skip_filters(top_bs) =3D=3D bdrv_skip_filters(bs))
> >> +    {
> >>          if (has_backing_file) {
> >>              error_setg(errp, "'backing-file' specified,"
> >>                               " but 'top' is the active layer");
> >=20
> > Hm, this error message isn't accurate any more.
> >=20
> > In fact, the implementation isn't consistent with the QAPI documentatio=
n
> > any more, because backing-file is only an error for the top level.
>=20
> Hm.  I wanted to agree, and then I wanted to come up with a QAPI
> documentation that fits the new behavior (because I think it makes more
> sense to change the QAPI documentation along with the behavior change,
> rather than to force us to allow backing-file for anything that isn=E2=80=
=99t on
> the top layer).
>=20
> But in the process of coming up with a better description, I noticed
> that this doesn=E2=80=99t say =E2=80=9Cis a root node=E2=80=9D, it says =
=E2=80=9Cis the active layer=E2=80=9D.
> I would say a node in the active layer is a node that has some parent
> that has taken a WRITE permission on it.  So actually I think that the
> documentation is right, and this code only now fits.

Then you may have not only "the" active layer, but multiple active
layers. I find this a bit counterintuitive.

There is a simple reason why backing-file is an error for a root node:
It doesn't have overlays, so a value to write to the header of overlay
images just doesn't make sense.

The same reasoning doesn't apply for writable images that do have
overlays. Forbidding backing-file is a more arbitrary restriction there.
I'm not saying that we can't make arbitrary restrictions where allowing
an option is not worth the effort, but I feel they should be spelt out
more explicitly instead of twisting words like "active layer" until they
fit the code.

> Though I do think this wants for some clarification.  Perhaps =E2=80=9CIf=
 'top'
> is the active layer (i.e., is a node that may be written to), specifying
> a backing [...]=E2=80=9D?

"If 'top' doesn't have an overlay image or is in use by a writer..."?

> There=E2=80=99s more wrong with the specification, namely the whole part =
under
> @backing-file past the =E2=80=9C(Since 2.1)=E2=80=9D, starting with =E2=
=80=9CIf top =3D=3D base=E2=80=9D.  I
> think all of that should go to the top level.  (And =E2=80=9CIf top =3D=
=3D active=E2=80=9D
> should be changed to =E2=80=9CIf top is active (i.e., may be written to)=
=E2=80=9D.)

At least the latter only becomes wrong with this patch, so I think it
needs to be changed by this patch.

Kevin

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9DyaoACgkQfwmycsiP
L9bnbRAAjEC7LKdHmOn6UYsx0ApxiRgSL/pyxanrZP4Zgzkgf6BKkl6caPWcPxlg
RgPbJzvPvAmvH35unOeTV+NNsmh8EMQEyhGQRPwtVsK7Ln+u41Le7jLwsYP0++Op
iD6eVJO3+Fjf1mL50FvCkp9mznnudWp93S1npxhsIuiCLODXkFocRV10iMldfXWi
lIP2ZQH5UM+HpYpiA2AhlHTEMu8GkEnEFOkT3zURWHvFhGi/o/gSu7vIohvWKVpe
ztNY0P6p7MPjzXkqtp/i3bFMOC1rHO3qLkjw+mJzz1GGVH9IAol9hNHrqB/Et5w3
+B9ad77nL7O3Sa6ylEkBM0dM7RB3JHp7mOm4a9yxFoOnmZ71/S9/8OvSc+WYdtss
df+76J8iwsoT672KhVYhstVGl5nX9A3VQP3k2Sg7ywzzaD7UhMu8/V4fpv73zQZE
OZYPDrGnoSMzI+iEJOYBPe0LnlYnbSWj+EOH2PqtrStsdMPyB8bhKIB8I0kdpj1X
Md5qpA0q9LocOndXCZsz2rgUYKSiq5q7ZWEug/XQ/jBvEbntStvc/hx4jp7MN+dJ
vsMQzaf/51JpGLY9ETkQIZyqmGXEwu9c1mcs6clGUKytLnsXKcIJluaj1KAqee/l
JxM5pIhZUTKBpjDP/UDTZv9EyyPsWVkgxupRsTDChCFVfVu0L8s=
=nrZi
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


