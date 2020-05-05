Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197FC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9963206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMRZeNme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9963206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvcl-0001AD-RN
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVvc3-0000aS-Cg
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:19:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVvbz-0004A2-Nq
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588677582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjA1A6gbFIRLpWJa6c9RKkIjF/tzSucVgtc4+xTpJ3o=;
 b=EMRZeNmethtZuMsyeA4w9v/zNR/xo0nB6HK7Tl6EhiLMch5sOnNTBurFX0fdOcyoPLSHNg
 YG5kcM4PdnJLbMz7GHaEl4MUANWSqAZTljz/1vQxYUWV7X5UuxdcR1sc3xGRturApMmFKU
 uYIG3aO+w+z2ze/gKHXNowpFrK/rCTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-oS_aCksnOWG8p8Ln4rGw6Q-1; Tue, 05 May 2020 07:19:40 -0400
X-MC-Unique: oS_aCksnOWG8p8Ln4rGw6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3392E100CCC9;
 Tue,  5 May 2020 11:19:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DF6970540;
 Tue,  5 May 2020 11:19:37 +0000 (UTC)
Date: Tue, 5 May 2020 13:19:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 03/33] block: Add BdrvChildRole and BdrvChildRoleBits
Message-ID: <20200505111936.GJ5759@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-4-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-4-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> This mask will supplement BdrvChildClass when it comes to what role (or
> combination of roles) a child takes for its parent.  It consists of
> BdrvChildRoleBits values (which is an enum).
>=20
> Because empty enums are not allowed, let us just start with it filled.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index fd89eb6c75..8c23948d08 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -268,6 +268,44 @@ enum {
>      DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHR=
OUGH,
>  };
> =20
> +enum BdrvChildRoleBits {
> +    /* Child stores data */
> +    BDRV_CHILD_DATA         =3D (1 << 0),
> +
> +    /* Child stores metadata */
> +    BDRV_CHILD_METADATA     =3D (1 << 1),
> +
> +    /*
> +     * A child to which the parent forwards all reads and writes.  It

Is "_all_ reads and writes" really required? Imagine a caching block
driver, should it not be considered a filter because it may just
complete the requests from its cache rather than asking the child?

> +     * must present exactly the same visible data as the parent.
> +     * Any node may have at most one filtered child at a time.
> +     */
> +    BDRV_CHILD_FILTERED     =3D (1 << 2),
> +
> +    /*
> +     * Child from which to read all data that isn=E2=80=99t allocated in=
 the
> +     * parent (i.e., the backing child); such data is copied to the
> +     * parent through COW (and optionally COR).
> +     */
> +    BDRV_CHILD_COW          =3D (1 << 3),
> +
> +    /*
> +     * The primary child.  For most drivers, this is the child whose
> +     * filename applies best to the parent node.
> +     * Each parent must give this flag to no more than one child at a
> +     * time.
> +     */
> +    BDRV_CHILD_PRIMARY      =3D (1 << 4),

And I assume some drivers like quorum don't set it on any child.

> +    /* Useful combination of flags */
> +    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
> +                              | BDRV_CHILD_METADATA
> +                              | BDRV_CHILD_PRIMARY,
> +};
> +
> +/* Mask of BdrvChildRoleBits values */
> +typedef unsigned int BdrvChildRole;
> +
>  char *bdrv_perm_names(uint64_t perm);
>  uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);

The list intuitively makes sense to me. Let me try to think of some
interesting cases to see whether the documentation is complete or
whether it could be improved.


qcow2 is what everyone has in mind, so it should be obvious:

* Without a data file:
  * file: BDRV_CHILD_IMAGE
  * backing: BDRV_CHILD_COW

* With a data file:
  * file: BDRV_CHILD_PRIMARY | BDRV_CHILD_METADATA
  * data-file: BDRV_CHILD_DATA
  * backing: BDRV_CHILD_COW


We can use VMDK to make things a bit more interesting:

* file: BDRV_CHILD_PRIMARY | BDRV_CHILD_METADATA
* extents.*: BDRV_CHILD_METADATA | BDRV_CHILD_DATA
* backing: BDRV_CHILD_COW

In other words, we can have multiple data and metadata children. Is this
correct or should extents not be marked as metadata? (Checked the final
code: yes we do have multiple of them in vmdk.) Should this be mentioned
in the documentation?

Do we then also want to allow multiple BDRV_CHILD_COW children? We don't
currently have a driver that needs it, but maybe it would be consistent
with DATA and METADATA then. However, it would contradict the
documentation that it's the "Child from which to read all data".


blkverify:

* x-image: BDRV_CHILD_PRIMARY | BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
* x-raw: BDRV_CHILD_DATA | BDRV_CHILD_FILTERED

Hm, according to the documentation, this doesn't work, FILTERED can be
set only for one node. But the condition ("the parent forwards all reads
and writes") applies to both children. I think the documentation should
mention what needs to be done in such cases. For blkverify, both
children are not equal in intention, so I guess the "real" filtered
child is x-image. But for quorum, you can't make any such distinction. I
assume the recommendation should be not to set FILTERED for any child
then.

Looking at the final code... Hm, your choice looks quite different: You
don't have DATA for x-raw, but you make it the PRIMARY and FILTERED
child. I think PRIMARY/FILTERED is just a bug (e.g. getlength and flush
being forwarded only to x-image show that it's primary). I do wonder
whether I have a different interpretation of DATA than you, though.

Also, the comparison makes me wonder whether FILTERED always implies
PRIMARY? Would there ever be a scenario where a child is FILTERED, but
not PRIMARY?


So I'm not completely sure if I understand the roles correctly, but I
guess my understanding is good enough to continue with the rest of the
series.

Kevin


