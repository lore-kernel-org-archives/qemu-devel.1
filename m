Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895FFC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A2321741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 15:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a83Nf4fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaLPl-0005C4-H5
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 10:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iaKXJ-0001dj-1y
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iaKWy-00060z-7T
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:12:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iaKWx-0005cE-RK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 09:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574950343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCdFFAGqgMwV85fIMPgikuTLpGOeyP5t/aaUax7dNPQ=;
 b=a83Nf4fT1iLyNjHkPAHZFta5svvE0dvnByjqftHoq5kMfSxmieeUN937gd66i04WI4i9Qc
 PwV+i/tljMfR4X2t+ukhfdL+cHUhstqyn+lGcjjMPOFlEXR1wxIanuhO1fO5IlcKj6WoUR
 1PQDTFrFk6kWidaf6nmva7jFcK/1Hdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-NZkHJEYWOCqT8Qs13ps2iQ-1; Thu, 28 Nov 2019 09:12:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 952ED10054E3;
 Thu, 28 Nov 2019 14:12:20 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-95.ams2.redhat.com [10.36.117.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB7F6600C8;
 Thu, 28 Nov 2019 14:12:19 +0000 (UTC)
Date: Thu, 28 Nov 2019 15:12:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 02/31] block: Add BdrvChildRole
Message-ID: <20191128141218.GA4944@linux.fritz.box>
References: <20191127131624.1062403-1-mreitz@redhat.com>
 <20191127131624.1062403-3-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127131624.1062403-3-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NZkHJEYWOCqT8Qs13ps2iQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.11.2019 um 14:15 hat Max Reitz geschrieben:
> This enum will supplement BdrvChildClass when it comes to what role (or
> combination of roles) a child takes for its parent.
>=20
> Because empty enums are not allowed, let us just start with it filled.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 38963ef203..36817d5689 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -279,6 +279,44 @@ enum {
>      DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHR=
OUGH,
>  };
> =20
> +typedef enum BdrvChildRole {
> +    /*
> +     * If present, bdrv_replace_node() will not change the node this
> +     * BdrvChild points to.
> +     */
> +    BDRV_CHILD_STAY_AT_NODE =3D (1 << 0),
> +
> +    /* Child stores data */
> +    BDRV_CHILD_DATA         =3D (1 << 1),
> +
> +    /* Child stores metadata */
> +    BDRV_CHILD_METADATA     =3D (1 << 2),
> +
> +    /* Filtered child */
> +    BDRV_CHILD_FILTERED     =3D (1 << 3),
> +
> +    /* Child to COW from (backing child) */
> +    BDRV_CHILD_COW          =3D (1 << 4),
> +
> +    /* Child is expected to be a protocol node */
> +    BDRV_CHILD_PROTOCOL     =3D (1 << 5),
> +
> +    /* Child is expected to be a format node */
> +    BDRV_CHILD_FORMAT       =3D (1 << 6),

In theory, a node shouldn't care what other nodes it has as its
children. For a parent, protocols and formats look exactly the same.

Of course, we do have BDRV_O_PROTOCOL, but if I'm not mistaken this is
basically only about probing or not probing an image format when a
legacy filename is given rather than BlockdevOptions.

Therefore, unless you have a real reason for this to be here, I'd prefer
if we could keep such legacy flags outside of the core infrastructure if
at all possible.

> +    /*
> +     * The primary child.  For most drivers, this is the child whose
> +     * filename applies best to the parent node.
> +     */
> +    BDRV_CHILD_PRIMARY      =3D (1 << 7),

If primary is a flag of each BdrvChild, then you could end up having
multiple children that claim that they're the primary child. On the
other hand, if we have a bs->primary_child instead to make sure that we
only have one primary child, we'd have to keep this consistent when
children change.

So maybe just document that this flag must be given to only one
BdrvChild link for each parent.

> +    /* Useful combination of flags */
> +    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
> +                              | BDRV_CHILD_METADATA
> +                              | BDRV_CHILD_PROTOCOL
> +                              | BDRV_CHILD_PRIMARY,
> +} BdrvChildRole;
> +
>  char *bdrv_perm_names(uint64_t perm);
>  uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);

Kevin


