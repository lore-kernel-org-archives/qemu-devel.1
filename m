Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B68BC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9D320663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUjeqmZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9D320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWHRG-0006Yq-0i
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWHQf-00063t-G8
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:37:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWHQe-0007mb-Dv
 for qemu-devel@nongnu.org; Wed, 06 May 2020 06:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588761447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZH2Jzjrd2COQQn9MkT54G2ZB9T9G10Aabepdp5D33E=;
 b=GUjeqmZdZWGywiAXtm8wAPD7lNn9ZOVn7rZf21cvZCZ8AI2muFW2/p6xv/beW18ypiRM/P
 UrEi5+5opCKZmuqUdX850D0KVpD+wkYOvwpKiS6A9Kbmn6Y0iY+xsfA4ma3RoGbYfYbmzn
 RBQoKIiERPymvNbZursoKn3bR6dXbEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-U0Up68PhPhasWxEEWMVrxQ-1; Wed, 06 May 2020 06:37:25 -0400
X-MC-Unique: U0Up68PhPhasWxEEWMVrxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4ABB8018A1;
 Wed,  6 May 2020 10:37:24 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B44995C1D4;
 Wed,  6 May 2020 10:37:23 +0000 (UTC)
Date: Wed, 6 May 2020 12:37:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
Message-ID: <20200506103722.GB6333@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-10-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-10-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> After the series this patch belongs to, we want to have a common
> BdrvChildClass that encompasses all of child_file, child_format, and
> child_backing.  Such a single class needs a single .inherit_options()
> implementation, and this patch introduces it.
>=20
> The next patch will show how the existing implementations can fall back
> to it just by passing appropriate BdrvChildRole and parent_is_format
> values.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index c33f0e9b42..9179b9b604 100644
> --- a/block.c
> +++ b/block.c
> @@ -998,6 +998,90 @@ static void bdrv_temp_snapshot_options(int *child_fl=
ags, QDict *child_options,
>      *child_flags &=3D ~BDRV_O_NATIVE_AIO;
>  }
> =20
> +/*
> + * Returns the options and flags that a generic child of a BDS should
> + * get, based on the given options and flags for the parent BDS.
> + */
> +static void __attribute__((unused))
> +    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
> +                           int *child_flags, QDict *child_options,
> +                           int parent_flags, QDict *parent_options)
> +{
> +    int flags =3D parent_flags;
> +
> +    /*
> +     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
> +     * Generally, the question to answer is: Should this child be
> +     * format-probed by default?
> +     */
> +
> +    /*
> +     * Pure and non-filtered data children of non-format nodes should
> +     * be probed by default (even when the node itself has BDRV_O_PROTOC=
OL
> +     * set).  This only affects a very limited set of drivers (namely
> +     * quorum and blkverify when this comment was written).
> +     * Force-clear BDRV_O_PROTOCOL then.
> +     */
> +    if (!parent_is_format &&
> +        (role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
> +                 BDRV_CHILD_FILTERED)) =3D=3D
> +            BDRV_CHILD_DATA)

You could avoid the odd indentation (I can't decide whether or not it
should be one space more to align correctly) and probably also make the
expression more readable if you split it into:

    (role & BDRV_CHILD_DATA) &&
    !(role & (BDRV_CHILD_METADATA | BDRV_CHILD_FILTERED))

> +    {
> +        flags &=3D ~BDRV_O_PROTOCOL;
> +    }
> +
> +    /*
> +     * All children of format nodes (except for COW children) and all
> +     * metadata children in general should never be format-probed.
> +     * Force-set BDRV_O_PROTOCOL then.
> +     */
> +    if ((parent_is_format && !(role & BDRV_CHILD_COW)) ||
> +        (role & BDRV_CHILD_METADATA))
> +    {
> +        flags |=3D BDRV_O_PROTOCOL;
> +    }
> +
> +    /*
> +     * If the cache mode isn't explicitly set, inherit direct and no-flu=
sh from
> +     * the parent.
> +     */
> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIR=
ECT);
> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_=
FLUSH);
> +    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHA=
RE);
> +
> +    if (role & BDRV_CHILD_COW) {
> +        /* backing files are always opened read-only */

Not "always", just by default.

> +        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
> +        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "o=
ff");
> +    } else {
> +        /* Inherit the read-only option from the parent if it's not set =
*/
> +        qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_=
ONLY);
> +        qdict_copy_default(child_options, parent_options,
> +                           BDRV_OPT_AUTO_READ_ONLY);
> +    }
> +
> +    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
> +        /*
> +         * Our format drivers take care to send flushes and respect
> +         * unmap policy, so we can default to enable both on lower
> +         * layers regardless of the corresponding parent options.
> +         */
> +        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
> +    }

Why the restriction to format here? Don't we break "unmap" propagation
through filters with this?

It would probably also be a good question why we don't propagate it to
the backing file, but this is preexisting.

> +    /* Clear flags that only apply to the top layer */
> +    flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_RE=
AD);
> +
> +    if (role & BDRV_CHILD_METADATA) {
> +        flags &=3D ~BDRV_O_NO_IO;
> +    }

Hm... This is interesting, but I guess it makes sense. It just never was
a hard rule that a format driver must not access data even internally
with NO_IO, but I think it holds true.

> +    if (role & BDRV_CHILD_COW) {
> +        flags &=3D ~BDRV_O_TEMPORARY;
> +    }

We could probably have a long discussion about whether this is right in
theory, but in practice BDRV_O_TEMPORARY only exists for snapshot=3Don,
for which we know that it's always qcow2 with a file and a backing
child. And there is no doubt that we make the right distinction in this
case.

> +    *child_flags =3D flags;
> +}
> +
>  /*
>   * Returns the options and flags that bs->file should get if a protocol =
driver
>   * is expected, based on the given options and flags for the parent BDS
> --=20
> 2.24.1

Kevin


