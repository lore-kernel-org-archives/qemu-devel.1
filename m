Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8325DC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE2D21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZPo+m0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE2D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihViF-0004VE-Hk
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 04:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihVhW-0003wJ-9S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihVhS-0001EM-O8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:32:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihVhS-00018i-7K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576661577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfoRo5KRxYSKs9LinVK0+21c+9/p5zdHPvKdelxjoX8=;
 b=AZPo+m0nxDO+8gePy5fjjswanhtyauTG3P9JHtI0ak6WBzTnhk4CgaQ8k+7E6oeJJk1NIh
 iS+n+7fT0+wXSgNYvjmkTCfea9PJsDD+v/vLImkUhakZMWHtrzJwEoXbxebCmENzoxW8pY
 4qwsw5ukUGikjfm5lOnbQ9uK/Igo9U8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-srk2Q29lPk6vGKK87eSMTQ-1; Wed, 18 Dec 2019 04:32:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1945940D8;
 Wed, 18 Dec 2019 09:32:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B55C68889;
 Wed, 18 Dec 2019 09:32:53 +0000 (UTC)
Date: Wed, 18 Dec 2019 10:32:52 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Tuguoyi <tu.guoyi@h3c.com>
Subject: Re: [PATCH] qcow2: Move error check of local_err near its assignment
Message-ID: <20191218093252.GB4632@linux.fritz.box>
References: <c9d3fc7246ec4c1f9a6cde9ed3c3ae57@h3c.com>
MIME-Version: 1.0
In-Reply-To: <c9d3fc7246ec4c1f9a6cde9ed3c3ae57@h3c.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: srk2Q29lPk6vGKK87eSMTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: vsementsov@virtuozzo.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 03:26 hat Tuguoyi geschrieben:
>=20
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>

Empty commit messages are rarely acceptable. You should explain here
why you are making the change and why it's correct (for example by
comparing with when it was introduced).

In this case, the local_err check outside of the if block was necessary
when it was introduced in commit d1258dd0c87 because it needed to be
executed even if qcow2_load_autoloading_dirty_bitmaps() returned false.

After some modifications that all required the error check to remain
where it is, commit 9c98f145dfb finally moved the
qcow2_load_dirty_bitmaps() call into the if block, so now the error
check should be there, too.

This is information that should be in the commit message rather than
requiring each reader to do the research.

Please also make sure to CC the author of the code that you're
modifying, in this case Vladimir.

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7c18721..ce3db29 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1705,14 +1705,14 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
>      if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>          /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management laye=
r. */
>          bool header_updated =3D qcow2_load_dirty_bitmaps(bs, &local_err)=
;
> +        if (local_err !=3D NULL) {
> +            error_propagate(errp, local_err);
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }
> =20
>          update_header =3D update_header && !header_updated;
>      }
> -    if (local_err !=3D NULL) {
> -        error_propagate(errp, local_err);
> -        ret =3D -EINVAL;
> -        goto fail;
> -    }
> =20
>      if (update_header) {
>          ret =3D qcow2_update_header(bs);

The change itself looks good to me, but I'll let Vladimir have a look as
well. If there are no more comments, I'm looking forward to a v2 patch
with a non-empty commit message.

Kevin


