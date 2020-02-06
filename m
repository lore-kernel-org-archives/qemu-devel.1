Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A906C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9571217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtAko1Ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9571217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgn9-0007sb-SF
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdH-0002zQ-Cr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdG-0000YC-3S
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdG-0000XD-0B
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shonINvC/t01O0OhjOpjtH1WEJrQjtcpVX05iRNLCwQ=;
 b=dtAko1LnPtJwBhgICV+yL99U7UiR3Wttr2a6vMFbgK9Tjk/x0Mz5iCDANz3t4/WYnfU0ax
 CMrQZUbjtetj6doEWKyD6d2bsjpzKqXHmOgJ4R5cDiJWPbCIXRnVM/Q46RSur8KMuIkoIF
 Ppg8swOZRjFjFiMEh2iTk6SyoKzU9oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-k3GkjJ6tMCW9rUgFUKVALQ-1; Thu, 06 Feb 2020 07:51:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D431050945;
 Thu,  6 Feb 2020 12:51:40 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF6E1001B09;
 Thu,  6 Feb 2020 12:51:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/17] block: fix memleaks in bdrv_refresh_filename
Date: Thu,  6 Feb 2020 13:51:18 +0100
Message-Id: <20200206125132.594625-4-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: k3GkjJ6tMCW9rUgFUKVALQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

If we call the qmp 'query-block' while qemu is working on
'block-commit', it will cause memleaks, the memory leak stack is as
follow:

Indirect leak of 12360 byte(s) in 3 object(s) allocated from:
    #0 0x7f80f0b6d970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f80ee86049d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55ea95b5bb67 in qdict_new /mnt/sdb/qemu-4.2.0-rc0/qobject/qdict.c:=
29
    #3 0x55ea956cd043 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6427
    #4 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6399
    #5 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6399
    #6 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6399
    #7 0x55ea958818ea in bdrv_block_device_info /mnt/sdb/qemu-4.2.0-rc0/blo=
ck/qapi.c:56
    #8 0x55ea958879de in bdrv_query_info /mnt/sdb/qemu-4.2.0-rc0/block/qapi=
.c:392
    #9 0x55ea9588b58f in qmp_query_block /mnt/sdb/qemu-4.2.0-rc0/block/qapi=
.c:578
    #10 0x55ea95567392 in qmp_marshal_query_block qapi/qapi-commands-block-=
core.c:95

Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7f80f0b6d970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f80ee86049d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55ea95b5bb67 in qdict_new /mnt/sdb/qemu-4.2.0-rc0/qobject/qdict.c:=
29
    #3 0x55ea956cd043 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6427
    #4 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6399
    #5 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:6399
    #6 0x55ea9569f301 in bdrv_backing_attach /mnt/sdb/qemu-4.2.0-rc0/block.=
c:1064
    #7 0x55ea956a99dd in bdrv_replace_child_noperm /mnt/sdb/qemu-4.2.0-rc0/=
block.c:2283
    #8 0x55ea956b9b53 in bdrv_replace_node /mnt/sdb/qemu-4.2.0-rc0/block.c:=
4196
    #9 0x55ea956b9e49 in bdrv_append /mnt/sdb/qemu-4.2.0-rc0/block.c:4236
    #10 0x55ea958c3472 in commit_start /mnt/sdb/qemu-4.2.0-rc0/block/commit=
.c:306
    #11 0x55ea94b68ab0 in qmp_block_commit /mnt/sdb/qemu-4.2.0-rc0/blockdev=
.c:3459
    #12 0x55ea9556a7a7 in qmp_marshal_block_commit qapi/qapi-commands-block=
-core.c:407

Fixes: bb808d5f5c0978828a974d547e6032402c339555
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-id: 20200116085600.24056-1-pannengyuan@huawei.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index fe5050c53f..9c810534d6 100644
--- a/block.c
+++ b/block.c
@@ -6442,6 +6442,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
                 child->bs->exact_filename);
         pstrcpy(bs->filename, sizeof(bs->filename), child->bs->filename);
=20
+        qobject_unref(bs->full_open_options);
         bs->full_open_options =3D qobject_ref(child->bs->full_open_options=
);
=20
         return;
--=20
2.24.1


