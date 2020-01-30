Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E7D2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDCVml6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E7D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHgS-0002pu-CC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHWc-0002Oy-Nf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHWb-0000sd-18
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHWa-0000op-D3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bJ8TzHQALlGcsbo6CfAHKgxLT0lBqzcK+7zzlvq1Zs=;
 b=bDCVml6qB/VWmaMTxLWCwfTAYcFeU2ZvmqpIg3BB8xo5mgKsoa2DPxBG9NIpq8idw5o2Iy
 U8QTasgG0fqAl/uSwkjtb3MwzLJ2GNXK1nAeMDR173dFTwUMLlFnGqgbliT/AHxgDhDnwv
 XWPWsU8k/lb6+lHdoOvuM3uaa8bqBbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-kCCDpSp0M3aETlBpPT3fLg-1; Thu, 30 Jan 2020 16:38:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9443118A6EC1;
 Thu, 30 Jan 2020 21:38:39 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C141960BE0;
 Thu, 30 Jan 2020 21:38:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] memory.c: Use trace_event_get_state_backends()
Date: Thu, 30 Jan 2020 21:38:12 +0000
Message-Id: <20200130213814.334195-4-stefanha@redhat.com>
In-Reply-To: <20200130213814.334195-1-stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kCCDpSp0M3aETlBpPT3fLg-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The preferred way to test whether a trace event is enabled is to
use trace_event_get_state_backends(), because this will give the
correct answer (allowing expensive computations to be skipped)
whether the trace event is compile-time or run-time disabled.
Convert the four old-style direct uses of TRACE_FOO_ENABLED in
memory.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200120151142.18954-3-peter.maydell@linaro.org
Message-Id: <20200120151142.18954-3-peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 854798791e..aeaa8dcc9e 100644
--- a/memory.c
+++ b/memory.c
@@ -434,7 +434,7 @@ static MemTxResult  memory_region_read_accessor(MemoryR=
egion *mr,
     tmp =3D mr->ops->read(mr->opaque, addr, size);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, s=
ize);
-    } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ=
)) {
         hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, s=
ize);
     }
@@ -456,7 +456,7 @@ static MemTxResult memory_region_read_with_attrs_access=
or(MemoryRegion *mr,
     r =3D mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
     if (mr->subpage) {
         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, s=
ize);
-    } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ=
)) {
         hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, s=
ize);
     }
@@ -476,7 +476,7 @@ static MemTxResult memory_region_write_accessor(MemoryR=
egion *mr,
=20
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, =
size);
-    } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRIT=
E)) {
         hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, =
size);
     }
@@ -496,7 +496,7 @@ static MemTxResult memory_region_write_with_attrs_acces=
sor(MemoryRegion *mr,
=20
     if (mr->subpage) {
         trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp, =
size);
-    } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
+    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_WRIT=
E)) {
         hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
         trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp, =
size);
     }
--=20
2.24.1


