Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B000C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4D7206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9opr43o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4D7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3Uh-00045r-5h
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iw3Ny-0000Ij-UC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iw3Nv-0006lw-IH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iw3Nv-0006lT-8B
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580127654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJPpUMTl9xvd/yGy009EG4AZlQWW/AJ/DDOd21vVNMI=;
 b=S9opr43oU+Wy+3Tn63EMrVKGA4PZyWmJo9nnNmACH8ZC5IAyxPFgbxhQxaqpvR8yMJuZuh
 wfO0e07IxxJxtklTO5mpdyhErUGypqt4bvW/E/aYwCWlTWq66SzqfrhuiQDtg+s8Typ6Um
 j6K/HEhhHidD28yC0smaEZqXssYCAS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-3Dmfx6KROdSYzPubOzBI5A-1; Mon, 27 Jan 2020 07:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A91548010C9;
 Mon, 27 Jan 2020 12:20:50 +0000 (UTC)
Received: from localhost (ovpn-116-220.ams2.redhat.com [10.36.116.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0D2D8702A;
 Mon, 27 Jan 2020 12:20:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/15] target/s390x/kvm: Enable adapter interruption
 suppression again
Date: Mon, 27 Jan 2020 13:20:09 +0100
Message-Id: <20200127122016.18752-9-cohuck@redhat.com>
In-Reply-To: <20200127122016.18752-1-cohuck@redhat.com>
References: <20200127122016.18752-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3Dmfx6KROdSYzPubOzBI5A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The AIS feature has been disabled late in the v2.10 development cycle since
there were some issues with migration (see commit 3f2d07b3b01ea61126b -
"s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
to enable it again for newer machine types, but apparently we forgot to do
this so far. Let's do it now for the machines that support proper CPU model=
s.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1756946
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200122101437.5069-1-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 15260aeb9aac..30112e529c2e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -365,10 +365,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     /*
      * The migration interface for ais was introduced with kernel 4.13
      * but the capability itself had been active since 4.12. As migration
-     * support is considered necessary let's disable ais in the 2.10
-     * machine.
+     * support is considered necessary, we only try to enable this for
+     * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
      */
-    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
+    if (cpu_model_allowed() && kvm_kernel_irqchip_allowed() &&
+        kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
+        kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+    }
=20
     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
     return 0;
--=20
2.21.1


