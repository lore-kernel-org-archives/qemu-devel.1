Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DB5C433F7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38E820775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVnqYT1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38E820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03m3-0008KK-8J
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k03l5-0007QY-5t
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:05:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k03l3-0005fi-BM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595858736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bEoIqJdCdfb7bKCFHXbgUU0RFnB0O9uMdyPzJNDVhs=;
 b=gVnqYT1VXwtgkDU+ccGMVdcJuE+VX5LA3D80iLEPFlzoAAEWMKUfTKKAkXAXtE2ahG+bNI
 mvwwoRIXcyYA1kGzgqo+FcI5k4ltaCUIUHuI6HLUM3ZVUqzPn7k/Rc90cEESH+ue/WUOND
 EIi5HyhIymwG8/c4QcXccyheTR/pne4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-eWDfvmvaPWekxur7t8dcCw-1; Mon, 27 Jul 2020 10:05:34 -0400
X-MC-Unique: eWDfvmvaPWekxur7t8dcCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12D7D100CCC1;
 Mon, 27 Jul 2020 14:05:32 +0000 (UTC)
Received: from localhost (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D368C19D82;
 Mon, 27 Jul 2020 14:05:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/2] s390x/protvirt: allow to IPL secure guests with -no-reboot
Date: Mon, 27 Jul 2020 16:05:21 +0200
Message-Id: <20200727140522.251815-2-cohuck@redhat.com>
In-Reply-To: <20200727140522.251815-1-cohuck@redhat.com>
References: <20200727140522.251815-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Right now, -no-reboot prevents secure guests from running. This is
correct from an implementation point of view, as we have modeled the
transition from non-secure to secure as a program directed IPL. From
a user perspective, this is not the behavior of least surprise.

We should implement the IPL into protected mode similar to the
functions that we use for kdump/kexec. In other words, we do not stop
here when -no-reboot is specified on the command line. Like function 0
or function 1, function 10 is not a classic reboot. For example, it
can only be called once. Before calling it a second time, a real
reboot/reset must happen in-between. So function code 10 is more or
less a state transition reset, but not a "standard" reset or reboot.

Fixes: 4d226deafc44 ("s390x: protvirt: Support unpack facility")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Message-Id: <20200721103202.30610-1-borntraeger@de.ibm.com>
[CH: tweaked description]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d46b1f094f75..3d2652d75abd 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -630,7 +630,8 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
         }
     }
     if (reset_type == S390_RESET_MODIFIED_CLEAR ||
-        reset_type == S390_RESET_LOAD_NORMAL) {
+        reset_type == S390_RESET_LOAD_NORMAL ||
+        reset_type == S390_RESET_PV) {
         /* ignore -no-reboot, send no event  */
         qemu_system_reset_request(SHUTDOWN_CAUSE_SUBSYSTEM_RESET);
     } else {
-- 
2.25.4


