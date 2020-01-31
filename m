Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5772C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D4B206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zvypeutc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D4B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaSM-0005Ka-Lj
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLu-0003Ws-3J
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLt-0004yi-5i
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLt-0004yD-2C
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOGOsxpR0p2OgwGamNOhNFGeIiUOgsZlr2K/1g0z2zM=;
 b=Zvypeutc971fTZln/w2lNWhtUJ63KXIetcIT+I38L60JX8UjGWAi+H+lad5MN4rIuxMF2t
 ztFJ7MAeD8N+TRrI3gsVoDWwJCFvBaNTTzJRek9ht1iAZpIQxOeN++pAxrrgVSfj65V+bf
 X7uY+hgxDReLY7exu391jd2Z+HGWVwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-F9DMh8VkMUimTRjx07R7XA-1; Fri, 31 Jan 2020 12:44:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23576800D48;
 Fri, 31 Jan 2020 17:44:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A56E87FB60;
 Fri, 31 Jan 2020 17:44:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/17] qcow2: Expose all zero bit through .bdrv_known_zeroes
Date: Fri, 31 Jan 2020 11:44:33 -0600
Message-Id: <20200131174436.2961874-15-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: F9DMh8VkMUimTRjx07R7XA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that qcow2 images have a way to track when the contents are known
to be all zero, it is worth exposing this to clients such as qemu-img
convert.  (Of course, until the next patch wires up qcow2 to actually
set the bit, this patch has no immediate effect; however, keeping it
as a separate patch allows for an easier revert when testing if the
bit makes a difference in qemu-img behavior).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 20cce9410c84..3f61d806a14b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4938,6 +4938,9 @@ static int qcow2_known_zeroes(BlockDriverState *bs)
      * therefore enough to check the first one.
      */
     preallocated =3D s->l1_size > 0 && s->l1_table[0] !=3D 0;
+    if (s->autoclear_features & QCOW2_AUTOCLEAR_ALL_ZERO) {
+        r |=3D BDRV_ZERO_OPEN;
+    }
     if (qemu_in_coroutine()) {
         qemu_co_mutex_unlock(&s->lock);
     }
--=20
2.24.1


