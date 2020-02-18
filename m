Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEFBC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE7121D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHTcjXH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE7121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43aK-00042I-C3
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xi-0006ru-3j
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xh-0001Qr-3P
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xg-0001QA-W4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVSnhp8bk+MPF/IpxOAFXYHQcKHoI7s74fdpDwowtyk=;
 b=DHTcjXH5fCMUFg9LL7X5vTXZeThBPSiIJ3J7YCH8+5VWKZXwAFApoUbf8vmxS4isMsdlnF
 yzCa3s39fsp/CdrTThPhwSqJr3+Xn1lR3dCmgqnZZ0v6ODU2cRInvFCW2HZEmaQ+0Gql/r
 BhXkw/3VSsYyfgXrW2Vq7pQ1lzGWi0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-_TiZdrLJMfWLs8GMVcQ-kQ-1; Tue, 18 Feb 2020 09:07:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 980C1800D55;
 Tue, 18 Feb 2020 14:07:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9087E8B549;
 Tue, 18 Feb 2020 14:07:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/36] qcow2: update_refcount(): Reset old_table_index after
 qcow2_cache_put()
Date: Tue, 18 Feb 2020 15:06:51 +0100
Message-Id: <20200218140722.23876-6-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _TiZdrLJMfWLs8GMVcQ-kQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the case that update_refcount() frees a refcount block, it evicts it
from the metadata cache. Before doing so, however, it returns the
currently used refcount block to the cache because it might be the same.
Returning the refcount block early means that we need to reset
old_table_index so that we reload the refcount block in the next
iteration if it is actually still in use.

Fixes: f71c08ea8e60f035485a512fd2af8908567592f0
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200211094900.17315-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index c963bc8de1..7ef1c0e42a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -889,6 +889,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(Bloc=
kDriverState *bs,
                                                 offset);
             if (table !=3D NULL) {
                 qcow2_cache_put(s->refcount_block_cache, &refcount_block);
+                old_table_index =3D -1;
                 qcow2_cache_discard(s->refcount_block_cache, table);
             }
=20
--=20
2.20.1


