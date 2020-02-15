Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A928DC4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BF920726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLimWXMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BF920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vro-00010v-Kx
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpM-0004Re-Vp
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpL-0006p7-7t
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpK-0006ok-Vv
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJa6oPjmfkyLWvSO6f8qsXgZQzgTLsWKxPw5B7WCrT4=;
 b=fLimWXMA1RvIr2MjJX/xFrgYojuGtl7PUNloV49vmpvcqmR/0wFkg7lFvUGy4x1b0Ox3uX
 73Q5EVi/8mHejssvV4AjsJYUZya04S4HLrgyZy6WpkSxdUyLeN74SS8+nmeoRDmAFoJkKe
 q2qru8Xl0ONrWiJGCDAgSdFXFclMw90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-BMpxWYHVOAqrxhqn-w6jhA-1; Sat, 15 Feb 2020 06:41:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3FD0107ACC9
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B22D884780;
 Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E4A211366C0; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] qapi: Expand documentation for LostTickPolicy
Date: Sat, 15 Feb 2020 12:41:16 +0100
Message-Id: <20200215114133.15097-2-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BMpxWYHVOAqrxhqn-w6jhA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Andrew Jones <drjones@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrea Bolognani <abologna@redhat.com>

The current documentation is fairly terse and not easy to decode
for someone who's not intimately familiar with the inner workings
of timer devices. Expand on it by providing a somewhat verbose
description of what behavior each policy will result in, as seen
from both the guest OS and host point of view.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Message-Id: <20200211183744.210298-1-abologna@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 33b94e3589..cd7445d29f 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -163,17 +163,29 @@
 ##
 # @LostTickPolicy:
 #
-# Policy for handling lost ticks in timer devices.
+# Policy for handling lost ticks in timer devices.  Ticks end up getting
+# lost when, for example, the guest is paused.
 #
-# @discard: throw away the missed tick(s) and continue with future injecti=
on
-#           normally.  Guest time may be delayed, unless the OS has explic=
it
-#           handling of lost ticks
+# @discard: throw away the missed ticks and continue with future injection
+#           normally.  The guest OS will see the timer jump ahead by a
+#           potentially quite significant amount all at once, as if the
+#           intervening chunk of time had simply not existed; needless to
+#           say, such a sudden jump can easily confuse a guest OS which is
+#           not specifically prepared to deal with it.  Assuming the guest
+#           OS can deal correctly with the time jump, the time in the gues=
t
+#           and in the host should now match.
 #
-# @delay: continue to deliver ticks at the normal rate.  Guest time will b=
e
-#         delayed due to the late tick
+# @delay: continue to deliver ticks at the normal rate.  The guest OS will
+#         not notice anything is amiss, as from its point of view time wil=
l
+#         have continued to flow normally.  The time in the guest should n=
ow
+#         be behind the time in the host by exactly the amount of time dur=
ing
+#         which ticks have been missed.
 #
-# @slew: deliver ticks at a higher rate to catch up with the missed tick. =
The
-#        guest time should not be delayed once catchup is complete.
+# @slew: deliver ticks at a higher rate to catch up with the missed ticks.
+#        The guest OS will not notice anything is amiss, as from its point
+#        of view time will have continued to flow normally.  Once the time=
r
+#        has managed to catch up with all the missing ticks, the time in
+#        the guest and in the host should match.
 #
 # Since: 2.0
 ##
--=20
2.21.1


