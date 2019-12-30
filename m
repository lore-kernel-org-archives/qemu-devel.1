Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D46C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C143620730
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hyELLRO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C143620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iltLA-0001TV-Uo
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iltK5-0000UK-K0
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iltK4-00081A-1y
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:34:57 -0500
Received: from kylie.crudebyte.com ([5.189.157.229]:57869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iltK3-00080U-K1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=EGox+qrddMnZiYOkyko/n3zWv2SCrC8t+WbbL/Mzhhw=; b=hyELLRO57DRWn6Wp/gkkUhDUZs
 /xUkKEDCMlnGWbW3T9RsoSaV39BwJsU5TiBR8UZFGchCOxomrGnYEl8AY5gvBMtE3vDrJ47s9ILcr
 iClijFE9GxwSaHTyxzpwjQTVn9uNDOja0fgYPSEqvIScljQYIuwz4WI2tjM6k5/MDkpUTJW923N4T
 wqPbFLhff3WYozTSGOuFbCqIfSrvQXE1xMWOKThg4Ryw0NXP1A5nx2sNcLofhJSlF0T2xM+IdObtA
 hDi+C57/IDJ3pn8WABjZd6vKSwEL43OZH5avk0SOvqDvwT3sFZ0UZPB6ED0XnBWZv4IAB/AQog2q8
 VSdlxZOBGffyvi0ht3WAEYXXy3KjKdXD2S3llxLnWMkMO20ih/vEko9gMhrUomaYTV5LCYIuP2cq/
 A+SriAo4DZpeQcxNhbxzDpA1PTyokrzfpa54VRQJi+xtZNX++XvRp3SDlEgwpT6w3uYznMmDXf4Po
 86mm25Nj8DDn1tdqZL+VFyoN3Z/1LKaznB2Wf86WZNTHPxLATWLPBSNJA8BtMGFZ+aEf/Z812Q62T
 emvYfStrwSxIanLg/fKEvdMuj15rX7R/5CsoptA43JTpKlmpPvITnjvBHoegz+PJr266ySXlhqSu/
 rFpKUTnFQ1hxnwXYn/NfUoLait2M98FtWsgsfgsfo=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Yan Wang <wangyan122@huawei.com>, Greg Kurz <groug@kaod.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] 9p: local: fix memory leak
Date: Mon, 30 Dec 2019 12:34:51 +0100
Message-ID: <1582630.xPu3mGmscH@silver>
In-Reply-To: <20191230022347.36932-1-wangyan122@huawei.com>
References: <20191230022347.36932-1-wangyan122@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 30. Dezember 2019 03:23:47 CET Yan Wang wrote:
> Signed-off-by: Yan Wang <wangyan122@huawei.com>
> ---
>  hw/9pfs/9p-local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ca641390fb..d0592c3b45 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -947,7 +947,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
> if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
>          local_is_mapped_file_metadata(ctx, name)) {
>          errno = EINVAL;
> -        return -1;
> +        goto out;
>      }
> 
>      odirfd = local_opendir_nofollow(ctx, odirpath);

This issue was already addressed 10 days ago and is scheduled for merge on 
Greg's 9p-next branch:

https://github.com/gkurz/qemu/commit/ac5987075f42e44419a461846fdefde8ab4dd624

https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04774.html



