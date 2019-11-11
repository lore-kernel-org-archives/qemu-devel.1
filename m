Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5E6C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E5421783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeubA5hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E5421783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU7PQ-0002TI-CF
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 05:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iU7On-0001w3-9m
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iU7Ol-0001kv-M1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:58:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iU7Ol-0001ka-I0
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 05:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573469899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2Hkzl9/iRiz4K6m1BSdo1oKykt+7iqmMl3V8j5XYVg=;
 b=AeubA5hqc96VpLAHYSPUmG2y3uBdRp7FCP5rhjANd8OsytbthsJjmcmVeo4qLaEY0A9uxN
 5wlqjR1tqp8//xyMByk+G5/KL+JnLoq+Xil83wwyBUPqXwwlNji2tcXjcj8lFgzvcR3bBD
 Jwqr+TJ5MDOKvvpPJ0HG8tVFi9OMM3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-y6XpKhI5M0aYxz2gAZJgCA-1; Mon, 11 Nov 2019 05:58:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E6C585B6F9;
 Mon, 11 Nov 2019 10:58:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-79.ams2.redhat.com [10.36.117.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE8D3600C6;
 Mon, 11 Nov 2019 10:58:00 +0000 (UTC)
Date: Mon, 11 Nov 2019 11:57:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 03/15] block/block: add BDRV flag for io_uring
Message-ID: <20191111105759.GB7297@linux.fritz.box>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191025160444.31632-4-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: y6XpKhI5M0aYxz2gAZJgCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com,
 Maxim Levitsky <maximlevitsky@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.10.2019 um 18:04 hat Stefan Hajnoczi geschrieben:
> From: Aarushi Mehta <mehta.aaru20@gmail.com>
>=20
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/block.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index 89606bd9f8..bdb48dcd1b 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -126,6 +126,7 @@ typedef struct HDGeometry {
>                                        ignoring the format layer */
>  #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
>  #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening re=
ad-write fails */
> +#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread=
 pool */

Why do we need a new (global!) flag rather than a driver-specific option
for file-posix? This looks wrong to me, the flag has no sensible meaning
for any other driver.

(Yes, BDRV_O_NATIVE_AIO is wrong, too, but compatibility means we can't
remove it easily.)

Kevin


