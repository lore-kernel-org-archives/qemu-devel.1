Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A02720658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEDCtUzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A02720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxWp-0000na-M0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHx-00047t-SU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHv-0006Rg-Rt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHt-0006NH-SA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKUYLYyTOhXXs5Uuzx/QroEWqaITGSQKhJNLF3Ips9U=;
 b=KEDCtUzS5ZUidBlkAoo0d6SomGztodjYJnjtsnPibv8LsuDISx+5qWu15p9sOOUL2uFLff
 nTEAUMyX7yEdICml7cMBSOCLq6T0oiTOBgagD4g0CiNYDtj4j8ph6I4RASwR+33ihWFQkm
 SydinnG5ZI+eg50A8mV4QKMtDSFcNPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-ttNj0ZWuMJi1nOUxPOGdIw-1; Mon, 16 Mar 2020 17:28:37 -0400
X-MC-Unique: ttNj0ZWuMJi1nOUxPOGdIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B16598017CC;
 Mon, 16 Mar 2020 21:28:36 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6997119C4F;
 Mon, 16 Mar 2020 21:28:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/61] cpus: avoid pause_all_vcpus getting stuck due to race
Date: Mon, 16 Mar 2020 22:27:01 +0100
Message-Id: <1584394048-44994-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Longpeng <longpeng2@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Longpeng <longpeng2@huawei.com>

We found an issue when repeat reboot in guest during migration, it cause th=
e
migration thread never be waken up again.

<main loop>                        |<migration_thread>
                                   |
LOCK BQL                           |
...                                |
main_loop_should_exit              |
 pause_all_vcpus                   |
  1. set all cpus ->stop=3Dtrue      |
     and then kick                 |
  2. return if all cpus is paused  |
     (by '->stopped =3D=3D true'), else|
  3. qemu_cond_wait [BQL UNLOCK]   |
                                   |LOCK BQL
                                   |...
                                   |do_vm_stop
                                   | pause_all_vcpus
                                   |  (A)set all cpus ->stop=3Dtrue
                                   |     and then kick
                                   |  (B)return if all cpus is paused
                                   |     (by '->stopped =3D=3D true'), else
                                   |  (C)qemu_cond_wait [BQL UNLOCK]
  4. be waken up and LOCK BQL      |  (D)be waken up BUT wait for  BQL
  5. goto 2.                       |
 (BQL is still LOCKed)             |
 resume_all_vcpus                  |
  1. set all cpus ->stop=3Dfalse     |
     and ->stopped=3Dfalse           |
...                                |
BQL UNLOCK                         |  (E)LOCK BQL
                                   |  (F)goto B. [but stopped is false now!=
]
                                   |Finally, sleep at step 3 forever.

resume_all_vcpus should notice this race, so we need to move the change
of runstate before pause_all_vcpus in do_vm_stop() and ignore the resume
request if runstate is not running.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Longpeng <longpeng2@huawei.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200316083732.2010-1-longpeng2@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b4f8b84..ef441bd 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1026,9 +1026,9 @@ static int do_vm_stop(RunState state, bool send_stop)
     int ret =3D 0;
=20
     if (runstate_is_running()) {
+        runstate_set(state);
         cpu_disable_ticks();
         pause_all_vcpus();
-        runstate_set(state);
         vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
@@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
 {
     CPUState *cpu;
=20
+    if (!runstate_is_running()) {
+        return;
+    }
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
         cpu_resume(cpu);
--=20
1.8.3.1



