Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B3AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAC820801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaKwKski"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAC820801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43KO-00059x-Ru
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Je-0004Lg-TS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Jd-00040W-OP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:53:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Jd-00040L-Kz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:53:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLzzfa/k+gcq71tiHqnDhD5y9NK5lElOhG1avfe2H88=;
 b=DaKwKskiUrTvaveGMn+h63ujBBLbg80+YJ+zM8SvyhJYZnwE/McHrxt9oHrp3WxpdzWFv9
 BKAMi9DQz91VdB7JqV+7G11UxWmDzQCN9wgcHU8xZWGrAFFvuck4YWgaUImNcHWScfSUB/
 GIzzc+zCBWCr8QGNBfvePbQkS04PPmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-HCCNvZgXMvuZ9Tm0y5nE8w-1; Tue, 18 Feb 2020 08:53:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7CA713F5;
 Tue, 18 Feb 2020 13:53:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-181.ams2.redhat.com [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98AE58B54F;
 Tue, 18 Feb 2020 13:53:13 +0000 (UTC)
Date: Tue, 18 Feb 2020 14:53:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v4 00/19] block: Fix check_to_replace_node()
Message-ID: <20200218135312.GE6157@linux.fritz.box>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HCCNvZgXMvuZ9Tm0y5nE8w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Am 18.02.2020 um 11:34 hat Max Reitz geschrieben:
> Branch: https://github.com/XanClic/qemu.git fix-can-replace-v4
> Branch: https://git.xanclic.moe/XanClic/qemu.git fix-can-replace-v4
>=20
> v1: https://lists.nongnu.org/archive/html/qemu-block/2019-09/msg01027.htm=
l
> v2: https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00370.htm=
l
> v3: https://lists.nongnu.org/archive/html/qemu-block/2020-01/msg00922.htm=
l
>=20
>=20
> Hi,
>=20
> For what this series does, see the cover letter of v1 (linked above).
>=20
>=20
> Changes in v4 compared to v3:
> - Following the discussion with Kevin, I changed Quorum=E2=80=99s
>   .bdrv_recurse_can_replace() implementation from unsharing the
>   CONSISTENT_READ permission and taking the WRITE permission to just
>   checking whether there are any other parents
>   - This made the old patches 8 and 9 unnecessary, so they=E2=80=99ve bee=
n
>     dropped
>   - And of course it requires some changes to patch 10 (now 8)
>   - (Patch 10 (was: 12) gets a rebase conflict that=E2=80=99s obvious to
>     resolve, so I kept Vladimir=E2=80=99s R-b)
>=20
> - As suggested by Vladimir, I added the root node name to the
>   cannot-follow-path error message in patch 14 (was: 16), and added an
>   assertion that the root node exists in the first place

Thanks, applied to the block branch.

Kevin


