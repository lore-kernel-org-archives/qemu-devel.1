Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43891CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A01021929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UydOuwpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A01021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxFj-0000sj-0s
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNwgw-0000LO-LY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNwgv-0002O2-40
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:19:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNwgv-0002N1-0Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571998770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZo/JBOv+pMyXQAy2tOmSk9WXn/8kYiIXIzF1+Wnb9Q=;
 b=UydOuwpRSx2wL35F2WCiXWRhon6CZDfpZ/3Bp+ofZRV5XQPexhi8haqgGSSVYl8i7GyhCm
 ukzp176/yLTUjYkeiTrdplm3mcWNkHcv57UHUeGsqK9AEuzQNIdVxlUwDd2zaXLJtfpbtX
 U0RdEyAX1hCCdQrBmzKXk2qf5BBNtvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-xabirLy0O4yDjdcHXmwZow-1; Fri, 25 Oct 2019 06:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F1F047B;
 Fri, 25 Oct 2019 10:19:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D15E910027C0;
 Fri, 25 Oct 2019 10:19:21 +0000 (UTC)
Date: Fri, 25 Oct 2019 12:19:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC 2/3] block/file-posix: Detect XFS with CONFIG_FALLOCATE
Message-ID: <20191025101920.GB7275@localhost.localdomain>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191025095849.25283-3-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191025095849.25283-3-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xabirLy0O4yDjdcHXmwZow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.10.2019 um 11:58 hat Max Reitz geschrieben:
> We will need this for the next patch.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 695fcf740d..5cd54c8bff 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -149,7 +149,7 @@ typedef struct BDRVRawState {
>      int perm_change_flags;
>      BDRVReopenState *reopen_state;
> =20
> -#ifdef CONFIG_XFS
> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
>      bool is_xfs:1;
>  #endif
>      bool has_discard:1;
> @@ -667,7 +667,7 @@ static int raw_open_common(BlockDriverState *bs, QDic=
t *options,
>      }
>  #endif
> =20
> -#ifdef CONFIG_XFS
> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
>      if (platform_test_xfs_fd(s->fd)) {

platform_test_xfs_fd() is defined in a header file from xfsprogs. I
don't think you can call that without CONFIG_XFS, it would break the
build.

>          s->is_xfs =3D true;
>      }

Kevin


