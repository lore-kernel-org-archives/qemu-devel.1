Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA61DC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92CF206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K32mckEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92CF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGqL-0003mg-Sk
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhm-0005at-Sl
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:51:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jWGhl-00052p-CC
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588758663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPYy5xjngtAqGsyw4OWH5Hdfo7Ahip1m9nldPmeLgtA=;
 b=K32mckECEvZa3R7CdL5EN+oq1noP9tShMvgV0MN9tbFSddmUkY/BMvmZxixFc7XTsNQRzK
 nyGHpH8HRFHwDhaPdWosBX8koUIg+TvNdbvVg3KqNXJdC+qSdJFyuG/pSftDUbFdQGvW6n
 g6QwaOGsKanwrACL1P2pJ3KybFV0+vI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-4NIsTY3ePFGNQHX65Cxkwg-1; Wed, 06 May 2020 05:50:59 -0400
X-MC-Unique: 4NIsTY3ePFGNQHX65Cxkwg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD4B1800D4A;
 Wed,  6 May 2020 09:50:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-17.ams2.redhat.com [10.36.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E345C1BD;
 Wed,  6 May 2020 09:50:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 14/17] numa: Handle virtio-mem in NUMA stats
Date: Wed,  6 May 2020 11:49:45 +0200
Message-Id: <20200506094948.76388-15-david@redhat.com>
In-Reply-To: <20200506094948.76388-1-david@redhat.com>
References: <20200506094948.76388-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Account the memory to the configured nid.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/numa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 316bc50d75..06960918e7 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -812,6 +812,7 @@ static void numa_stat_memory_devices(NumaNodeMem node=
_mem[])
     MemoryDeviceInfoList *info;
     PCDIMMDeviceInfo     *pcdimm_info;
     VirtioPMEMDeviceInfo *vpi;
+    VirtioMEMDeviceInfo *vmi;
=20
     for (info =3D info_list; info; info =3D info->next) {
         MemoryDeviceInfo *value =3D info->value;
@@ -832,6 +833,11 @@ static void numa_stat_memory_devices(NumaNodeMem nod=
e_mem[])
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
2.25.3


