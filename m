Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72781C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1C920753
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcikOzPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1C920753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFog-0000Pi-C1
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnR-00078O-K5
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnQ-0002dv-L3
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45834
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnQ-0002bG-Hb
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNhsHe1ks/W6vffoOtI59Fa/WOopBghzrWUoCJWtL3A=;
 b=gcikOzPe30EqattdNzwBIgKaFRkC78sATJKJ9dVBCqqnl8WaBmNbgJDWQ11upON+pHpUnU
 e1p/ihqkQa3XnWjJtU1kWogAC+ohuQeKefub7ujHeNeyhfygFaAVqsblVMnqnyOA3EpZa0
 acqB3pt7aKU/H2la+3viCoXbXQrI+WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-JUa2V2m1NlSuwIuOSKbsNQ-1; Sat, 11 Apr 2020 09:03:36 -0400
X-MC-Unique: JUa2V2m1NlSuwIuOSKbsNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DD8107ACC9
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 13:03:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B48DC98A2B;
 Sat, 11 Apr 2020 13:03:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] vl.c: error out if -mem-path is used together with -M
 memory-backend
Date: Sat, 11 Apr 2020 09:03:28 -0400
Message-Id: <20200411130330.1993-7-pbonzini@redhat.com>
In-Reply-To: <20200411130330.1993-1-pbonzini@redhat.com>
References: <20200411130330.1993-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

the former is not actually used by explicit backend, so instead of
silently ignoring the option in non valid context, exit with error.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200409134133.11339-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 58a40bcfc1..32c0047889 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4315,6 +4315,11 @@ void qemu_init(int argc, char **argv, char **envp)
                              "explicitly specified 'memory-backend' proper=
ty");
                 exit(EXIT_FAILURE);
         }
+        if (mem_path) {
+            error_report("'-mem-path' can't be used together with"
+                         "'-machine memory-backend'");
+            exit(EXIT_FAILURE);
+        }
         ram_size =3D backend_size;
     }
=20
--=20
2.18.2



