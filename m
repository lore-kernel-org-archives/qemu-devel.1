Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C0CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1A1206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIDNhI4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1A1206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMU7g-0001Xt-RB
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iMU5k-0008FY-9L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iMU5j-0006fz-6y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:35:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20679
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iMU5i-0006fn-Q8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571650506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=452rOFHLZuQ69THyBeLG2H1IImc4AIS+WhLwuY/U5iE=;
 b=NIDNhI4lZfBedPpHbrS0faa0TTKDDAeOcYGHy/XptR4FyQpG/3/YquCHENi4sAivMb+ppF
 GL8dW+4ca7dj8TwnBYjmKS/rcZ4Aa2UcxTy4S6EwZ96LAnT8skNLrdJrcX9Y2oz/ZP3pN1
 B1ZmhZpIN0UPLL1zy+ub/Un6iLFPgyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-d1mxQ4ObPoGznjf_dza4Iw-1; Mon, 21 Oct 2019 05:35:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A541D100550E;
 Mon, 21 Oct 2019 09:35:01 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-198.ams2.redhat.com [10.36.116.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 368C060BE2;
 Mon, 21 Oct 2019 09:34:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] s390x/kvm: Set default cpu model for all machine classes
Date: Mon, 21 Oct 2019 11:34:56 +0200
Message-Id: <20191021093456.6168-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: d1mxQ4ObPoGznjf_dza4Iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Reported-by: Jiri Denemark <jdenemar@redhat.com>
Fixes: b6805e127c6b ("s390x: use generic cpu_model parsing")
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/kvm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c24c869e77..5966ab0d37 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -320,11 +320,17 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Err=
or **errp)
     cap_hpage_1m =3D 1;
 }
=20
-int kvm_arch_init(MachineState *ms, KVMState *s)
+static void ccw_machine_class_foreach(ObjectClass *klass, void *opaque)
 {
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    MachineClass *mc =3D MACHINE_CLASS(klass);
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


