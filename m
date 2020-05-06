Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3D6C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640DB2073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c00J7V91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640DB2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJqZ-0001Nb-Go
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWJpv-0000sZ-M9
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:11:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57800
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWJpu-0002p2-7n
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588770700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8V3F7RZOxA1axkeye5I1e1zVTinceLbaUd7q8zYexc=;
 b=c00J7V915ztvDlHDx9admSgP+GUxAzShAWqtwphWzz48XrksTAwJtVybQCsdxvtPDdGvEp
 l3Zx3RkTM4KyxJ9q/UFLzVgPf0etudR2uZTyEsagyMRqrIeG7t7cqJS7ZInyWsiRGYQ28k
 Fx1VKe7qoqWQVvpgJZUAvMsFwfSA1Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-qiwACL9MMFic9QTv3QDzdg-1; Wed, 06 May 2020 09:11:38 -0400
X-MC-Unique: qiwACL9MMFic9QTv3QDzdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA246108BD1C;
 Wed,  6 May 2020 13:11:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDA6310021B3;
 Wed,  6 May 2020 13:11:36 +0000 (UTC)
Date: Wed, 6 May 2020 15:11:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
Message-ID: <20200506131135.GE6333@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-10-mreitz@redhat.com>
 <20200506103722.GB6333@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200506103722.GB6333@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Am 06.05.2020 um 12:37 hat Kevin Wolf geschrieben:
> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> > After the series this patch belongs to, we want to have a common
> > BdrvChildClass that encompasses all of child_file, child_format, and
> > child_backing.  Such a single class needs a single .inherit_options()
> > implementation, and this patch introduces it.
> >=20
> > The next patch will show how the existing implementations can fall back
> > to it just by passing appropriate BdrvChildRole and parent_is_format
> > values.
> >=20
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
> >  block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >=20
> > diff --git a/block.c b/block.c
> > index c33f0e9b42..9179b9b604 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -998,6 +998,90 @@ static void bdrv_temp_snapshot_options(int *child_=
flags, QDict *child_options,
> >      *child_flags &=3D ~BDRV_O_NATIVE_AIO;
> >  }
> > =20
> > +/*
> > + * Returns the options and flags that a generic child of a BDS should
> > + * get, based on the given options and flags for the parent BDS.
> > + */
> > +static void __attribute__((unused))
> > +    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
> > +                           int *child_flags, QDict *child_options,
> > +                           int parent_flags, QDict *parent_options)
> > +{
> > +    int flags =3D parent_flags;
> > +
> > +    /*
> > +     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
> > +     * Generally, the question to answer is: Should this child be
> > +     * format-probed by default?
> > +     */

Just for clarity: Do you know a good reason to ever leave it (i.e.
inherit it from the parent), except that that's what we have always been
doing for backing files? Though of course, only formats have backing
files, so the flag would never be set in practice in this case.

> > +    /*
> > +     * Pure and non-filtered data children of non-format nodes should
> > +     * be probed by default (even when the node itself has BDRV_O_PROT=
OCOL
> > +     * set).  This only affects a very limited set of drivers (namely
> > +     * quorum and blkverify when this comment was written).
> > +     * Force-clear BDRV_O_PROTOCOL then.
> > +     */
> > +    if (!parent_is_format &&
> > +        (role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
> > +                 BDRV_CHILD_FILTERED)) =3D=3D
> > +            BDRV_CHILD_DATA)
>=20
> You could avoid the odd indentation (I can't decide whether or not it
> should be one space more to align correctly) and probably also make the
> expression more readable if you split it into:
>=20
>     (role & BDRV_CHILD_DATA) &&
>     !(role & (BDRV_CHILD_METADATA | BDRV_CHILD_FILTERED))
>=20
> > +    {
> > +        flags &=3D ~BDRV_O_PROTOCOL;
> > +    }
> > +
> > +    /*
> > +     * All children of format nodes (except for COW children) and all
> > +     * metadata children in general should never be format-probed.
> > +     * Force-set BDRV_O_PROTOCOL then.
> > +     */
> > +    if ((parent_is_format && !(role & BDRV_CHILD_COW)) ||
> > +        (role & BDRV_CHILD_METADATA))
> > +    {
> > +        flags |=3D BDRV_O_PROTOCOL;
> > +    }
> > +
> > +    /*
> > +     * If the cache mode isn't explicitly set, inherit direct and no-f=
lush from
> > +     * the parent.
> > +     */
> > +    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_D=
IRECT);
> > +    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_N=
O_FLUSH);
> > +    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_S=
HARE);
> > +
> > +    if (role & BDRV_CHILD_COW) {
> > +        /* backing files are always opened read-only */
>=20
> Not "always", just by default.
>=20
> > +        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on")=
;
> > +        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, =
"off");
> > +    } else {
> > +        /* Inherit the read-only option from the parent if it's not se=
t */
> > +        qdict_copy_default(child_options, parent_options, BDRV_OPT_REA=
D_ONLY);
> > +        qdict_copy_default(child_options, parent_options,
> > +                           BDRV_OPT_AUTO_READ_ONLY);
> > +    }
> > +
> > +    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
> > +        /*
> > +         * Our format drivers take care to send flushes and respect
> > +         * unmap policy, so we can default to enable both on lower
> > +         * layers regardless of the corresponding parent options.
> > +         */
> > +        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap"=
);
> > +    }
>=20
> Why the restriction to format here? Don't we break "unmap" propagation
> through filters with this?
>=20
> It would probably also be a good question why we don't propagate it to
> the backing file, but this is preexisting.

Some patches later, I think the fix is an else branch that copies the
flag from parent_options.

Kevin


