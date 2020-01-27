Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BAC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF0E20702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiiMnUhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF0E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzT6-0005Dl-PE
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ivzSP-0004oo-HN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ivzSO-0003Pm-8a
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:09:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ivzSO-0003PT-62
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580112555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yoJjZ2FMqCMP/rTFRctrXLtvAxEeEovA+1PQpRhYpg=;
 b=NiiMnUhD+1jEbhxl/CaSLbTuiYAInzSoIJHiTzDIfCFdYrmJzjIbHjemsoF8TjsW2tGXmG
 sBsIq6RjEBfazimjIx6SmKD4WzWuGEvD7PTDSKabipWFOUmtjQhltpXEmfhnjXvaXUV7ck
 blbV8ZEoj3ZE0e4bayVwuH6ez0JCPwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-omkf7XvwPmqDC41ReUPcew-1; Mon, 27 Jan 2020 03:09:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A61F810054E3;
 Mon, 27 Jan 2020 08:09:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8F198E619;
 Mon, 27 Jan 2020 08:09:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3.1 74/80] exec: cleanup
 qemu_minrampagesize()/qemu_maxrampagesize()
Date: Mon, 27 Jan 2020 09:06:48 +0100
Message-Id: <1580112408-93354-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-75-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-75-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: omkf7XvwPmqDC41ReUPcew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: thuth@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since all RAM is backed by hostmem backends, drop
global -mem-path invariant and simplify code.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
  * fix access to uninitialized pagesize/hpsize
    (David Gibson <david@gibson.dropbear.id.au>)

CC: thuth@redhat.com
CC: aik@ozlabs.ru
CC: mdroth@linux.vnet.ibm.com
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
CC: pbonzini@redhat.com
CC: rth@twiddle.net
---
 exec.c | 49 ++++---------------------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/exec.c b/exec.c
index 67e520d..9f5421c 100644
--- a/exec.c
+++ b/exec.c
@@ -1668,59 +1668,18 @@ static int find_max_backend_pagesize(Object *obj, v=
oid *opaque)
 long qemu_minrampagesize(void)
 {
     long hpsize =3D LONG_MAX;
-    long mainrampagesize;
-    Object *memdev_root;
-    MachineState *ms =3D MACHINE(qdev_get_machine());
-
-    mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
-
-    /* it's possible we have memory-backend objects with
-     * hugepage-backed RAM. these may get mapped into system
-     * address space via -numa parameters or memory hotplug
-     * hooks. we want to take these into account, but we
-     * also want to make sure these supported hugepage
-     * sizes are applicable across the entire range of memory
-     * we may boot from, so we take the min across all
-     * backends, and assume normal pages in cases where a
-     * backend isn't backed by hugepages.
-     */
-    memdev_root =3D object_resolve_path("/objects", NULL);
-    if (memdev_root) {
-        object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsi=
ze);
-    }
-    if (hpsize =3D=3D LONG_MAX) {
-        /* No additional memory regions found =3D=3D> Report main RAM page=
 size */
-        return mainrampagesize;
-    }
-
-    /* If NUMA is disabled or the NUMA nodes are not backed with a
-     * memory-backend, then there is at least one node using "normal" RAM,
-     * so if its page size is smaller we have got to report that size inst=
ead.
-     */
-    if (hpsize > mainrampagesize &&
-        (ms->numa_state =3D=3D NULL ||
-         ms->numa_state->num_nodes =3D=3D 0 ||
-         ms->numa_state->nodes[0].node_memdev =3D=3D NULL)) {
-        static bool warned;
-        if (!warned) {
-            error_report("Huge page support disabled (n/a for main memory)=
.");
-            warned =3D true;
-        }
-        return mainrampagesize;
-    }
+    Object *memdev_root =3D object_resolve_path("/objects", NULL);
=20
+    object_child_foreach(memdev_root, find_min_backend_pagesize, &hpsize);
     return hpsize;
 }
=20
 long qemu_maxrampagesize(void)
 {
-    long pagesize =3D qemu_mempath_getpagesize(mem_path);
+    long pagesize =3D 0;
     Object *memdev_root =3D object_resolve_path("/objects", NULL);
=20
-    if (memdev_root) {
-        object_child_foreach(memdev_root, find_max_backend_pagesize,
-                             &pagesize);
-    }
+    object_child_foreach(memdev_root, find_max_backend_pagesize, &pagesize=
);
     return pagesize;
 }
 #else
--=20
2.7.4


