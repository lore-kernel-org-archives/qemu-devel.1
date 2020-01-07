Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23461C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30B8208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZdxdJAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30B8208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorwA-0005pP-GX
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorkx-0007iM-3W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorkv-0005Kz-Np
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51940
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorko-0005Id-Ow
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TnHo7VvJZaLFzHYDnog4vzTE/uU8KgG0+PD95HCZAE=;
 b=LZdxdJAILFFCpakFfq20FtISWKdSH2mu5FVzwY+MAv8ULSZ2CQ2L3kPW6mNPACXdG3ktKn
 GGVA5Izml4L90Xq3h+GylM/ljUkrTFYZJ6yjWk64+H7wFY/lJYggFjJPVZyYWq1bac35d3
 /0TZioq0uSzkQLzA087fJuOwMIK/kp8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-aqa2ZuW6OrejtwSoq3UWzw-1; Tue, 07 Jan 2020 11:30:49 -0500
Received: by mail-qv1-f69.google.com with SMTP id e14so250740qvr.6
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yLxJY7rN1k5OoWYN8rEjFXzk7p6lyE6U8ZaTa83HTg0=;
 b=Bme3pdXUrUGezCl3/zDyUkFkYe6bvmugosJlympXZOWypOX75D3ATyCQ27i55XBSBc
 sdKlwAcOZrWAfJN0CBHf89onubHj21EnGXAd0QMO4ecPEX9KQoGCfgzyMtW4vpxDe+kS
 50F88Wa5Rd+pV0thuTa2gb96PtAOoU+qhT05SqqarXXdKBF0L49T83hO6jeTzVlztqKY
 aq/ig7DzX0tpJqeD5b5Qdys1XjYO6v8cdll4WiQh4sWq42uPz7yuuJ1ntdfvVnm9KfOO
 xlBTkDlXuS0YfpCSyONEe3xJzH/F7JuuUcphbxwzo9I68oklpnZ3Vs+PL9d8g+KLeWWS
 XmDA==
X-Gm-Message-State: APjAAAXKar7Hm5BbrtQxGmzXwZWQ9Ghq0MMAc3Ou5MKwwvnyBwqPlnJ+
 WP9nUOTWqZ1BonWD58/U1O7Jv0oKzTfzioqNAMFZT+4xIr6rM0iGPx7cTN7H5sfKjlXJeiTi0kR
 dCGJWHoiQoEu1r30=
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr67899799qtn.156.1578414648319; 
 Tue, 07 Jan 2020 08:30:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWDX80KStv/ELPCNeed2iz8G5Ka9R7iIG/zuj/zoBKNQA7tKZv73aY8mvN8QrQclSqtCPZdg==
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr67899784qtn.156.1578414648096; 
 Tue, 07 Jan 2020 08:30:48 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 201sm45486qkf.10.2020.01.07.08.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:47 -0800 (PST)
Date: Tue, 7 Jan 2020 11:30:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 16/32] hmat acpi: Build Memory Side Cache Information
 Structure(s)
Message-ID: <20200107162850.411448-17-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: aqa2ZuW6OrejtwSoq3UWzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Liu Jingqi <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel Black <daniel@linux.ibm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

This structure describes memory side cache information for memory
proximity domains if the memory side cache is present and the
physical device forms the memory side cache.
The software could use this information to effectively place
the data in memory to maximize the performance of the system
memory that use the memory side cache.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-7-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/hmat.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 4635d45dee..7c24bb5371 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -143,14 +143,62 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB=
_Info *hmat_lb,
     g_free(entry_list);
 }
=20
+/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-147=
 */
+static void build_hmat_cache(GArray *table_data, uint8_t total_levels,
+                             NumaHmatCacheOptions *hmat_cache)
+{
+    /*
+     * Cache Attributes: Bits [3:0] =E2=80=93 Total Cache Levels
+     * for this Memory Proximity Domain
+     */
+    uint32_t cache_attr =3D total_levels;
+
+    /* Bits [7:4] : Cache Level described in this structure */
+    cache_attr |=3D (uint32_t) hmat_cache->level << 4;
+
+    /* Bits [11:8] - Cache Associativity */
+    cache_attr |=3D (uint32_t) hmat_cache->associativity << 8;
+
+    /* Bits [15:12] - Write Policy */
+    cache_attr |=3D (uint32_t) hmat_cache->policy << 12;
+
+    /* Bits [31:16] - Cache Line size in bytes */
+    cache_attr |=3D (uint32_t) hmat_cache->line << 16;
+
+    /* Type */
+    build_append_int_noprefix(table_data, 2, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 4);
+    /* Proximity Domain for the Memory */
+    build_append_int_noprefix(table_data, hmat_cache->node_id, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Memory Side Cache Size */
+    build_append_int_noprefix(table_data, hmat_cache->size, 8);
+    /* Cache Attributes */
+    build_append_int_noprefix(table_data, cache_attr, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /*
+     * Number of SMBIOS handles (n)
+     * Linux kernel uses Memory Side Cache Information Structure
+     * without SMBIOS entries for now, so set Number of SMBIOS handles
+     * as 0.
+     */
+    build_append_int_noprefix(table_data, 0, 2);
+}
+
 /* Build HMAT sub table structures */
 static void hmat_build_table_structs(GArray *table_data, NumaState *numa_s=
tate)
 {
     uint16_t flags;
     uint32_t num_initiator =3D 0;
     uint32_t initiator_list[MAX_NODES];
-    int i, hierarchy, type;
+    int i, hierarchy, type, cache_level, total_levels;
     HMAT_LB_Info *hmat_lb;
+    NumaHmatCacheOptions *hmat_cache;
=20
     for (i =3D 0; i < numa_state->num_nodes; i++) {
         flags =3D 0;
@@ -184,6 +232,25 @@ static void hmat_build_table_structs(GArray *table_dat=
a, NumaState *numa_state)
             }
         }
     }
+
+    /*
+     * ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure:
+     * Table 5-147
+     */
+    for (i =3D 0; i < numa_state->num_nodes; i++) {
+        total_levels =3D 0;
+        for (cache_level =3D 1; cache_level < HMAT_LB_LEVELS; cache_level+=
+) {
+            if (numa_state->hmat_cache[i][cache_level]) {
+                total_levels++;
+            }
+        }
+        for (cache_level =3D 0; cache_level <=3D total_levels; cache_level=
++) {
+            hmat_cache =3D numa_state->hmat_cache[i][cache_level];
+            if (hmat_cache) {
+                build_hmat_cache(table_data, total_levels, hmat_cache);
+            }
+        }
+    }
 }
=20
 void build_hmat(GArray *table_data, BIOSLinker *linker, NumaState *numa_st=
ate)
--=20
MST


