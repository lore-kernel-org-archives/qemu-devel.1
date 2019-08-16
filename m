Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8673AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C02920644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C02920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyWkW-0006lA-GG
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWgv-0004Qb-PI
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWgr-0007W6-2y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:30:29 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.237]:21087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWgL-0007H5-Tz; Fri, 16 Aug 2019 03:29:55 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 RDW083A010ED66.bt.com (10.187.98.36) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 16 Aug 2019 08:28:56 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:29:51 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:29:51 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 09/42] exec: Access MemoryRegion with
 MemOp
Thread-Index: AQHVVARkr0oSYLrLyE6r/DMggcmOyQ==
Date: Fri, 16 Aug 2019 07:29:51 +0000
Message-ID: <1565940590840.53573@bt.com>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.237
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 09/42] exec: Access MemoryRegion with MemOp
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, lersek@redhat.com,
 jasowang@redhat.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, philmd@redhat.com,
 amarkovic@wavecomp.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c            |  6 ++++--
 memory_ldst.inc.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index 3e78de3..9f69197 100644
--- a/exec.c
+++ b/exec.c
@@ -3334,7 +3334,8 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
             val =3D ldn_p(buf, l);
-            result |=3D memory_region_dispatch_write(mr, addr1, val, l, at=
trs);
+            result |=3D memory_region_dispatch_write(mr, addr1, val,
+                                                   size_memop(l), attrs);
         } else {
             /* RAM case */
             ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3395,7 +3396,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,
             /* I/O case */
             release_lock |=3D prepare_mmio_access(mr);
             l =3D memory_access_size(mr, l, addr1);
-            result |=3D memory_region_dispatch_read(mr, addr1, &val, l, at=
trs);
+            result |=3D memory_region_dispatch_read(mr, addr1, &val,
+                                                  size_memop(l), attrs);
             stn_p(buf, l, val);
         } else {
             /* RAM case */
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index acf865b..1e8a2fc 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, S=
UFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 4, attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(4), =
attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {
             val =3D bswap32(val);
@@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal,=
 SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 8, attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(8), =
attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {
             val =3D bswap64(val);
@@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(1), =
attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal=
, SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 2, attrs);
+        r =3D memory_region_dispatch_read(mr, addr1, &val, size_memop(2), =
attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {
             val =3D bswap16(val);
@@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL=
,
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |=3D prepare_mmio_access(mr);

-        r =3D memory_region_dispatch_write(mr, addr1, val, 4, attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(4), =
attrs);
     } else {
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
         stl_p(ptr, val);
@@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUF=
FIX)(ARG1_DECL,
             val =3D bswap32(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, 4, attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(4), =
attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!memory_access_is_direct(mr, true)) {
         release_lock |=3D prepare_mmio_access(mr);
-        r =3D memory_region_dispatch_write(mr, addr1, val, 1, attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(1), =
attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUF=
FIX)(ARG1_DECL,
             val =3D bswap16(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, 2, attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(2), =
attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(AR=
G1_DECL,
             val =3D bswap64(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, 8, attrs);
+        r =3D memory_region_dispatch_write(mr, addr1, val, size_memop(8), =
attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
--
1.8.3.1

?

