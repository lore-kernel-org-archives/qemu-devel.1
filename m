Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695AC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75F3222CD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Br4rWfq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75F3222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWm5C-0001lm-Dz
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iWm2z-0000Mb-Tc
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iWm2x-0002ZM-Ea
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47679
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iWm2x-0002Z7-AK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574102806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbzCWQhkAFYr3RWem9Ik6YNZkGt6jUdUsAYdYydrjPM=;
 b=Br4rWfq97SpS3AD9MZ1LWmr88RyeBLsrO8W6cJTEHMWIoV2abo4Bx6zrwYAIEYby/WF2Rz
 muUwuO7gnymo3DukdXNkZHIq98BV/eC/c7PreCaurmUuuLNhFGluEA8ZWr0vbZ7NgMSBrq
 Hf/Q8QimvIv1sQIzwXsCrAo6ub9Jkqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-3J8vg4KAOI21H6qa00wrIw-1; Mon, 18 Nov 2019 13:46:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 182A4800EBA
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 18:46:44 +0000 (UTC)
Received: from gimli.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D10891036C81;
 Mon, 18 Nov 2019 18:46:41 +0000 (UTC)
Subject: [PULL 1/3] hw/vfio/pci: Fix double free of migration_blocker
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 18 Nov 2019 11:46:40 -0700
Message-ID: <157410279325.24655.3627393451907566053.stgit@gimli.home>
In-Reply-To: <157410270703.24655.9333886493163056872.stgit@gimli.home>
References: <157410270703.24655.9333886493163056872.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3J8vg4KAOI21H6qa00wrIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

When user tries to hotplug a VFIO device, but the operation fails
somewhere in the middle (in my testing it failed because of
RLIMIT_MEMLOCK forbidding more memory allocation), then a double
free occurs. In vfio_realize() the vdev->migration_blocker is
allocated, then something goes wrong which causes control to jump
onto 'error' label where the error is freed. But the pointer is
left pointing to invalid memory. Later, when
vfio_instance_finalize() is called, the memory is freed again.

In my testing the second hunk was sufficient to fix the bug, but
I figured the first hunk doesn't hurt either.

=3D=3D169952=3D=3D Invalid read of size 8
=3D=3D169952=3D=3D    at 0xA47DCD: error_free (error.c:266)
=3D=3D169952=3D=3D    by 0x4E0A18: vfio_instance_finalize (pci.c:3040)
=3D=3D169952=3D=3D    by 0x8DF74C: object_deinit (object.c:606)
=3D=3D169952=3D=3D    by 0x8DF7BE: object_finalize (object.c:620)
=3D=3D169952=3D=3D    by 0x8E0757: object_unref (object.c:1074)
=3D=3D169952=3D=3D    by 0x45079C: memory_region_unref (memory.c:1779)
=3D=3D169952=3D=3D    by 0x45376B: do_address_space_destroy (memory.c:2793)
=3D=3D169952=3D=3D    by 0xA5C600: call_rcu_thread (rcu.c:283)
=3D=3D169952=3D=3D    by 0xA427CB: qemu_thread_start (qemu-thread-posix.c:5=
19)
=3D=3D169952=3D=3D    by 0x80A8457: start_thread (in /lib64/libpthread-2.29=
.so)
=3D=3D169952=3D=3D    by 0x81C96EE: clone (in /lib64/libc-2.29.so)
=3D=3D169952=3D=3D  Address 0x143137e0 is 0 bytes inside a block of size 48=
 free'd
=3D=3D169952=3D=3D    at 0x4A342BB: free (vg_replace_malloc.c:530)
=3D=3D169952=3D=3D    by 0xA47E05: error_free (error.c:270)
=3D=3D169952=3D=3D    by 0x4E0945: vfio_realize (pci.c:3025)
=3D=3D169952=3D=3D    by 0x76A4FF: pci_qdev_realize (pci.c:2099)
=3D=3D169952=3D=3D    by 0x689B9A: device_set_realized (qdev.c:876)
=3D=3D169952=3D=3D    by 0x8E2C80: property_set_bool (object.c:2080)
=3D=3D169952=3D=3D    by 0x8E0EF6: object_property_set (object.c:1272)
=3D=3D169952=3D=3D    by 0x8E3FC8: object_property_set_qobject (qom-qobject=
.c:26)
=3D=3D169952=3D=3D    by 0x8E11DB: object_property_set_bool (object.c:1338)
=3D=3D169952=3D=3D    by 0x5E7BDD: qdev_device_add (qdev-monitor.c:673)
=3D=3D169952=3D=3D    by 0x5E81E5: qmp_device_add (qdev-monitor.c:798)
=3D=3D169952=3D=3D    by 0x9E18A8: do_qmp_dispatch (qmp-dispatch.c:132)
=3D=3D169952=3D=3D  Block was alloc'd at
=3D=3D169952=3D=3D    at 0x4A35476: calloc (vg_replace_malloc.c:752)
=3D=3D169952=3D=3D    by 0x51B1158: g_malloc0 (in /usr/lib64/libglib-2.0.so=
.0.6000.6)
=3D=3D169952=3D=3D    by 0xA47357: error_setv (error.c:61)
=3D=3D169952=3D=3D    by 0xA475D9: error_setg_internal (error.c:97)
=3D=3D169952=3D=3D    by 0x4DF8C2: vfio_realize (pci.c:2737)
=3D=3D169952=3D=3D    by 0x76A4FF: pci_qdev_realize (pci.c:2099)
=3D=3D169952=3D=3D    by 0x689B9A: device_set_realized (qdev.c:876)
=3D=3D169952=3D=3D    by 0x8E2C80: property_set_bool (object.c:2080)
=3D=3D169952=3D=3D    by 0x8E0EF6: object_property_set (object.c:1272)
=3D=3D169952=3D=3D    by 0x8E3FC8: object_property_set_qobject (qom-qobject=
.c:26)
=3D=3D169952=3D=3D    by 0x8E11DB: object_property_set_bool (object.c:1338)
=3D=3D169952=3D=3D    by 0x5E7BDD: qdev_device_add (qdev-monitor.c:673)

Fixes: f045a0104c8c ("vfio: unplug failover primary device before migration=
")
Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e6569a796850..9c165995df32 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2740,6 +2740,7 @@ static void vfio_realize(PCIDevice *pdev, Error **err=
p)
         if (err) {
             error_propagate(errp, err);
             error_free(vdev->migration_blocker);
+            vdev->migration_blocker =3D NULL;
             return;
         }
     }
@@ -3023,6 +3024,7 @@ error:
     if (vdev->migration_blocker) {
         migrate_del_blocker(vdev->migration_blocker);
         error_free(vdev->migration_blocker);
+        vdev->migration_blocker =3D NULL;
     }
 }
=20


