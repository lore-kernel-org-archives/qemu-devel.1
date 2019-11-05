Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF9C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE40217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaJ4q8mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE40217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS159-0001CK-JG
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS101-0004HT-W9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS0zz-0002Th-Ra
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS0zx-0002P8-UA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+YArILCMhXG24AbA68Zfhwsbzb9vDjrJoEpzRpU8rg=;
 b=SaJ4q8mRcA2yI8T5av4EAxFgQ4QYWTGGH3Nyt+E/DU2bnI0qr5u6xjx5/6uUXeEOiWzEnI
 QdLZ7hAFPmDWeUyJMahYQV8VaD6iocA16Q2rp1/N7FJt0lbEJnFPrUSnK73Cw0Kic78gCC
 gmBsQs28mpDClQ2s6e/S9MxrCSmMQAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-LqB_iqlmO5GVr09wEGFCpQ-1; Tue, 05 Nov 2019 10:43:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0280C2A3;
 Tue,  5 Nov 2019 15:43:56 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50E1D608AC;
 Tue,  5 Nov 2019 15:43:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] image-fuzzer: Explicitly use integer division operator
Date: Tue,  5 Nov 2019 16:43:24 +0100
Message-Id: <20191105154332.181417-4-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
References: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: LqB_iqlmO5GVr09wEGFCpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Most of the division expressions in image-fuzzer assume integer
division.  Use the // operator to keep the same behavior when we
move to Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191016192430.25098-4-ehabkost@redhat.com
Message-Id: <20191016192430.25098-4-ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/image-fuzzer/qcow2/fuzz.py   | 12 ++++-----
 tests/image-fuzzer/qcow2/layout.py | 40 +++++++++++++++---------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tests/image-fuzzer/qcow2/fuzz.py b/tests/image-fuzzer/qcow2/fu=
zz.py
index abc4f0635d..154dc06cc0 100644
--- a/tests/image-fuzzer/qcow2/fuzz.py
+++ b/tests/image-fuzzer/qcow2/fuzz.py
@@ -27,14 +27,14 @@ UINT64 =3D 0xffffffffffffffff
 UINT32_M =3D 31
 UINT64_M =3D 63
 # Fuzz vectors
-UINT8_V =3D [0, 0x10, UINT8/4, UINT8/2 - 1, UINT8/2, UINT8/2 + 1, UINT8 - =
1,
+UINT8_V =3D [0, 0x10, UINT8//4, UINT8//2 - 1, UINT8//2, UINT8//2 + 1, UINT=
8 - 1,
            UINT8]
-UINT16_V =3D [0, 0x100, 0x1000, UINT16/4, UINT16/2 - 1, UINT16/2, UINT16/2=
 + 1,
+UINT16_V =3D [0, 0x100, 0x1000, UINT16//4, UINT16//2 - 1, UINT16//2, UINT1=
6//2 + 1,
             UINT16 - 1, UINT16]
-UINT32_V =3D [0, 0x100, 0x1000, 0x10000, 0x100000, UINT32/4, UINT32/2 - 1,
-            UINT32/2, UINT32/2 + 1, UINT32 - 1, UINT32]
-UINT64_V =3D UINT32_V + [0x1000000, 0x10000000, 0x100000000, UINT64/4,
-                       UINT64/2 - 1, UINT64/2, UINT64/2 + 1, UINT64 - 1,
+UINT32_V =3D [0, 0x100, 0x1000, 0x10000, 0x100000, UINT32//4, UINT32//2 - =
1,
+            UINT32//2, UINT32//2 + 1, UINT32 - 1, UINT32]
+UINT64_V =3D UINT32_V + [0x1000000, 0x10000000, 0x100000000, UINT64//4,
+                       UINT64//2 - 1, UINT64//2, UINT64//2 + 1, UINT64 - 1=
,
                        UINT64]
 STRING_V =3D ['%s%p%x%d', '.1024d', '%.2049d', '%p%p%p%p', '%x%x%x%x',
             '%d%d%d%d', '%s%s%s%s', '%99999999999s', '%08x', '%%20d', '%%2=
0n',
diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow2/=
layout.py
index fe273d4143..6501c9fd4b 100644
--- a/tests/image-fuzzer/qcow2/layout.py
+++ b/tests/image-fuzzer/qcow2/layout.py
@@ -253,7 +253,7 @@ class Image(object):
                 ['>I', self.ext_offset, 0x6803f857, 'ext_magic'],
                 # One feature table contains 3 fields and takes 48 bytes
                 ['>I', self.ext_offset + UINT32_S,
-                 len(feature_tables) / 3 * 48, 'ext_length']
+                 len(feature_tables) // 3 * 48, 'ext_length']
             ] + feature_tables)
             self.ext_offset =3D inner_offset
=20
@@ -271,7 +271,7 @@ class Image(object):
         def create_l2_entry(host, guest, l2_cluster):
             """Generate one L2 entry."""
             offset =3D l2_cluster * self.cluster_size
-            l2_size =3D self.cluster_size / UINT64_S
+            l2_size =3D self.cluster_size // UINT64_S
             entry_offset =3D offset + UINT64_S * (guest % l2_size)
             cluster_descriptor =3D host * self.cluster_size
             if not self.header['version'][0].value =3D=3D 2:
@@ -283,8 +283,8 @@ class Image(object):
=20
         def create_l1_entry(l2_cluster, l1_offset, guest):
             """Generate one L1 entry."""
-            l2_size =3D self.cluster_size / UINT64_S
-            entry_offset =3D l1_offset + UINT64_S * (guest / l2_size)
+            l2_size =3D self.cluster_size // UINT64_S
+            entry_offset =3D l1_offset + UINT64_S * (guest // l2_size)
             # While snapshots are not supported bit #63 =3D 1
             entry_val =3D (1 << 63) + l2_cluster * self.cluster_size
             return ['>Q', entry_offset, entry_val, 'l1_entry']
@@ -298,11 +298,11 @@ class Image(object):
             l2 =3D []
         else:
             meta_data =3D self._get_metadata()
-            guest_clusters =3D random.sample(range(self.image_size /
+            guest_clusters =3D random.sample(range(self.image_size //
                                                  self.cluster_size),
                                            len(self.data_clusters))
             # Number of entries in a L1/L2 table
-            l_size =3D self.cluster_size / UINT64_S
+            l_size =3D self.cluster_size // UINT64_S
             # Number of clusters necessary for L1 table
             l1_size =3D int(ceil((max(guest_clusters) + 1) / float(l_size*=
*2)))
             l1_start =3D self._get_adjacent_clusters(self.data_clusters |
@@ -318,7 +318,7 @@ class Image(object):
             # L2 entries
             l2 =3D []
             for host, guest in zip(self.data_clusters, guest_clusters):
-                l2_id =3D guest / l_size
+                l2_id =3D guest // l_size
                 if l2_id not in l2_ids:
                     l2_ids.append(l2_id)
                     l2_clusters.append(self._get_adjacent_clusters(
@@ -339,14 +339,14 @@ class Image(object):
         def allocate_rfc_blocks(data, size):
             """Return indices of clusters allocated for refcount blocks.""=
"
             cluster_ids =3D set()
-            diff =3D block_ids =3D set([x / size for x in data])
+            diff =3D block_ids =3D set([x // size for x in data])
             while len(diff) !=3D 0:
                 # Allocate all yet not allocated clusters
                 new =3D self._get_available_clusters(data | cluster_ids,
                                                    len(diff))
                 # Indices of new refcount blocks necessary to cover cluste=
rs
                 # in 'new'
-                diff =3D set([x / size for x in new]) - block_ids
+                diff =3D set([x // size for x in new]) - block_ids
                 cluster_ids |=3D new
                 block_ids |=3D diff
             return cluster_ids, block_ids
@@ -359,7 +359,7 @@ class Image(object):
             blocks =3D set(init_blocks)
             clusters =3D set()
             # Number of entries in one cluster of the refcount table
-            size =3D self.cluster_size / UINT64_S
+            size =3D self.cluster_size // UINT64_S
             # Number of clusters necessary for the refcount table based on
             # the current number of refcount blocks
             table_size =3D int(ceil((max(blocks) + 1) / float(size)))
@@ -373,7 +373,7 @@ class Image(object):
                                                  table_size + 1))
             # New refcount blocks necessary for clusters occupied by the
             # refcount table
-            diff =3D set([c / block_size for c in table_clusters]) - block=
s
+            diff =3D set([c // block_size for c in table_clusters]) - bloc=
ks
             blocks |=3D diff
             while len(diff) !=3D 0:
                 # Allocate clusters for new refcount blocks
@@ -382,12 +382,12 @@ class Image(object):
                                                    len(diff))
                 # Indices of new refcount blocks necessary to cover
                 # clusters in 'new'
-                diff =3D set([x / block_size for x in new]) - blocks
+                diff =3D set([x // block_size for x in new]) - blocks
                 clusters |=3D new
                 blocks |=3D diff
                 # Check if the refcount table needs one more cluster
                 if int(ceil((max(blocks) + 1) / float(size))) > table_size=
:
-                    new_block_id =3D (table_start + table_size) / block_si=
ze
+                    new_block_id =3D (table_start + table_size) // block_s=
ize
                     # Check if the additional table cluster needs
                     # one more refcount block
                     if new_block_id not in blocks:
@@ -399,13 +399,13 @@ class Image(object):
         def create_table_entry(table_offset, block_cluster, block_size,
                                cluster):
             """Generate a refcount table entry."""
-            offset =3D table_offset + UINT64_S * (cluster / block_size)
+            offset =3D table_offset + UINT64_S * (cluster // block_size)
             return ['>Q', offset, block_cluster * self.cluster_size,
                     'refcount_table_entry']
=20
         def create_block_entry(block_cluster, block_size, cluster):
             """Generate a list of entries for the current block."""
-            entry_size =3D self.cluster_size / block_size
+            entry_size =3D self.cluster_size // block_size
             offset =3D block_cluster * self.cluster_size
             entry_offset =3D offset + entry_size * (cluster % block_size)
             # While snapshots are not supported all refcounts are set to 1
@@ -415,7 +415,7 @@ class Image(object):
         # Number of refcount entries per refcount block
         # Convert self.cluster_size from bytes to bits to have the same
         # base for the numerator and denominator
-        block_size =3D self.cluster_size * 8 / refcount_bits
+        block_size =3D self.cluster_size * 8 // refcount_bits
         meta_data =3D self._get_metadata()
         if len(self.data_clusters) =3D=3D 0:
             # All metadata for an empty guest image needs 4 clusters:
@@ -452,8 +452,8 @@ class Image(object):
         rfc_blocks =3D []
=20
         for cluster in sorted(self.data_clusters | meta_data):
-            if cluster / block_size !=3D block_id:
-                block_id =3D cluster / block_size
+            if cluster // block_size !=3D block_id:
+                block_id =3D cluster // block_size
                 block_cluster =3D block_clusters[block_ids.index(block_id)=
]
                 rfc_table.append(create_table_entry(table_offset,
                                                     block_cluster,
@@ -587,7 +587,7 @@ class Image(object):
     def _alloc_data(img_size, cluster_size):
         """Return a set of random indices of clusters allocated for guest =
data.
         """
-        num_of_cls =3D img_size/cluster_size
+        num_of_cls =3D img_size // cluster_size
         return set(random.sample(range(1, num_of_cls + 1),
                                  random.randint(0, num_of_cls)))
=20
@@ -595,7 +595,7 @@ class Image(object):
         """Return indices of clusters allocated for image metadata."""
         ids =3D set()
         for x in self:
-            ids.add(x.offset/self.cluster_size)
+            ids.add(x.offset // self.cluster_size)
         return ids
=20
=20
--=20
2.23.0


