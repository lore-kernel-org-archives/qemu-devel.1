Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCCBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C348214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuuStCrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C348214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqzQ-0004RM-Ps
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMqsk-0006GI-8C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMqsi-0005ql-V6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMqsi-0005qV-Ru
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REel0uxylpp8LiKeGnsU0Tx+Qcl79+GyTo3iyWFgAIU=;
 b=BuuStCrXOS3XL/qayCuj7yTeOs4/ZTkwCaZB0eFiKWU3QyNfr5nimrKWF5+80sZDUk26Wo
 e4arE1qOyHKegLFRvOH/cHvr8bz39CqbIFS/ScCsEuCduTqSIsBRFiZnZKBakb71MAjEXF
 CAoyf8Uk3gnX7FopmfHcA1nOp7lwCsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-OGME-PpTOhe5mpuEFc-jTA-1; Tue, 22 Oct 2019 05:55:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E72FA80183E;
 Tue, 22 Oct 2019 09:55:07 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 013195C1D4;
 Tue, 22 Oct 2019 09:55:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 9/9] s390x/kvm: Set default cpu model for all machine classes
Date: Tue, 22 Oct 2019 11:54:28 +0200
Message-Id: <20191022095428.20780-10-cohuck@redhat.com>
In-Reply-To: <20191022095428.20780-1-cohuck@redhat.com>
References: <20191022095428.20780-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OGME-PpTOhe5mpuEFc-jTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

We have to set the default model of all machine classes, not just for
the active one. Otherwise, "query-machines" will indicate the wrong
CPU model ("qemu-s390x-cpu" instead of "host-s390x-cpu") as
"default-cpu-type".

Doing a
    {"execute":"query-machines"}
under KVM now results in
    {"return": [
        {
            "hotpluggable-cpus": true,
            "name": "s390-ccw-virtio-4.0",
            "numa-mem-supported": false,
            "default-cpu-type": "host-s390x-cpu",
            "cpu-max": 248,
            "deprecated": false},
        {
            "hotpluggable-cpus": true,
            "name": "s390-ccw-virtio-2.7",
            "numa-mem-supported": false,
            "default-cpu-type": "host-s390x-cpu",
            "cpu-max": 248,
            "deprecated": false
        } ...

Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
currently see the wrong CPU model under KVM.

Reported-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: b6805e127c6b ("s390x: use generic cpu_model parsing")
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20191021100515.6978-1-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c24c869e7703..0c9d14b4b115 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -320,11 +320,17 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Err=
or **errp)
     cap_hpage_1m =3D 1;
 }
=20
-int kvm_arch_init(MachineState *ms, KVMState *s)
+static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
 {
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    MachineClass *mc =3D MACHINE_CLASS(oc);
=20
     mc->default_cpu_type =3D S390_CPU_TYPE_NAME("host");
+}
+
+int kvm_arch_init(MachineState *ms, KVMState *s)
+{
+    object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
+                         false, NULL);
=20
     if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
         error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
--=20
2.21.0


