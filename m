Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA124C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A2E20724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ6UYobr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A2E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sE2-0006r8-JG
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBm-0001pd-Nl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBk-0006Bc-No
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBk-0006BD-JN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2r3DDaMUaxbj3rtg/Mzlpifx0VyC9cejkjYt0rz/Y4=;
 b=EZ6UYobrPz04dm/P+JUMSEwZJyE7/GnLZaSmmD0T4h8A+Htt6Hw3yWHFZBYi97qMLqCWcN
 b6VBukt+Urws3lnCZ3c9/dOaAdlG1mGOtjxAfltAUQs6opXX8RTQpanZlD8F6u/BIoAZNK
 bazP0KDpbnMtGAe//wP3edMr3gTvDOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-gy8e3AlGN_qhsaTrgi2b2Q-1; Wed, 12 Feb 2020 08:36:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B618800D4E;
 Wed, 12 Feb 2020 13:36:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9411019C69;
 Wed, 12 Feb 2020 13:36:17 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] numa: Handle virtio-mem in NUMA stats
Date: Wed, 12 Feb 2020 14:35:49 +0100
Message-Id: <20200212133601.10555-5-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gy8e3AlGN_qhsaTrgi2b2Q-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Account the memory to the configured nide.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/numa.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 601cf9f603..4deb27ebee 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -855,10 +855,11 @@ static void numa_stat_memory_devices(NumaNodeMem node=
_mem[])
 {
     MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
     MemoryDeviceInfoList *info;
-    PCDIMMDeviceInfo     *pcdimm_info;
     VirtioPMEMDeviceInfo *vpi;
+    VirtioMEMDeviceInfo *vmi;
=20
     for (info =3D info_list; info; info =3D info->next) {
+        PCDIMMDeviceInfo *pcdimm_info =3D NULL;;
         MemoryDeviceInfo *value =3D info->value;
=20
         if (value) {
@@ -877,6 +878,11 @@ static void numa_stat_memory_devices(NumaNodeMem node_=
mem[])
                 node_mem[0].node_mem +=3D vpi->size;
                 node_mem[0].node_plugged_mem +=3D vpi->size;
                 break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
+                vmi =3D value->u.virtio_mem.data;
+                node_mem[vmi->node].node_mem +=3D vmi->size;
+                node_mem[vmi->node].node_plugged_mem +=3D vmi->size;
+                break;
             default:
                 g_assert_not_reached();
             }
--=20
2.24.1


