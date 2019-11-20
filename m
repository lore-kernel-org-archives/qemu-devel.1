Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA384C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56BA208A3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiCGJR/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56BA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTVZ-0008HK-RX
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iXTUU-00061o-CD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iXTUT-0007Uw-D8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:10:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iXTUT-0007Uc-9J
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574269804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E1GfN4jf+6b03TESN6F4TGDMTMShcKvS1cafQ2s9NiY=;
 b=AiCGJR/i31GsDPdj729M9NvmPCdJKHoJNoD+pxINAhSJZsFZ3IpxZgQIvD9tmswv143xmQ
 pSjIcg8iCeUMEoEbkh9PR96zV2cy83zfCnPQ+7iWABHMjHooINU/2+XhnpzSjZNjjJjaMd
 vnLJ7j5DHJPGaxaWtRV6RvncmkUaOU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-mS7MQsHyOXywL0RfX9fmeQ-1; Wed, 20 Nov 2019 12:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0C928018A3;
 Wed, 20 Nov 2019 17:10:01 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-216.ams2.redhat.com
 [10.36.116.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8001F605C7;
 Wed, 20 Nov 2019 17:09:56 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pseries: disable migration-test if /dev/kvm cannot be used
Date: Wed, 20 Nov 2019 18:09:55 +0100
Message-Id: <20191120170955.242900-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mS7MQsHyOXywL0RfX9fmeQ-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ppc64, migration-test only works with kvm_hv, and we already
have a check to verify the module is loaded.

kvm_hv module can be loaded in memory and /sys/module/kvm_hv exists,
but on some systems (like build systems) /dev/kvm can be missing
(by administrators choice).

And as kvm_hv exists test-migration is started but QEMU falls back to
TCG because it cannot be used:

    Could not access KVM kernel module: No such file or directory
    failed to initialize KVM: No such file or directory
    Back to tcg accelerator

And as the test is done with TCG, it fails.

As for s390x, we must check for the existence and the access rights
of /dev/kvm.

Reported-by: Cole Robinson <crobinso@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index ac780dffdaad..2b25ba6d77f6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -1349,7 +1349,8 @@ int main(int argc, char **argv)
      * some reason)
      */
     if (g_str_equal(qtest_get_arch(), "ppc64") &&
-        access("/sys/module/kvm_hv", F_OK)) {
+        (access("/sys/module/kvm_hv", F_OK) ||
+         access("/dev/kvm", R_OK | W_OK))) {
         g_test_message("Skipping test: kvm_hv not available");
         return g_test_run();
     }
--=20
2.23.0


