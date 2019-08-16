Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EFEC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1AE20644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1AE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyWjm-0005cz-Og
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWfh-0002Y0-9Q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWfW-00070M-9l
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:29:13 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.72]:30393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWdj-0006UW-R1; Fri, 16 Aug 2019 03:27:12 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926077.bt.com (10.36.82.108) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 08:26:29 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:26:59 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:26:59 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 02/42] tcg: TCGMemOp is now accelerator
 independent MemOp
Thread-Index: AQHVVAP9cvU70bsx4kOKMEb2vufQ+w==
Date: Fri, 16 Aug 2019 07:26:59 +0000
Message-ID: <1565940417783.5399@bt.com>
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
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.72
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 02/42] tcg: TCGMemOp is now accelerator
 independent MemOp
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

Preparation for collapsing the two byte swaps, adjust_endianness and
handle_bswap, along the I/O path.

Target dependant attributes are conditionalized upon NEED_CPU_H.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 MAINTAINERS                             |   1 +
 accel/tcg/cputlb.c                      |   2 +-
 include/exec/memop.h                    | 110 ++++++++++++++++++++++++++
 target/alpha/translate.c                |   2 +-
 target/arm/translate-a64.c              |  48 ++++++------
 target/arm/translate-a64.h              |   2 +-
 target/arm/translate-sve.c              |   2 +-
 target/arm/translate.c                  |  32 ++++----
 target/arm/translate.h                  |   2 +-
 target/hppa/translate.c                 |  14 ++--
 target/i386/translate.c                 | 132 ++++++++++++++++------------=
----
 target/m68k/translate.c                 |   2 +-
 target/microblaze/translate.c           |   4 +-
 target/mips/translate.c                 |   8 +-
 target/openrisc/translate.c             |   4 +-
 target/ppc/translate.c                  |  12 +--
 target/riscv/insn_trans/trans_rva.inc.c |   8 +-
 target/riscv/insn_trans/trans_rvi.inc.c |   4 +-
 target/s390x/translate.c                |   6 +-
 target/s390x/translate_vx.inc.c         |  10 +--
 target/sparc/translate.c                |  14 ++--
 target/tilegx/translate.c               |  10 +--
 target/tricore/translate.c              |   8 +-
 tcg/README                              |   2 +-
 tcg/aarch64/tcg-target.inc.c            |  26 +++----
 tcg/arm/tcg-target.inc.c                |  26 +++----
 tcg/i386/tcg-target.inc.c               |  24 +++---
 tcg/mips/tcg-target.inc.c               |  16 ++--
 tcg/optimize.c                          |   2 +-
 tcg/ppc/tcg-target.inc.c                |  12 +--
 tcg/riscv/tcg-target.inc.c              |  20 ++---
 tcg/s390/tcg-target.inc.c               |  14 ++--
 tcg/sparc/tcg-target.inc.c              |   6 +-
 tcg/tcg-op.c                            |  38 ++++-----
 tcg/tcg-op.h                            |  86 ++++++++++-----------
 tcg/tcg.c                               |   2 +-
 tcg/tcg.h                               | 101 ++----------------------
 trace/mem-internal.h                    |   4 +-
 trace/mem.h                             |   4 +-
 39 files changed, 421 insertions(+), 399 deletions(-)
 create mode 100644 include/exec/memop.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d6de200..c7cf84a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1889,6 +1889,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/exec/ioport.h
 F: ioport.c
+F: include/exec/memop.h
 F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: memory.c
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bb9897b..523be4c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1133,7 +1133,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, tar=
get_ulong addr,
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
     CPUTLBEntry *tlbe =3D tlb_entry(env, mmu_idx, addr);
     target_ulong tlb_addr =3D tlb_addr_write(tlbe);
-    TCGMemOp mop =3D get_memop(oi);
+    MemOp mop =3D get_memop(oi);
     int a_bits =3D get_alignment_bits(mop);
     int s_bits =3D mop & MO_SIZE;
     void *hostaddr;
diff --git a/include/exec/memop.h b/include/exec/memop.h
new file mode 100644
index 0000000..7262ca3
--- /dev/null
+++ b/include/exec/memop.h
@@ -0,0 +1,110 @@
+/*
+ * Constants for memory operations
+ *
+ * Authors:
+ *  Richard Henderson <rth@twiddle.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MEMOP_H
+#define MEMOP_H
+
+typedef enum MemOp {
+    MO_8     =3D 0,
+    MO_16    =3D 1,
+    MO_32    =3D 2,
+    MO_64    =3D 3,
+    MO_SIZE  =3D 3,   /* Mask for the above.  */
+
+    MO_SIGN  =3D 4,   /* Sign-extended, otherwise zero-extended.  */
+
+    MO_BSWAP =3D 8,   /* Host reverse endian.  */
+#ifdef HOST_WORDS_BIGENDIAN
+    MO_LE    =3D MO_BSWAP,
+    MO_BE    =3D 0,
+#else
+    MO_LE    =3D 0,
+    MO_BE    =3D MO_BSWAP,
+#endif
+#ifdef NEED_CPU_H
+#ifdef TARGET_WORDS_BIGENDIAN
+    MO_TE    =3D MO_BE,
+#else
+    MO_TE    =3D MO_LE,
+#endif
+#endif
+
+    /*
+     * MO_UNALN accesses are never checked for alignment.
+     * MO_ALIGN accesses will result in a call to the CPU's
+     * do_unaligned_access hook if the guest address is not aligned.
+     * The default depends on whether the target CPU defines
+     * TARGET_ALIGNED_ONLY.
+     *
+     * Some architectures (e.g. ARMv8) need the address which is aligned
+     * to a size more than the size of the memory access.
+     * Some architectures (e.g. SPARCv9) need an address which is aligned,
+     * but less strictly than the natural alignment.
+     *
+     * MO_ALIGN supposes the alignment size is the size of a memory access=
.
+     *
+     * There are three options:
+     * - unaligned access permitted (MO_UNALN).
+     * - an alignment to the size of an access (MO_ALIGN);
+     * - an alignment to a specified size, which may be more or less than
+     *   the access size (MO_ALIGN_x where 'x' is a size in bytes);
+     */
+    MO_ASHIFT =3D 4,
+    MO_AMASK =3D 7 << MO_ASHIFT,
+#ifdef NEED_CPU_H
+#ifdef TARGET_ALIGNED_ONLY
+    MO_ALIGN =3D 0,
+    MO_UNALN =3D MO_AMASK,
+#else
+    MO_ALIGN =3D MO_AMASK,
+    MO_UNALN =3D 0,
+#endif
+#endif
+    MO_ALIGN_2  =3D 1 << MO_ASHIFT,
+    MO_ALIGN_4  =3D 2 << MO_ASHIFT,
+    MO_ALIGN_8  =3D 3 << MO_ASHIFT,
+    MO_ALIGN_16 =3D 4 << MO_ASHIFT,
+    MO_ALIGN_32 =3D 5 << MO_ASHIFT,
+    MO_ALIGN_64 =3D 6 << MO_ASHIFT,
+
+    /* Combinations of the above, for ease of use.  */
+    MO_UB    =3D MO_8,
+    MO_UW    =3D MO_16,
+    MO_UL    =3D MO_32,
+    MO_SB    =3D MO_SIGN | MO_8,
+    MO_SW    =3D MO_SIGN | MO_16,
+    MO_SL    =3D MO_SIGN | MO_32,
+    MO_Q     =3D MO_64,
+
+    MO_LEUW  =3D MO_LE | MO_UW,
+    MO_LEUL  =3D MO_LE | MO_UL,
+    MO_LESW  =3D MO_LE | MO_SW,
+    MO_LESL  =3D MO_LE | MO_SL,
+    MO_LEQ   =3D MO_LE | MO_Q,
+
+    MO_BEUW  =3D MO_BE | MO_UW,
+    MO_BEUL  =3D MO_BE | MO_UL,
+    MO_BESW  =3D MO_BE | MO_SW,
+    MO_BESL  =3D MO_BE | MO_SL,
+    MO_BEQ   =3D MO_BE | MO_Q,
+
+#ifdef NEED_CPU_H
+    MO_TEUW  =3D MO_TE | MO_UW,
+    MO_TEUL  =3D MO_TE | MO_UL,
+    MO_TESW  =3D MO_TE | MO_SW,
+    MO_TESL  =3D MO_TE | MO_SL,
+    MO_TEQ   =3D MO_TE | MO_Q,
+#endif
+
+    MO_SSIZE =3D MO_SIZE | MO_SIGN,
+} MemOp;
+
+#endif
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2c9cccf..d5d4888 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -403,7 +403,7 @@ static inline void gen_store_mem(DisasContext *ctx,

 static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int =
rb,
                                            int32_t disp16, int mem_idx,
-                                           TCGMemOp op)
+                                           MemOp op)
 {
     TCGLabel *lab_fail, *lab_done;
     TCGv addr, val;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d323147..b6c07d6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -85,7 +85,7 @@ typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
-typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, TCGMemO=
p);
+typedef void AtomicThreeOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGArg, MemOp);

 /* initialize TCG globals.  */
 void a64_translate_init(void)
@@ -455,7 +455,7 @@ TCGv_i64 read_cpu_reg_sp(DisasContext *s, int reg, int =
sf)
  * Dn, Sn, Hn or Bn).
  * (Note that this is not the same mapping as for A32; see cpu.h)
  */
-static inline int fp_reg_offset(DisasContext *s, int regno, TCGMemOp size)
+static inline int fp_reg_offset(DisasContext *s, int regno, MemOp size)
 {
     return vec_reg_offset(s, regno, 0, size);
 }
@@ -871,7 +871,7 @@ static void do_gpr_ld_memidx(DisasContext *s,
                              bool iss_valid, unsigned int iss_srt,
                              bool iss_sf, bool iss_ar)
 {
-    TCGMemOp memop =3D s->be_data + size;
+    MemOp memop =3D s->be_data + size;

     g_assert(size <=3D 3);

@@ -948,7 +948,7 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv=
_i64 tcg_addr, int size)
     TCGv_i64 tmphi;

     if (size < 4) {
-        TCGMemOp memop =3D s->be_data + size;
+        MemOp memop =3D s->be_data + size;
         tmphi =3D tcg_const_i64(0);
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), memop);
     } else {
@@ -989,7 +989,7 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv=
_i64 tcg_addr, int size)

 /* Get value of an element within a vector register */
 static void read_vec_element(DisasContext *s, TCGv_i64 tcg_dest, int srcid=
x,
-                             int element, TCGMemOp memop)
+                             int element, MemOp memop)
 {
     int vect_off =3D vec_reg_offset(s, srcidx, element, memop & MO_SIZE);
     switch (memop) {
@@ -1021,7 +1021,7 @@ static void read_vec_element(DisasContext *s, TCGv_i6=
4 tcg_dest, int srcidx,
 }

 static void read_vec_element_i32(DisasContext *s, TCGv_i32 tcg_dest, int s=
rcidx,
-                                 int element, TCGMemOp memop)
+                                 int element, MemOp memop)
 {
     int vect_off =3D vec_reg_offset(s, srcidx, element, memop & MO_SIZE);
     switch (memop) {
@@ -1048,7 +1048,7 @@ static void read_vec_element_i32(DisasContext *s, TCG=
v_i32 tcg_dest, int srcidx,

 /* Set value of an element within a vector register */
 static void write_vec_element(DisasContext *s, TCGv_i64 tcg_src, int desti=
dx,
-                              int element, TCGMemOp memop)
+                              int element, MemOp memop)
 {
     int vect_off =3D vec_reg_offset(s, destidx, element, memop & MO_SIZE);
     switch (memop) {
@@ -1070,7 +1070,7 @@ static void write_vec_element(DisasContext *s, TCGv_i=
64 tcg_src, int destidx,
 }

 static void write_vec_element_i32(DisasContext *s, TCGv_i32 tcg_src,
-                                  int destidx, int element, TCGMemOp memop=
)
+                                  int destidx, int element, MemOp memop)
 {
     int vect_off =3D vec_reg_offset(s, destidx, element, memop & MO_SIZE);
     switch (memop) {
@@ -1090,7 +1090,7 @@ static void write_vec_element_i32(DisasContext *s, TC=
Gv_i32 tcg_src,

 /* Store from vector register to memory */
 static void do_vec_st(DisasContext *s, int srcidx, int element,
-                      TCGv_i64 tcg_addr, int size, TCGMemOp endian)
+                      TCGv_i64 tcg_addr, int size, MemOp endian)
 {
     TCGv_i64 tcg_tmp =3D tcg_temp_new_i64();

@@ -1102,7 +1102,7 @@ static void do_vec_st(DisasContext *s, int srcidx, in=
t element,

 /* Load from memory to vector register */
 static void do_vec_ld(DisasContext *s, int destidx, int element,
-                      TCGv_i64 tcg_addr, int size, TCGMemOp endian)
+                      TCGv_i64 tcg_addr, int size, MemOp endian)
 {
     TCGv_i64 tcg_tmp =3D tcg_temp_new_i64();

@@ -2200,7 +2200,7 @@ static void gen_load_exclusive(DisasContext *s, int r=
t, int rt2,
                                TCGv_i64 addr, int size, bool is_pair)
 {
     int idx =3D get_mem_index(s);
-    TCGMemOp memop =3D s->be_data;
+    MemOp memop =3D s->be_data;

     g_assert(size <=3D 3);
     if (is_pair) {
@@ -3286,7 +3286,7 @@ static void disas_ldst_multiple_struct(DisasContext *=
s, uint32_t insn)
     bool is_postidx =3D extract32(insn, 23, 1);
     bool is_q =3D extract32(insn, 30, 1);
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
-    TCGMemOp endian =3D s->be_data;
+    MemOp endian =3D s->be_data;

     int ebytes;   /* bytes per element */
     int elements; /* elements per vector */
@@ -5455,7 +5455,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t i=
nsn)
     unsigned int mos, type, rm, cond, rn, rd;
     TCGv_i64 t_true, t_false, t_zero;
     DisasCompare64 c;
-    TCGMemOp sz;
+    MemOp sz;

     mos =3D extract32(insn, 29, 3);
     type =3D extract32(insn, 22, 2);
@@ -6267,7 +6267,7 @@ static void disas_fp_imm(DisasContext *s, uint32_t in=
sn)
     int mos =3D extract32(insn, 29, 3);
     uint64_t imm;
     TCGv_i64 tcg_res;
-    TCGMemOp sz;
+    MemOp sz;

     if (mos || imm5) {
         unallocated_encoding(s);
@@ -7030,7 +7030,7 @@ static TCGv_i32 do_reduction_op(DisasContext *s, int =
fpopcode, int rn,
 {
     if (esize =3D=3D size) {
         int element;
-        TCGMemOp msize =3D esize =3D=3D 16 ? MO_16 : MO_32;
+        MemOp msize =3D esize =3D=3D 16 ? MO_16 : MO_32;
         TCGv_i32 tcg_elem;

         /* We should have one register left here */
@@ -8022,7 +8022,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s, b=
ool is_scalar, bool is_q,
     int shift =3D (2 * esize) - immhb;
     int elements =3D is_scalar ? 1 : (64 / esize);
     bool round =3D extract32(opcode, 0, 1);
-    TCGMemOp ldop =3D (size + 1) | (is_u_shift ? 0 : MO_SIGN);
+    MemOp ldop =3D (size + 1) | (is_u_shift ? 0 : MO_SIGN);
     TCGv_i64 tcg_rn, tcg_rd, tcg_round;
     TCGv_i32 tcg_rd_narrowed;
     TCGv_i64 tcg_final;
@@ -8181,7 +8181,7 @@ static void handle_simd_qshl(DisasContext *s, bool sc=
alar, bool is_q,
             }
         };
         NeonGenTwoOpEnvFn *genfn =3D fns[src_unsigned][dst_unsigned][size]=
;
-        TCGMemOp memop =3D scalar ? size : MO_32;
+        MemOp memop =3D scalar ? size : MO_32;
         int maxpass =3D scalar ? 1 : is_q ? 4 : 2;

         for (pass =3D 0; pass < maxpass; pass++) {
@@ -8225,7 +8225,7 @@ static void handle_simd_intfp_conv(DisasContext *s, i=
nt rd, int rn,
     TCGv_ptr tcg_fpst =3D get_fpstatus_ptr(size =3D=3D MO_16);
     TCGv_i32 tcg_shift =3D NULL;

-    TCGMemOp mop =3D size | (is_signed ? MO_SIGN : 0);
+    MemOp mop =3D size | (is_signed ? MO_SIGN : 0);
     int pass;

     if (fracbits || size =3D=3D MO_64) {
@@ -10004,7 +10004,7 @@ static void handle_vec_simd_shri(DisasContext *s, b=
ool is_q, bool is_u,
     int dsize =3D is_q ? 128 : 64;
     int esize =3D 8 << size;
     int elements =3D dsize/esize;
-    TCGMemOp memop =3D size | (is_u ? 0 : MO_SIGN);
+    MemOp memop =3D size | (is_u ? 0 : MO_SIGN);
     TCGv_i64 tcg_rn =3D new_tmp_a64(s);
     TCGv_i64 tcg_rd =3D new_tmp_a64(s);
     TCGv_i64 tcg_round;
@@ -10347,7 +10347,7 @@ static void handle_3rd_widening(DisasContext *s, in=
t is_q, int is_u, int size,
             TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();
             TCGv_i64 tcg_op2 =3D tcg_temp_new_i64();
             TCGv_i64 tcg_passres;
-            TCGMemOp memop =3D MO_32 | (is_u ? 0 : MO_SIGN);
+            MemOp memop =3D MO_32 | (is_u ? 0 : MO_SIGN);

             int elt =3D pass + is_q * 2;

@@ -11827,7 +11827,7 @@ static void handle_2misc_pairwise(DisasContext *s, =
int opcode, bool u,

     if (size =3D=3D 2) {
         /* 32 + 32 -> 64 op */
-        TCGMemOp memop =3D size + (u ? 0 : MO_SIGN);
+        MemOp memop =3D size + (u ? 0 : MO_SIGN);

         for (pass =3D 0; pass < maxpass; pass++) {
             TCGv_i64 tcg_op1 =3D tcg_temp_new_i64();
@@ -12849,7 +12849,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)

     switch (is_fp) {
     case 1: /* normal fp */
-        /* convert insn encoded size to TCGMemOp size */
+        /* convert insn encoded size to MemOp size */
         switch (size) {
         case 0: /* half-precision */
             size =3D MO_16;
@@ -12897,7 +12897,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         return;
     }

-    /* Given TCGMemOp size, adjust register and indexing.  */
+    /* Given MemOp size, adjust register and indexing.  */
     switch (size) {
     case MO_16:
         index =3D h << 2 | l << 1 | m;
@@ -13194,7 +13194,7 @@ static void disas_simd_indexed(DisasContext *s, uin=
t32_t insn)
         TCGv_i64 tcg_res[2];
         int pass;
         bool satop =3D extract32(opcode, 0, 1);
-        TCGMemOp memop =3D MO_32;
+        MemOp memop =3D MO_32;

         if (satop || !u) {
             memop |=3D MO_SIGN;
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9ab4087..f1246b7 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -64,7 +64,7 @@ static inline void assert_fp_access_checked(DisasContext =
*s)
  * the FP/vector register Qn.
  */
 static inline int vec_reg_offset(DisasContext *s, int regno,
-                                 int element, TCGMemOp size)
+                                 int element, MemOp size)
 {
     int element_size =3D 1 << size;
     int offs =3D element * element_size;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fa068b0..5d7edd0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4567,7 +4567,7 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a=
)
  */

 /* The memory mode of the dtype.  */
-static const TCGMemOp dtype_mop[16] =3D {
+static const MemOp dtype_mop[16] =3D {
     MO_UB, MO_UB, MO_UB, MO_UB,
     MO_SL, MO_UW, MO_UW, MO_UW,
     MO_SW, MO_SW, MO_UL, MO_UL,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462..d116c8c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -114,7 +114,7 @@ typedef enum ISSInfo {
 } ISSInfo;

 /* Save the syndrome information for a Data Abort */
-static void disas_set_da_iss(DisasContext *s, TCGMemOp memop, ISSInfo issi=
nfo)
+static void disas_set_da_iss(DisasContext *s, MemOp memop, ISSInfo issinfo=
)
 {
     uint32_t syn;
     int sas =3D memop & MO_SIZE;
@@ -1079,7 +1079,7 @@ static inline void store_reg_from_load(DisasContext *=
s, int reg, TCGv_i32 var)
  * that the address argument is TCGv_i32 rather than TCGv.
  */

-static inline TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, TCGMemOp o=
p)
+static inline TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 {
     TCGv addr =3D tcg_temp_new();
     tcg_gen_extu_i32_tl(addr, a32);
@@ -1092,7 +1092,7 @@ static inline TCGv gen_aa32_addr(DisasContext *s, TCG=
v_i32 a32, TCGMemOp op)
 }

 static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,
-                            int index, TCGMemOp opc)
+                            int index, MemOp opc)
 {
     TCGv addr;

@@ -1107,7 +1107,7 @@ static void gen_aa32_ld_i32(DisasContext *s, TCGv_i32=
 val, TCGv_i32 a32,
 }

 static void gen_aa32_st_i32(DisasContext *s, TCGv_i32 val, TCGv_i32 a32,
-                            int index, TCGMemOp opc)
+                            int index, MemOp opc)
 {
     TCGv addr;

@@ -1160,7 +1160,7 @@ static inline void gen_aa32_frob64(DisasContext *s, T=
CGv_i64 val)
 }

 static void gen_aa32_ld_i64(DisasContext *s, TCGv_i64 val, TCGv_i32 a32,
-                            int index, TCGMemOp opc)
+                            int index, MemOp opc)
 {
     TCGv addr =3D gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_ld_i64(val, addr, index, opc);
@@ -1175,7 +1175,7 @@ static inline void gen_aa32_ld64(DisasContext *s, TCG=
v_i64 val,
 }

 static void gen_aa32_st_i64(DisasContext *s, TCGv_i64 val, TCGv_i32 a32,
-                            int index, TCGMemOp opc)
+                            int index, MemOp opc)
 {
     TCGv addr =3D gen_aa32_addr(s, a32, opc);

@@ -1400,7 +1400,7 @@ neon_reg_offset (int reg, int n)
  * where 0 is the least significant end of the register.
  */
 static inline long
-neon_element_offset(int reg, int element, TCGMemOp size)
+neon_element_offset(int reg, int element, MemOp size)
 {
     int element_size =3D 1 << size;
     int ofs =3D element * element_size;
@@ -1422,7 +1422,7 @@ static TCGv_i32 neon_load_reg(int reg, int pass)
     return tmp;
 }

-static void neon_load_element(TCGv_i32 var, int reg, int ele, TCGMemOp mop=
)
+static void neon_load_element(TCGv_i32 var, int reg, int ele, MemOp mop)
 {
     long offset =3D neon_element_offset(reg, ele, mop & MO_SIZE);

@@ -1441,7 +1441,7 @@ static void neon_load_element(TCGv_i32 var, int reg, =
int ele, TCGMemOp mop)
     }
 }

-static void neon_load_element64(TCGv_i64 var, int reg, int ele, TCGMemOp m=
op)
+static void neon_load_element64(TCGv_i64 var, int reg, int ele, MemOp mop)
 {
     long offset =3D neon_element_offset(reg, ele, mop & MO_SIZE);

@@ -1469,7 +1469,7 @@ static void neon_store_reg(int reg, int pass, TCGv_i3=
2 var)
     tcg_temp_free_i32(var);
 }

-static void neon_store_element(int reg, int ele, TCGMemOp size, TCGv_i32 v=
ar)
+static void neon_store_element(int reg, int ele, MemOp size, TCGv_i32 var)
 {
     long offset =3D neon_element_offset(reg, ele, size);

@@ -1488,7 +1488,7 @@ static void neon_store_element(int reg, int ele, TCGM=
emOp size, TCGv_i32 var)
     }
 }

-static void neon_store_element64(int reg, int ele, TCGMemOp size, TCGv_i64=
 var)
+static void neon_store_element64(int reg, int ele, MemOp size, TCGv_i64 va=
r)
 {
     long offset =3D neon_element_offset(reg, ele, size);

@@ -3558,7 +3558,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32=
_t insn)
     int n;
     int vec_size;
     int mmu_idx;
-    TCGMemOp endian;
+    MemOp endian;
     TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -6867,7 +6867,7 @@ static int disas_neon_data_insn(DisasContext *s, uint=
32_t insn)
             } else if ((insn & 0x380) =3D=3D 0) {
                 /* VDUP */
                 int element;
-                TCGMemOp size;
+                MemOp size;

                 if ((insn & (7 << 16)) =3D=3D 0 || (q && (rd & 1))) {
                     return 1;
@@ -7435,7 +7435,7 @@ static void gen_load_exclusive(DisasContext *s, int r=
t, int rt2,
                                TCGv_i32 addr, int size)
 {
     TCGv_i32 tmp =3D tcg_temp_new_i32();
-    TCGMemOp opc =3D size | MO_ALIGN | s->be_data;
+    MemOp opc =3D size | MO_ALIGN | s->be_data;

     s->is_ldex =3D true;

@@ -7489,7 +7489,7 @@ static void gen_store_exclusive(DisasContext *s, int =
rd, int rt, int rt2,
     TCGv taddr;
     TCGLabel *done_label;
     TCGLabel *fail_label;
-    TCGMemOp opc =3D size | MO_ALIGN | s->be_data;
+    MemOp opc =3D size | MO_ALIGN | s->be_data;

     /* if (env->exclusive_addr =3D=3D addr && env->exclusive_val =3D=3D [a=
ddr]) {
          [addr] =3D {Rt};
@@ -8603,7 +8603,7 @@ static void disas_arm_insn(DisasContext *s, unsigned =
int insn)
                         */

                         TCGv taddr;
-                        TCGMemOp opc =3D s->be_data;
+                        MemOp opc =3D s->be_data;

                         rm =3D (insn) & 0xf;

diff --git a/target/arm/translate.h b/target/arm/translate.h
index a20f6e2..284c510 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -21,7 +21,7 @@ typedef struct DisasContext {
     int condexec_cond;
     int thumb;
     int sctlr_b;
-    TCGMemOp be_data;
+    MemOp be_data;
 #if !defined(CONFIG_USER_ONLY)
     int user;
 #endif
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 188fe68..ff4802a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1500,7 +1500,7 @@ static void form_gva(DisasContext *ctx, TCGv_tl *pgva=
, TCGv_reg *pofs,
  */
 static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
                        unsigned rx, int scale, target_sreg disp,
-                       unsigned sp, int modify, TCGMemOp mop)
+                       unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
     TCGv_tl addr;
@@ -1518,7 +1518,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 de=
st, unsigned rb,

 static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
                        unsigned rx, int scale, target_sreg disp,
-                       unsigned sp, int modify, TCGMemOp mop)
+                       unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
     TCGv_tl addr;
@@ -1536,7 +1536,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 de=
st, unsigned rb,

 static void do_store_32(DisasContext *ctx, TCGv_i32 src, unsigned rb,
                         unsigned rx, int scale, target_sreg disp,
-                        unsigned sp, int modify, TCGMemOp mop)
+                        unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
     TCGv_tl addr;
@@ -1554,7 +1554,7 @@ static void do_store_32(DisasContext *ctx, TCGv_i32 s=
rc, unsigned rb,

 static void do_store_64(DisasContext *ctx, TCGv_i64 src, unsigned rb,
                         unsigned rx, int scale, target_sreg disp,
-                        unsigned sp, int modify, TCGMemOp mop)
+                        unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg ofs;
     TCGv_tl addr;
@@ -1580,7 +1580,7 @@ static void do_store_64(DisasContext *ctx, TCGv_i64 s=
rc, unsigned rb,

 static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
                     unsigned rx, int scale, target_sreg disp,
-                    unsigned sp, int modify, TCGMemOp mop)
+                    unsigned sp, int modify, MemOp mop)
 {
     TCGv_reg dest;

@@ -1653,7 +1653,7 @@ static bool trans_fldd(DisasContext *ctx, arg_ldst *a=
)

 static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      target_sreg disp, unsigned sp,
-                     int modify, TCGMemOp mop)
+                     int modify, MemOp mop)
 {
     nullify_over(ctx);
     do_store_reg(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
@@ -2940,7 +2940,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)

 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
-    TCGMemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;
+    MemOp mop =3D MO_TEUL | MO_ALIGN_16 | a->size;
     TCGv_reg zero, dest, ofs;
     TCGv_tl addr;

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03150a8..def9867 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -87,8 +87,8 @@ typedef struct DisasContext {
     /* current insn context */
     int override; /* -1 if no override */
     int prefix;
-    TCGMemOp aflag;
-    TCGMemOp dflag;
+    MemOp aflag;
+    MemOp dflag;
     target_ulong pc_start;
     target_ulong pc; /* pc =3D eip + cs_base */
     /* current block context */
@@ -149,7 +149,7 @@ static void gen_eob(DisasContext *s);
 static void gen_jr(DisasContext *s, TCGv dest);
 static void gen_jmp(DisasContext *s, target_ulong eip);
 static void gen_jmp_tb(DisasContext *s, target_ulong eip, int tb_num);
-static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d);
+static void gen_op(DisasContext *s1, int op, MemOp ot, int d);

 /* i386 arith/logic operations */
 enum {
@@ -320,7 +320,7 @@ static inline bool byte_reg_is_xH(DisasContext *s, int =
reg)
 }

 /* Select the size of a push/pop operation.  */
-static inline TCGMemOp mo_pushpop(DisasContext *s, TCGMemOp ot)
+static inline MemOp mo_pushpop(DisasContext *s, MemOp ot)
 {
     if (CODE64(s)) {
         return ot =3D=3D MO_16 ? MO_16 : MO_64;
@@ -330,13 +330,13 @@ static inline TCGMemOp mo_pushpop(DisasContext *s, TC=
GMemOp ot)
 }

 /* Select the size of the stack pointer.  */
-static inline TCGMemOp mo_stacksize(DisasContext *s)
+static inline MemOp mo_stacksize(DisasContext *s)
 {
     return CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;
 }

 /* Select only size 64 else 32.  Used for SSE operand sizes.  */
-static inline TCGMemOp mo_64_32(TCGMemOp ot)
+static inline MemOp mo_64_32(MemOp ot)
 {
 #ifdef TARGET_X86_64
     return ot =3D=3D MO_64 ? MO_64 : MO_32;
@@ -347,19 +347,19 @@ static inline TCGMemOp mo_64_32(TCGMemOp ot)

 /* Select size 8 if lsb of B is clear, else OT.  Used for decoding
    byte vs word opcodes.  */
-static inline TCGMemOp mo_b_d(int b, TCGMemOp ot)
+static inline MemOp mo_b_d(int b, MemOp ot)
 {
     return b & 1 ? ot : MO_8;
 }

 /* Select size 8 if lsb of B is clear, else OT capped at 32.
    Used for decoding operand size of port opcodes.  */
-static inline TCGMemOp mo_b_d32(int b, TCGMemOp ot)
+static inline MemOp mo_b_d32(int b, MemOp ot)
 {
     return b & 1 ? (ot =3D=3D MO_16 ? MO_16 : MO_32) : MO_8;
 }

-static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp ot, int reg, TCGv t=
0)
+static void gen_op_mov_reg_v(DisasContext *s, MemOp ot, int reg, TCGv t0)
 {
     switch(ot) {
     case MO_8:
@@ -388,7 +388,7 @@ static void gen_op_mov_reg_v(DisasContext *s, TCGMemOp =
ot, int reg, TCGv t0)
 }

 static inline
-void gen_op_mov_v_reg(DisasContext *s, TCGMemOp ot, TCGv t0, int reg)
+void gen_op_mov_v_reg(DisasContext *s, MemOp ot, TCGv t0, int reg)
 {
     if (ot =3D=3D MO_8 && byte_reg_is_xH(s, reg)) {
         tcg_gen_extract_tl(t0, cpu_regs[reg - 4], 8, 8);
@@ -411,13 +411,13 @@ static inline void gen_op_jmp_v(TCGv dest)
 }

 static inline
-void gen_op_add_reg_im(DisasContext *s, TCGMemOp size, int reg, int32_t va=
l)
+void gen_op_add_reg_im(DisasContext *s, MemOp size, int reg, int32_t val)
 {
     tcg_gen_addi_tl(s->tmp0, cpu_regs[reg], val);
     gen_op_mov_reg_v(s, size, reg, s->tmp0);
 }

-static inline void gen_op_add_reg_T0(DisasContext *s, TCGMemOp size, int r=
eg)
+static inline void gen_op_add_reg_T0(DisasContext *s, MemOp size, int reg)
 {
     tcg_gen_add_tl(s->tmp0, cpu_regs[reg], s->T0);
     gen_op_mov_reg_v(s, size, reg, s->tmp0);
@@ -451,7 +451,7 @@ static inline void gen_jmp_im(DisasContext *s, target_u=
long pc)
 /* Compute SEG:REG into A0.  SEG is selected from the override segment
    (OVR_SEG) and the default segment (DEF_SEG).  OVR_SEG may be -1 to
    indicate no override.  */
-static void gen_lea_v_seg(DisasContext *s, TCGMemOp aflag, TCGv a0,
+static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
                           int def_seg, int ovr_seg)
 {
     switch (aflag) {
@@ -514,13 +514,13 @@ static inline void gen_string_movl_A0_EDI(DisasContex=
t *s)
     gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_ES, -1);
 }

-static inline void gen_op_movl_T0_Dshift(DisasContext *s, TCGMemOp ot)
+static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
 {
     tcg_gen_ld32s_tl(s->T0, cpu_env, offsetof(CPUX86State, df));
     tcg_gen_shli_tl(s->T0, s->T0, ot);
 };

-static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp size, bool sign)
+static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
 {
     switch (size) {
     case MO_8:
@@ -551,18 +551,18 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, TCGMemOp s=
ize, bool sign)
     }
 }

-static void gen_extu(TCGMemOp ot, TCGv reg)
+static void gen_extu(MemOp ot, TCGv reg)
 {
     gen_ext_tl(reg, reg, ot, false);
 }

-static void gen_exts(TCGMemOp ot, TCGv reg)
+static void gen_exts(MemOp ot, TCGv reg)
 {
     gen_ext_tl(reg, reg, ot, true);
 }

 static inline
-void gen_op_jnz_ecx(DisasContext *s, TCGMemOp size, TCGLabel *label1)
+void gen_op_jnz_ecx(DisasContext *s, MemOp size, TCGLabel *label1)
 {
     tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);
     gen_extu(size, s->tmp0);
@@ -570,14 +570,14 @@ void gen_op_jnz_ecx(DisasContext *s, TCGMemOp size, T=
CGLabel *label1)
 }

 static inline
-void gen_op_jz_ecx(DisasContext *s, TCGMemOp size, TCGLabel *label1)
+void gen_op_jz_ecx(DisasContext *s, MemOp size, TCGLabel *label1)
 {
     tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);
     gen_extu(size, s->tmp0);
     tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);
 }

-static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCGv_i32 n)
+static void gen_helper_in_func(MemOp ot, TCGv v, TCGv_i32 n)
 {
     switch (ot) {
     case MO_8:
@@ -594,7 +594,7 @@ static void gen_helper_in_func(TCGMemOp ot, TCGv v, TCG=
v_i32 n)
     }
 }

-static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v, TCGv_i32 n)
+static void gen_helper_out_func(MemOp ot, TCGv_i32 v, TCGv_i32 n)
 {
     switch (ot) {
     case MO_8:
@@ -611,7 +611,7 @@ static void gen_helper_out_func(TCGMemOp ot, TCGv_i32 v=
, TCGv_i32 n)
     }
 }

-static void gen_check_io(DisasContext *s, TCGMemOp ot, target_ulong cur_ei=
p,
+static void gen_check_io(DisasContext *s, MemOp ot, target_ulong cur_eip,
                          uint32_t svm_flags)
 {
     target_ulong next_eip;
@@ -644,7 +644,7 @@ static void gen_check_io(DisasContext *s, TCGMemOp ot, =
target_ulong cur_eip,
     }
 }

-static inline void gen_movs(DisasContext *s, TCGMemOp ot)
+static inline void gen_movs(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
@@ -840,7 +840,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, =
TCGv reg)
         return (CCPrepare) { .cond =3D TCG_COND_NEVER, .mask =3D -1 };
     default:
         {
-            TCGMemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;
+            MemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;
             TCGv t0 =3D gen_ext_tl(reg, cpu_cc_dst, size, true);
             return (CCPrepare) { .cond =3D TCG_COND_LT, .reg =3D t0, .mask=
 =3D -1 };
         }
@@ -885,7 +885,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, =
TCGv reg)
                              .mask =3D -1 };
     default:
         {
-            TCGMemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;
+            MemOp size =3D (s->cc_op - CC_OP_ADDB) & 3;
             TCGv t0 =3D gen_ext_tl(reg, cpu_cc_dst, size, false);
             return (CCPrepare) { .cond =3D TCG_COND_EQ, .reg =3D t0, .mask=
 =3D -1 };
         }
@@ -897,7 +897,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, =
TCGv reg)
 static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
 {
     int inv, jcc_op, cond;
-    TCGMemOp size;
+    MemOp size;
     CCPrepare cc;
     TCGv t0;

@@ -1075,7 +1075,7 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s, t=
arget_ulong next_eip)
     return l2;
 }

-static inline void gen_stos(DisasContext *s, TCGMemOp ot)
+static inline void gen_stos(DisasContext *s, MemOp ot)
 {
     gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
     gen_string_movl_A0_EDI(s);
@@ -1084,7 +1084,7 @@ static inline void gen_stos(DisasContext *s, TCGMemOp=
 ot)
     gen_op_add_reg_T0(s, s->aflag, R_EDI);
 }

-static inline void gen_lods(DisasContext *s, TCGMemOp ot)
+static inline void gen_lods(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_ESI(s);
     gen_op_ld_v(s, ot, s->T0, s->A0);
@@ -1093,7 +1093,7 @@ static inline void gen_lods(DisasContext *s, TCGMemOp=
 ot)
     gen_op_add_reg_T0(s, s->aflag, R_ESI);
 }

-static inline void gen_scas(DisasContext *s, TCGMemOp ot)
+static inline void gen_scas(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
@@ -1102,7 +1102,7 @@ static inline void gen_scas(DisasContext *s, TCGMemOp=
 ot)
     gen_op_add_reg_T0(s, s->aflag, R_EDI);
 }

-static inline void gen_cmps(DisasContext *s, TCGMemOp ot)
+static inline void gen_cmps(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
@@ -1126,7 +1126,7 @@ static void gen_bpt_io(DisasContext *s, TCGv_i32 t_po=
rt, int ot)
 }


-static inline void gen_ins(DisasContext *s, TCGMemOp ot)
+static inline void gen_ins(DisasContext *s, MemOp ot)
 {
     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -1148,7 +1148,7 @@ static inline void gen_ins(DisasContext *s, TCGMemOp =
ot)
     }
 }

-static inline void gen_outs(DisasContext *s, TCGMemOp ot)
+static inline void gen_outs(DisasContext *s, MemOp ot)
 {
     if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
         gen_io_start();
@@ -1171,7 +1171,7 @@ static inline void gen_outs(DisasContext *s, TCGMemOp=
 ot)
 /* same method as Valgrind : we generate jumps to current or next
    instruction */
 #define GEN_REPZ(op)                                                      =
    \
-static inline void gen_repz_ ## op(DisasContext *s, TCGMemOp ot,          =
    \
+static inline void gen_repz_ ## op(DisasContext *s, MemOp ot,             =
 \
                                  target_ulong cur_eip, target_ulong next_e=
ip) \
 {                                                                         =
    \
     TCGLabel *l2;                                                         =
    \
@@ -1187,7 +1187,7 @@ static inline void gen_repz_ ## op(DisasContext *s, T=
CGMemOp ot,              \
 }

 #define GEN_REPZ2(op)                                                     =
    \
-static inline void gen_repz_ ## op(DisasContext *s, TCGMemOp ot,          =
    \
+static inline void gen_repz_ ## op(DisasContext *s, MemOp ot,             =
 \
                                    target_ulong cur_eip,                  =
    \
                                    target_ulong next_eip,                 =
    \
                                    int nz)                                =
    \
@@ -1284,7 +1284,7 @@ static void gen_illegal_opcode(DisasContext *s)
 }

 /* if d =3D=3D OR_TMP0, it means memory operand (address in A0) */
-static void gen_op(DisasContext *s1, int op, TCGMemOp ot, int d)
+static void gen_op(DisasContext *s1, int op, MemOp ot, int d)
 {
     if (d !=3D OR_TMP0) {
         if (s1->prefix & PREFIX_LOCK) {
@@ -1395,7 +1395,7 @@ static void gen_op(DisasContext *s1, int op, TCGMemOp=
 ot, int d)
 }

 /* if d =3D=3D OR_TMP0, it means memory operand (address in A0) */
-static void gen_inc(DisasContext *s1, TCGMemOp ot, int d, int c)
+static void gen_inc(DisasContext *s1, MemOp ot, int d, int c)
 {
     if (s1->prefix & PREFIX_LOCK) {
         if (d !=3D OR_TMP0) {
@@ -1421,7 +1421,7 @@ static void gen_inc(DisasContext *s1, TCGMemOp ot, in=
t d, int c)
     set_cc_op(s1, (c > 0 ? CC_OP_INCB : CC_OP_DECB) + ot);
 }

-static void gen_shift_flags(DisasContext *s, TCGMemOp ot, TCGv result,
+static void gen_shift_flags(DisasContext *s, MemOp ot, TCGv result,
                             TCGv shm1, TCGv count, bool is_right)
 {
     TCGv_i32 z32, s32, oldop;
@@ -1466,7 +1466,7 @@ static void gen_shift_flags(DisasContext *s, TCGMemOp=
 ot, TCGv result,
     set_cc_op(s, CC_OP_DYNAMIC);
 }

-static void gen_shift_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
+static void gen_shift_rm_T1(DisasContext *s, MemOp ot, int op1,
                             int is_right, int is_arith)
 {
     target_ulong mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
@@ -1502,7 +1502,7 @@ static void gen_shift_rm_T1(DisasContext *s, TCGMemOp=
 ot, int op1,
     gen_shift_flags(s, ot, s->T0, s->tmp0, s->T1, is_right);
 }

-static void gen_shift_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2=
,
+static void gen_shift_rm_im(DisasContext *s, MemOp ot, int op1, int op2,
                             int is_right, int is_arith)
 {
     int mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
@@ -1542,7 +1542,7 @@ static void gen_shift_rm_im(DisasContext *s, TCGMemOp=
 ot, int op1, int op2,
     }
 }

-static void gen_rot_rm_T1(DisasContext *s, TCGMemOp ot, int op1, int is_ri=
ght)
+static void gen_rot_rm_T1(DisasContext *s, MemOp ot, int op1, int is_right=
)
 {
     target_ulong mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
     TCGv_i32 t0, t1;
@@ -1627,7 +1627,7 @@ static void gen_rot_rm_T1(DisasContext *s, TCGMemOp o=
t, int op1, int is_right)
     set_cc_op(s, CC_OP_DYNAMIC);
 }

-static void gen_rot_rm_im(DisasContext *s, TCGMemOp ot, int op1, int op2,
+static void gen_rot_rm_im(DisasContext *s, MemOp ot, int op1, int op2,
                           int is_right)
 {
     int mask =3D (ot =3D=3D MO_64 ? 0x3f : 0x1f);
@@ -1705,7 +1705,7 @@ static void gen_rot_rm_im(DisasContext *s, TCGMemOp o=
t, int op1, int op2,
 }

 /* XXX: add faster immediate =3D 1 case */
-static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
+static void gen_rotc_rm_T1(DisasContext *s, MemOp ot, int op1,
                            int is_right)
 {
     gen_compute_eflags(s);
@@ -1761,7 +1761,7 @@ static void gen_rotc_rm_T1(DisasContext *s, TCGMemOp =
ot, int op1,
 }

 /* XXX: add faster immediate case */
-static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
+static void gen_shiftd_rm_T1(DisasContext *s, MemOp ot, int op1,
                              bool is_right, TCGv count_in)
 {
     target_ulong mask =3D (ot =3D=3D MO_64 ? 63 : 31);
@@ -1842,7 +1842,7 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemO=
p ot, int op1,
     tcg_temp_free(count);
 }

-static void gen_shift(DisasContext *s1, int op, TCGMemOp ot, int d, int s)
+static void gen_shift(DisasContext *s1, int op, MemOp ot, int d, int s)
 {
     if (s !=3D OR_TMP1)
         gen_op_mov_v_reg(s1, ot, s1->T1, s);
@@ -1872,7 +1872,7 @@ static void gen_shift(DisasContext *s1, int op, TCGMe=
mOp ot, int d, int s)
     }
 }

-static void gen_shifti(DisasContext *s1, int op, TCGMemOp ot, int d, int c=
)
+static void gen_shifti(DisasContext *s1, int op, MemOp ot, int d, int c)
 {
     switch(op) {
     case OP_ROL:
@@ -2149,7 +2149,7 @@ static void gen_add_A0_ds_seg(DisasContext *s)
 /* generate modrm memory load or store of 'reg'. TMP0 is used if reg =3D=
=3D
    OR_TMP0 */
 static void gen_ldst_modrm(CPUX86State *env, DisasContext *s, int modrm,
-                           TCGMemOp ot, int reg, int is_store)
+                           MemOp ot, int reg, int is_store)
 {
     int mod, rm;

@@ -2179,7 +2179,7 @@ static void gen_ldst_modrm(CPUX86State *env, DisasCon=
text *s, int modrm,
     }
 }

-static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, TCGMemO=
p ot)
+static inline uint32_t insn_get(CPUX86State *env, DisasContext *s, MemOp o=
t)
 {
     uint32_t ret;

@@ -2202,7 +2202,7 @@ static inline uint32_t insn_get(CPUX86State *env, Dis=
asContext *s, TCGMemOp ot)
     return ret;
 }

-static inline int insn_const_size(TCGMemOp ot)
+static inline int insn_const_size(MemOp ot)
 {
     if (ot <=3D MO_32) {
         return 1 << ot;
@@ -2266,7 +2266,7 @@ static inline void gen_jcc(DisasContext *s, int b,
     }
 }

-static void gen_cmovcc1(CPUX86State *env, DisasContext *s, TCGMemOp ot, in=
t b,
+static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b=
,
                         int modrm, int reg)
 {
     CCPrepare cc;
@@ -2363,8 +2363,8 @@ static inline void gen_stack_update(DisasContext *s, =
int addend)
 /* Generate a push. It depends on ss32, addseg and dflag.  */
 static void gen_push_v(DisasContext *s, TCGv val)
 {
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
-    TCGMemOp a_ot =3D mo_stacksize(s);
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);
+    MemOp a_ot =3D mo_stacksize(s);
     int size =3D 1 << d_ot;
     TCGv new_esp =3D s->A0;

@@ -2383,9 +2383,9 @@ static void gen_push_v(DisasContext *s, TCGv val)
 }

 /* two step pop is necessary for precise exceptions */
-static TCGMemOp gen_pop_T0(DisasContext *s)
+static MemOp gen_pop_T0(DisasContext *s)
 {
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);

     gen_lea_v_seg(s, mo_stacksize(s), cpu_regs[R_ESP], R_SS, -1);
     gen_op_ld_v(s, d_ot, s->T0, s->A0);
@@ -2393,7 +2393,7 @@ static TCGMemOp gen_pop_T0(DisasContext *s)
     return d_ot;
 }

-static inline void gen_pop_update(DisasContext *s, TCGMemOp ot)
+static inline void gen_pop_update(DisasContext *s, MemOp ot)
 {
     gen_stack_update(s, 1 << ot);
 }
@@ -2405,8 +2405,8 @@ static inline void gen_stack_A0(DisasContext *s)

 static void gen_pusha(DisasContext *s)
 {
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_16;
-    TCGMemOp d_ot =3D s->dflag;
+    MemOp s_ot =3D s->ss32 ? MO_32 : MO_16;
+    MemOp d_ot =3D s->dflag;
     int size =3D 1 << d_ot;
     int i;

@@ -2421,8 +2421,8 @@ static void gen_pusha(DisasContext *s)

 static void gen_popa(DisasContext *s)
 {
-    TCGMemOp s_ot =3D s->ss32 ? MO_32 : MO_16;
-    TCGMemOp d_ot =3D s->dflag;
+    MemOp s_ot =3D s->ss32 ? MO_32 : MO_16;
+    MemOp d_ot =3D s->dflag;
     int size =3D 1 << d_ot;
     int i;

@@ -2442,8 +2442,8 @@ static void gen_popa(DisasContext *s)

 static void gen_enter(DisasContext *s, int esp_addend, int level)
 {
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
-    TCGMemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);
+    MemOp a_ot =3D CODE64(s) ? MO_64 : s->ss32 ? MO_32 : MO_16;
     int size =3D 1 << d_ot;

     /* Push BP; compute FrameTemp into T1.  */
@@ -2482,8 +2482,8 @@ static void gen_enter(DisasContext *s, int esp_addend=
, int level)

 static void gen_leave(DisasContext *s)
 {
-    TCGMemOp d_ot =3D mo_pushpop(s, s->dflag);
-    TCGMemOp a_ot =3D mo_stacksize(s);
+    MemOp d_ot =3D mo_pushpop(s, s->dflag);
+    MemOp a_ot =3D mo_stacksize(s);

     gen_lea_v_seg(s, a_ot, cpu_regs[R_EBP], R_SS, -1);
     gen_op_ld_v(s, d_ot, s->T0, s->A0);
@@ -3045,7 +3045,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s=
, int b,
     SSEFunc_0_eppi sse_fn_eppi;
     SSEFunc_0_ppi sse_fn_ppi;
     SSEFunc_0_eppt sse_fn_eppt;
-    TCGMemOp ot;
+    MemOp ot;

     b &=3D 0xff;
     if (s->prefix & PREFIX_DATA)
@@ -4488,7 +4488,7 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     CPUX86State *env =3D cpu->env_ptr;
     int b, prefixes;
     int shift;
-    TCGMemOp ot, aflag, dflag;
+    MemOp ot, aflag, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     target_ulong next_eip, tval;
     int rex_w, rex_r;
@@ -5567,8 +5567,8 @@ static target_ulong disas_insn(DisasContext *s, CPUSt=
ate *cpu)
     case 0x1be: /* movsbS Gv, Eb */
     case 0x1bf: /* movswS Gv, Eb */
         {
-            TCGMemOp d_ot;
-            TCGMemOp s_ot;
+            MemOp d_ot;
+            MemOp s_ot;

             /* d_ot is the size of destination */
             d_ot =3D dflag;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 60bcfb7..24c1dd3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2414,7 +2414,7 @@ DISAS_INSN(cas)
     uint16_t ext;
     TCGv load;
     TCGv cmp;
-    TCGMemOp opc;
+    MemOp opc;

     switch ((insn >> 9) & 3) {
     case 1:
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9ce65f3..41d1b8b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -919,7 +919,7 @@ static void dec_load(DisasContext *dc)
     unsigned int size;
     bool rev =3D false, ex =3D false, ea =3D false;
     int mem_index =3D cpu_mmu_index(&dc->cpu->env, false);
-    TCGMemOp mop;
+    MemOp mop;

     mop =3D dc->opcode & 3;
     size =3D 1 << mop;
@@ -1035,7 +1035,7 @@ static void dec_store(DisasContext *dc)
     unsigned int size;
     bool rev =3D false, ex =3D false, ea =3D false;
     int mem_index =3D cpu_mmu_index(&dc->cpu->env, false);
-    TCGMemOp mop;
+    MemOp mop;

     mop =3D dc->opcode & 3;
     size =3D 1 << mop;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ca62800..59b5d85 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -2526,7 +2526,7 @@ typedef struct DisasContext {
     int32_t CP0_Config5;
     /* Routine used to access memory */
     int mem_idx;
-    TCGMemOp default_tcg_memop_mask;
+    MemOp default_tcg_memop_mask;
     uint32_t hflags, saved_hflags;
     target_ulong btarget;
     bool ulri;
@@ -3706,7 +3706,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, i=
nt rt,

 /* Store conditional */
 static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
-                        TCGMemOp tcg_mo, bool eva)
+                        MemOp tcg_mo, bool eva)
 {
     TCGv addr, t0, val;
     TCGLabel *l1 =3D gen_new_label();
@@ -4546,7 +4546,7 @@ static void gen_HILO(DisasContext *ctx, uint32_t opc,=
 int acc, int reg)
 }

 static inline void gen_r6_ld(target_long addr, int reg, int memidx,
-                             TCGMemOp memop)
+                             MemOp memop)
 {
     TCGv t0 =3D tcg_const_tl(addr);
     tcg_gen_qemu_ld_tl(t0, t0, memidx, memop);
@@ -21828,7 +21828,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *=
env, DisasContext *ctx)
                              extract32(ctx->opcode, 0, 8);
                     TCGv va =3D tcg_temp_new();
                     TCGv t1 =3D tcg_temp_new();
-                    TCGMemOp memop =3D (extract32(ctx->opcode, 8, 3)) =3D=
=3D
+                    MemOp memop =3D (extract32(ctx->opcode, 8, 3)) =3D=3D
                                       NM_P_LS_UAWM ? MO_UNALN : 0;

                     count =3D (count =3D=3D 0) ? 8 : count;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 4360ce4..b189c50 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -681,7 +681,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     return true;
 }

-static void do_load(DisasContext *dc, arg_load *a, TCGMemOp mop)
+static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 {
     TCGv ea;

@@ -763,7 +763,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
     return true;
 }

-static void do_store(DisasContext *dc, arg_store *a, TCGMemOp mop)
+static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 {
     TCGv t0 =3D tcg_temp_new();
     tcg_gen_addi_tl(t0, cpu_R[a->a], a->i);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28..31800ed 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -162,7 +162,7 @@ struct DisasContext {
     int mem_idx;
     int access_type;
     /* Translation flags */
-    TCGMemOp default_tcg_memop_mask;
+    MemOp default_tcg_memop_mask;
 #if defined(TARGET_PPC64)
     bool sf_mode;
     bool has_cfar;
@@ -3142,7 +3142,7 @@ static void gen_isync(DisasContext *ctx)

 #define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))

-static void gen_load_locked(DisasContext *ctx, TCGMemOp memop)
+static void gen_load_locked(DisasContext *ctx, MemOp memop)
 {
     TCGv gpr =3D cpu_gpr[rD(ctx->opcode)];
     TCGv t0 =3D tcg_temp_new();
@@ -3167,7 +3167,7 @@ LARX(lbarx, DEF_MEMOP(MO_UB))
 LARX(lharx, DEF_MEMOP(MO_UW))
 LARX(lwarx, DEF_MEMOP(MO_UL))

-static void gen_fetch_inc_conditional(DisasContext *ctx, TCGMemOp memop,
+static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
                                       TCGv EA, TCGCond cond, int addend)
 {
     TCGv t =3D tcg_temp_new();
@@ -3193,7 +3193,7 @@ static void gen_fetch_inc_conditional(DisasContext *c=
tx, TCGMemOp memop,
     tcg_temp_free(u);
 }

-static void gen_ld_atomic(DisasContext *ctx, TCGMemOp memop)
+static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
 {
     uint32_t gpr_FC =3D FC(ctx->opcode);
     TCGv EA =3D tcg_temp_new();
@@ -3306,7 +3306,7 @@ static void gen_ldat(DisasContext *ctx)
 }
 #endif

-static void gen_st_atomic(DisasContext *ctx, TCGMemOp memop)
+static void gen_st_atomic(DisasContext *ctx, MemOp memop)
 {
     uint32_t gpr_FC =3D FC(ctx->opcode);
     TCGv EA =3D tcg_temp_new();
@@ -3389,7 +3389,7 @@ static void gen_stdat(DisasContext *ctx)
 }
 #endif

-static void gen_conditional_store(DisasContext *ctx, TCGMemOp memop)
+static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 {
     TCGLabel *l1 =3D gen_new_label();
     TCGLabel *l2 =3D gen_new_label();
diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_tr=
ans/trans_rva.inc.c
index fadd888..be8a9f0 100644
--- a/target/riscv/insn_trans/trans_rva.inc.c
+++ b/target/riscv/insn_trans/trans_rva.inc.c
@@ -18,7 +18,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */

-static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
+static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1 =3D tcg_temp_new();
     /* Put addr in load_res, data in load_val.  */
@@ -37,7 +37,7 @@ static inline bool gen_lr(DisasContext *ctx, arg_atomic *=
a, TCGMemOp mop)
     return true;
 }

-static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
+static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1 =3D tcg_temp_new();
     TCGv src2 =3D tcg_temp_new();
@@ -82,8 +82,8 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *=
a, TCGMemOp mop)
 }

 static bool gen_amo(DisasContext *ctx, arg_atomic *a,
-                    void(*func)(TCGv, TCGv, TCGv, TCGArg, TCGMemOp),
-                    TCGMemOp mop)
+                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
+                    MemOp mop)
 {
     TCGv src1 =3D tcg_temp_new();
     TCGv src2 =3D tcg_temp_new();
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_tr=
ans/trans_rvi.inc.c
index ea64731..cf440d1 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -135,7 +135,7 @@ static bool trans_bgeu(DisasContext *ctx, arg_bgeu *a)
     return gen_branch(ctx, a, TCG_COND_GEU);
 }

-static bool gen_load(DisasContext *ctx, arg_lb *a, TCGMemOp memop)
+static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     TCGv t0 =3D tcg_temp_new();
     TCGv t1 =3D tcg_temp_new();
@@ -174,7 +174,7 @@ static bool trans_lhu(DisasContext *ctx, arg_lhu *a)
     return gen_load(ctx, a, MO_TEUW);
 }

-static bool gen_store(DisasContext *ctx, arg_sb *a, TCGMemOp memop)
+static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
     TCGv t0 =3D tcg_temp_new();
     TCGv dat =3D tcg_temp_new();
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index ac0d8b6..2927247 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -152,7 +152,7 @@ static inline int vec_full_reg_offset(uint8_t reg)
     return offsetof(CPUS390XState, vregs[reg][0]);
 }

-static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
+static inline int vec_reg_offset(uint8_t reg, uint8_t enr, MemOp es)
 {
     /* Convert element size (es) - e.g. MO_8 - to bytes */
     const uint8_t bytes =3D 1 << es;
@@ -2262,7 +2262,7 @@ static DisasJumpType op_csst(DisasContext *s, DisasOp=
s *o)
 #ifndef CONFIG_USER_ONLY
 static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 {
-    TCGMemOp mop =3D s->insn->data;
+    MemOp mop =3D s->insn->data;
     TCGv_i64 addr, old, cc;
     TCGLabel *lab =3D gen_new_label();

@@ -3228,7 +3228,7 @@ static DisasJumpType op_lm64(DisasContext *s, DisasOp=
s *o)
 static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 a1, a2;
-    TCGMemOp mop =3D s->insn->data;
+    MemOp mop =3D s->insn->data;

     /* In a parallel context, stop the world and single step.  */
     if (tb_cflags(s->base.tb) & CF_PARALLEL) {
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.in=
c.c
index 41d5cf8..4c56bbb 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -57,13 +57,13 @@
 #define FPF_LONG        3
 #define FPF_EXT         4

-static inline bool valid_vec_element(uint8_t enr, TCGMemOp es)
+static inline bool valid_vec_element(uint8_t enr, MemOp es)
 {
     return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
 }

 static void read_vec_element_i64(TCGv_i64 dst, uint8_t reg, uint8_t enr,
-                                 TCGMemOp memop)
+                                 MemOp memop)
 {
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);

@@ -96,7 +96,7 @@ static void read_vec_element_i64(TCGv_i64 dst, uint8_t re=
g, uint8_t enr,
 }

 static void read_vec_element_i32(TCGv_i32 dst, uint8_t reg, uint8_t enr,
-                                 TCGMemOp memop)
+                                 MemOp memop)
 {
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);

@@ -123,7 +123,7 @@ static void read_vec_element_i32(TCGv_i32 dst, uint8_t =
reg, uint8_t enr,
 }

 static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
-                                  TCGMemOp memop)
+                                  MemOp memop)
 {
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);

@@ -146,7 +146,7 @@ static void write_vec_element_i64(TCGv_i64 src, int reg=
, uint8_t enr,
 }

 static void write_vec_element_i32(TCGv_i32 src, int reg, uint8_t enr,
-                                  TCGMemOp memop)
+                                  MemOp memop)
 {
     const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 091bab5..bef9ce6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2019,7 +2019,7 @@ static inline void gen_ne_fop_QD(DisasContext *dc, in=
t rd, int rs,
 }

 static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
-                     TCGv addr, int mmu_idx, TCGMemOp memop)
+                     TCGv addr, int mmu_idx, MemOp memop)
 {
     gen_address_mask(dc, addr);
     tcg_gen_atomic_xchg_tl(dst, addr, src, mmu_idx, memop);
@@ -2050,10 +2050,10 @@ typedef struct {
     ASIType type;
     int asi;
     int mem_idx;
-    TCGMemOp memop;
+    MemOp memop;
 } DisasASI;

-static DisasASI get_asi(DisasContext *dc, int insn, TCGMemOp memop)
+static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
 {
     int asi =3D GET_FIELD(insn, 19, 26);
     ASIType type =3D GET_ASI_HELPER;
@@ -2267,7 +2267,7 @@ static DisasASI get_asi(DisasContext *dc, int insn, T=
CGMemOp memop)
 }

 static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
-                       int insn, TCGMemOp memop)
+                       int insn, MemOp memop)
 {
     DisasASI da =3D get_asi(dc, insn, memop);

@@ -2305,7 +2305,7 @@ static void gen_ld_asi(DisasContext *dc, TCGv dst, TC=
Gv addr,
 }

 static void gen_st_asi(DisasContext *dc, TCGv src, TCGv addr,
-                       int insn, TCGMemOp memop)
+                       int insn, MemOp memop)
 {
     DisasASI da =3D get_asi(dc, insn, memop);

@@ -2511,7 +2511,7 @@ static void gen_ldf_asi(DisasContext *dc, TCGv addr,
     case GET_ASI_BLOCK:
         /* Valid for lddfa on aligned registers only.  */
         if (size =3D=3D 8 && (rd & 7) =3D=3D 0) {
-            TCGMemOp memop;
+            MemOp memop;
             TCGv eight;
             int i;

@@ -2625,7 +2625,7 @@ static void gen_stf_asi(DisasContext *dc, TCGv addr,
     case GET_ASI_BLOCK:
         /* Valid for stdfa on aligned registers only.  */
         if (size =3D=3D 8 && (rd & 7) =3D=3D 0) {
-            TCGMemOp memop;
+            MemOp memop;
             TCGv eight;
             int i;

diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index c46a4ab..68dd4aa 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -290,7 +290,7 @@ static void gen_cmul2(TCGv tdest, TCGv tsrca, TCGv tsrc=
b, int sh, int rd)
 }

 static TileExcp gen_st_opcode(DisasContext *dc, unsigned dest, unsigned sr=
ca,
-                              unsigned srcb, TCGMemOp memop, const char *n=
ame)
+                              unsigned srcb, MemOp memop, const char *name=
)
 {
     if (dest) {
         return TILEGX_EXCP_OPCODE_UNKNOWN;
@@ -305,7 +305,7 @@ static TileExcp gen_st_opcode(DisasContext *dc, unsigne=
d dest, unsigned srca,
 }

 static TileExcp gen_st_add_opcode(DisasContext *dc, unsigned srca, unsigne=
d srcb,
-                                  int imm, TCGMemOp memop, const char *nam=
e)
+                                  int imm, MemOp memop, const char *name)
 {
     TCGv tsrca =3D load_gr(dc, srca);
     TCGv tsrcb =3D load_gr(dc, srcb);
@@ -496,7 +496,7 @@ static TileExcp gen_rr_opcode(DisasContext *dc, unsigne=
d opext,
 {
     TCGv tdest, tsrca;
     const char *mnemonic;
-    TCGMemOp memop;
+    MemOp memop;
     TileExcp ret =3D TILEGX_EXCP_NONE;
     bool prefetch_nofault =3D false;

@@ -1478,7 +1478,7 @@ static TileExcp gen_rri_opcode(DisasContext *dc, unsi=
gned opext,
     TCGv tsrca =3D load_gr(dc, srca);
     bool prefetch_nofault =3D false;
     const char *mnemonic;
-    TCGMemOp memop;
+    MemOp memop;
     int i2, i3;
     TCGv t0;

@@ -2106,7 +2106,7 @@ static TileExcp decode_y2(DisasContext *dc, tilegx_bu=
ndle_bits bundle)
     unsigned srca =3D get_SrcA_Y2(bundle);
     unsigned srcbdest =3D get_SrcBDest_Y2(bundle);
     const char *mnemonic;
-    TCGMemOp memop;
+    MemOp memop;
     bool prefetch_nofault =3D false;

     switch (OEY2(opc, mode)) {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index dc2a65f..87a5f50 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -227,7 +227,7 @@ static inline void generate_trap(DisasContext *ctx, int=
 class, int tin);
 /* Functions for load/save to/from memory */

 static inline void gen_offset_ld(DisasContext *ctx, TCGv r1, TCGv r2,
-                                 int16_t con, TCGMemOp mop)
+                                 int16_t con, MemOp mop)
 {
     TCGv temp =3D tcg_temp_new();
     tcg_gen_addi_tl(temp, r2, con);
@@ -236,7 +236,7 @@ static inline void gen_offset_ld(DisasContext *ctx, TCG=
v r1, TCGv r2,
 }

 static inline void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
-                                 int16_t con, TCGMemOp mop)
+                                 int16_t con, MemOp mop)
 {
     TCGv temp =3D tcg_temp_new();
     tcg_gen_addi_tl(temp, r2, con);
@@ -284,7 +284,7 @@ static void gen_offset_ld_2regs(TCGv rh, TCGv rl, TCGv =
base, int16_t con,
 }

 static void gen_st_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t of=
f,
-                           TCGMemOp mop)
+                           MemOp mop)
 {
     TCGv temp =3D tcg_temp_new();
     tcg_gen_addi_tl(temp, r2, off);
@@ -294,7 +294,7 @@ static void gen_st_preincr(DisasContext *ctx, TCGv r1, =
TCGv r2, int16_t off,
 }

 static void gen_ld_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t of=
f,
-                           TCGMemOp mop)
+                           MemOp mop)
 {
     TCGv temp =3D tcg_temp_new();
     tcg_gen_addi_tl(temp, r2, off);
diff --git a/tcg/README b/tcg/README
index 21fcdf7..b4382fa 100644
--- a/tcg/README
+++ b/tcg/README
@@ -512,7 +512,7 @@ Both t0 and t1 may be split into little-endian ordered =
pairs of registers
 if dealing with 64-bit quantities on a 32-bit host.

 The memidx selects the qemu tlb index to use (e.g. user or kernel access).
-The flags are the TCGMemOp bits, selecting the sign, width, and endianness
+The flags are the MemOp bits, selecting the sign, width, and endianness
 of the memory access.

 For a 32-bit host, qemu_ld/st_i64 is guaranteed to only be used with a
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 0713448..3f92101 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -1423,7 +1423,7 @@ static inline void tcg_out_rev16(TCGContext *s, TCGRe=
g rd, TCGReg rn)
     tcg_out_insn(s, 3507, REV16, TCG_TYPE_I32, rd, rn);
 }

-static inline void tcg_out_sxt(TCGContext *s, TCGType ext, TCGMemOp s_bits=
,
+static inline void tcg_out_sxt(TCGContext *s, TCGType ext, MemOp s_bits,
                                TCGReg rd, TCGReg rn)
 {
     /* Using ALIASes SXTB, SXTH, SXTW, of SBFM Xd, Xn, #0, #7|15|31 */
@@ -1431,7 +1431,7 @@ static inline void tcg_out_sxt(TCGContext *s, TCGType=
 ext, TCGMemOp s_bits,
     tcg_out_sbfm(s, ext, rd, rn, 0, bits);
 }

-static inline void tcg_out_uxt(TCGContext *s, TCGMemOp s_bits,
+static inline void tcg_out_uxt(TCGContext *s, MemOp s_bits,
                                TCGReg rd, TCGReg rn)
 {
     /* Using ALIASes UXTB, UXTH of UBFM Wd, Wn, #0, #7|15 */
@@ -1580,8 +1580,8 @@ static inline void tcg_out_adr(TCGContext *s, TCGReg =
rd, void *target)
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
-    TCGMemOp size =3D opc & MO_SIZE;
+    MemOp opc =3D get_memop(oi);
+    MemOp size =3D opc & MO_SIZE;

     if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
         return false;
@@ -1605,8 +1605,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
-    TCGMemOp size =3D opc & MO_SIZE;
+    MemOp opc =3D get_memop(oi);
+    MemOp size =3D opc & MO_SIZE;

     if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
         return false;
@@ -1649,7 +1649,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) !=
=3D 8);
    slow path for the failure case, which will be patched later when finali=
zing
    the slow path. Generated code returns the host addend in X1,
    clobbers X0,X2,X3,TMP. */
-static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, TCGMemOp opc,
+static void tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,
                              tcg_insn_unit **label_ptr, int mem_index,
                              bool is_read)
 {
@@ -1709,11 +1709,11 @@ static void tcg_out_tlb_read(TCGContext *s, TCGReg =
addr_reg, TCGMemOp opc,

 #endif /* CONFIG_SOFTMMU */

-static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp memop, TCGType =
ext,
+static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp memop, TCGType ext=
,
                                    TCGReg data_r, TCGReg addr_r,
                                    TCGType otype, TCGReg off_r)
 {
-    const TCGMemOp bswap =3D memop & MO_BSWAP;
+    const MemOp bswap =3D memop & MO_BSWAP;

     switch (memop & MO_SSIZE) {
     case MO_UB:
@@ -1765,11 +1765,11 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, T=
CGMemOp memop, TCGType ext,
     }
 }

-static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp memop,
+static void tcg_out_qemu_st_direct(TCGContext *s, MemOp memop,
                                    TCGReg data_r, TCGReg addr_r,
                                    TCGType otype, TCGReg off_r)
 {
-    const TCGMemOp bswap =3D memop & MO_BSWAP;
+    const MemOp bswap =3D memop & MO_BSWAP;

     switch (memop & MO_SIZE) {
     case MO_8:
@@ -1804,7 +1804,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCG=
MemOp memop,
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi, TCGType ext)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    MemOp memop =3D get_memop(oi);
     const TCGType otype =3D TARGET_LONG_BITS =3D=3D 64 ? TCG_TYPE_I64 : TC=
G_TYPE_I32;
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
@@ -1829,7 +1829,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a_reg, TCGReg addr_reg,
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    MemOp memop =3D get_memop(oi);
     const TCGType otype =3D TARGET_LONG_BITS =3D=3D 64 ? TCG_TYPE_I64 : TC=
G_TYPE_I32;
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index ece88dc..94d80d7 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1233,7 +1233,7 @@ QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) !=
=3D 4);
    containing the addend of the tlb entry.  Clobbers R0, R1, R2, TMP.  */

 static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi=
,
-                               TCGMemOp opc, int mem_index, bool is_load)
+                               MemOp opc, int mem_index, bool is_load)
 {
     int cmp_off =3D (is_load ? offsetof(CPUTLBEntry, addr_read)
                    : offsetof(CPUTLBEntry, addr_write));
@@ -1348,7 +1348,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 {
     TCGReg argreg, datalo, datahi;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     void *func;

     if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
@@ -1412,7 +1412,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 {
     TCGReg argreg, datalo, datahi;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);

     if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
         return false;
@@ -1453,11 +1453,11 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s=
, TCGLabelQemuLdst *lb)
 }
 #endif /* SOFTMMU */

-static inline void tcg_out_qemu_ld_index(TCGContext *s, TCGMemOp opc,
+static inline void tcg_out_qemu_ld_index(TCGContext *s, MemOp opc,
                                          TCGReg datalo, TCGReg datahi,
                                          TCGReg addrlo, TCGReg addend)
 {
-    TCGMemOp bswap =3D opc & MO_BSWAP;
+    MemOp bswap =3D opc & MO_BSWAP;

     switch (opc & MO_SSIZE) {
     case MO_UB:
@@ -1514,11 +1514,11 @@ static inline void tcg_out_qemu_ld_index(TCGContext=
 *s, TCGMemOp opc,
     }
 }

-static inline void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc,
+static inline void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc,
                                           TCGReg datalo, TCGReg datahi,
                                           TCGReg addrlo)
 {
-    TCGMemOp bswap =3D opc & MO_BSWAP;
+    MemOp bswap =3D opc & MO_BSWAP;

     switch (opc & MO_SSIZE) {
     case MO_UB:
@@ -1577,7 +1577,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is64)
 {
     TCGReg addrlo, datalo, datahi, addrhi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #ifdef CONFIG_SOFTMMU
     int mem_index;
     TCGReg addend;
@@ -1614,11 +1614,11 @@ static void tcg_out_qemu_ld(TCGContext *s, const TC=
GArg *args, bool is64)
 #endif
 }

-static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, TCGMemOp=
 opc,
+static inline void tcg_out_qemu_st_index(TCGContext *s, int cond, MemOp op=
c,
                                          TCGReg datalo, TCGReg datahi,
                                          TCGReg addrlo, TCGReg addend)
 {
-    TCGMemOp bswap =3D opc & MO_BSWAP;
+    MemOp bswap =3D opc & MO_BSWAP;

     switch (opc & MO_SIZE) {
     case MO_8:
@@ -1659,11 +1659,11 @@ static inline void tcg_out_qemu_st_index(TCGContext=
 *s, int cond, TCGMemOp opc,
     }
 }

-static inline void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc,
+static inline void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc,
                                           TCGReg datalo, TCGReg datahi,
                                           TCGReg addrlo)
 {
-    TCGMemOp bswap =3D opc & MO_BSWAP;
+    MemOp bswap =3D opc & MO_BSWAP;

     switch (opc & MO_SIZE) {
     case MO_8:
@@ -1708,7 +1708,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is64)
 {
     TCGReg addrlo, datalo, datahi, addrhi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #ifdef CONFIG_SOFTMMU
     int mem_index;
     TCGReg addend;
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6ddeebf..9d8ed97 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1697,7 +1697,7 @@ static void * const qemu_st_helpers[16] =3D {
    First argument register is clobbered.  */

 static inline void tcg_out_tlb_load(TCGContext *s, TCGReg addrlo, TCGReg a=
ddrhi,
-                                    int mem_index, TCGMemOp opc,
+                                    int mem_index, MemOp opc,
                                     tcg_insn_unit **label_ptr, int which)
 {
     const TCGReg r0 =3D TCG_REG_L0;
@@ -1810,7 +1810,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool i=
s_ld, bool is_64,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     TCGReg data_reg;
     tcg_insn_unit **label_ptr =3D &l->label_ptr[0];
     int rexw =3D (l->type =3D=3D TCG_TYPE_I64 ? P_REXW : 0);
@@ -1895,8 +1895,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
-    TCGMemOp s_bits =3D opc & MO_SIZE;
+    MemOp opc =3D get_memop(oi);
+    MemOp s_bits =3D opc & MO_SIZE;
     tcg_insn_unit **label_ptr =3D &l->label_ptr[0];
     TCGReg retaddr;

@@ -1995,10 +1995,10 @@ static inline int setup_guest_base_seg(void)

 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg da=
tahi,
                                    TCGReg base, int index, intptr_t ofs,
-                                   int seg, bool is64, TCGMemOp memop)
+                                   int seg, bool is64, MemOp memop)
 {
-    const TCGMemOp real_bswap =3D memop & MO_BSWAP;
-    TCGMemOp bswap =3D real_bswap;
+    const MemOp real_bswap =3D memop & MO_BSWAP;
+    MemOp bswap =3D real_bswap;
     int rexw =3D is64 * P_REXW;
     int movop =3D OPC_MOVL_GvEv;

@@ -2103,7 +2103,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is64)
     TCGReg datalo, datahi, addrlo;
     TCGReg addrhi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #if defined(CONFIG_SOFTMMU)
     int mem_index;
     tcg_insn_unit *label_ptr[2];
@@ -2137,15 +2137,15 @@ static void tcg_out_qemu_ld(TCGContext *s, const TC=
GArg *args, bool is64)

 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg da=
tahi,
                                    TCGReg base, int index, intptr_t ofs,
-                                   int seg, TCGMemOp memop)
+                                   int seg, MemOp memop)
 {
     /* ??? Ideally we wouldn't need a scratch register.  For user-only,
        we could perform the bswap twice to restore the original value
        instead of moving to the scratch.  But as it is, the L constraint
        means that TCG_REG_L0 is definitely free here.  */
     const TCGReg scratch =3D TCG_REG_L0;
-    const TCGMemOp real_bswap =3D memop & MO_BSWAP;
-    TCGMemOp bswap =3D real_bswap;
+    const MemOp real_bswap =3D memop & MO_BSWAP;
+    MemOp bswap =3D real_bswap;
     int movop =3D OPC_MOVL_EvGv;

     if (have_movbe && real_bswap) {
@@ -2221,7 +2221,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is64)
     TCGReg datalo, datahi, addrlo;
     TCGReg addrhi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #if defined(CONFIG_SOFTMMU)
     int mem_index;
     tcg_insn_unit *label_ptr[2];
diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
index 41bff32..5442167 100644
--- a/tcg/mips/tcg-target.inc.c
+++ b/tcg/mips/tcg-target.inc.c
@@ -1215,7 +1215,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg ba=
se, TCGReg addrl,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit *label_ptr[2], bool is_load)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     unsigned s_bits =3D opc & MO_SIZE;
     unsigned a_bits =3D get_alignment_bits(opc);
     int mem_index =3D get_mmuidx(oi);
@@ -1313,7 +1313,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is=
_ld, TCGMemOpIdx oi,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     TCGReg v0;
     int i;

@@ -1363,8 +1363,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
-    TCGMemOp s_bits =3D opc & MO_SIZE;
+    MemOp opc =3D get_memop(oi);
+    MemOp s_bits =3D opc & MO_SIZE;
     int i;

     /* resolve label address */
@@ -1413,7 +1413,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 #endif

 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
-                                   TCGReg base, TCGMemOp opc, bool is_64)
+                                   TCGReg base, MemOp opc, bool is_64)
 {
     switch (opc & (MO_SSIZE | MO_BSWAP)) {
     case MO_UB:
@@ -1521,7 +1521,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     TCGReg addr_regl, addr_regh __attribute__((unused));
     TCGReg data_regl, data_regh;
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #if defined(CONFIG_SOFTMMU)
     tcg_insn_unit *label_ptr[2];
 #endif
@@ -1558,7 +1558,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
 }

 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
-                                   TCGReg base, TCGMemOp opc)
+                                   TCGReg base, MemOp opc)
 {
     /* Don't clutter the code below with checks to avoid bswapping ZERO.  =
*/
     if ((lo | hi) =3D=3D 0) {
@@ -1624,7 +1624,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     TCGReg addr_regl, addr_regh __attribute__((unused));
     TCGReg data_regl, data_regh;
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #if defined(CONFIG_SOFTMMU)
     tcg_insn_unit *label_ptr[2];
 #endif
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d2424de..a89ffda 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1014,7 +1014,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(qemu_ld):
             {
                 TCGMemOpIdx oi =3D op->args[nb_oargs + nb_iargs];
-                TCGMemOp mop =3D get_memop(oi);
+                MemOp mop =3D get_memop(oi);
                 if (!(mop & MO_SIGN)) {
                     mask =3D (2ULL << ((8 << (mop & MO_SIZE)) - 1)) - 1;
                 }
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 852b894..815edac 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1506,7 +1506,7 @@ QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -32768);
    in CR7, loads the addend of the TLB into R3, and returns the register
    containing the guest address (zero-extended into R4).  Clobbers R0 and =
R2. */

-static TCGReg tcg_out_tlb_read(TCGContext *s, TCGMemOp opc,
+static TCGReg tcg_out_tlb_read(TCGContext *s, MemOp opc,
                                TCGReg addrlo, TCGReg addrhi,
                                int mem_index, bool is_read)
 {
@@ -1633,7 +1633,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool i=
s_ld, TCGMemOpIdx oi,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     TCGReg hi, lo, arg =3D TCG_REG_R3;

     if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
@@ -1680,8 +1680,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 {
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
-    TCGMemOp s_bits =3D opc & MO_SIZE;
+    MemOp opc =3D get_memop(oi);
+    MemOp s_bits =3D opc & MO_SIZE;
     TCGReg hi, lo, arg =3D TCG_REG_R3;

     if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
@@ -1744,7 +1744,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     TCGReg datalo, datahi, addrlo, rbase;
     TCGReg addrhi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc, s_bits;
+    MemOp opc, s_bits;
 #ifdef CONFIG_SOFTMMU
     int mem_index;
     tcg_insn_unit *label_ptr;
@@ -1819,7 +1819,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     TCGReg datalo, datahi, addrlo, rbase;
     TCGReg addrhi __attribute__((unused));
     TCGMemOpIdx oi;
-    TCGMemOp opc, s_bits;
+    MemOp opc, s_bits;
 #ifdef CONFIG_SOFTMMU
     int mem_index;
     tcg_insn_unit *label_ptr;
diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 3e76bf5..7018509 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -970,7 +970,7 @@ static void tcg_out_tlb_load(TCGContext *s, TCGReg addr=
l,
                              TCGReg addrh, TCGMemOpIdx oi,
                              tcg_insn_unit **label_ptr, bool is_load)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     unsigned s_bits =3D opc & MO_SIZE;
     unsigned a_bits =3D get_alignment_bits(opc);
     tcg_target_long compare_mask;
@@ -1044,7 +1044,7 @@ static void add_qemu_ldst_label(TCGContext *s, int is=
_ld, TCGMemOpIdx oi,
 static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
     TCGReg a0 =3D tcg_target_call_iarg_regs[0];
     TCGReg a1 =3D tcg_target_call_iarg_regs[1];
     TCGReg a2 =3D tcg_target_call_iarg_regs[2];
@@ -1077,8 +1077,8 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
 {
     TCGMemOpIdx oi =3D l->oi;
-    TCGMemOp opc =3D get_memop(oi);
-    TCGMemOp s_bits =3D opc & MO_SIZE;
+    MemOp opc =3D get_memop(oi);
+    MemOp s_bits =3D opc & MO_SIZE;
     TCGReg a0 =3D tcg_target_call_iarg_regs[0];
     TCGReg a1 =3D tcg_target_call_iarg_regs[1];
     TCGReg a2 =3D tcg_target_call_iarg_regs[2];
@@ -1121,9 +1121,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *l)
 #endif /* CONFIG_SOFTMMU */

 static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
-                                   TCGReg base, TCGMemOp opc, bool is_64)
+                                   TCGReg base, MemOp opc, bool is_64)
 {
-    const TCGMemOp bswap =3D opc & MO_BSWAP;
+    const MemOp bswap =3D opc & MO_BSWAP;

     /* We don't yet handle byteswapping, assert */
     g_assert(!bswap);
@@ -1172,7 +1172,7 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
     TCGReg addr_regl, addr_regh __attribute__((unused));
     TCGReg data_regl, data_regh;
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #if defined(CONFIG_SOFTMMU)
     tcg_insn_unit *label_ptr[1];
 #endif
@@ -1208,9 +1208,9 @@ static void tcg_out_qemu_ld(TCGContext *s, const TCGA=
rg *args, bool is_64)
 }

 static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
-                                   TCGReg base, TCGMemOp opc)
+                                   TCGReg base, MemOp opc)
 {
-    const TCGMemOp bswap =3D opc & MO_BSWAP;
+    const MemOp bswap =3D opc & MO_BSWAP;

     /* We don't yet handle byteswapping, assert */
     g_assert(!bswap);
@@ -1243,7 +1243,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGA=
rg *args, bool is_64)
     TCGReg addr_regl, addr_regh __attribute__((unused));
     TCGReg data_regl, data_regh;
     TCGMemOpIdx oi;
-    TCGMemOp opc;
+    MemOp opc;
 #if defined(CONFIG_SOFTMMU)
     tcg_insn_unit *label_ptr[1];
 #endif
diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index fe42939..8aaa4ce 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1430,7 +1430,7 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit=
 *dest)
     }
 }

-static void tcg_out_qemu_ld_direct(TCGContext *s, TCGMemOp opc, TCGReg dat=
a,
+static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg data,
                                    TCGReg base, TCGReg index, int disp)
 {
     switch (opc & (MO_SSIZE | MO_BSWAP)) {
@@ -1489,7 +1489,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCG=
MemOp opc, TCGReg data,
     }
 }

-static void tcg_out_qemu_st_direct(TCGContext *s, TCGMemOp opc, TCGReg dat=
a,
+static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg data,
                                    TCGReg base, TCGReg index, int disp)
 {
     switch (opc & (MO_SIZE | MO_BSWAP)) {
@@ -1544,7 +1544,7 @@ QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 19))=
;

 /* Load and compare a TLB entry, leaving the flags set.  Loads the TLB
    addend into R2.  Returns a register with the santitized guest address. =
 */
-static TCGReg tcg_out_tlb_read(TCGContext* s, TCGReg addr_reg, TCGMemOp op=
c,
+static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,
                                int mem_index, bool is_ld)
 {
     unsigned s_bits =3D opc & MO_SIZE;
@@ -1614,7 +1614,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     TCGReg addr_reg =3D lb->addrlo_reg;
     TCGReg data_reg =3D lb->datalo_reg;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);

     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
                      (intptr_t)s->code_ptr, 2)) {
@@ -1639,7 +1639,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, =
TCGLabelQemuLdst *lb)
     TCGReg addr_reg =3D lb->addrlo_reg;
     TCGReg data_reg =3D lb->datalo_reg;
     TCGMemOpIdx oi =3D lb->oi;
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);

     if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
                      (intptr_t)s->code_ptr, 2)) {
@@ -1694,7 +1694,7 @@ static void tcg_prepare_user_ldst(TCGContext *s, TCGR=
eg *addr_reg,
 static void tcg_out_qemu_ld(TCGContext* s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
     tcg_insn_unit *label_ptr;
@@ -1721,7 +1721,7 @@ static void tcg_out_qemu_ld(TCGContext* s, TCGReg dat=
a_reg, TCGReg addr_reg,
 static void tcg_out_qemu_st(TCGContext* s, TCGReg data_reg, TCGReg addr_re=
g,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp opc =3D get_memop(oi);
+    MemOp opc =3D get_memop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned mem_index =3D get_mmuidx(oi);
     tcg_insn_unit *label_ptr;
diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 10b1cea..d7986cd 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1081,7 +1081,7 @@ QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 12))=
;
    is in the returned register, maybe %o0.  The TLB addend is in %o1.  */

 static TCGReg tcg_out_tlb_load(TCGContext *s, TCGReg addr, int mem_index,
-                               TCGMemOp opc, int which)
+                               MemOp opc, int which)
 {
     int fast_off =3D TLB_MASK_TABLE_OFS(mem_index);
     int mask_off =3D fast_off + offsetof(CPUTLBDescFast, mask);
@@ -1164,7 +1164,7 @@ static const int qemu_st_opc[16] =3D {
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
                             TCGMemOpIdx oi, bool is_64)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    MemOp memop =3D get_memop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned memi =3D get_mmuidx(oi);
     TCGReg addrz, param;
@@ -1246,7 +1246,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg dat=
a, TCGReg addr,
 static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
                             TCGMemOpIdx oi)
 {
-    TCGMemOp memop =3D get_memop(oi);
+    MemOp memop =3D get_memop(oi);
 #ifdef CONFIG_SOFTMMU
     unsigned memi =3D get_mmuidx(oi);
     TCGReg addrz, param;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 587d092..e87c327 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2714,7 +2714,7 @@ void tcg_gen_lookup_and_goto_ptr(void)
     }
 }

-static inline TCGMemOp tcg_canonicalize_memop(TCGMemOp op, bool is64, bool=
 st)
+static inline MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
 {
     /* Trigger the asserts within as early as possible.  */
     (void)get_alignment_bits(op);
@@ -2743,7 +2743,7 @@ static inline TCGMemOp tcg_canonicalize_memop(TCGMemO=
p op, bool is64, bool st)
 }

 static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val, TCGv addr,
-                         TCGMemOp memop, TCGArg idx)
+                         MemOp memop, TCGArg idx)
 {
     TCGMemOpIdx oi =3D make_memop_idx(memop, idx);
 #if TARGET_LONG_BITS =3D=3D 32
@@ -2758,7 +2758,7 @@ static void gen_ldst_i32(TCGOpcode opc, TCGv_i32 val,=
 TCGv addr,
 }

 static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 val, TCGv addr,
-                         TCGMemOp memop, TCGArg idx)
+                         MemOp memop, TCGArg idx)
 {
     TCGMemOpIdx oi =3D make_memop_idx(memop, idx);
 #if TARGET_LONG_BITS =3D=3D 32
@@ -2788,9 +2788,9 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }

-void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)
+void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 {
-    TCGMemOp orig_memop;
+    MemOp orig_memop;

     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop =3D tcg_canonicalize_memop(memop, 0, 0);
@@ -2825,7 +2825,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     }
 }

-void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)
+void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     TCGv_i32 swap =3D NULL;

@@ -2858,9 +2858,9 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     }
 }

-void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)
+void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 {
-    TCGMemOp orig_memop;
+    MemOp orig_memop;

     if (TCG_TARGET_REG_BITS =3D=3D 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32(TCGV_LOW(val), addr, idx, memop);
@@ -2911,7 +2911,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     }
 }

-void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp mem=
op)
+void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
 {
     TCGv_i64 swap =3D NULL;

@@ -2953,7 +2953,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCG=
Arg idx, TCGMemOp memop)
     }
 }

-static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, TCGMemOp opc)
+static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
 {
     switch (opc & MO_SSIZE) {
     case MO_SB:
@@ -2974,7 +2974,7 @@ static void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 va=
l, TCGMemOp opc)
     }
 }

-static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, TCGMemOp opc)
+static void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
 {
     switch (opc & MO_SSIZE) {
     case MO_SB:
@@ -3034,7 +3034,7 @@ static void * const table_cmpxchg[16] =3D {
 };

 void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
-                                TCGv_i32 newv, TCGArg idx, TCGMemOp memop)
+                                TCGv_i32 newv, TCGArg idx, MemOp memop)
 {
     memop =3D tcg_canonicalize_memop(memop, 0, 0);

@@ -3078,7 +3078,7 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv a=
ddr, TCGv_i32 cmpv,
 }

 void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
-                                TCGv_i64 newv, TCGArg idx, TCGMemOp memop)
+                                TCGv_i64 newv, TCGArg idx, MemOp memop)
 {
     memop =3D tcg_canonicalize_memop(memop, 1, 0);

@@ -3142,7 +3142,7 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv a=
ddr, TCGv_i64 cmpv,
 }

 static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
-                                TCGArg idx, TCGMemOp memop, bool new_val,
+                                TCGArg idx, MemOp memop, bool new_val,
                                 void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t1 =3D tcg_temp_new_i32();
@@ -3160,7 +3160,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv ad=
dr, TCGv_i32 val,
 }

 static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
-                             TCGArg idx, TCGMemOp memop, void * const tabl=
e[])
+                             TCGArg idx, MemOp memop, void * const table[]=
)
 {
     gen_atomic_op_i32 gen;

@@ -3185,7 +3185,7 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr,=
 TCGv_i32 val,
 }

 static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
-                                TCGArg idx, TCGMemOp memop, bool new_val,
+                                TCGArg idx, MemOp memop, bool new_val,
                                 void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t1 =3D tcg_temp_new_i64();
@@ -3203,7 +3203,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv ad=
dr, TCGv_i64 val,
 }

 static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
-                             TCGArg idx, TCGMemOp memop, void * const tabl=
e[])
+                             TCGArg idx, MemOp memop, void * const table[]=
)
 {
     memop =3D tcg_canonicalize_memop(memop, 1, 0);

@@ -3257,7 +3257,7 @@ static void * const table_##NAME[16] =3D {           =
                     \
     WITH_ATOMIC64([MO_64 | MO_BE] =3D gen_helper_atomic_##NAME##q_be)     =
\
 };                                                                      \
 void tcg_gen_atomic_##NAME##_i32                                        \
-    (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, TCGMemOp memop) \
+    (TCGv_i32 ret, TCGv addr, TCGv_i32 val, TCGArg idx, MemOp memop)    \
 {                                                                       \
     if (tcg_ctx->tb_cflags & CF_PARALLEL) {                             \
         do_atomic_op_i32(ret, addr, val, idx, memop, table_##NAME);     \
@@ -3267,7 +3267,7 @@ void tcg_gen_atomic_##NAME##_i32                     =
                   \
     }                                                                   \
 }                                                                       \
 void tcg_gen_atomic_##NAME##_i64                                        \
-    (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, TCGMemOp memop) \
+    (TCGv_i64 ret, TCGv addr, TCGv_i64 val, TCGArg idx, MemOp memop)    \
 {                                                                       \
     if (tcg_ctx->tb_cflags & CF_PARALLEL) {                             \
         do_atomic_op_i64(ret, addr, val, idx, memop, table_##NAME);     \
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 2d4dd5c..e9cf172 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -851,10 +851,10 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
 #endif

-void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
-void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, TCGMemOp);
-void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
-void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, TCGMemOp);
+void tcg_gen_qemu_ld_i32(TCGv_i32, TCGv, TCGArg, MemOp);
+void tcg_gen_qemu_st_i32(TCGv_i32, TCGv, TCGArg, MemOp);
+void tcg_gen_qemu_ld_i64(TCGv_i64, TCGv, TCGArg, MemOp);
+void tcg_gen_qemu_st_i64(TCGv_i64, TCGv, TCGArg, MemOp);

 static inline void tcg_gen_qemu_ld8u(TCGv ret, TCGv addr, int mem_index)
 {
@@ -912,46 +912,46 @@ static inline void tcg_gen_qemu_st64(TCGv_i64 arg, TC=
Gv addr, int mem_index)
 }

 void tcg_gen_atomic_cmpxchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGv_i32,
-                                TCGArg, TCGMemOp);
+                                TCGArg, MemOp);
 void tcg_gen_atomic_cmpxchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGv_i64,
-                                TCGArg, TCGMemOp);
-
-void tcg_gen_atomic_xchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemOp);
-void tcg_gen_atomic_xchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
-
-void tcg_gen_atomic_fetch_add_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_fetch_add_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_fetch_and_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_fetch_and_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_fetch_or_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemO=
p);
-void tcg_gen_atomic_fetch_or_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemO=
p);
-void tcg_gen_atomic_fetch_xor_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_fetch_xor_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_fetch_smin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_smin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_umin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_umin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_smax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_smax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_umax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_fetch_umax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-
-void tcg_gen_atomic_add_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_add_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_and_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_and_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_or_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMemO=
p);
-void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemO=
p);
-void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMem=
Op);
-void tcg_gen_atomic_smin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_smin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_umin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_umin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_smax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_smax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_umax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, TCGMe=
mOp);
-void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMe=
mOp);
+                                TCGArg, MemOp);
+
+void tcg_gen_atomic_xchg_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
+void tcg_gen_atomic_xchg_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
+
+void tcg_gen_atomic_fetch_add_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;
+void tcg_gen_atomic_fetch_add_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;
+void tcg_gen_atomic_fetch_and_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;
+void tcg_gen_atomic_fetch_and_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;
+void tcg_gen_atomic_fetch_or_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
+void tcg_gen_atomic_fetch_or_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
+void tcg_gen_atomic_fetch_xor_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;
+void tcg_gen_atomic_fetch_xor_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;
+void tcg_gen_atomic_fetch_smin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_smin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_umin_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_umin_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_smax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_smax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_umax_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_fetch_umax_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+
+void tcg_gen_atomic_add_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;
+void tcg_gen_atomic_add_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;
+void tcg_gen_atomic_and_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;
+void tcg_gen_atomic_and_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;
+void tcg_gen_atomic_or_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp);
+void tcg_gen_atomic_or_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp);
+void tcg_gen_atomic_xor_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp)=
;
+void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp)=
;
+void tcg_gen_atomic_smin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_smin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+void tcg_gen_atomic_umin_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_umin_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+void tcg_gen_atomic_smax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_smax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);
+void tcg_gen_atomic_umax_fetch_i32(TCGv_i32, TCGv, TCGv_i32, TCGArg, MemOp=
);
+void tcg_gen_atomic_umax_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, MemOp=
);

 void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8d23fb0..0dff196 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2056,7 +2056,7 @@ static void tcg_dump_ops(TCGContext *s, bool have_pre=
fs)
             case INDEX_op_qemu_st_i64:
                 {
                     TCGMemOpIdx oi =3D op->args[k++];
-                    TCGMemOp op =3D get_memop(oi);
+                    MemOp op =3D get_memop(oi);
                     unsigned ix =3D get_mmuidx(oi);

                     if (op & ~(MO_AMASK | MO_BSWAP | MO_SSIZE)) {
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 529acb2..a37181c 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -26,6 +26,7 @@
 #define TCG_H

 #include "cpu.h"
+#include "exec/memop.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
 #include "qemu/queue.h"
@@ -309,103 +310,13 @@ typedef enum TCGType {
 #endif
 } TCGType;

-/* Constants for qemu_ld and qemu_st for the Memory Operation field.  */
-typedef enum TCGMemOp {
-    MO_8     =3D 0,
-    MO_16    =3D 1,
-    MO_32    =3D 2,
-    MO_64    =3D 3,
-    MO_SIZE  =3D 3,   /* Mask for the above.  */
-
-    MO_SIGN  =3D 4,   /* Sign-extended, otherwise zero-extended.  */
-
-    MO_BSWAP =3D 8,   /* Host reverse endian.  */
-#ifdef HOST_WORDS_BIGENDIAN
-    MO_LE    =3D MO_BSWAP,
-    MO_BE    =3D 0,
-#else
-    MO_LE    =3D 0,
-    MO_BE    =3D MO_BSWAP,
-#endif
-#ifdef TARGET_WORDS_BIGENDIAN
-    MO_TE    =3D MO_BE,
-#else
-    MO_TE    =3D MO_LE,
-#endif
-
-    /*
-     * MO_UNALN accesses are never checked for alignment.
-     * MO_ALIGN accesses will result in a call to the CPU's
-     * do_unaligned_access hook if the guest address is not aligned.
-     * The default depends on whether the target CPU defines
-     * TARGET_ALIGNED_ONLY.
-     *
-     * Some architectures (e.g. ARMv8) need the address which is aligned
-     * to a size more than the size of the memory access.
-     * Some architectures (e.g. SPARCv9) need an address which is aligned,
-     * but less strictly than the natural alignment.
-     *
-     * MO_ALIGN supposes the alignment size is the size of a memory access=
.
-     *
-     * There are three options:
-     * - unaligned access permitted (MO_UNALN).
-     * - an alignment to the size of an access (MO_ALIGN);
-     * - an alignment to a specified size, which may be more or less than
-     *   the access size (MO_ALIGN_x where 'x' is a size in bytes);
-     */
-    MO_ASHIFT =3D 4,
-    MO_AMASK =3D 7 << MO_ASHIFT,
-#ifdef TARGET_ALIGNED_ONLY
-    MO_ALIGN =3D 0,
-    MO_UNALN =3D MO_AMASK,
-#else
-    MO_ALIGN =3D MO_AMASK,
-    MO_UNALN =3D 0,
-#endif
-    MO_ALIGN_2  =3D 1 << MO_ASHIFT,
-    MO_ALIGN_4  =3D 2 << MO_ASHIFT,
-    MO_ALIGN_8  =3D 3 << MO_ASHIFT,
-    MO_ALIGN_16 =3D 4 << MO_ASHIFT,
-    MO_ALIGN_32 =3D 5 << MO_ASHIFT,
-    MO_ALIGN_64 =3D 6 << MO_ASHIFT,
-
-    /* Combinations of the above, for ease of use.  */
-    MO_UB    =3D MO_8,
-    MO_UW    =3D MO_16,
-    MO_UL    =3D MO_32,
-    MO_SB    =3D MO_SIGN | MO_8,
-    MO_SW    =3D MO_SIGN | MO_16,
-    MO_SL    =3D MO_SIGN | MO_32,
-    MO_Q     =3D MO_64,
-
-    MO_LEUW  =3D MO_LE | MO_UW,
-    MO_LEUL  =3D MO_LE | MO_UL,
-    MO_LESW  =3D MO_LE | MO_SW,
-    MO_LESL  =3D MO_LE | MO_SL,
-    MO_LEQ   =3D MO_LE | MO_Q,
-
-    MO_BEUW  =3D MO_BE | MO_UW,
-    MO_BEUL  =3D MO_BE | MO_UL,
-    MO_BESW  =3D MO_BE | MO_SW,
-    MO_BESL  =3D MO_BE | MO_SL,
-    MO_BEQ   =3D MO_BE | MO_Q,
-
-    MO_TEUW  =3D MO_TE | MO_UW,
-    MO_TEUL  =3D MO_TE | MO_UL,
-    MO_TESW  =3D MO_TE | MO_SW,
-    MO_TESL  =3D MO_TE | MO_SL,
-    MO_TEQ   =3D MO_TE | MO_Q,
-
-    MO_SSIZE =3D MO_SIZE | MO_SIGN,
-} TCGMemOp;
-
 /**
  * get_alignment_bits
- * @memop: TCGMemOp value
+ * @memop: MemOp value
  *
  * Extract the alignment size from the memop.
  */
-static inline unsigned get_alignment_bits(TCGMemOp memop)
+static inline unsigned get_alignment_bits(MemOp memop)
 {
     unsigned a =3D memop & MO_AMASK;

@@ -1186,7 +1097,7 @@ static inline size_t tcg_current_code_size(TCGContext=
 *s)
     return tcg_ptr_byte_diff(s->code_ptr, s->code_buf);
 }

-/* Combine the TCGMemOp and mmu_idx parameters into a single value.  */
+/* Combine the MemOp and mmu_idx parameters into a single value.  */
 typedef uint32_t TCGMemOpIdx;

 /**
@@ -1196,7 +1107,7 @@ typedef uint32_t TCGMemOpIdx;
  *
  * Encode these values into a single parameter.
  */
-static inline TCGMemOpIdx make_memop_idx(TCGMemOp op, unsigned idx)
+static inline TCGMemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
     tcg_debug_assert(idx <=3D 15);
     return (op << 4) | idx;
@@ -1208,7 +1119,7 @@ static inline TCGMemOpIdx make_memop_idx(TCGMemOp op,=
 unsigned idx)
  *
  * Extract the memory operation from the combined value.
  */
-static inline TCGMemOp get_memop(TCGMemOpIdx oi)
+static inline MemOp get_memop(TCGMemOpIdx oi)
 {
     return oi >> 4;
 }
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index f6efaf6..3444fbc 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -16,7 +16,7 @@
 #define TRACE_MEM_ST (1ULL << 5)    /* store (y/n) */

 static inline uint8_t trace_mem_build_info(
-    int size_shift, bool sign_extend, TCGMemOp endianness, bool store)
+    int size_shift, bool sign_extend, MemOp endianness, bool store)
 {
     uint8_t res;

@@ -33,7 +33,7 @@ static inline uint8_t trace_mem_build_info(
     return res;
 }

-static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
+static inline uint8_t trace_mem_get_info(MemOp op, bool store)
 {
     return trace_mem_build_info(op & MO_SIZE, !!(op & MO_SIGN),
                                 op & MO_BSWAP, store);
diff --git a/trace/mem.h b/trace/mem.h
index 2b58196..8cf213d 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -18,7 +18,7 @@
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_get_info(TCGMemOp op, bool store);
+static uint8_t trace_mem_get_info(MemOp op, bool store);

 /**
  * trace_mem_build_info:
@@ -26,7 +26,7 @@ static uint8_t trace_mem_get_info(TCGMemOp op, bool store=
);
  * Return a value for the 'info' argument in guest memory access traces.
  */
 static uint8_t trace_mem_build_info(int size_shift, bool sign_extend,
-                                    TCGMemOp endianness, bool store);
+                                    MemOp endianness, bool store);


 #include "trace/mem-internal.h"
--
1.8.3.1

?

