Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BA2C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74190214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vi6PtecY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74190214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT02S-0006fr-Kx
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iT01Y-0005kU-Ag
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iT01X-0007cL-9a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iT01X-0007cB-6T
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573203222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GzxLFzL+9LXuE6dWeSgWf1dukfXzVPj1WHJ1jYgYL1E=;
 b=Vi6PtecY3/WcGH6Wi4r7sORkgOKd6eiIhaEt78tQwOvIbJxgMnuoC8yw7vdM3bGK9vcRqv
 5cgPQ3T5z2f6oOWfixgglRwlUjyeZGP4I9FhzLfYjfNoA1mTdjOhw2Dec3C7isxGBanmvU
 sse35jV/Bh5auEbY0DoOwazicUWDsLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-bq8Gi9NINium1zIHimzYyQ-1; Fri, 08 Nov 2019 03:53:39 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57A58107ACC3;
 Fri,  8 Nov 2019 08:53:38 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-227.ams2.redhat.com
 [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AE85600C9;
 Fri,  8 Nov 2019 08:53:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] block: Remove 'backing': null from bs->{explicit_,
 }options
Date: Fri,  8 Nov 2019 09:53:11 +0100
Message-Id: <20191108085312.27049-2-kwolf@redhat.com>
In-Reply-To: <20191108085312.27049-1-kwolf@redhat.com>
References: <20191108085312.27049-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bq8Gi9NINium1zIHimzYyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bs->options and bs->explicit_options shouldn't contain any options for
child nodes. bdrv_open_inherited() takes care to remove any options that
match a child name after opening the image and the same is done when
reopening.

However, we miss the case of 'backing': null, which is a child option,
but results in no child being created. This means that a 'backing': null
remains in bs->options and bs->explicit_options.

A typical use for 'backing': null is in live snapshots: blockdev-add for
the qcow2 overlay makes sure not to open the backing file (because it is
already opened and blockdev-snapshot will attach it). After doing a
blockdev-snapshot, bs->options and bs->explicit_options become
inconsistent with the actual state (bs has a backing file now, but the
options still say null). On the next occasion that the image is
reopened, e.g. switching it from read-write to read-only when another
snapshot is taken, the option will take effect again and the node
incorrectly loses its backing file.

Fix bdrv_open_inherited() to remove the 'backing' option from
bs->options and bs->explicit_options even for the case where it
specifies that no backing file is wanted.

Reported-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index dad5a3d8e0..74ba9acb08 100644
--- a/block.c
+++ b/block.c
@@ -3019,6 +3019,8 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                         "use \"backing\": null instead");
         }
         flags |=3D BDRV_O_NO_BACKING;
+        qdict_del(bs->explicit_options, "backing");
+        qdict_del(bs->options, "backing");
         qdict_del(options, "backing");
     }
=20
--=20
2.20.1


