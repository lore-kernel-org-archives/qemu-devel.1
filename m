Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF61C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5622074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtwmDZwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5622074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKS4-0000T0-Ul
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIb-00034G-J0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIW-00062Q-6Q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDGw8RS5yS0Ad+cF6EFO+debCWGbFVNQRHUBR33EE8U=;
 b=LtwmDZwRu3DJUbN3iwRu+b+dipoQAB2imRCHFzAdpb2bQ7DH4XMlnTZ7w5S6uTGPQtBc8U
 whOUDZugzX4vE2awzHS+65tDsUyHocNsEobfXD0obN1oeBEqNYbgjy2IQUt3ppgzRPviiA
 VrjNIrsMxyK/usTredcmi1GHEQvncrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-qh_U4VqkN5C6E6N3d9X95w-1; Wed, 04 Nov 2020 10:02:00 -0500
X-MC-Unique: qh_U4VqkN5C6E6N3d9X95w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B541016CE8;
 Wed,  4 Nov 2020 15:01:59 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 771E06EF6A;
 Wed,  4 Nov 2020 15:01:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] tests/qtest/libqos/ahci.c: Avoid NULL dereference in
 ahci_exec()
Date: Wed,  4 Nov 2020 10:01:43 -0500
Message-Id: <20201104150153.541326-11-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

In ahci_exec() we attempt to permit the caller to pass a NULL pointer
for opts_in (in which case we use a default set of options).  However
although we check for NULL when setting up the opts variable at the
top of the function, we unconditionally dereference opts_in at the
end of the function as part of freeing the opts->buffer.

Switch to checking whether the final buffer is the same as the
buffer we started with, instead of assuming the value we started
with is always opts_in->buffer.

At the moment all the callers pass a non-NULL opts argument, so
we never saw any crashes in practice.

Fixes: Coverity CID 1432302
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20201103115257.23623-1-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/libqos/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 2946abc15a..fba3e7a954 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -637,10 +637,13 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
     AHCICommand *cmd;
     int rc;
     AHCIOpts *opts;
+    uint64_t buffer_in;
 
     opts = g_memdup((opts_in == NULL ? &default_opts : opts_in),
                     sizeof(AHCIOpts));
 
+    buffer_in = opts->buffer;
+
     /* No guest buffer provided, create one. */
     if (opts->size && !opts->buffer) {
         opts->buffer = ahci_alloc(ahci, opts->size);
@@ -686,7 +689,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
         g_assert_cmpint(rc, ==, 0);
     }
     ahci_command_free(cmd);
-    if (opts->buffer != opts_in->buffer) {
+    if (opts->buffer != buffer_in) {
         ahci_free(ahci, opts->buffer);
     }
     g_free(opts);
-- 
2.26.2



