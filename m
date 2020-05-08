Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8AC47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BBD24958
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqdhvF+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BBD24958
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2WZ-0005vt-6O
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kf-0000Jr-GK
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kb-00007l-GI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMV28D7x38tNYyvnMyu9QYQABUuYx8lvBARxdG3PmWc=;
 b=eqdhvF+qjaxqbMpj6W7pbD9ag8Oxv7HgHFCPKm+BYV82yVpsT39s1AwtF4H390BDopnWCp
 +Lhb53Pp2wspbfyL7fpmq30gTP2HaUz/KIH36zCJGs2RNNbY/y0FP4fIefuER+eQfZjWny
 U8DSRTs3WIj8coJGwpcfE6t1JvloL34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-fToO9inxP_uUd7X4sHO2pw-1; Fri, 08 May 2020 08:42:17 -0400
X-MC-Unique: fToO9inxP_uUd7X4sHO2pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E7F19057A0;
 Fri,  8 May 2020 12:42:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA4D19167;
 Fri,  8 May 2020 12:42:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 26/30] sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Fri,  8 May 2020 14:41:31 +0200
Message-Id: <20200508124135.252565-27-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Our .bdrv_has_zero_init_truncate always returns 1 because sheepdog
always 0-fills; we can use that same knowledge to implement
BDRV_REQ_ZERO_WRITE by ignoring it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200428202905.770727-6-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2eb61938ff..739e6dee30 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1654,6 +1654,7 @@ static int sd_open(BlockDriverState *bs, QDict *optio=
ns, int flags,
     memcpy(&s->inode, buf, sizeof(s->inode));
=20
     bs->total_sectors =3D s->inode.vdi_size / BDRV_SECTOR_SIZE;
+    bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
     pstrcpy(s->name, sizeof(s->name), vdi);
     qemu_co_mutex_init(&s->lock);
     qemu_co_mutex_init(&s->queue_lock);
--=20
2.25.3


