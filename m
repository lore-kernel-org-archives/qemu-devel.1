Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E28C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC842073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxe93rq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC842073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ica71-0006jY-IW
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ica1E-0002cw-Bx
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:09:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ica18-0005TU-Ru
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35930
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ica16-0005PF-UA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575486529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeQb7b0beOVO0Lr1WGzTfmVOOghutFPqqMJQKCCjm/o=;
 b=Xxe93rq18hT76H/Pf3iLJ1l+WOG8rD8C5OgxCyLIZT7SeJv1dKbqrMCYbdYGQbKag4nWeN
 pDWNmibR4UEe7JqAQNwhBa/wyihXYdAgqftxRTlNojVYyzcdUNclsJhe579pfM7vZhazWj
 z2Jn0dV3yJrwIcTVBJNe1HpxnA09KiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-Ws-x8GdTOuOUWsXmhGfT7g-1; Wed, 04 Dec 2019 14:08:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9A8D1005516
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:08:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B935A4B60;
 Wed,  4 Dec 2019 19:08:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 15A8F2246AE; Wed,  4 Dec 2019 14:08:42 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] virtiofsd: Get rid of unused fields in fv_QueueInfo
Date: Wed,  4 Dec 2019 14:08:32 -0500
Message-Id: <20191204190836.31324-2-vgoyal@redhat.com>
In-Reply-To: <20191204190836.31324-1-vgoyal@redhat.com>
References: <20191204190836.31324-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Ws-x8GdTOuOUWsXmhGfT7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: mszeredi@redhat.com, dgilbert@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some unused fields in "struct fv_QueueInfo". Get rid of these fie=
lds.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/fuse_virtio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 31c8542b6c..2a9cd60a01 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -50,12 +50,6 @@ struct fv_QueueInfo {
     int qidx;
     int kick_fd;
     int kill_fd; /* For killing the thread */
-
-    /* The element for the command currently being processed */
-    VuVirtqElement *qe;
-    /* If any of the qe vec elements (towards vmm) are unmappable */
-    unsigned int elem_bad_in;
-    bool reply_sent;
 };
=20
 /* A FUSE request */
--=20
2.20.1


