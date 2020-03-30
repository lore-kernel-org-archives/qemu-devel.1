Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8497C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF59A2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNgm9pbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF59A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxfN-0005zM-T3
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jIxdP-0002mk-2l
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jIxdN-00069g-DN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:51:34 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jIxdN-00068P-8Z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585587092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7/w/rIoSm/HqUimSv+sanRXug3k4lzfdzGcY0nPkh0=;
 b=cNgm9pbLpDbYFgzp157TB7wT4jVxLgU6O3DETz4lxGY+hmt9Trq7Lv4kZKlgVknZXqUwZS
 8x6E8y95AT0QOLz05laLF9WCHJjQoRW6Eb0IUh5+zzC+eAuKcq2sVHsE8sEsQMOPG0dqu4
 yd+6pY0N1gRRwGSjmUqF72aQP9QYG+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-XFQp1mv8NJKs_bgX0H0Gig-1; Mon, 30 Mar 2020 12:51:30 -0400
X-MC-Unique: XFQp1mv8NJKs_bgX0H0Gig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 352E6107BA99;
 Mon, 30 Mar 2020 16:51:29 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-227.ams2.redhat.com [10.36.113.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D477C194BB;
 Mon, 30 Mar 2020 16:51:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] s390x: Reject unaligned RAM sizes
Date: Mon, 30 Mar 2020 18:51:22 +0200
Message-Id: <20200330165122.34564-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Historically, we fixed up the RAM size (rounded it down), to fit into
storage increments (maximum number of storage increments is 1020). Since
commit 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM"), we no
longer consider the fixed-up size when allcoating the RAM block - which
will break migration.

Let's simply drop that manual fixup code and let the user supply sane
RAM sizes. This will bail out early when trying to migrate (and make
an existing guest with e.g., 12345 MB non-migratable), but maybe we
should have rejected such RAM sizes right from the beginning. One can
consider it a BUG that we don't supply what the user asked for.

As we no longer fixup maxram_size as well, make other users use ram_size
instead. Keep using maxram_size when setting the maximum ram size in KVM,
as that will come in handy in the future when supporting memory hotplug
(in contrast, storage keys and storage attributes for hotplugged memory
 will have to be migrated per RAM block in the future).

This fixes (or rather rejects early):

1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as the
   RAM block size changed.

2. Migrating upstream QEMU to upstream QEMU (e.g., with "-m 1235M"), as
   we receive storage attributes for memory we don't expect (as we fixed up
   ram_size and maxram_size).

Note that a migration from older QEMU is still possible - the migration
target has to be started with the properly (down) aligned size (e.g.,
"-m 1234M" instead of "-m 1235M"). The following table can be used to write
a conversion script to automate migration in environments where
this is relevant.

 VM size (<=3D) | Alignment
--------------------------
      1020M   |     1M
      2040M   |     2M
      4080M   |     4M
      8160M   |     8M
     16320M   |    16M
     32640M   |    32M
     65280M   |    64M
    130560M   |   128M
    261120M   |   256M
    522240M   |   512M
   1044480M   |     1G
   2088960M   |     2G
   4177920M   |     4G
   8355840M   |     8G

Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Don't use global ram_size
- Add more details how migration from older QEMU can still work, along
  with a table.

---
 hw/s390x/s390-skeys.c        |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  4 ++--
 hw/s390x/sclp.c              | 20 +++++++++++---------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5da6e5292f..a9a4ae7b39 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -176,7 +176,7 @@ static void qemu_s390_skeys_init(Object *obj)
     QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
     MachineState *machine =3D MACHINE(qdev_get_machine());
=20
-    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    skeys->key_count =3D machine->ram_size / TARGET_PAGE_SIZE;
     skeys->keydata =3D g_malloc0(skeys->key_count);
 }
=20
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index c7e1f35524..f89d8d9d16 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -85,7 +85,7 @@ static int kvm_s390_stattrib_set_stattr(S390StAttribState=
 *sa,
 {
     KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
=20
     if (start_gfn + count > max) {
         error_report("Out of memory bounds when setting storage attributes=
");
@@ -104,7 +104,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribS=
tate *sa)
 {
     KVMS390StAttribState *sas =3D KVM_S390_STATTRIB(sa);
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    unsigned long max =3D machine->maxram_size / TARGET_PAGE_SIZE;
+    unsigned long max =3D machine->ram_size / TARGET_PAGE_SIZE;
     /* We do not need to reach the maximum buffer size allowed */
     unsigned long cx, len =3D KVM_S390_SKEYS_MAX / 2;
     int r;
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index af0bfbc2ec..bbf6364511 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -327,7 +327,7 @@ out:
 static void sclp_memory_init(SCLPDevice *sclp)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    ram_addr_t initial_mem =3D machine->ram_size;
+    uint64_t initial_mem =3D machine->ram_size;
     int increment_size =3D 20;
=20
     /* The storage increment size is a multiple of 1M and is a power of 2.
@@ -339,15 +339,17 @@ static void sclp_memory_init(SCLPDevice *sclp)
     }
     sclp->increment_size =3D increment_size;
=20
-    /* The core memory area needs to be aligned with the increment size.
-     * In effect, this can cause the user-specified memory size to be roun=
ded
-     * down to align with the nearest increment boundary. */
+    /*
+     * The core memory area needs to be aligned to the increment size. In
+     * case it's not aligned, bail out.
+     */
     initial_mem =3D initial_mem >> increment_size << increment_size;
-
-    machine->ram_size =3D initial_mem;
-    machine->maxram_size =3D initial_mem;
-    /* let's propagate the changed ram size into the global variable. */
-    ram_size =3D initial_mem;
+    if (initial_mem !=3D machine->ram_size) {
+        error_report("RAM size not aligned to storage increments."
+                     " Possible aligned RAM size: %" PRIu64 " MB",
+                     initial_mem / MiB);
+        exit(1);
+    }
 }
=20
 static void sclp_init(Object *obj)
--=20
2.25.1


