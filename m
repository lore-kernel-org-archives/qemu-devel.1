Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC3BC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B5B2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeI681sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B5B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGj9H-0003W9-Oa
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jGj8Z-0002Li-CR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jGj8X-0000Pk-W2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:58:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jGj8X-0000PO-SZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585054709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWoxJwkSaxdZJFzu2c9akVSWs0RILOzoA63VYFffJlQ=;
 b=LeI681sO5TgWx1acQzcVuCxZLu6RweQVqXiEVAICAzivjElZib7VcOWxqyrpK/hFtY8xAp
 4PYJoRSlU1ZUBCzYT18hT2x3OA8mNPuXyF1987L2PysPO7whPsWCaruNS7tdxI8oj0LjfI
 o3BH91vPjPtlAs+BqcwTU/dFrBAXh2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-D-W_7vCQOPid7B7ezRf_Vw-1; Tue, 24 Mar 2020 08:58:27 -0400
X-MC-Unique: D-W_7vCQOPid7B7ezRf_Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A98B51005510;
 Tue, 24 Mar 2020 12:58:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-119.ams2.redhat.com [10.36.113.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85C411001B3F;
 Tue, 24 Mar 2020 12:58:25 +0000 (UTC)
Date: Tue, 24 Mar 2020 13:58:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: Potential Null dereference
Message-ID: <20200324125824.GH5417@linux.fritz.box>
References: <CAGT9xrCJSy6yQ48p3hCRuwgV7t8vPS7eo+83_pOiPp0gDOfvvQ@mail.gmail.com>
 <336bbdf8-140a-e884-d5d1-0610a9b1c6a6@redhat.com>
 <20200324095056.GD5417@linux.fritz.box>
 <b432626a-49c9-255e-5e26-b296490a52cd@virtuozzo.com>
 <c99b61b9-08eb-92cc-5590-e28076b23e43@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <c99b61b9-08eb-92cc-5590-e28076b23e43@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Mansour Ahmadi <ManSoSec@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.03.2020 um 13:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 24.03.2020 14:59, Vladimir Sementsov-Ogievskiy wrote:
> > Aha, new crashes! Let's look at them.
> >=20
> > 41 and 155 failed with crash, 141 without but I see "+{"error": {"class=
": "GenericError", "desc": "Block device drv0 is in use"}}" in its output.
> >=20
> > Hmm, but all crashes are because of assert(QTAILQ_EMPTY(&all_bdrv_state=
s)); in bdrv_close_all..
> >=20
> > So, we have a problem, but another one..
>=20
> Investigate it a bit more.
>=20
> Accordingly to comment, bdrv_attach_child unrefs child bs even on failure=
, so let's do
>=20
> --- a/block.c
> +++ b/block.c
> @@ -2768,6 +2768,7 @@ void bdrv_set_backing_hd_ex(BlockDriverState *bs, B=
lockDriverState *backing_hd,
>=20
>      if (bdrv_attach_child_fail) {
>          bs->backing =3D NULL;
> +        bdrv_unref(backing_hd);
>          error_setg(errp, "Unpredicted failure :)");
>      } else {
>          bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &ch=
ild_backing,
>=20
>=20
> - then, all three tests fails, but without crashes. OK.
>=20
> The only interesting thing is that, it seems that bdrv_attach_child doesn=
't unref child on all failure paths.
>=20
> It calls bdrv_root_attach_child..
>=20
> which doesn't unref child on the path
>=20
> if (bdrv_get_aio_context(child_bs) !=3D ctx) {
>   ...
>    if (ret < 0) {
>          error_propagate(errp, local_err);
>          g_free(child);
>          bdrv_abort_perm_update(child_bs);
>          return NULL;
>    }
> }
>=20
> or am I wrong?

I think you're right, we need a bdrv_unref() there. The function comment
makes it clear that bdrv_root_attach_child() is supposed to consume the
reference both in success and error cases.

Kevin


