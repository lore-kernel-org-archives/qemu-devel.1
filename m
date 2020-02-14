Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF96AC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDEF222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hd1vBZfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDEF222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hHN-0000wo-HS
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2hGU-0007ci-5p
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2hGT-0005Y1-3X
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2hGT-0005XO-0G
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581710920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJEiE9xI7aILw83dDnsZdVaUnSegYkhr1oQCmytCVto=;
 b=Hd1vBZfJ8UiHuy1VwHMb5K6YQJSS2urK/up+ZjLRhCRKEQsOytYhixUVAv6sGueOYeWISr
 0FlN43DZTB5YUaBtCXUv6t182+LEb/iSeZHsdxmV41SRIh7sClIT+tK1RLLCgQjr57RPJ7
 Ew+iSwDGlyKhIksM6yKmh8VLQKFSK5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-WMq0NUqFM4mZ78wiA7Kqig-1; Fri, 14 Feb 2020 15:08:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 776BD8017CC;
 Fri, 14 Feb 2020 20:08:36 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE8075C1C3;
 Fri, 14 Feb 2020 20:08:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/7] commit: Fix is_read for block_job_error_action()
Date: Fri, 14 Feb 2020 21:08:10 +0100
Message-Id: <20200214200812.28180-6-kwolf@redhat.com>
In-Reply-To: <20200214200812.28180-1-kwolf@redhat.com>
References: <20200214200812.28180-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WMq0NUqFM4mZ78wiA7Kqig-1
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block_job_error_action() needs to know if reading from the top node or
writing to the base node failed so that it can set the right 'operation'
in the BLOCK_JOB_ERROR QMP event.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 2992a1012f..8e672799af 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -143,6 +143,7 @@ static int coroutine_fn commit_run(Job *job, Error **er=
rp)
=20
     for (offset =3D 0; offset < len; offset +=3D n) {
         bool copy;
+        bool error_in_source =3D true;
=20
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -162,11 +163,15 @@ static int coroutine_fn commit_run(Job *job, Error **=
errp)
             ret =3D blk_co_pread(s->top, offset, n, buf, 0);
             if (ret >=3D 0) {
                 ret =3D blk_co_pwrite(s->base, offset, n, buf, 0);
+                if (ret < 0) {
+                    error_in_source =3D false;
+                }
             }
         }
         if (ret < 0) {
             BlockErrorAction action =3D
-                block_job_error_action(&s->common, s->on_error, false, -re=
t);
+                block_job_error_action(&s->common, s->on_error,
+                                       error_in_source, -ret);
             if (action =3D=3D BLOCK_ERROR_ACTION_REPORT) {
                 goto out;
             } else {
--=20
2.20.1


