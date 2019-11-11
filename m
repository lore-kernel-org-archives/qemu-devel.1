Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B02C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C57E20659
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9WoY/fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C57E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUGQc-0001dn-BC
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 15:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iUGPQ-0000gS-CN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 15:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iUGPO-0002Xx-2M
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 15:35:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iUGPN-0002Xb-RM
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 15:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573504533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UgJRKIftxSKtotUapu/hPu4CT3JdNxKM6gjdNrL3vJk=;
 b=B9WoY/frvrR1OEQeKypbJcyjUoi3MPqIrYZyRRIm28+JZ2231NTsfxlkOtgc8Rtnpr0buB
 vWcuLLn5QvmZzeqorwDzLeIW1Q455gCI1bon3zUVzrWMjnRMChH1FKmqhTUdjBou4KzfL2
 4NAucJ5wotCgqnG0OoWL2MB7R1cRMq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-dDN-vDm-PFGnK18NKViI6w-1; Mon, 11 Nov 2019 15:35:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E21DBA3;
 Mon, 11 Nov 2019 20:35:30 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46706600CC;
 Mon, 11 Nov 2019 20:35:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-coroutine-sleep: Silence Coverity warning
Date: Mon, 11 Nov 2019 14:35:24 -0600
Message-Id: <20191111203524.21912-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dDN-vDm-PFGnK18NKViI6w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity warns that we store the address of a stack variable through a
pointer passed in by the caller, which would let the caller trivially
trigger use-after-free if that stored value is still present when we
finish execution.  However, the way coroutines work is that after our
call to qemu_coroutine_yield(), control is temporarily continued in
the caller prior to our function concluding, and in order to resume
our coroutine, the caller must poll until the variable has been set to
NULL.  Thus, we can add an assert that we do not leak stack storage to
the caller on function exit.

Fixes: Coverity CID 1406474
CC: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

I don't know if this actually shuts Coverity up; Peter, since you
reported the Coverity issue, are you in a better position to test if
this makes a difference?  At any rate, the tests still pass after
this is in place.

I'm not sure if the compiler wants us to insert a 'volatile' in any
of our uses of QemuCoSleepState.user_state_pointer.

 util/qemu-coroutine-sleep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index ae91b92b6e78..769a76e57df0 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -68,5 +68,12 @@ void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockTyp=
e type, int64_t ns,
     }
     timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
+    if (sleep_state) {
+        /*
+         * Note that *sleep_state is cleared during qemu_co_sleep_wake
+         * before resuming this coroutine.
+         */
+        assert(*sleep_state =3D=3D NULL);
+    }
     timer_free(state.ts);
 }
--=20
2.21.0


