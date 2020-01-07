Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D21C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E41F2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjewaGEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E41F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorwU-0006Sb-TM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorlF-00084v-DI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlE-0005Wi-2N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorkl-0005Gu-PA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLV8rQCbLBZmY0FVDGOQq3AQD9eSmdJYBYmhF7NfsUU=;
 b=HjewaGEfJzQo92hvUs/AR4p9ZYeRe2N8kuzt2bXvCZywiWbSQUzsrtxCem3/sqaht/kMQ4
 39HLUWINzJ+zZrAa/ZDJsjYgF0iAGmm3oHTxcYp0f8bWPfL6u38ZpTLB6z9NA8D10oXnGb
 58zjXr1C9BBB53QaSqSp1pxxVrb0JcU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115--Yt23CJmOf2UDMdu_g5Jig-1; Tue, 07 Jan 2020 11:30:44 -0500
Received: by mail-qv1-f70.google.com with SMTP id n11so232368qvp.15
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3qP/C/NttECQ066FqPp6xPe1UgZkrZPuw+r54Uke8BM=;
 b=GyU9hvazJM+KSiZZoqsZ8JiFDf2QqT915PilNXrGrobV5zoIhEDoozSU/oDNYAIm3u
 cMKGSiaH+EQt3oZqopWXSeqzxlku1y9GYrbctEvAc8TF/CrNjSSbfQvAgf6Aw3ZaaXo2
 KLxbqoNJ2wIZbehpnS5qoHhQs4Q5f/Foo4ZlZ1gcDsAL7yqcD6nwXmoa4Y+fHXo0qFKW
 x+pt7nQ+Mr9p3wjNCIRtHGRnNTnA1bYuISkxLHjo2qJoduqXOtvGpzROAIPsoM1tfTDo
 rinMKjdycB7Er3uLMjjarx20RpNOxV/3rJpSBxntAv2cenWzWMgMa2lVpHc4tV8G5Wn/
 zv+w==
X-Gm-Message-State: APjAAAWxEwRKBOoTG5nohPt1MW1HPhnTJVz28dypOEEVqIBEys+XS3SS
 F9xI6+Aa4v9czL69ujlt7R3m1dVOQxJtSSZ36kRZn5OUxIrL/qicsMw0bOipbqG1Bo82q/oHB4x
 ePMPpBA2EUqg9mig=
X-Received: by 2002:a37:e10f:: with SMTP id c15mr97758qkm.331.1578414643729;
 Tue, 07 Jan 2020 08:30:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXnH72yEnhryaaxGH1hUxkVE5gAuNrPlnSrf3PyNeUX2NBiWnnmzaIPdZnt4F74OumB8Y5IQ==
X-Received: by 2002:a37:e10f:: with SMTP id c15mr97735qkm.331.1578414643427;
 Tue, 07 Jan 2020 08:30:43 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id c3sm49024qkk.8.2020.01.07.08.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:42 -0800 (PST)
Date: Tue, 7 Jan 2020 11:30:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 15/32] hmat acpi: Build System Locality Latency and
 Bandwidth Information Structure(s)
Message-ID: <20200107162850.411448-16-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: -Yt23CJmOf2UDMdu_g5Jig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Liu Jingqi <jingqi.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

This structure describes the memory access latency and bandwidth
information from various memory access initiator proximity domains.
The latency and bandwidth numbers represented in this structure
correspond to rated latency and bandwidth for the platform.
The software could use this information as hint for optimization.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-6-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/hmat.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 9ff79308a4..4635d45dee 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -25,6 +25,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "sysemu/numa.h"
 #include "hw/acpi/hmat.h"
=20
@@ -67,11 +68,89 @@ static void build_hmat_mpda(GArray *table_data, uint16_=
t flags,
     build_append_int_noprefix(table_data, 0, 8);
 }
=20
+/*
+ * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
+ * Structure: Table 5-146
+ */
+static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
+                          uint32_t num_initiator, uint32_t num_target,
+                          uint32_t *initiator_list)
+{
+    int i, index;
+    HMAT_LB_Data *lb_data;
+    uint16_t *entry_list;
+    uint32_t base;
+    /* Length in bytes for entire structure */
+    uint32_t lb_length
+        =3D 32 /* Table length upto and including Entry Base Unit */
+        + 4 * num_initiator /* Initiator Proximity Domain List */
+        + 4 * num_target /* Target Proximity Domain List */
+        + 2 * num_initiator * num_target; /* Latency or Bandwidth Entries =
*/
+
+    /* Type */
+    build_append_int_noprefix(table_data, 1, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, lb_length, 4);
+    /* Flags: Bits [3:0] Memory Hierarchy, Bits[7:4] Reserved */
+    assert(!(hmat_lb->hierarchy >> 4));
+    build_append_int_noprefix(table_data, hmat_lb->hierarchy, 1);
+    /* Data Type */
+    build_append_int_noprefix(table_data, hmat_lb->data_type, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Number of Initiator Proximity Domains (s) */
+    build_append_int_noprefix(table_data, num_initiator, 4);
+    /* Number of Target Proximity Domains (t) */
+    build_append_int_noprefix(table_data, num_target, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    /* Entry Base Unit */
+    if (hmat_lb->data_type <=3D HMAT_LB_DATA_WRITE_LATENCY) {
+        /* Convert latency base from nanoseconds to picosecond */
+        base =3D hmat_lb->base * 1000;
+    } else {
+        /* Convert bandwidth base from Byte to Megabyte */
+        base =3D hmat_lb->base / MiB;
+    }
+    build_append_int_noprefix(table_data, base, 8);
+
+    /* Initiator Proximity Domain List */
+    for (i =3D 0; i < num_initiator; i++) {
+        build_append_int_noprefix(table_data, initiator_list[i], 4);
+    }
+
+    /* Target Proximity Domain List */
+    for (i =3D 0; i < num_target; i++) {
+        build_append_int_noprefix(table_data, i, 4);
+    }
+
+    /* Latency or Bandwidth Entries */
+    entry_list =3D g_malloc0(num_initiator * num_target * sizeof(uint16_t)=
);
+    for (i =3D 0; i < hmat_lb->list->len; i++) {
+        lb_data =3D &g_array_index(hmat_lb->list, HMAT_LB_Data, i);
+        index =3D lb_data->initiator * num_target + lb_data->target;
+
+        entry_list[index] =3D (uint16_t)(lb_data->data / hmat_lb->base);
+    }
+
+    for (i =3D 0; i < num_initiator * num_target; i++) {
+        build_append_int_noprefix(table_data, entry_list[i], 2);
+    }
+
+    g_free(entry_list);
+}
+
 /* Build HMAT sub table structures */
 static void hmat_build_table_structs(GArray *table_data, NumaState *numa_s=
tate)
 {
     uint16_t flags;
-    int i;
+    uint32_t num_initiator =3D 0;
+    uint32_t initiator_list[MAX_NODES];
+    int i, hierarchy, type;
+    HMAT_LB_Info *hmat_lb;
=20
     for (i =3D 0; i < numa_state->num_nodes; i++) {
         flags =3D 0;
@@ -82,6 +161,29 @@ static void hmat_build_table_structs(GArray *table_data=
, NumaState *numa_state)
=20
         build_hmat_mpda(table_data, flags, numa_state->nodes[i].initiator,=
 i);
     }
+
+    for (i =3D 0; i < numa_state->num_nodes; i++) {
+        if (numa_state->nodes[i].has_cpu) {
+            initiator_list[num_initiator++] =3D i;
+        }
+    }
+
+    /*
+     * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Informatio=
n
+     * Structure: Table 5-146
+     */
+    for (hierarchy =3D HMAT_LB_MEM_MEMORY;
+         hierarchy <=3D HMAT_LB_MEM_CACHE_3RD_LEVEL; hierarchy++) {
+        for (type =3D HMAT_LB_DATA_ACCESS_LATENCY;
+             type <=3D HMAT_LB_DATA_WRITE_BANDWIDTH; type++) {
+            hmat_lb =3D numa_state->hmat_lb[hierarchy][type];
+
+            if (hmat_lb && hmat_lb->list->len) {
+                build_hmat_lb(table_data, hmat_lb, num_initiator,
+                              numa_state->num_nodes, initiator_list);
+            }
+        }
+    }
 }
=20
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_st=
ate)
--=20
MST


