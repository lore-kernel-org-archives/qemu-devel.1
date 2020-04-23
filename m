Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407D1C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F07206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9LVnYJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F07206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdkI-0006vF-5w
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdjb-0006Qb-UT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdjb-00048s-3c
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdja-00045Y-M9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587655549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fy6gCa4zjX3kHE0rYDZh+ykgPGfE6mWbauggzBoAwf8=;
 b=a9LVnYJFJNYvuFYe2kB7fkQt9ZMUBnvWbq3SbL0eelL/kyt5PYD2ZWFjUe89vJTK2NXbD2
 YlQkSY2Y4/icRbsUzc+YwtNMKrxB11lsHUVvn7yEkOnziGfyf155opkxQx84ZXRo6R6j71
 pnyMsH64AVSZyEtecVTAa+nSbr1Cw6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-m-zjbhDqMHSKQN5pPACaoQ-1; Thu, 23 Apr 2020 11:25:46 -0400
X-MC-Unique: m-zjbhDqMHSKQN5pPACaoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B94CD180F12C;
 Thu, 23 Apr 2020 15:25:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F6686116D;
 Thu, 23 Apr 2020 15:25:36 +0000 (UTC)
Date: Thu, 23 Apr 2020 17:25:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/3] block: use int64_t as bytes type in tracked requests
Message-ID: <20200423152535.GC23654@linux.fritz.box>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
 <20200330141818.31294-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200330141818.31294-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, berto@igalia.com, stefanha@redhat.com,
 qemu-block@nongnu.org, dillaman@redhat.com, pavel.dovgaluk@ispras.ru,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.03.2020 um 16:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> We are generally moving to int64_t for both offset and bytes paramaters
> on all io paths. Convert tracked requests now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block_int.h |  4 ++--
>  block/io.c                | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 4c3587ea19..c8daba608b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
>  typedef struct BdrvTrackedRequest {
>      BlockDriverState *bs;
>      int64_t offset;
> -    uint64_t bytes;
> +    int64_t bytes;
>      enum BdrvTrackedRequestType type;
> =20
>      bool serialising;
>      int64_t overlap_offset;
> -    uint64_t overlap_bytes;
> +    int64_t overlap_bytes;
> =20
>      QLIST_ENTRY(BdrvTrackedRequest) list;
>      Coroutine *co; /* owner, used for deadlock detection */
> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..7cbb80bd24 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest =
*req)
>  static void tracked_request_begin(BdrvTrackedRequest *req,
>                                    BlockDriverState *bs,
>                                    int64_t offset,
> -                                  uint64_t bytes,
> +                                  int64_t bytes,
>                                    enum BdrvTrackedRequestType type)
>  {
> -    assert(bytes <=3D INT64_MAX && offset <=3D INT64_MAX - bytes);
> +    assert(offset >=3D 0 && bytes >=3D 0 &&
> +           bytes <=3D INT64_MAX && offset <=3D INT64_MAX - bytes);
> =20
>      *req =3D (BdrvTrackedRequest){
>          .bs =3D bs,
> @@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest =
*req,
>  }
> =20
>  static bool tracked_request_overlaps(BdrvTrackedRequest *req,
> -                                     int64_t offset, uint64_t bytes)
> +                                     int64_t offset, int64_t bytes)
>  {
>      /*        aaaa   bbbb */
>      if (offset >=3D req->overlap_offset + req->overlap_bytes) {
> @@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest=
 *req, uint64_t align)
>  {
>      BlockDriverState *bs =3D req->bs;
>      int64_t overlap_offset =3D req->offset & ~(align - 1);
> -    uint64_t overlap_bytes =3D ROUND_UP(req->offset + req->bytes, align)
> -                               - overlap_offset;
> +    int64_t overlap_bytes =3D
> +            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;

An indentation with 8 spaces is unconventional in QEMU.

Kevin


