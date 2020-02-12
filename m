Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0DC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3F520659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R42hRv3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3F520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sHQ-0004Kn-8P
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sC0-0002O7-SW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBz-0006Nn-GJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52806
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBz-0006NV-CK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EJilu8UQEI4Ua/3JwUxBBHVuhlt2FuhAXQHVUGsLTc=;
 b=R42hRv3/+N85+5K+XwsJTWU2qmYd9V/YBWzjAKX/kKvp03bfRZ/GzcKjUMnnrTKAQoa7jI
 BsHGGSvqrvW65zZ9SkI/Gx2TrcmgQabBSkoUlywGbChlv3YS90cmZASsQcFsiFQA7Y6Dxf
 DR2DaGDJNWG+JnVDNIegexOmFUj0jik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-67-pY_7JN4uM5wcOc2HeTg-1; Wed, 12 Feb 2020 08:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CB219057A2;
 Wed, 12 Feb 2020 13:36:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0B7F19C69;
 Wed, 12 Feb 2020 13:36:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/16] hostmem: Factor out applying settings
Date: Wed, 12 Feb 2020 14:35:55 +0100
Message-Id: <20200212133601.10555-11-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 67-pY_7JN4uM5wcOc2HeTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to reuse the functionality when resizing resizable memory
region.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 backends/hostmem.c | 137 +++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 61 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index e773bdfa6e..2c8e4567e1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -308,15 +308,85 @@ size_t host_memory_backend_pagesize(HostMemoryBackend=
 *memdev)
 }
 #endif
=20
+static void host_memory_backend_apply_settings(HostMemoryBackend *backend,
+                                               Error **errp)
+{
+    const uint64_t sz =3D memory_region_size(&backend->mr);
+    void *ptr =3D memory_region_get_ram_ptr(&backend->mr);
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    Error *local_err =3D NULL;
+
+    if (backend->merge) {
+        qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
+    }
+    if (!backend->dump) {
+        qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
+    }
+#ifdef CONFIG_NUMA
+   unsigned long lastbit =3D find_last_bit(backend->host_nodes, MAX_NODES)=
;
+   /* lastbit =3D=3D MAX_NODES means maxnode =3D 0 */
+   unsigned long maxnode =3D (lastbit + 1) % (MAX_NODES + 1);
+   /*
+    * Ensure policy won't be ignored in case memory is preallocated before
+    * mbind(). note: MPOL_MF_STRICT is ignored on hugepages so this doesn'=
t
+    * catch hugepage case.
+    */
+   unsigned flags =3D MPOL_MF_STRICT | MPOL_MF_MOVE;
+
+   /*
+    * Check for invalid host-nodes and policies and give more verbose erro=
r
+    * messages than mbind().
+    */
+   if (maxnode && backend->policy =3D=3D MPOL_DEFAULT) {
+       error_setg(errp, "host-nodes must be empty for policy default,"
+                  " or you should explicitly specify a policy other"
+                  " than default");
+       return;
+   } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAULT) {
+       error_setg(errp, "host-nodes must be set for policy %s",
+                  HostMemPolicy_str(backend->policy));
+       return;
+   }
+
+   /*
+    * We can have up to MAX_NODES nodes, but we need to pass maxnode+1 as
+    * argument to mbind() due to an old Linux bug (feature?) which cuts of=
f the
+    * last specified node. This means backend->host_nodes must have MAX_NO=
DES+1
+    * bits available.
+    */
+   assert(sizeof(backend->host_nodes) >=3D
+          BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
+   assert(maxnode <=3D MAX_NODES);
+   if (mbind(ptr, sz, backend->policy,
+             maxnode ? backend->host_nodes : NULL, maxnode + 1, flags)) {
+       if (backend->policy !=3D MPOL_DEFAULT || errno !=3D ENOSYS) {
+           error_setg_errno(errp, errno,
+                            "cannot bind memory to host NUMA nodes");
+           return;
+       }
+   }
+#endif
+    /*
+     * Preallocate memory after the NUMA policy has been instantiated. Thi=
s is
+     * necessary to guarantee memory is allocated with specified NUMA poli=
cy
+     * in place.
+     */
+    if (backend->prealloc) {
+        os_mem_prealloc(memory_region_get_fd(&backend->mr), ptr, sz,
+                        ms->smp.cpus, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+}
+
 static void
 host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
 {
     HostMemoryBackend *backend =3D MEMORY_BACKEND(uc);
     HostMemoryBackendClass *bc =3D MEMORY_BACKEND_GET_CLASS(uc);
-    MachineState *ms =3D MACHINE(qdev_get_machine());
     Error *local_err =3D NULL;
-    void *ptr;
-    uint64_t sz;
=20
     if (bc->alloc) {
         bc->alloc(backend, &local_err);
@@ -324,64 +394,9 @@ host_memory_backend_memory_complete(UserCreatable *uc,=
 Error **errp)
             goto out;
         }
=20
-        ptr =3D memory_region_get_ram_ptr(&backend->mr);
-        sz =3D memory_region_size(&backend->mr);
-
-        if (backend->merge) {
-            qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
-        }
-        if (!backend->dump) {
-            qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
-        }
-#ifdef CONFIG_NUMA
-        unsigned long lastbit =3D find_last_bit(backend->host_nodes, MAX_N=
ODES);
-        /* lastbit =3D=3D MAX_NODES means maxnode =3D 0 */
-        unsigned long maxnode =3D (lastbit + 1) % (MAX_NODES + 1);
-        /* ensure policy won't be ignored in case memory is preallocated
-         * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
-         * this doesn't catch hugepage case. */
-        unsigned flags =3D MPOL_MF_STRICT | MPOL_MF_MOVE;
-
-        /* check for invalid host-nodes and policies and give more verbose
-         * error messages than mbind(). */
-        if (maxnode && backend->policy =3D=3D MPOL_DEFAULT) {
-            error_setg(errp, "host-nodes must be empty for policy default,=
"
-                       " or you should explicitly specify a policy other"
-                       " than default");
-            return;
-        } else if (maxnode =3D=3D 0 && backend->policy !=3D MPOL_DEFAULT) =
{
-            error_setg(errp, "host-nodes must be set for policy %s",
-                       HostMemPolicy_str(backend->policy));
-            return;
-        }
-
-        /* We can have up to MAX_NODES nodes, but we need to pass maxnode+=
1
-         * as argument to mbind() due to an old Linux bug (feature?) which
-         * cuts off the last specified node. This means backend->host_node=
s
-         * must have MAX_NODES+1 bits available.
-         */
-        assert(sizeof(backend->host_nodes) >=3D
-               BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
-        assert(maxnode <=3D MAX_NODES);
-        if (mbind(ptr, sz, backend->policy,
-                  maxnode ? backend->host_nodes : NULL, maxnode + 1, flags=
)) {
-            if (backend->policy !=3D MPOL_DEFAULT || errno !=3D ENOSYS) {
-                error_setg_errno(errp, errno,
-                                 "cannot bind memory to host NUMA nodes");
-                return;
-            }
-        }
-#endif
-        /* Preallocate memory after the NUMA policy has been instantiated.
-         * This is necessary to guarantee memory is allocated with
-         * specified NUMA policy in place.
-         */
-        if (backend->prealloc) {
-            os_mem_prealloc(memory_region_get_fd(&backend->mr), ptr, sz,
-                            ms->smp.cpus, &local_err);
-            if (local_err) {
-                goto out;
-            }
+        host_memory_backend_apply_settings(backend, &local_err);
+        if (local_err) {
+            goto out;
         }
     }
 out:
--=20
2.24.1


