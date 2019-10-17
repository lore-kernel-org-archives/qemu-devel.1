Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0CDFA3736
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C0F214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C0F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2s8-0000QU-TK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iL2rG-0007zP-4U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iL2rC-0005SC-9T
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iL2rC-0005QL-4p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47E8E7BDA9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:18:08 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-247.ams2.redhat.com
 [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21BC35D712;
 Thu, 17 Oct 2019 10:18:06 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] runstate: ignore exit request in finish migrate state
Date: Thu, 17 Oct 2019 12:18:06 +0200
Message-Id: <20191017101806.3644-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 17 Oct 2019 10:18:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trying to reboot a VM while a migration is running can
move to the prelaunch state (because of the reset) while
the runstate is in finish migrate state.
As the logical step after the finish migrate is postmigrate,
this can create an invalid state transition from prelaunch state
to postmigrate state and this raises an error and aborts:

    invalid runstate transition: 'prelaunch' -> 'postmigrate'

As we are not able to manage reset in finish migrate state the
best we can do is to ignore any changes and delay them until
the next state which should be postmigrate and which should allow
this kind of transition.

Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/vl.c b/vl.c
index 0a295e5d77d6..dc71c822ba24 100644
--- a/vl.c
+++ b/vl.c
@@ -1744,6 +1744,9 @@ static bool main_loop_should_exit(void)
     RunState r;
     ShutdownCause request;
=20
+    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        return false;
+    }
     if (preconfig_exit_requested) {
         if (runstate_check(RUN_STATE_PRECONFIG)) {
             runstate_set(RUN_STATE_PRELAUNCH);
--=20
2.21.0


