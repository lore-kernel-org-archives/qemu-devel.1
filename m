Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED653C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE5D2468D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQvAd3fO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE5D2468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GFl-0007qX-UE
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j7GAt-00032j-6b
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j7GAs-0006Iw-5n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:13:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55255
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j7GAs-0006EZ-1P
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582798425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMudDymxhn5SYN8zB8osoTwCL+VNgZTY4vrznHYmidc=;
 b=eQvAd3fOyO4PRAUpPDITfhLKEQdvlL20O6nz1ESV4nbNAp7nvN5CufJFFcbpCzSzvOGB48
 EXBPFqK0IgQ/iuxMMBvPNsCxacDhCZ2aUFStRcTVnSOt8ruSbudlqXjvKKFEPk8fCinU+4
 WZL6ckPITKr14abnE6wNBvVZUgNkaZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-VH5RIL7ANKGMIbL5DCQQvQ-1; Thu, 27 Feb 2020 05:13:44 -0500
X-MC-Unique: VH5RIL7ANKGMIbL5DCQQvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD9EC107B7DB;
 Thu, 27 Feb 2020 10:13:42 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C8F96E3EE;
 Thu, 27 Feb 2020 10:13:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/15] exec: Reuse qemu_ram_apply_settings() in
 qemu_ram_remap()
Date: Thu, 27 Feb 2020 11:11:55 +0100
Message-Id: <20200227101205.5616-6-david@redhat.com>
In-Reply-To: <20200227101205.5616-1-david@redhat.com>
References: <20200227101205.5616-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't see why we shouldn't apply all settings to make it look like the
surrounding RAM (and enable proper VMA merging).

Note: memory backend settings might have overridden these settings. We
would need a callback to let the memory backend fix that up.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index a0a8d93fee..1fc1fa237e 100644
--- a/exec.c
+++ b/exec.c
@@ -2516,8 +2516,7 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t lengt=
h)
                                  length, addr);
                     exit(1);
                 }
-                memory_try_enable_merging(vaddr, length);
-                qemu_ram_setup_dump(vaddr, length);
+                qemu_ram_apply_settings(vaddr, length);
             }
         }
     }
--=20
2.24.1


