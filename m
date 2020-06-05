Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2820C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F27E2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SamyVJKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F27E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhERe-0006yj-QF
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQS-0005HD-TV
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQS-00025V-8z
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591371511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CyAY6frRQbrMGHfD+FOKfMZ6ysesSwrNH3XlAy9ECc=;
 b=SamyVJKMSqgJnQScjzQH/Hpaeo5wbEryl4V/fwHW04qbcBrF+oZGwLFZ/0L3/mDHl/2FTE
 vQ9pnGQJfS3oWSeNZLeyKvLqjDpygYN6VXFf9QbI70ssWPWP+gK2QJyF6w9UfTJcjpJ1J8
 em1cYNwGsgPHfaKOA7EFg4Mq00YJ8nM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-iCdGy7cWPMeWahwl0oFCsw-1; Fri, 05 Jun 2020 11:38:27 -0400
X-MC-Unique: iCdGy7cWPMeWahwl0oFCsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F03DA0C08;
 Fri,  5 Jun 2020 15:38:26 +0000 (UTC)
Received: from localhost (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89FE39CA0;
 Fri,  5 Jun 2020 15:38:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/10] target/s390x/helper: Clean ifdef'ry
Date: Fri,  5 Jun 2020 17:37:55 +0200
Message-Id: <20200605153756.392825-10-cohuck@redhat.com>
In-Reply-To: <20200605153756.392825-1-cohuck@redhat.com>
References: <20200605153756.392825-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

All this code is guarded checking CONFIG_USER_ONLY definition.
Drop the duplicated checks.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200526172427.17460-7-f4bug@amsat.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 09f60406aa33..9257d388baed 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -42,9 +42,6 @@ void s390x_cpu_timer(void *opaque)
 {
     cpu_inject_cpu_timer((S390CPU *) opaque);
 }
-#endif
-
-#ifndef CONFIG_USER_ONLY
 
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 {
@@ -98,14 +95,12 @@ void s390_handle_wait(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
 
     if (s390_cpu_halt(cpu) == 0) {
-#ifndef CONFIG_USER_ONLY
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
             cpu->env.crash_reason = S390_CRASH_REASON_DISABLED_WAIT;
             qemu_system_guest_panicked(cpu_get_crash_info(cs));
         }
-#endif
     }
 }
 
-- 
2.25.4


