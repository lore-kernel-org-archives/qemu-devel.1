Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC81C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C75C206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtakxB63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C75C206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZb98-0003vD-Jl
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 08:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZb6w-0001Kd-UE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZb6v-0001G3-W1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:42:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZb6v-0001Fr-Sv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574775753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m/dSl8gZ5jOtPI5gmWMa//FCuVvD3263xK4p+4+iDvQ=;
 b=QtakxB63D3hK72r5iCl5pWZRsmzFl8+2yRSzASa40wY6BYQ1k5GEqMiPKCx0Pe2tFqzgIn
 +Il6f/e2t5epskfX4w+miheG7niz27ZZz0KmFBGFktLoJfx5T/j70cL3tG8sDJ8asQWSKn
 T0emLpoyRHy5ZsOTzBpxnQ9A5EZ2MwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-Xo_aRWgtNMSb4S0yin6Gxg-1; Tue, 26 Nov 2019 08:42:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B9E801E72;
 Tue, 26 Nov 2019 13:42:29 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-171.ams2.redhat.com
 [10.36.117.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 392E5600CC;
 Tue, 26 Nov 2019 13:42:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] blockjob: Fix error message for negative speed
Date: Tue, 26 Nov 2019 14:42:22 +0100
Message-Id: <20191126134222.16340-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Xo_aRWgtNMSb4S0yin6Gxg-1
X-Mimecast-Spam-Score: 0
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error message for a negative speed uses QERR_INVALID_PARAMETER,
which implies that the 'speed' option doesn't even exist:

    {"error": {"class": "GenericError", "desc": "Invalid parameter 'speed'"=
}}

Make it use QERR_INVALID_PARAMETER_VALUE instead:

    {"error": {"class": "GenericError", "desc": "Parameter 'speed' expects =
a non-negative value"}}

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index c6e20e2fcd..5d63b1e89d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -261,7 +261,8 @@ void block_job_set_speed(BlockJob *job, int64_t speed, =
Error **errp)
         return;
     }
     if (speed < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "speed");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "speed",
+                   "a non-negative value");
         return;
     }
=20
--=20
2.20.1


