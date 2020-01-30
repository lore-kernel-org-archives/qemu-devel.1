Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA49AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BE72083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edXKZc8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BE72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHa5-00087s-Tc
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHWc-0002Ov-NT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHWb-0000sY-16
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHWa-0000qA-BG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOdBGk8Ti42m26thpGsTgXlNQcjGRQeyLHjmuldSczI=;
 b=edXKZc8p/UahxnfOE2N+CEwR/0tNJMpI8HiuLHVAtuslqxAljjahWC6hxlX5IprJ5v+je/
 8NQob//8Ij8yvm8OSCGgNa2jP2UrSU9/MbzeTlEb+7RbeLmDoTt87p69EgqLHVb8PgYHJS
 2jV2QvtnYE9QUVJClweaexDBWMP2BKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-Srb6hHFnMDO8bl6-4fxtgQ-1; Thu, 30 Jan 2020 16:38:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AE92800D48;
 Thu, 30 Jan 2020 21:38:46 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 048E987B00;
 Thu, 30 Jan 2020 21:38:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] hw/display/qxl.c: Use trace_event_get_state_backends()
Date: Thu, 30 Jan 2020 21:38:13 +0000
Message-Id: <20200130213814.334195-5-stefanha@redhat.com>
In-Reply-To: <20200130213814.334195-1-stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Srb6hHFnMDO8bl6-4fxtgQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The preferred way to test whether a trace event is enabled is to
use trace_event_get_state_backends(), because this will give the
correct answer (allowing expensive computations to be skipped)
whether the trace event is compile-time or run-time disabled.
Convert the old-style direct use of TRACE_FOO_ENABLED.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200120151142.18954-4-peter.maydell@linaro.org
Message-Id: <20200120151142.18954-4-peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 944c02ce56..c33b1915a5 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1764,7 +1764,7 @@ async_common:
         qxl_set_mode(d, val, 0);
         break;
     case QXL_IO_LOG:
-        if (TRACE_QXL_IO_LOG_ENABLED || d->guestdebug) {
+        if (trace_event_get_state_backends(TRACE_QXL_IO_LOG) || d->guestde=
bug) {
             /* We cannot trust the guest to NUL terminate d->ram->log_buf =
*/
             char *log_buf =3D g_strndup((const char *)d->ram->log_buf,
                                       sizeof(d->ram->log_buf));
--=20
2.24.1


