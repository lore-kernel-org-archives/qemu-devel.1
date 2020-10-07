Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54E6206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUwUK3CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54E6206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8Fy-0007l2-I1
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84S-0001fP-Vd
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ84P-0001la-Iv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602071840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ceM7PphOnMySWLEUgFCdxPQq6ixQ0Q1whnbjS30O+vg=;
 b=DUwUK3CD0+3kFO8BqLrmToloGSg5MmEKiUeYewWM5d2RUJMgGXCAsN8ddrDMEITIzr0e7h
 q3rpRMFmNrrcg/LBm32VD4b25JEKKa89TLx1XG98REp1q6//ZI9mbN86CAswE2slXD5ksV
 JoH7YtAGuqYDs0sgCD9vibruMIhG6tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-gyCxVid0PFSEaPqf0VC6gQ-1; Wed, 07 Oct 2020 07:57:17 -0400
X-MC-Unique: gyCxVid0PFSEaPqf0VC6gQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26951007464;
 Wed,  7 Oct 2020 11:57:15 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D81560BEC;
 Wed,  7 Oct 2020 11:57:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/17] device_core: use drain_call_rcu in in qmp_device_add
Date: Wed,  7 Oct 2020 07:56:53 -0400
Message-Id: <20201007115700.707938-11-pbonzini@redhat.com>
In-Reply-To: <20201007115700.707938-1-pbonzini@redhat.com>
References: <20201007115700.707938-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Soon, a device removal might only happen on RCU callback execution.
This is okay for device-del which provides a DEVICE_DELETED event,
but not for the failure case of device-add.  To avoid changing
monitor semantics, just drain all pending RCU callbacks on error.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-4-mlevitsk@redhat.com>
[Don't use it in qmp_device_del. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/qdev-monitor.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index e9b7228480..bcfb90a08f 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -803,6 +803,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, errp);
+
+    /*
+     * Drain all pending RCU callbacks. This is done because
+     * some bus related operations can delay a device removal
+     * (in this case this can happen if device is added and then
+     * removed due to a configuration error)
+     * to a RCU callback, but user might expect that this interface
+     * will finish its job completely once qmp command returns result
+     * to the user
+     */
+    drain_call_rcu();
+
     if (!dev) {
         qemu_opts_del(opts);
         return;
-- 
2.26.2



