Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8233C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C4F20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXPlms33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C4F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5zE-0006Wg-M8
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lm-0007vo-D4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lk-0004wm-SD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lk-0004wQ-Cq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkHcsJJDlzusy6gB61FxjZ/EXO5XoJeYd/a8T99x3TY=;
 b=fXPlms33GLK0KqsdWDlZhXFHMBFkR0+OGInDIo2e+yUheL5PtDHE/562hR66JGD8HTCu97
 szkDV0jzo0opVmHawHWuqRiLYrDM8M6Z5B0dctKsQnfbmww9yumZlQxTVp1u+/EYMK4FDk
 zvCYjv6GJKaZtFJkNCURNhD8Fy837II=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-YBIGzMTnN0WjiVyDhNYjcw-1; Thu, 30 Apr 2020 05:46:09 -0400
X-MC-Unique: YBIGzMTnN0WjiVyDhNYjcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1156E10082EA;
 Thu, 30 Apr 2020 09:46:08 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09769196AE;
 Thu, 30 Apr 2020 09:46:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/20] s390x: Add unpack facility feature to GA1
Date: Thu, 30 Apr 2020 11:44:42 +0200
Message-Id: <20200430094445.25943-18-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The unpack facility is an indication that diagnose 308 subcodes 8-10
are available to the guest. That means, that the guest can put itself
into protected mode.

Once it is in protected mode, the hardware stops any attempt of VM
introspection by the hypervisor.

Some features are currently not supported in protected mode:
     * vfio devices
     * Migration
     * Huge page backings

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200319131921.2367-17-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/gen-features.c | 1 +
 target/s390x/kvm.c          | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 6278845b12b8..8ddeebc54419 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -562,6 +562,7 @@ static uint16_t full_GEN15_GA1[] =3D {
     S390_FEAT_GROUP_MSA_EXT_9,
     S390_FEAT_GROUP_MSA_EXT_9_PCKMO,
     S390_FEAT_ETOKEN,
+    S390_FEAT_UNPACK,
 };
=20
 /* Default features (in order of release)
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 870dd1b52b6e..69881a0da0b3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2425,6 +2425,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model=
, Error **errp)
         clear_bit(S390_FEAT_BPB, model->features);
     }
=20
+    /*
+     * If we have support for protected virtualization, indicate
+     * the protected virtualization IPL unpack facility.
+     */
+    if (cap_protected) {
+        set_bit(S390_FEAT_UNPACK, model->features);
+    }
+
     /* We emulate a zPCI bus and AEN, therefore we don't need HW support *=
/
     set_bit(S390_FEAT_ZPCI, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
--=20
2.21.1


