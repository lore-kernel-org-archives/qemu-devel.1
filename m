Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C5C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2B5206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2B5206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuRT-0005SX-50
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43432)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hhuK2-0006Wh-AC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hhuJs-0000c4-KQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hhuJq-0000JC-JZ; Mon, 01 Jul 2019 07:17:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4CFF4ACDF;
 Mon,  1 Jul 2019 11:17:40 +0000 (UTC)
Received: from localhost (ovpn-117-220.ams2.redhat.com [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 671FE691A3;
 Mon,  1 Jul 2019 11:17:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  1 Jul 2019 13:17:18 +0200
Message-Id: <20190701111722.32068-3-cohuck@redhat.com>
In-Reply-To: <20190701111722.32068-1-cohuck@redhat.com>
References: <20190701111722.32068-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 01 Jul 2019 11:17:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/6] s390x/cpumodel: Rework CPU feature
 definition
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
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's define features at a single spot and make it less error prone to
define new features.

Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c         | 352 +-------------------------
 target/s390x/cpu_features_def.h     | 352 +-------------------------
 target/s390x/cpu_features_def.inc.h | 369 ++++++++++++++++++++++++++++
 3 files changed, 386 insertions(+), 687 deletions(-)
 create mode 100644 target/s390x/cpu_features_def.inc.h

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index f64f581c8614..9f817e3cfa72 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -2,8 +2,9 @@
  * CPU features/facilities for s390x
  *
  * Copyright IBM Corp. 2016, 2018
+ * Copyright Red Hat, Inc. 2019
  *
- * Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
+ * Author(s): David Hildenbrand <david@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
  * your option) any later version. See the COPYING file in the top-level
@@ -14,346 +15,17 @@
 #include "qemu/module.h"
 #include "cpu_features.h"
=20
-#define FEAT_INIT(_name, _type, _bit, _desc) \
-    {                                                \
-        .name =3D _name,                               \
-        .type =3D _type,                               \
-        .bit =3D _bit,                                 \
-        .desc =3D _desc,                               \
-    }
-
-/* S390FeatDef.bit is not applicable as there is no feature block. */
-#define FEAT_INIT_MISC(_name, _desc)                 \
-            FEAT_INIT(_name, S390_FEAT_TYPE_MISC, 0, _desc)
-
-/* indexed by feature number for easy lookup */
-static const S390FeatDef s390_features[] =3D {
-    FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n=
3"),
-    FEAT_INIT("zarch", S390_FEAT_TYPE_STFL, 1, "z/Architecture architect=
ural mode"),
-    FEAT_INIT("dateh", S390_FEAT_TYPE_STFL, 3, "DAT-enhancement facility=
"),
-    FEAT_INIT("idtes", S390_FEAT_TYPE_STFL, 4, "IDTE selective TLB segme=
nt-table clearing"),
-    FEAT_INIT("idter", S390_FEAT_TYPE_STFL, 5, "IDTE selective TLB regio=
n-table clearing"),
-    FEAT_INIT("asnlxr", S390_FEAT_TYPE_STFL, 6, "ASN-and-LX reuse facili=
ty"),
-    FEAT_INIT("stfle", S390_FEAT_TYPE_STFL, 7, "Store-facility-list-exte=
nded facility"),
-    FEAT_INIT("edat", S390_FEAT_TYPE_STFL, 8, "Enhanced-DAT facility"),
-    FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status facil=
ity"),
-    FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE facili=
ty"),
-    FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topology f=
acility"),
-    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query AP Configuration =
Information facility"),
-    FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility"),
-    FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-setti=
ng facility"),
-    FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "AP Facilities Test facil=
ity"),
-    FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, "Extended-translation fac=
ility 2"),
-    FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, "Message-security-ass=
ist facility (excluding subfunctions)"),
-    FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement facil=
ity"),
-    FEAT_INIT("ldisphp", S390_FEAT_TYPE_STFL, 19, "Long-displacement fac=
ility has high performance"),
-    FEAT_INIT("hfpm", S390_FEAT_TYPE_STFL, 20, "HFP-multiply-add/subtrac=
t facility"),
-    FEAT_INIT("eimm", S390_FEAT_TYPE_STFL, 21, "Extended-immediate facil=
ity"),
-    FEAT_INIT("etf3", S390_FEAT_TYPE_STFL, 22, "Extended-translation fac=
ility 3"),
-    FEAT_INIT("hfpue", S390_FEAT_TYPE_STFL, 23, "HFP-unnormalized-extens=
ion facility"),
-    FEAT_INIT("etf2eh", S390_FEAT_TYPE_STFL, 24, "ETF2-enhancement facil=
ity"),
-    FEAT_INIT("stckf", S390_FEAT_TYPE_STFL, 25, "Store-clock-fast facili=
ty"),
-    FEAT_INIT("parseh", S390_FEAT_TYPE_STFL, 26, "Parsing-enhancement fa=
cility"),
-    FEAT_INIT("mvcos", S390_FEAT_TYPE_STFL, 27, "Move-with-optional-spec=
ification facility"),
-    FEAT_INIT("tods-base", S390_FEAT_TYPE_STFL, 28, "TOD-clock-steering =
facility (excluding subfunctions)"),
-    FEAT_INIT("etf3eh", S390_FEAT_TYPE_STFL, 30, "ETF3-enhancement facil=
ity"),
-    FEAT_INIT("ectg", S390_FEAT_TYPE_STFL, 31, "Extract-CPU-time facilit=
y"),
-    FEAT_INIT("csst", S390_FEAT_TYPE_STFL, 32, "Compare-and-swap-and-sto=
re facility"),
-    FEAT_INIT("csst2", S390_FEAT_TYPE_STFL, 33, "Compare-and-swap-and-st=
ore facility 2"),
-    FEAT_INIT("ginste", S390_FEAT_TYPE_STFL, 34, "General-instructions-e=
xtension facility"),
-    FEAT_INIT("exrl", S390_FEAT_TYPE_STFL, 35, "Execute-extensions facil=
ity"),
-    FEAT_INIT("emon", S390_FEAT_TYPE_STFL, 36, "Enhanced-monitor facilit=
y"),
-    FEAT_INIT("fpe", S390_FEAT_TYPE_STFL, 37, "Floating-point extension =
facility"),
-    FEAT_INIT("opc", S390_FEAT_TYPE_STFL, 38, "Order Preserving Compress=
ion facility"),
-    FEAT_INIT("sprogp", S390_FEAT_TYPE_STFL, 40, "Set-program-parameters=
 facility"),
-    FEAT_INIT("fpseh", S390_FEAT_TYPE_STFL, 41, "Floating-point-support-=
enhancement facilities"),
-    FEAT_INIT("dfp", S390_FEAT_TYPE_STFL, 42, "DFP (decimal-floating-poi=
nt) facility"),
-    FEAT_INIT("dfphp", S390_FEAT_TYPE_STFL, 43, "DFP (decimal-floating-p=
oint) facility has high performance"),
-    FEAT_INIT("pfpo", S390_FEAT_TYPE_STFL, 44, "PFPO instruction"),
-    FEAT_INIT("stfle45", S390_FEAT_TYPE_STFL, 45, "Various facilities in=
troduced with z196"),
-    FEAT_INIT("cmpsceh", S390_FEAT_TYPE_STFL, 47, "CMPSC-enhancement fac=
ility"),
-    FEAT_INIT("dfpzc", S390_FEAT_TYPE_STFL, 48, "Decimal-floating-point =
zoned-conversion facility"),
-    FEAT_INIT("stfle49", S390_FEAT_TYPE_STFL, 49, "Various facilities in=
troduced with zEC12"),
-    FEAT_INIT("cte", S390_FEAT_TYPE_STFL, 50, "Constrained transactional=
-execution facility"),
-    FEAT_INIT("ltlbc", S390_FEAT_TYPE_STFL, 51, "Local-TLB-clearing faci=
lity"),
-    FEAT_INIT("iacc2", S390_FEAT_TYPE_STFL, 52, "Interlocked-access faci=
lity 2"),
-    FEAT_INIT("stfle53", S390_FEAT_TYPE_STFL, 53, "Various facilities in=
troduced with z13"),
-    FEAT_INIT("eec", S390_FEAT_TYPE_STFL, 54, "Entropy encoding compress=
ion facility"),
-    FEAT_INIT("msa5-base", S390_FEAT_TYPE_STFL, 57, "Message-security-as=
sist-extension-5 facility (excluding subfunctions)"),
-    FEAT_INIT("minste2", S390_FEAT_TYPE_STFL, 58, "Miscellaneous-instruc=
tion-extensions facility 2"),
-    FEAT_INIT("sema", S390_FEAT_TYPE_STFL, 59, "Semaphore-assist facilit=
y"),
-    FEAT_INIT("tsi", S390_FEAT_TYPE_STFL, 60, "Time-slice Instrumentatio=
n facility"),
-    FEAT_INIT("minste3", S390_FEAT_TYPE_STFL, 61, "Miscellaneous-Instruc=
tion-Extensions Facility 3"),
-    FEAT_INIT("ri", S390_FEAT_TYPE_STFL, 64, "CPU runtime-instrumentatio=
n facility"),
-    FEAT_INIT("zpci", S390_FEAT_TYPE_STFL, 69, "z/PCI facility"),
-    FEAT_INIT("aen", S390_FEAT_TYPE_STFL, 71, "General-purpose-adapter-e=
vent-notification facility"),
-    FEAT_INIT("ais", S390_FEAT_TYPE_STFL, 72, "General-purpose-adapter-i=
nterruption-suppression facility"),
-    FEAT_INIT("te", S390_FEAT_TYPE_STFL, 73, "Transactional-execution fa=
cility"),
-    FEAT_INIT("sthyi", S390_FEAT_TYPE_STFL, 74, "Store-hypervisor-inform=
ation facility"),
-    FEAT_INIT("aefsi", S390_FEAT_TYPE_STFL, 75, "Access-exception-fetch/=
store-indication facility"),
-    FEAT_INIT("msa3-base", S390_FEAT_TYPE_STFL, 76, "Message-security-as=
sist-extension-3 facility (excluding subfunctions)"),
-    FEAT_INIT("msa4-base", S390_FEAT_TYPE_STFL, 77, "Message-security-as=
sist-extension-4 facility (excluding subfunctions)"),
-    FEAT_INIT("edat2", S390_FEAT_TYPE_STFL, 78, "Enhanced-DAT facility 2=
"),
-    FEAT_INIT("dfppc", S390_FEAT_TYPE_STFL, 80, "Decimal-floating-point =
packed-conversion facility"),
-    FEAT_INIT("ppa15", S390_FEAT_TYPE_STFL, 81, "PPA15 is installed"),
-    FEAT_INIT("bpb", S390_FEAT_TYPE_STFL, 82, "Branch prediction blockin=
g"),
-    FEAT_INIT("vx", S390_FEAT_TYPE_STFL, 129, "Vector facility"),
-    FEAT_INIT("iep", S390_FEAT_TYPE_STFL, 130, "Instruction-execution-pr=
otection facility"),
-    FEAT_INIT("sea_esop2", S390_FEAT_TYPE_STFL, 131, "Side-effect-access=
 facility and Enhanced-suppression-on-protection facility 2"),
-    FEAT_INIT("gs", S390_FEAT_TYPE_STFL, 133, "Guarded-storage facility"=
),
-    FEAT_INIT("vxpd", S390_FEAT_TYPE_STFL, 134, "Vector packed decimal f=
acility"),
-    FEAT_INIT("vxeh", S390_FEAT_TYPE_STFL, 135, "Vector enhancements fac=
ility"),
-    FEAT_INIT("mepoch", S390_FEAT_TYPE_STFL, 139, "Multiple-epoch facili=
ty"),
-    FEAT_INIT("tpei", S390_FEAT_TYPE_STFL, 144, "Test-pending-external-i=
nterruption facility"),
-    FEAT_INIT("irbm", S390_FEAT_TYPE_STFL, 145, "Insert-reference-bits-m=
ultiple facility"),
-    FEAT_INIT("msa8-base", S390_FEAT_TYPE_STFL, 146, "Message-security-a=
ssist-extension-8 facility (excluding subfunctions)"),
-    FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement =
(no translate) facility"),
-    FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements fa=
cility 2"),
-    FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort fac=
ility (excluding subfunctions)"),
-    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-convers=
ion facility (excluding subfunctions)"),
-    FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancement=
s facility 1"),
-    FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-a=
ssist-extension-9 facility (excluding subfunctions)"),
-    FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
-
-    /* SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
-    FEAT_INIT("gsls", S390_FEAT_TYPE_SCLP_CONF_CHAR, 40, "SIE: Guest-sto=
rage-limit-suppression facility"),
-    FEAT_INIT("esop", S390_FEAT_TYPE_SCLP_CONF_CHAR, 46, "Enhanced-suppr=
ession-on-protection facility"),
-    FEAT_INIT("hpma2", S390_FEAT_TYPE_SCLP_CONF_CHAR, 90, "Host page man=
agement assist 2 Facility"), /* 91-2 */
-    FEAT_INIT("kss", S390_FEAT_TYPE_SCLP_CONF_CHAR, 151, "SIE: Keyless-s=
ubset facility"),  /* 98-7 */
-
-    /* SCLP SCCB Byte 116 - 119 (bit numbers relative to byte-116) */
-    FEAT_INIT("64bscao", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 0, "SIE: 64-=
bit-SCAO facility"),
-    FEAT_INIT("cmma", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 1, "SIE: Collab=
orative-memory-management assist"),
-    FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF =
interpretation facility"),
-    FEAT_INIT("ibs", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 10, "SIE: Interl=
ock-and-broadcast-suppression facility"),
-
-    FEAT_INIT("sief2", S390_FEAT_TYPE_SCLP_CPU, 4, "SIE: interception fo=
rmat 2 (Virtual SIE)"),
-    FEAT_INIT("skey", S390_FEAT_TYPE_SCLP_CPU, 5, "SIE: Storage-key faci=
lity"),
-    FEAT_INIT("gpereh", S390_FEAT_TYPE_SCLP_CPU, 10, "SIE: Guest-PER enh=
ancement facility"),
-    FEAT_INIT("siif", S390_FEAT_TYPE_SCLP_CPU, 11, "SIE: Shared IPTE-int=
erlock facility"),
-    FEAT_INIT("sigpif", S390_FEAT_TYPE_SCLP_CPU, 12, "SIE: SIGP interpre=
tation facility"),
-    FEAT_INIT("ib", S390_FEAT_TYPE_SCLP_CPU, 42, "SIE: Intervention bypa=
ss facility"),
-    FEAT_INIT("cei", S390_FEAT_TYPE_SCLP_CPU, 43, "SIE: Conditional-exte=
rnal-interception facility"),
-
-    FEAT_INIT_MISC("dateh2", "DAT-enhancement facility 2"),
-    FEAT_INIT_MISC("cmm", "Collaborative-memory-management facility"),
-    FEAT_INIT_MISC("ap", "AP instructions installed"),
-
-    FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32=
 bit in general registers)"),
-    FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (6=
4 bit in parameter list)"),
-    FEAT_INIT("plo-clgr", S390_FEAT_TYPE_PLO, 2, "PLO Compare and load (=
32 bit in general registers)"),
-    FEAT_INIT("plo-clx", S390_FEAT_TYPE_PLO, 3, "PLO Compare and load (1=
28 bit in parameter list)"),
-    FEAT_INIT("plo-cs", S390_FEAT_TYPE_PLO, 4, "PLO Compare and swap (32=
 bit in general registers)"),
-    FEAT_INIT("plo-csg", S390_FEAT_TYPE_PLO, 5, "PLO Compare and swap (6=
4 bit in parameter list)"),
-    FEAT_INIT("plo-csgr", S390_FEAT_TYPE_PLO, 6, "PLO Compare and swap (=
32 bit in general registers)"),
-    FEAT_INIT("plo-csx", S390_FEAT_TYPE_PLO, 7, "PLO Compare and swap (1=
28 bit in parameter list)"),
-    FEAT_INIT("plo-dcs", S390_FEAT_TYPE_PLO, 8, "PLO Double compare and =
swap (32 bit in general registers)"),
-    FEAT_INIT("plo-dcsg", S390_FEAT_TYPE_PLO, 9, "PLO Double compare and=
 swap (64 bit in parameter list)"),
-    FEAT_INIT("plo-dcsgr", S390_FEAT_TYPE_PLO, 10, "PLO Double compare a=
nd swap (32 bit in general registers)"),
-    FEAT_INIT("plo-dcsx", S390_FEAT_TYPE_PLO, 11, "PLO Double compare an=
d swap (128 bit in parameter list)"),
-    FEAT_INIT("plo-csst", S390_FEAT_TYPE_PLO, 12, "PLO Compare and swap =
and store (32 bit in general registers)"),
-    FEAT_INIT("plo-csstg", S390_FEAT_TYPE_PLO, 13, "PLO Compare and swap=
 and store (64 bit in parameter list)"),
-    FEAT_INIT("plo-csstgr", S390_FEAT_TYPE_PLO, 14, "PLO Compare and swa=
p and store (32 bit in general registers)"),
-    FEAT_INIT("plo-csstx", S390_FEAT_TYPE_PLO, 15, "PLO Compare and swap=
 and store (128 bit in parameter list)"),
-    FEAT_INIT("plo-csdst", S390_FEAT_TYPE_PLO, 16, "PLO Compare and swap=
 and double store (32 bit in general registers)"),
-    FEAT_INIT("plo-csdstg", S390_FEAT_TYPE_PLO, 17, "PLO Compare and swa=
p and double store (64 bit in parameter list)"),
-    FEAT_INIT("plo-csdstgr", S390_FEAT_TYPE_PLO, 18, "PLO Compare and sw=
ap and double store (32 bit in general registers)"),
-    FEAT_INIT("plo-csdstx", S390_FEAT_TYPE_PLO, 19, "PLO Compare and swa=
p and double store (128 bit in parameter list)"),
-    FEAT_INIT("plo-cstst", S390_FEAT_TYPE_PLO, 20, "PLO Compare and swap=
 and triple store (32 bit in general registers)"),
-    FEAT_INIT("plo-cststg", S390_FEAT_TYPE_PLO, 21, "PLO Compare and swa=
p and triple store (64 bit in parameter list)"),
-    FEAT_INIT("plo-cststgr", S390_FEAT_TYPE_PLO, 22, "PLO Compare and sw=
ap and triple store (32 bit in general registers)"),
-    FEAT_INIT("plo-cststx", S390_FEAT_TYPE_PLO, 23, "PLO Compare and swa=
p and triple store (128 bit in parameter list)"),
-
-    FEAT_INIT("ptff-qto", S390_FEAT_TYPE_PTFF, 1, "PTFF Query TOD Offset=
"),
-    FEAT_INIT("ptff-qsi", S390_FEAT_TYPE_PTFF, 2, "PTFF Query Steering I=
nformation"),
-    FEAT_INIT("ptff-qpc", S390_FEAT_TYPE_PTFF, 3, "PTFF Query Physical C=
lock"),
-    FEAT_INIT("ptff-qui", S390_FEAT_TYPE_PTFF, 4, "PTFF Query UTC Inform=
ation"),
-    FEAT_INIT("ptff-qtou", S390_FEAT_TYPE_PTFF, 5, "PTFF Query TOD Offse=
t User"),
-    FEAT_INIT("ptff-qsie", S390_FEAT_TYPE_PTFF, 10, "PTFF Query Steering=
 Information Extended"),
-    FEAT_INIT("ptff-qtoue", S390_FEAT_TYPE_PTFF, 13, "PTFF Query TOD Off=
set User Extended"),
-    FEAT_INIT("ptff-sto", S390_FEAT_TYPE_PTFF, 65, "PTFF Set TOD Offset"=
),
-    FEAT_INIT("ptff-stou", S390_FEAT_TYPE_PTFF, 69, "PTFF Set TOD Offset=
 User"),
-    FEAT_INIT("ptff-stoe", S390_FEAT_TYPE_PTFF, 73, "PTFF Set TOD Offset=
 Extended"),
-    FEAT_INIT("ptff-stoue", S390_FEAT_TYPE_PTFF, 77, "PTFF Set TOD Offse=
t User Extended"),
-
-    FEAT_INIT("kmac-dea", S390_FEAT_TYPE_KMAC, 1, "KMAC DEA"),
-    FEAT_INIT("kmac-tdea-128", S390_FEAT_TYPE_KMAC, 2, "KMAC TDEA-128"),
-    FEAT_INIT("kmac-tdea-192", S390_FEAT_TYPE_KMAC, 3, "KMAC TDEA-192"),
-    FEAT_INIT("kmac-edea", S390_FEAT_TYPE_KMAC, 9, "KMAC Encrypted-DEA")=
,
-    FEAT_INIT("kmac-etdea-128", S390_FEAT_TYPE_KMAC, 10, "KMAC Encrypted=
-TDEA-128"),
-    FEAT_INIT("kmac-etdea-192", S390_FEAT_TYPE_KMAC, 11, "KMAC Encrypted=
-TDEA-192"),
-    FEAT_INIT("kmac-aes-128", S390_FEAT_TYPE_KMAC, 18, "KMAC AES-128"),
-    FEAT_INIT("kmac-aes-192", S390_FEAT_TYPE_KMAC, 19, "KMAC AES-192"),
-    FEAT_INIT("kmac-aes-256", S390_FEAT_TYPE_KMAC, 20, "KMAC AES-256"),
-    FEAT_INIT("kmac-eaes-128", S390_FEAT_TYPE_KMAC, 26, "KMAC Encrypted-=
AES-128"),
-    FEAT_INIT("kmac-eaes-192", S390_FEAT_TYPE_KMAC, 27, "KMAC Encrypted-=
AES-192"),
-    FEAT_INIT("kmac-eaes-256", S390_FEAT_TYPE_KMAC, 28, "KMAC Encrypted-=
AES-256"),
-
-    FEAT_INIT("kmc-dea", S390_FEAT_TYPE_KMC, 1, "KMC DEA"),
-    FEAT_INIT("kmc-tdea-128", S390_FEAT_TYPE_KMC, 2, "KMC TDEA-128"),
-    FEAT_INIT("kmc-tdea-192", S390_FEAT_TYPE_KMC, 3, "KMC TDEA-192"),
-    FEAT_INIT("kmc-edea", S390_FEAT_TYPE_KMC, 9, "KMC Encrypted-DEA"),
-    FEAT_INIT("kmc-etdea-128", S390_FEAT_TYPE_KMC, 10, "KMC Encrypted-TD=
EA-128"),
-    FEAT_INIT("kmc-etdea-192", S390_FEAT_TYPE_KMC, 11, "KMC Encrypted-TD=
EA-192"),
-    FEAT_INIT("kmc-aes-128", S390_FEAT_TYPE_KMC, 18, "KMC AES-128"),
-    FEAT_INIT("kmc-aes-192", S390_FEAT_TYPE_KMC, 19, "KMC AES-192"),
-    FEAT_INIT("kmc-aes-256", S390_FEAT_TYPE_KMC, 20, "KMC AES-256"),
-    FEAT_INIT("kmc-eaes-128", S390_FEAT_TYPE_KMC, 26, "KMC Encrypted-AES=
-128"),
-    FEAT_INIT("kmc-eaes-192", S390_FEAT_TYPE_KMC, 27, "KMC Encrypted-AES=
-192"),
-    FEAT_INIT("kmc-eaes-256", S390_FEAT_TYPE_KMC, 28, "KMC Encrypted-AES=
-256"),
-    FEAT_INIT("kmc-prng", S390_FEAT_TYPE_KMC, 67, "KMC PRNG"),
-
-    FEAT_INIT("km-dea", S390_FEAT_TYPE_KM, 1, "KM DEA"),
-    FEAT_INIT("km-tdea-128", S390_FEAT_TYPE_KM, 2, "KM TDEA-128"),
-    FEAT_INIT("km-tdea-192", S390_FEAT_TYPE_KM, 3, "KM TDEA-192"),
-    FEAT_INIT("km-edea", S390_FEAT_TYPE_KM, 9, "KM Encrypted-DEA"),
-    FEAT_INIT("km-etdea-128", S390_FEAT_TYPE_KM, 10, "KM Encrypted-TDEA-=
128"),
-    FEAT_INIT("km-etdea-192", S390_FEAT_TYPE_KM, 11, "KM Encrypted-TDEA-=
192"),
-    FEAT_INIT("km-aes-128", S390_FEAT_TYPE_KM, 18, "KM AES-128"),
-    FEAT_INIT("km-aes-192", S390_FEAT_TYPE_KM, 19, "KM AES-192"),
-    FEAT_INIT("km-aes-256", S390_FEAT_TYPE_KM, 20, "KM AES-256"),
-    FEAT_INIT("km-eaes-128", S390_FEAT_TYPE_KM, 26, "KM Encrypted-AES-12=
8"),
-    FEAT_INIT("km-eaes-192", S390_FEAT_TYPE_KM, 27, "KM Encrypted-AES-19=
2"),
-    FEAT_INIT("km-eaes-256", S390_FEAT_TYPE_KM, 28, "KM Encrypted-AES-25=
6"),
-    FEAT_INIT("km-xts-aes-128", S390_FEAT_TYPE_KM, 50, "KM XTS-AES-128")=
,
-    FEAT_INIT("km-xts-aes-256", S390_FEAT_TYPE_KM, 52, "KM XTS-AES-256")=
,
-    FEAT_INIT("km-xts-eaes-128", S390_FEAT_TYPE_KM, 58, "KM XTS-Encrypte=
d-AES-128"),
-    FEAT_INIT("km-xts-eaes-256", S390_FEAT_TYPE_KM, 60, "KM XTS-Encrypte=
d-AES-256"),
-
-    FEAT_INIT("kimd-sha-1", S390_FEAT_TYPE_KIMD, 1, "KIMD SHA-1"),
-    FEAT_INIT("kimd-sha-256", S390_FEAT_TYPE_KIMD, 2, "KIMD SHA-256"),
-    FEAT_INIT("kimd-sha-512", S390_FEAT_TYPE_KIMD, 3, "KIMD SHA-512"),
-    FEAT_INIT("kimd-sha3-224", S390_FEAT_TYPE_KIMD, 32, "KIMD SHA3-224")=
,
-    FEAT_INIT("kimd-sha3-256", S390_FEAT_TYPE_KIMD, 33, "KIMD SHA3-256")=
,
-    FEAT_INIT("kimd-sha3-384", S390_FEAT_TYPE_KIMD, 34, "KIMD SHA3-384")=
,
-    FEAT_INIT("kimd-sha3-512", S390_FEAT_TYPE_KIMD, 35, "KIMD SHA3-512")=
,
-    FEAT_INIT("kimd-shake-128", S390_FEAT_TYPE_KIMD, 36, "KIMD SHAKE-128=
"),
-    FEAT_INIT("kimd-shake-256", S390_FEAT_TYPE_KIMD, 37, "KIMD SHAKE-256=
"),
-    FEAT_INIT("kimd-ghash", S390_FEAT_TYPE_KIMD, 65, "KIMD GHASH"),
-
-    FEAT_INIT("klmd-sha-1", S390_FEAT_TYPE_KLMD, 1, "KLMD SHA-1"),
-    FEAT_INIT("klmd-sha-256", S390_FEAT_TYPE_KLMD, 2, "KLMD SHA-256"),
-    FEAT_INIT("klmd-sha-512", S390_FEAT_TYPE_KLMD, 3, "KLMD SHA-512"),
-    FEAT_INIT("klmd-sha3-224", S390_FEAT_TYPE_KLMD, 32, "KLMD SHA3-224")=
,
-    FEAT_INIT("klmd-sha3-256", S390_FEAT_TYPE_KLMD, 33, "KLMD SHA3-256")=
,
-    FEAT_INIT("klmd-sha3-384", S390_FEAT_TYPE_KLMD, 34, "KLMD SHA3-384")=
,
-    FEAT_INIT("klmd-sha3-512", S390_FEAT_TYPE_KLMD, 35, "KLMD SHA3-512")=
,
-    FEAT_INIT("klmd-shake-128", S390_FEAT_TYPE_KLMD, 36, "KLMD SHAKE-128=
"),
-    FEAT_INIT("klmd-shake-256", S390_FEAT_TYPE_KLMD, 37, "KLMD SHAKE-256=
"),
-
-    FEAT_INIT("pckmo-edea", S390_FEAT_TYPE_PCKMO, 1, "PCKMO Encrypted-DE=
A-Key"),
-    FEAT_INIT("pckmo-etdea-128", S390_FEAT_TYPE_PCKMO, 2, "PCKMO Encrypt=
ed-TDEA-128-Key"),
-    FEAT_INIT("pckmo-etdea-192", S390_FEAT_TYPE_PCKMO, 3, "PCKMO Encrypt=
ed-TDEA-192-Key"),
-    FEAT_INIT("pckmo-aes-128", S390_FEAT_TYPE_PCKMO, 18, "PCKMO Encrypte=
d-AES-128-Key"),
-    FEAT_INIT("pckmo-aes-192", S390_FEAT_TYPE_PCKMO, 19, "PCKMO Encrypte=
d-AES-192-Key"),
-    FEAT_INIT("pckmo-aes-256", S390_FEAT_TYPE_PCKMO, 20, "PCKMO Encrypte=
d-AES-256-Key"),
-    FEAT_INIT("pckmo-ecc-p256", S390_FEAT_TYPE_PCKMO, 32, "PCKMO Encrypt=
-ECC-P256-Key"),
-    FEAT_INIT("pckmo-ecc-p384", S390_FEAT_TYPE_PCKMO, 33, "PCKMO Encrypt=
-ECC-P384-Key"),
-    FEAT_INIT("pckmo-ecc-p521", S390_FEAT_TYPE_PCKMO, 34, "PCKMO Encrypt=
-ECC-P521-Key"),
-    FEAT_INIT("pckmo-ecc-ed25519", S390_FEAT_TYPE_PCKMO, 40 , "PCKMO Enc=
rypt-ECC-Ed25519-Key"),
-    FEAT_INIT("pckmo-ecc-ed448", S390_FEAT_TYPE_PCKMO, 41 , "PCKMO Encry=
pt-ECC-Ed448-Key"),
-
-    FEAT_INIT("kmctr-dea", S390_FEAT_TYPE_KMCTR, 1, "KMCTR DEA"),
-    FEAT_INIT("kmctr-tdea-128", S390_FEAT_TYPE_KMCTR, 2, "KMCTR TDEA-128=
"),
-    FEAT_INIT("kmctr-tdea-192", S390_FEAT_TYPE_KMCTR, 3, "KMCTR TDEA-192=
"),
-    FEAT_INIT("kmctr-edea", S390_FEAT_TYPE_KMCTR, 9, "KMCTR Encrypted-DE=
A"),
-    FEAT_INIT("kmctr-etdea-128", S390_FEAT_TYPE_KMCTR, 10, "KMCTR Encryp=
ted-TDEA-128"),
-    FEAT_INIT("kmctr-etdea-192", S390_FEAT_TYPE_KMCTR, 11, "KMCTR Encryp=
ted-TDEA-192"),
-    FEAT_INIT("kmctr-aes-128", S390_FEAT_TYPE_KMCTR, 18, "KMCTR AES-128"=
),
-    FEAT_INIT("kmctr-aes-192", S390_FEAT_TYPE_KMCTR, 19, "KMCTR AES-192"=
),
-    FEAT_INIT("kmctr-aes-256", S390_FEAT_TYPE_KMCTR, 20, "KMCTR AES-256"=
),
-    FEAT_INIT("kmctr-eaes-128", S390_FEAT_TYPE_KMCTR, 26, "KMCTR Encrypt=
ed-AES-128"),
-    FEAT_INIT("kmctr-eaes-192", S390_FEAT_TYPE_KMCTR, 27, "KMCTR Encrypt=
ed-AES-192"),
-    FEAT_INIT("kmctr-eaes-256", S390_FEAT_TYPE_KMCTR, 28, "KMCTR Encrypt=
ed-AES-256"),
-
-    FEAT_INIT("kmf-dea", S390_FEAT_TYPE_KMF, 1, "KMF DEA"),
-    FEAT_INIT("kmf-tdea-128", S390_FEAT_TYPE_KMF, 2, "KMF TDEA-128"),
-    FEAT_INIT("kmf-tdea-192", S390_FEAT_TYPE_KMF, 3, "KMF TDEA-192"),
-    FEAT_INIT("kmf-edea", S390_FEAT_TYPE_KMF, 9, "KMF Encrypted-DEA"),
-    FEAT_INIT("kmf-etdea-128", S390_FEAT_TYPE_KMF, 10, "KMF Encrypted-TD=
EA-128"),
-    FEAT_INIT("kmf-etdea-192", S390_FEAT_TYPE_KMF, 11, "KMF Encrypted-TD=
EA-192"),
-    FEAT_INIT("kmf-aes-128", S390_FEAT_TYPE_KMF, 18, "KMF AES-128"),
-    FEAT_INIT("kmf-aes-192", S390_FEAT_TYPE_KMF, 19, "KMF AES-192"),
-    FEAT_INIT("kmf-aes-256", S390_FEAT_TYPE_KMF, 20, "KMF AES-256"),
-    FEAT_INIT("kmf-eaes-128", S390_FEAT_TYPE_KMF, 26, "KMF Encrypted-AES=
-128"),
-    FEAT_INIT("kmf-eaes-192", S390_FEAT_TYPE_KMF, 27, "KMF Encrypted-AES=
-192"),
-    FEAT_INIT("kmf-eaes-256", S390_FEAT_TYPE_KMF, 28, "KMF Encrypted-AES=
-256"),
-
-    FEAT_INIT("kmo-dea", S390_FEAT_TYPE_KMO, 1, "KMO DEA"),
-    FEAT_INIT("kmo-tdea-128", S390_FEAT_TYPE_KMO, 2, "KMO TDEA-128"),
-    FEAT_INIT("kmo-tdea-192", S390_FEAT_TYPE_KMO, 3, "KMO TDEA-192"),
-    FEAT_INIT("kmo-edea", S390_FEAT_TYPE_KMO, 9, "KMO Encrypted-DEA"),
-    FEAT_INIT("kmo-etdea-128", S390_FEAT_TYPE_KMO, 10, "KMO Encrypted-TD=
EA-128"),
-    FEAT_INIT("kmo-etdea-192", S390_FEAT_TYPE_KMO, 11, "KMO Encrypted-TD=
EA-192"),
-    FEAT_INIT("kmo-aes-128", S390_FEAT_TYPE_KMO, 18, "KMO AES-128"),
-    FEAT_INIT("kmo-aes-192", S390_FEAT_TYPE_KMO, 19, "KMO AES-192"),
-    FEAT_INIT("kmo-aes-256", S390_FEAT_TYPE_KMO, 20, "KMO AES-256"),
-    FEAT_INIT("kmo-eaes-128", S390_FEAT_TYPE_KMO, 26, "KMO Encrypted-AES=
-128"),
-    FEAT_INIT("kmo-eaes-192", S390_FEAT_TYPE_KMO, 27, "KMO Encrypted-AES=
-192"),
-    FEAT_INIT("kmo-eaes-256", S390_FEAT_TYPE_KMO, 28, "KMO Encrypted-AES=
-256"),
-
-    FEAT_INIT("pcc-cmac-dea", S390_FEAT_TYPE_PCC, 1, "PCC Compute-Last-B=
lock-CMAC-Using-DEA"),
-    FEAT_INIT("pcc-cmac-tdea-128", S390_FEAT_TYPE_PCC, 2, "PCC Compute-L=
ast-Block-CMAC-Using-TDEA-128"),
-    FEAT_INIT("pcc-cmac-tdea-192", S390_FEAT_TYPE_PCC, 3, "PCC Compute-L=
ast-Block-CMAC-Using-TDEA-192"),
-    FEAT_INIT("pcc-cmac-edea", S390_FEAT_TYPE_PCC, 9, "PCC Compute-Last-=
Block-CMAC-Using-Encrypted-DEA"),
-    FEAT_INIT("pcc-cmac-etdea-128", S390_FEAT_TYPE_PCC, 10, "PCC Compute=
-Last-Block-CMAC-Using-Encrypted-TDEA-128"),
-    FEAT_INIT("pcc-cmac-etdea-192", S390_FEAT_TYPE_PCC, 11, "PCC Compute=
-Last-Block-CMAC-Using-EncryptedTDEA-192"),
-    FEAT_INIT("pcc-cmac-aes-128", S390_FEAT_TYPE_PCC, 18, "PCC Compute-L=
ast-Block-CMAC-Using-AES-128"),
-    FEAT_INIT("pcc-cmac-aes-192", S390_FEAT_TYPE_PCC, 19, "PCC Compute-L=
ast-Block-CMAC-Using-AES-192"),
-    FEAT_INIT("pcc-cmac-eaes-256", S390_FEAT_TYPE_PCC, 20, "PCC Compute-=
Last-Block-CMAC-Using-AES-256"),
-    FEAT_INIT("pcc-cmac-eaes-128", S390_FEAT_TYPE_PCC, 26, "PCC Compute-=
Last-Block-CMAC-Using-Encrypted-AES-128"),
-    FEAT_INIT("pcc-cmac-eaes-192", S390_FEAT_TYPE_PCC, 27, "PCC Compute-=
Last-Block-CMAC-Using-Encrypted-AES-192"),
-    FEAT_INIT("pcc-cmac-eaes-256", S390_FEAT_TYPE_PCC, 28, "PCC Compute-=
Last-Block-CMAC-Using-Encrypted-AES-256"),
-    FEAT_INIT("pcc-xts-aes-128", S390_FEAT_TYPE_PCC, 50, "PCC Compute-XT=
S-Parameter-Using-AES-128"),
-    FEAT_INIT("pcc-xts-aes-256", S390_FEAT_TYPE_PCC, 52, "PCC Compute-XT=
S-Parameter-Using-AES-256"),
-    FEAT_INIT("pcc-xts-eaes-128", S390_FEAT_TYPE_PCC, 58, "PCC Compute-X=
TS-Parameter-Using-Encrypted-AES-128"),
-    FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-X=
TS-Parameter-Using-Encrypted-AES-256"),
-    FEAT_INIT("pcc-scalar-mult-p256", S390_FEAT_TYPE_PCC, 64, "PCC Scala=
r-Multiply-P256"),
-    FEAT_INIT("pcc-scalar-mult-p384", S390_FEAT_TYPE_PCC, 65, "PCC Scala=
r-Multiply-P384"),
-    FEAT_INIT("pcc-scalar-mult-p521", S390_FEAT_TYPE_PCC, 66, "PCC Scala=
r-Multiply-P521"),
-    FEAT_INIT("pcc-scalar-mult-ed25519", S390_FEAT_TYPE_PCC, 72, "PCC Sc=
alar-Multiply-Ed25519"),
-    FEAT_INIT("pcc-scalar-mult-ed448", S390_FEAT_TYPE_PCC, 73, "PCC Scal=
ar-Multiply-Ed448"),
-    FEAT_INIT("pcc-scalar-mult-x25519", S390_FEAT_TYPE_PCC, 80, "PCC Sca=
lar-Multiply-X25519"),
-    FEAT_INIT("pcc-scalar-mult-x448", S390_FEAT_TYPE_PCC, 81, "PCC Scala=
r-Multiply-X448"),
-
-    FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512=
-DRNG"),
-    FEAT_INIT("prno-trng-qrtcr", S390_FEAT_TYPE_PPNO, 112, "PRNO TRNG-Qu=
ery-Raw-to-Conditioned-Ratio"),
-    FEAT_INIT("prno-trng", S390_FEAT_TYPE_PPNO, 114, "PRNO TRNG"),
-
-    FEAT_INIT("kma-gcm-aes-128", S390_FEAT_TYPE_KMA, 18, "KMA GCM-AES-12=
8"),
-    FEAT_INIT("kma-gcm-aes-192", S390_FEAT_TYPE_KMA, 19, "KMA GCM-AES-19=
2"),
-    FEAT_INIT("kma-gcm-aes-256", S390_FEAT_TYPE_KMA, 20, "KMA GCM-AES-25=
6"),
-    FEAT_INIT("kma-gcm-eaes-128", S390_FEAT_TYPE_KMA, 26, "KMA GCM-Encry=
pted-AES-128"),
-    FEAT_INIT("kma-gcm-eaes-192", S390_FEAT_TYPE_KMA, 27, "KMA GCM-Encry=
pted-AES-192"),
-    FEAT_INIT("kma-gcm-eaes-256", S390_FEAT_TYPE_KMA, 28, "KMA GCM-Encry=
pted-AES-256"),
-
-    FEAT_INIT("kdsa-ecdsa-verify-p256", S390_FEAT_TYPE_KDSA, 1, "KDSA EC=
DSA-Verify-P256"),
-    FEAT_INIT("kdsa-ecdsa-verify-p384", S390_FEAT_TYPE_KDSA, 2, "KDSA EC=
DSA-Verify-P384"),
-    FEAT_INIT("kdsa-ecdsa-verify-p521", S390_FEAT_TYPE_KDSA, 3, "KDSA EC=
DSA-Verify-P521"),
-    FEAT_INIT("kdsa-ecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 9, "KDSA ECDS=
A-Sign-P256"),
-    FEAT_INIT("kdsa-ecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 10, "KDSA ECD=
SA-Sign-P384"),
-    FEAT_INIT("kdsa-ecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 11, "KDSA ECD=
SA-Sign-P521"),
-    FEAT_INIT("kdsa-eecdsa-sign-p256", S390_FEAT_TYPE_KDSA, 17, "KDSA En=
crypted-ECDSA-Sign-P256"),
-    FEAT_INIT("kdsa-eecdsa-sign-p384", S390_FEAT_TYPE_KDSA, 18, "KDSA En=
crypted-ECDSA-Sign-P384"),
-    FEAT_INIT("kdsa-eecdsa-sign-p521", S390_FEAT_TYPE_KDSA, 19, "KDSA En=
crypted-ECDSA-Sign-P521"),
-    FEAT_INIT("kdsa-eddsa-verify-ed25519", S390_FEAT_TYPE_KDSA, 32, "KDS=
A EdDSA-Verify-Ed25519"),
-    FEAT_INIT("kdsa-eddsa-verify-ed448", S390_FEAT_TYPE_KDSA, 36, "KDSA =
EdDSA-Verify-Ed448"),
-    FEAT_INIT("kdsa-eddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 40, "KDSA =
EdDSA-Sign-Ed25519"),
-    FEAT_INIT("kdsa-eddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 44, "KDSA Ed=
DSA-Sign-Ed448"),
-    FEAT_INIT("kdsa-eeddsa-sign-ed25519", S390_FEAT_TYPE_KDSA, 48, "KDSA=
 Encrypted-EdDSA-Sign-Ed25519"),
-    FEAT_INIT("kdsa-eeddsa-sign-ed448", S390_FEAT_TYPE_KDSA, 52, "KDSA E=
ncrypted-EdDSA-Sign-Ed448"),
-
-    FEAT_INIT("sortl-sflr", S390_FEAT_TYPE_SORTL, 1, "SORTL SFLR"),
-    FEAT_INIT("sortl-svlr", S390_FEAT_TYPE_SORTL, 2, "SORTL SVLR"),
-    FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lis=
ts"),
-    FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input l=
ists"),
-    FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 par=
ameter-block"),
-
-    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
-    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
-    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
-    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 =
parameter-block"),
+#define DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC) \
+    [S390_FEAT_##_FEAT] =3D {                        \
+        .name =3D _NAME,                             \
+        .type =3D S390_FEAT_TYPE_##_TYPE,            \
+        .bit =3D _BIT,                               \
+        .desc =3D _DESC,                             \
+    },
+static const S390FeatDef s390_features[S390_FEAT_MAX] =3D {
+    #include "cpu_features_def.inc.h"
 };
+#undef DEF_FEAT
=20
 const S390FeatDef *s390_feat_def(S390Feat feat)
 {
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_=
def.h
index 292b17b35d32..412d356febbb 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -2,9 +2,10 @@
  * CPU features/facilities for s390
  *
  * Copyright IBM Corp. 2016, 2018
+ * Copyright Red Hat, Inc. 2019
  *
  * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
- *            David Hildenbrand <dahi@linux.vnet.ibm.com>
+ *            David Hildenbrand <david@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
  * your option) any later version. See the COPYING file in the top-level
@@ -14,354 +15,11 @@
 #ifndef TARGET_S390X_CPU_FEATURES_DEF_H
 #define TARGET_S390X_CPU_FEATURES_DEF_H
=20
+#define DEF_FEAT(_FEAT, ...) S390_FEAT_##_FEAT,
 typedef enum {
-    /* Stfle */
-    S390_FEAT_ESAN3 =3D 0,
-    S390_FEAT_ZARCH,
-    S390_FEAT_DAT_ENH,
-    S390_FEAT_IDTE_SEGMENT,
-    S390_FEAT_IDTE_REGION,
-    S390_FEAT_ASN_LX_REUSE,
-    S390_FEAT_STFLE,
-    S390_FEAT_EDAT,
-    S390_FEAT_SENSE_RUNNING_STATUS,
-    S390_FEAT_CONDITIONAL_SSKE,
-    S390_FEAT_CONFIGURATION_TOPOLOGY,
-    S390_FEAT_AP_QUERY_CONFIG_INFO,
-    S390_FEAT_IPTE_RANGE,
-    S390_FEAT_NONQ_KEY_SETTING,
-    S390_FEAT_AP_FACILITIES_TEST,
-    S390_FEAT_EXTENDED_TRANSLATION_2,
-    S390_FEAT_MSA,
-    S390_FEAT_LONG_DISPLACEMENT,
-    S390_FEAT_LONG_DISPLACEMENT_FAST,
-    S390_FEAT_HFP_MADDSUB,
-    S390_FEAT_EXTENDED_IMMEDIATE,
-    S390_FEAT_EXTENDED_TRANSLATION_3,
-    S390_FEAT_HFP_UNNORMALIZED_EXT,
-    S390_FEAT_ETF2_ENH,
-    S390_FEAT_STORE_CLOCK_FAST,
-    S390_FEAT_PARSING_ENH,
-    S390_FEAT_MOVE_WITH_OPTIONAL_SPEC,
-    S390_FEAT_TOD_CLOCK_STEERING,
-    S390_FEAT_ETF3_ENH,
-    S390_FEAT_EXTRACT_CPU_TIME,
-    S390_FEAT_COMPARE_AND_SWAP_AND_STORE,
-    S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2,
-    S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
-    S390_FEAT_EXECUTE_EXT,
-    S390_FEAT_ENHANCED_MONITOR,
-    S390_FEAT_FLOATING_POINT_EXT,
-    S390_FEAT_ORDER_PRESERVING_COMPRESSION,
-    S390_FEAT_SET_PROGRAM_PARAMETERS,
-    S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
-    S390_FEAT_DFP,
-    S390_FEAT_DFP_FAST,
-    S390_FEAT_PFPO,
-    S390_FEAT_STFLE_45,
-    S390_FEAT_CMPSC_ENH,
-    S390_FEAT_DFP_ZONED_CONVERSION,
-    S390_FEAT_STFLE_49,
-    S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
-    S390_FEAT_LOCAL_TLB_CLEARING,
-    S390_FEAT_INTERLOCKED_ACCESS_2,
-    S390_FEAT_STFLE_53,
-    S390_FEAT_ENTROPY_ENC_COMP,
-    S390_FEAT_MSA_EXT_5,
-    S390_FEAT_MISC_INSTRUCTION_EXT,
-    S390_FEAT_SEMAPHORE_ASSIST,
-    S390_FEAT_TIME_SLICE_INSTRUMENTATION,
-    S390_FEAT_MISC_INSTRUCTION_EXT3,
-    S390_FEAT_RUNTIME_INSTRUMENTATION,
-    S390_FEAT_ZPCI,
-    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
-    S390_FEAT_ADAPTER_INT_SUPPRESSION,
-    S390_FEAT_TRANSACTIONAL_EXE,
-    S390_FEAT_STORE_HYPERVISOR_INFO,
-    S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
-    S390_FEAT_MSA_EXT_3,
-    S390_FEAT_MSA_EXT_4,
-    S390_FEAT_EDAT_2,
-    S390_FEAT_DFP_PACKED_CONVERSION,
-    S390_FEAT_PPA15,
-    S390_FEAT_BPB,
-    S390_FEAT_VECTOR,
-    S390_FEAT_INSTRUCTION_EXEC_PROT,
-    S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
-    S390_FEAT_GUARDED_STORAGE,
-    S390_FEAT_VECTOR_PACKED_DECIMAL,
-    S390_FEAT_VECTOR_ENH,
-    S390_FEAT_MULTIPLE_EPOCH,
-    S390_FEAT_TEST_PENDING_EXT_INTERRUPTION,
-    S390_FEAT_INSERT_REFERENCE_BITS_MULT,
-    S390_FEAT_MSA_EXT_8,
-    S390_FEAT_CMM_NT,
-    S390_FEAT_VECTOR_ENH2,
-    S390_FEAT_ESORT_BASE,
-    S390_FEAT_DEFLATE_BASE,
-    S390_FEAT_VECTOR_BCD_ENH,
-    S390_FEAT_MSA_EXT_9,
-    S390_FEAT_ETOKEN,
-
-    /* Sclp Conf Char */
-    S390_FEAT_SIE_GSLS,
-    S390_FEAT_ESOP,
-    S390_FEAT_HPMA2,
-    S390_FEAT_SIE_KSS,
-
-    /* Sclp Conf Char Ext */
-    S390_FEAT_SIE_64BSCAO,
-    S390_FEAT_SIE_CMMA,
-    S390_FEAT_SIE_PFMFI,
-    S390_FEAT_SIE_IBS,
-
-    /* Sclp Cpu */
-    S390_FEAT_SIE_F2,
-    S390_FEAT_SIE_SKEY,
-    S390_FEAT_SIE_GPERE,
-    S390_FEAT_SIE_SIIF,
-    S390_FEAT_SIE_SIGPIF,
-    S390_FEAT_SIE_IB,
-    S390_FEAT_SIE_CEI,
-
-    /* Misc */
-    S390_FEAT_DAT_ENH_2,
-    S390_FEAT_CMM,
-    S390_FEAT_AP,
-
-    /* PLO */
-    S390_FEAT_PLO_CL,
-    S390_FEAT_PLO_CLG,
-    S390_FEAT_PLO_CLGR,
-    S390_FEAT_PLO_CLX,
-    S390_FEAT_PLO_CS,
-    S390_FEAT_PLO_CSG,
-    S390_FEAT_PLO_CSGR,
-    S390_FEAT_PLO_CSX,
-    S390_FEAT_PLO_DCS,
-    S390_FEAT_PLO_DCSG,
-    S390_FEAT_PLO_DCSGR,
-    S390_FEAT_PLO_DCSX,
-    S390_FEAT_PLO_CSST,
-    S390_FEAT_PLO_CSSTG,
-    S390_FEAT_PLO_CSSTGR,
-    S390_FEAT_PLO_CSSTX,
-    S390_FEAT_PLO_CSDST,
-    S390_FEAT_PLO_CSDSTG,
-    S390_FEAT_PLO_CSDSTGR,
-    S390_FEAT_PLO_CSDSTX,
-    S390_FEAT_PLO_CSTST,
-    S390_FEAT_PLO_CSTSTG,
-    S390_FEAT_PLO_CSTSTGR,
-    S390_FEAT_PLO_CSTSTX,
-
-    /* PTFF */
-    S390_FEAT_PTFF_QTO,
-    S390_FEAT_PTFF_QSI,
-    S390_FEAT_PTFF_QPT,
-    S390_FEAT_PTFF_QUI,
-    S390_FEAT_PTFF_QTOU,
-    S390_FEAT_PTFF_QSIE,
-    S390_FEAT_PTFF_QTOUE,
-    S390_FEAT_PTFF_STO,
-    S390_FEAT_PTFF_STOU,
-    S390_FEAT_PTFF_STOE,
-    S390_FEAT_PTFF_STOUE,
-
-    /* KMAC */
-    S390_FEAT_KMAC_DEA,
-    S390_FEAT_KMAC_TDEA_128,
-    S390_FEAT_KMAC_TDEA_192,
-    S390_FEAT_KMAC_EDEA,
-    S390_FEAT_KMAC_ETDEA_128,
-    S390_FEAT_KMAC_ETDEA_192,
-    S390_FEAT_KMAC_AES_128,
-    S390_FEAT_KMAC_AES_192,
-    S390_FEAT_KMAC_AES_256,
-    S390_FEAT_KMAC_EAES_128,
-    S390_FEAT_KMAC_EAES_192,
-    S390_FEAT_KMAC_EAES_256,
-
-    /* KMC */
-    S390_FEAT_KMC_DEA,
-    S390_FEAT_KMC_TDEA_128,
-    S390_FEAT_KMC_TDEA_192,
-    S390_FEAT_KMC_EDEA,
-    S390_FEAT_KMC_ETDEA_128,
-    S390_FEAT_KMC_ETDEA_192,
-    S390_FEAT_KMC_AES_128,
-    S390_FEAT_KMC_AES_192,
-    S390_FEAT_KMC_AES_256,
-    S390_FEAT_KMC_EAES_128,
-    S390_FEAT_KMC_EAES_192,
-    S390_FEAT_KMC_EAES_256,
-    S390_FEAT_KMC_PRNG,
-
-    /* KM */
-    S390_FEAT_KM_DEA,
-    S390_FEAT_KM_TDEA_128,
-    S390_FEAT_KM_TDEA_192,
-    S390_FEAT_KM_EDEA,
-    S390_FEAT_KM_ETDEA_128,
-    S390_FEAT_KM_ETDEA_192,
-    S390_FEAT_KM_AES_128,
-    S390_FEAT_KM_AES_192,
-    S390_FEAT_KM_AES_256,
-    S390_FEAT_KM_EAES_128,
-    S390_FEAT_KM_EAES_192,
-    S390_FEAT_KM_EAES_256,
-    S390_FEAT_KM_XTS_AES_128,
-    S390_FEAT_KM_XTS_AES_256,
-    S390_FEAT_KM_XTS_EAES_128,
-    S390_FEAT_KM_XTS_EAES_256,
-
-    /* KIMD */
-    S390_FEAT_KIMD_SHA_1,
-    S390_FEAT_KIMD_SHA_256,
-    S390_FEAT_KIMD_SHA_512,
-    S390_FEAT_KIMD_SHA3_224,
-    S390_FEAT_KIMD_SHA3_256,
-    S390_FEAT_KIMD_SHA3_384,
-    S390_FEAT_KIMD_SHA3_512,
-    S390_FEAT_KIMD_SHAKE_128,
-    S390_FEAT_KIMD_SHAKE_256,
-    S390_FEAT_KIMD_GHASH,
-
-    /* KLMD */
-    S390_FEAT_KLMD_SHA_1,
-    S390_FEAT_KLMD_SHA_256,
-    S390_FEAT_KLMD_SHA_512,
-    S390_FEAT_KLMD_SHA3_224,
-    S390_FEAT_KLMD_SHA3_256,
-    S390_FEAT_KLMD_SHA3_384,
-    S390_FEAT_KLMD_SHA3_512,
-    S390_FEAT_KLMD_SHAKE_128,
-    S390_FEAT_KLMD_SHAKE_256,
-
-    /* PCKMO */
-    S390_FEAT_PCKMO_EDEA,
-    S390_FEAT_PCKMO_ETDEA_128,
-    S390_FEAT_PCKMO_ETDEA_256,
-    S390_FEAT_PCKMO_AES_128,
-    S390_FEAT_PCKMO_AES_192,
-    S390_FEAT_PCKMO_AES_256,
-    S390_FEAT_PCKMO_ECC_P256,
-    S390_FEAT_PCKMO_ECC_P384,
-    S390_FEAT_PCKMO_ECC_P521,
-    S390_FEAT_PCKMO_ECC_ED25519,
-    S390_FEAT_PCKMO_ECC_ED448,
-
-    /* KMCTR */
-    S390_FEAT_KMCTR_DEA,
-    S390_FEAT_KMCTR_TDEA_128,
-    S390_FEAT_KMCTR_TDEA_192,
-    S390_FEAT_KMCTR_EDEA,
-    S390_FEAT_KMCTR_ETDEA_128,
-    S390_FEAT_KMCTR_ETDEA_192,
-    S390_FEAT_KMCTR_AES_128,
-    S390_FEAT_KMCTR_AES_192,
-    S390_FEAT_KMCTR_AES_256,
-    S390_FEAT_KMCTR_EAES_128,
-    S390_FEAT_KMCTR_EAES_192,
-    S390_FEAT_KMCTR_EAES_256,
-
-    /* KMF */
-    S390_FEAT_KMF_DEA,
-    S390_FEAT_KMF_TDEA_128,
-    S390_FEAT_KMF_TDEA_192,
-    S390_FEAT_KMF_EDEA,
-    S390_FEAT_KMF_ETDEA_128,
-    S390_FEAT_KMF_ETDEA_192,
-    S390_FEAT_KMF_AES_128,
-    S390_FEAT_KMF_AES_192,
-    S390_FEAT_KMF_AES_256,
-    S390_FEAT_KMF_EAES_128,
-    S390_FEAT_KMF_EAES_192,
-    S390_FEAT_KMF_EAES_256,
-
-    /* KMO */
-    S390_FEAT_KMO_DEA,
-    S390_FEAT_KMO_TDEA_128,
-    S390_FEAT_KMO_TDEA_192,
-    S390_FEAT_KMO_EDEA,
-    S390_FEAT_KMO_ETDEA_128,
-    S390_FEAT_KMO_ETDEA_192,
-    S390_FEAT_KMO_AES_128,
-    S390_FEAT_KMO_AES_192,
-    S390_FEAT_KMO_AES_256,
-    S390_FEAT_KMO_EAES_128,
-    S390_FEAT_KMO_EAES_192,
-    S390_FEAT_KMO_EAES_256,
-
-    /* PCC */
-    S390_FEAT_PCC_CMAC_DEA,
-    S390_FEAT_PCC_CMAC_TDEA_128,
-    S390_FEAT_PCC_CMAC_TDEA_192,
-    S390_FEAT_PCC_CMAC_ETDEA_128,
-    S390_FEAT_PCC_CMAC_ETDEA_192,
-    S390_FEAT_PCC_CMAC_TDEA,
-    S390_FEAT_PCC_CMAC_AES_128,
-    S390_FEAT_PCC_CMAC_AES_192,
-    S390_FEAT_PCC_CMAC_AES_256,
-    S390_FEAT_PCC_CMAC_EAES_128,
-    S390_FEAT_PCC_CMAC_EAES_192,
-    S390_FEAT_PCC_CMAC_EAES_256,
-    S390_FEAT_PCC_XTS_AES_128,
-    S390_FEAT_PCC_XTS_AES_256,
-    S390_FEAT_PCC_XTS_EAES_128,
-    S390_FEAT_PCC_XTS_EAES_256,
-    S390_FEAT_PCC_SCALAR_MULT_P256,
-    S390_FEAT_PCC_SCALAR_MULT_P384,
-    S390_FEAT_PCC_SCALAR_MULT_P512,
-    S390_FEAT_PCC_SCALAR_MULT_ED25519,
-    S390_FEAT_PCC_SCALAR_MULT_ED448,
-    S390_FEAT_PCC_SCALAR_MULT_X25519,
-    S390_FEAT_PCC_SCALAR_MULT_X448,
-
-    /* PPNO/PRNO */
-    S390_FEAT_PPNO_SHA_512_DRNG,
-    S390_FEAT_PRNO_TRNG_QRTCR,
-    S390_FEAT_PRNO_TRNG,
-
-    /* KMA */
-    S390_FEAT_KMA_GCM_AES_128,
-    S390_FEAT_KMA_GCM_AES_192,
-    S390_FEAT_KMA_GCM_AES_256 ,
-    S390_FEAT_KMA_GCM_EAES_128,
-    S390_FEAT_KMA_GCM_EAES_192,
-    S390_FEAT_KMA_GCM_EAES_256,
-
-    /* KDSA */
-    S390_FEAT_ECDSA_VERIFY_P256,
-    S390_FEAT_ECDSA_VERIFY_P384,
-    S390_FEAT_ECDSA_VERIFY_P512,
-    S390_FEAT_ECDSA_SIGN_P256,
-    S390_FEAT_ECDSA_SIGN_P384,
-    S390_FEAT_ECDSA_SIGN_P512,
-    S390_FEAT_EECDSA_SIGN_P256,
-    S390_FEAT_EECDSA_SIGN_P384,
-    S390_FEAT_EECDSA_SIGN_P512,
-    S390_FEAT_EDDSA_VERIFY_ED25519,
-    S390_FEAT_EDDSA_VERIFY_ED448,
-    S390_FEAT_EDDSA_SIGN_ED25519,
-    S390_FEAT_EDDSA_SIGN_ED448,
-    S390_FEAT_EEDDSA_SIGN_ED25519,
-    S390_FEAT_EEDDSA_SIGN_ED448,
-
-    /* SORTL */
-    S390_FEAT_SORTL_SFLR,
-    S390_FEAT_SORTL_SVLR,
-    S390_FEAT_SORTL_32,
-    S390_FEAT_SORTL_128,
-    S390_FEAT_SORTL_F0,
-
-    /* DEFLATE */
-    S390_FEAT_DEFLATE_GHDT,
-    S390_FEAT_DEFLATE_CMPR,
-    S390_FEAT_DEFLATE_XPND,
-    S390_FEAT_DEFLATE_F0,
-
+    #include "cpu_features_def.inc.h"
     S390_FEAT_MAX,
 } S390Feat;
+#undef DEF_FEAT
=20
 #endif /* TARGET_S390X_CPU_FEATURES_DEF_H */
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_featu=
res_def.inc.h
new file mode 100644
index 000000000000..5dffff65fa5d
--- /dev/null
+++ b/target/s390x/cpu_features_def.inc.h
@@ -0,0 +1,369 @@
+/*
+ * RAW s390x CPU feature definitions:
+ *
+ * DEF_FEAT(_FEAT, _NAME, _TYPE, _BIT, _DESC):
+ * - _FEAT: Feature (enum) name used internally (S390_FEAT_##_FEAT)
+ * - _NAME: Feature name exposed to the user.
+ * - _TYPE: Feature type (S390_FEAT_TYPE_##_TYPE).
+ * - _BIT: Feature bit number within feature type block (unused for MISC=
).
+ * - _DESC: Feature description, exposed to the user.
+ *
+ * Copyright IBM Corp. 2016, 2018
+ * Copyright Red Hat, Inc. 2019
+ *
+ * Author(s): Michael Mueller <mimu@linux.vnet.ibm.com>
+ *            David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+/* Features exposed via the STFL(E) instruction. */
+DEF_FEAT(ESAN3, "esan3", STFL, 0, "Instructions marked as n3")
+DEF_FEAT(ZARCH, "zarch", STFL, 1, "z/Architecture architectural mode")
+DEF_FEAT(DAT_ENH, "dateh", STFL, 3, "DAT-enhancement facility")
+DEF_FEAT(IDTE_SEGMENT, "idtes", STFL, 4, "IDTE selective TLB segment-tab=
le clearing")
+DEF_FEAT(IDTE_REGION, "idter", STFL, 5, "IDTE selective TLB region-table=
 clearing")
+DEF_FEAT(ASN_LX_REUSE, "asnlxr", STFL, 6, "ASN-and-LX reuse facility")
+DEF_FEAT(STFLE, "stfle", STFL, 7, "Store-facility-list-extended facility=
")
+DEF_FEAT(EDAT, "edat", STFL, 8, "Enhanced-DAT facility")
+DEF_FEAT(SENSE_RUNNING_STATUS, "srs", STFL, 9, "Sense-running-status fac=
ility")
+DEF_FEAT(CONDITIONAL_SSKE, "csske", STFL, 10, "Conditional-SSKE facility=
")
+DEF_FEAT(CONFIGURATION_TOPOLOGY, "ctop", STFL, 11, "Configuration-topolo=
gy facility")
+DEF_FEAT(AP_QUERY_CONFIG_INFO, "apqci", STFL, 12, "Query AP Configuratio=
n Information facility")
+DEF_FEAT(IPTE_RANGE, "ipter", STFL, 13, "IPTE-range facility")
+DEF_FEAT(NONQ_KEY_SETTING, "nonqks", STFL, 14, "Nonquiescing key-setting=
 facility")
+DEF_FEAT(AP_FACILITIES_TEST, "apft", STFL, 15, "AP Facilities Test facil=
ity")
+DEF_FEAT(EXTENDED_TRANSLATION_2, "etf2", STFL, 16, "Extended-translation=
 facility 2")
+DEF_FEAT(MSA, "msa-base", STFL, 17, "Message-security-assist facility (e=
xcluding subfunctions)")
+DEF_FEAT(LONG_DISPLACEMENT, "ldisp", STFL, 18, "Long-displacement facili=
ty")
+DEF_FEAT(LONG_DISPLACEMENT_FAST, "ldisphp", STFL, 19, "Long-displacement=
 facility has high performance")
+DEF_FEAT(HFP_MADDSUB, "hfpm", STFL, 20, "HFP-multiply-add/subtract facil=
ity")
+DEF_FEAT(EXTENDED_IMMEDIATE, "eimm", STFL, 21, "Extended-immediate facil=
ity")
+DEF_FEAT(EXTENDED_TRANSLATION_3, "etf3", STFL, 22, "Extended-translation=
 facility 3")
+DEF_FEAT(HFP_UNNORMALIZED_EXT, "hfpue", STFL, 23, "HFP-unnormalized-exte=
nsion facility")
+DEF_FEAT(ETF2_ENH, "etf2eh", STFL, 24, "ETF2-enhancement facility")
+DEF_FEAT(STORE_CLOCK_FAST, "stckf", STFL, 25, "Store-clock-fast facility=
")
+DEF_FEAT(PARSING_ENH, "parseh", STFL, 26, "Parsing-enhancement facility"=
)
+DEF_FEAT(MOVE_WITH_OPTIONAL_SPEC, "mvcos", STFL, 27, "Move-with-optional=
-specification facility")
+DEF_FEAT(TOD_CLOCK_STEERING, "tods-base", STFL, 28, "TOD-clock-steering =
facility (excluding subfunctions)")
+DEF_FEAT(ETF3_ENH, "etf3eh", STFL, 30, "ETF3-enhancement facility")
+DEF_FEAT(EXTRACT_CPU_TIME, "ectg", STFL, 31, "Extract-CPU-time facility"=
)
+DEF_FEAT(COMPARE_AND_SWAP_AND_STORE, "csst", STFL, 32, "Compare-and-swap=
-and-store facility")
+DEF_FEAT(COMPARE_AND_SWAP_AND_STORE_2, "csst2", STFL, 33, "Compare-and-s=
wap-and-store facility 2")
+DEF_FEAT(GENERAL_INSTRUCTIONS_EXT, "ginste", STFL, 34, "General-instruct=
ions-extension facility")
+DEF_FEAT(EXECUTE_EXT, "exrl", STFL, 35, "Execute-extensions facility")
+DEF_FEAT(ENHANCED_MONITOR, "emon", STFL, 36, "Enhanced-monitor facility"=
)
+DEF_FEAT(FLOATING_POINT_EXT, "fpe", STFL, 37, "Floating-point extension =
facility")
+DEF_FEAT(ORDER_PRESERVING_COMPRESSION, "opc", STFL, 38, "Order Preservin=
g Compression facility")
+DEF_FEAT(SET_PROGRAM_PARAMETERS, "sprogp", STFL, 40, "Set-program-parame=
ters facility")
+DEF_FEAT(FLOATING_POINT_SUPPPORT_ENH, "fpseh", STFL, 41, "Floating-point=
-support-enhancement facilities")
+DEF_FEAT(DFP, "dfp", STFL, 42, "DFP (decimal-floating-point) facility")
+DEF_FEAT(DFP_FAST, "dfphp", STFL, 43, "DFP (decimal-floating-point) faci=
lity has high performance")
+DEF_FEAT(PFPO, "pfpo", STFL, 44, "PFPO instruction")
+DEF_FEAT(STFLE_45, "stfle45", STFL, 45, "Various facilities introduced w=
ith z196")
+DEF_FEAT(CMPSC_ENH, "cmpsceh", STFL, 47, "CMPSC-enhancement facility")
+DEF_FEAT(DFP_ZONED_CONVERSION, "dfpzc", STFL, 48, "Decimal-floating-poin=
t zoned-conversion facility")
+DEF_FEAT(STFLE_49, "stfle49", STFL, 49, "Various facilities introduced w=
ith zEC12")
+DEF_FEAT(CONSTRAINT_TRANSACTIONAL_EXE, "cte", STFL, 50, "Constrained tra=
nsactional-execution facility")
+DEF_FEAT(LOCAL_TLB_CLEARING, "ltlbc", STFL, 51, "Local-TLB-clearing faci=
lity")
+DEF_FEAT(INTERLOCKED_ACCESS_2, "iacc2", STFL, 52, "Interlocked-access fa=
cility 2")
+DEF_FEAT(STFLE_53, "stfle53", STFL, 53, "Various facilities introduced w=
ith z13")
+DEF_FEAT(ENTROPY_ENC_COMP, "eec", STFL, 54, "Entropy encoding compressio=
n facility")
+DEF_FEAT(MSA_EXT_5, "msa5-base", STFL, 57, "Message-security-assist-exte=
nsion-5 facility (excluding subfunctions)")
+DEF_FEAT(MISC_INSTRUCTION_EXT, "minste2", STFL, 58, "Miscellaneous-instr=
uction-extensions facility 2")
+DEF_FEAT(SEMAPHORE_ASSIST, "sema", STFL, 59, "Semaphore-assist facility"=
)
+DEF_FEAT(TIME_SLICE_INSTRUMENTATION, "tsi", STFL, 60, "Time-slice Instru=
mentation facility")
+DEF_FEAT(MISC_INSTRUCTION_EXT3, "minste3", STFL, 61, "Miscellaneous-Inst=
ruction-Extensions Facility 3")
+DEF_FEAT(RUNTIME_INSTRUMENTATION, "ri", STFL, 64, "CPU runtime-instrumen=
tation facility")
+DEF_FEAT(ZPCI, "zpci", STFL, 69, "z/PCI facility")
+DEF_FEAT(ADAPTER_EVENT_NOTIFICATION, "aen", STFL, 71, "General-purpose-a=
dapter-event-notification facility")
+DEF_FEAT(ADAPTER_INT_SUPPRESSION, "ais", STFL, 72, "General-purpose-adap=
ter-interruption-suppression facility")
+DEF_FEAT(TRANSACTIONAL_EXE, "te", STFL, 73, "Transactional-execution fac=
ility")
+DEF_FEAT(STORE_HYPERVISOR_INFO, "sthyi", STFL, 74, "Store-hypervisor-inf=
ormation facility")
+DEF_FEAT(ACCESS_EXCEPTION_FS_INDICATION, "aefsi", STFL, 75, "Access-exce=
ption-fetch/store-indication facility")
+DEF_FEAT(MSA_EXT_3, "msa3-base", STFL, 76, "Message-security-assist-exte=
nsion-3 facility (excluding subfunctions)")
+DEF_FEAT(MSA_EXT_4, "msa4-base", STFL, 77, "Message-security-assist-exte=
nsion-4 facility (excluding subfunctions)")
+DEF_FEAT(EDAT_2, "edat2", STFL, 78, "Enhanced-DAT facility 2")
+DEF_FEAT(DFP_PACKED_CONVERSION, "dfppc", STFL, 80, "Decimal-floating-poi=
nt packed-conversion facility")
+DEF_FEAT(PPA15, "ppa15", STFL, 81, "PPA15 is installed")
+DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
+DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
+DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution=
-protection facility")
+DEF_FEAT(SIDE_EFFECT_ACCESS_ESOP2, "sea_esop2", STFL, 131, "Side-effect-=
access facility and Enhanced-suppression-on-protection facility 2")
+DEF_FEAT(GUARDED_STORAGE, "gs", STFL, 133, "Guarded-storage facility")
+DEF_FEAT(VECTOR_PACKED_DECIMAL, "vxpd", STFL, 134, "Vector packed decima=
l facility")
+DEF_FEAT(VECTOR_ENH, "vxeh", STFL, 135, "Vector enhancements facility")
+DEF_FEAT(MULTIPLE_EPOCH, "mepoch", STFL, 139, "Multiple-epoch facility")
+DEF_FEAT(TEST_PENDING_EXT_INTERRUPTION, "tpei", STFL, 144, "Test-pending=
-external-interruption facility")
+DEF_FEAT(INSERT_REFERENCE_BITS_MULT, "irbm", STFL, 145, "Insert-referenc=
e-bits-multiple facility")
+DEF_FEAT(MSA_EXT_8, "msa8-base", STFL, 146, "Message-security-assist-ext=
ension-8 facility (excluding subfunctions)")
+DEF_FEAT(CMM_NT, "cmmnt", STFL, 147, "CMM: ESSA-enhancement (no translat=
e) facility")
+DEF_FEAT(VECTOR_ENH2, "vxeh2", STFL, 148, "Vector Enhancements facility =
2")
+DEF_FEAT(ESORT_BASE, "esort-base", STFL, 150, "Enhanced-sort facility (e=
xcluding subfunctions)")
+DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion fa=
cility (excluding subfunctions)")
+DEF_FEAT(VECTOR_BCD_ENH, "vxbeh", STFL, 152, "Vector BCD enhancements fa=
cility 1")
+DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-ext=
ension-9 facility (excluding subfunctions)")
+DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
+
+/* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to=
 byte-80) */
+DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit=
-suppression facility")
+DEF_FEAT(ESOP, "esop", SCLP_CONF_CHAR, 46, "Enhanced-suppression-on-prot=
ection facility")
+DEF_FEAT(HPMA2, "hpma2", SCLP_CONF_CHAR, 90, "Host page management assis=
t 2 Facility") /* 91-2 */
+DEF_FEAT(SIE_KSS, "kss", SCLP_CONF_CHAR, 151, "SIE: Keyless-subset facil=
ity")  /* 98-7 */
+
+/* Features exposed via SCLP SCCB Byte 116 - 119 (bit numbers relative t=
o byte-116) */
+DEF_FEAT(SIE_64BSCAO, "64bscao", SCLP_CONF_CHAR_EXT, 0, "SIE: 64-bit-SCA=
O facility")
+DEF_FEAT(SIE_CMMA, "cmma", SCLP_CONF_CHAR_EXT, 1, "SIE: Collaborative-me=
mory-management assist")
+DEF_FEAT(SIE_PFMFI, "pfmfi", SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpret=
ation facility")
+DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-bro=
adcast-suppression facility")
+
+/* Features exposed via SCLP CPU info. */
+DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virt=
ual SIE)")
+DEF_FEAT(SIE_SKEY, "skey", SCLP_CPU, 5, "SIE: Storage-key facility")
+DEF_FEAT(SIE_GPERE, "gpereh", SCLP_CPU, 10, "SIE: Guest-PER enhancement =
facility")
+DEF_FEAT(SIE_SIIF, "siif", SCLP_CPU, 11, "SIE: Shared IPTE-interlock fac=
ility")
+DEF_FEAT(SIE_SIGPIF, "sigpif", SCLP_CPU, 12, "SIE: SIGP interpretation f=
acility")
+DEF_FEAT(SIE_IB, "ib", SCLP_CPU, 42, "SIE: Intervention bypass facility"=
)
+DEF_FEAT(SIE_CEI, "cei", SCLP_CPU, 43, "SIE: Conditional-external-interc=
eption facility")
+
+/*
+ * Features exposed via no feature bit (but e.g., instruction sensing)
+ * -> the feature bit number is irrelavant
+ */
+DEF_FEAT(DAT_ENH_2, "dateh2", MISC, 0, "DAT-enhancement facility 2")
+DEF_FEAT(CMM, "cmm", MISC, 0, "Collaborative-memory-management facility"=
)
+DEF_FEAT(AP, "ap", MISC, 0, "AP instructions installed")
+
+/* Features exposed via the PLO instruction. */
+DEF_FEAT(PLO_CL, "plo-cl", PLO, 0, "PLO Compare and load (32 bit in gene=
ral registers)")
+DEF_FEAT(PLO_CLG, "plo-clg", PLO, 1, "PLO Compare and load (64 bit in pa=
rameter list)")
+DEF_FEAT(PLO_CLGR, "plo-clgr", PLO, 2, "PLO Compare and load (32 bit in =
general registers)")
+DEF_FEAT(PLO_CLX, "plo-clx", PLO, 3, "PLO Compare and load (128 bit in p=
arameter list)")
+DEF_FEAT(PLO_CS, "plo-cs", PLO, 4, "PLO Compare and swap (32 bit in gene=
ral registers)")
+DEF_FEAT(PLO_CSG, "plo-csg", PLO, 5, "PLO Compare and swap (64 bit in pa=
rameter list)")
+DEF_FEAT(PLO_CSGR, "plo-csgr", PLO, 6, "PLO Compare and swap (32 bit in =
general registers)")
+DEF_FEAT(PLO_CSX, "plo-csx", PLO, 7, "PLO Compare and swap (128 bit in p=
arameter list)")
+DEF_FEAT(PLO_DCS, "plo-dcs", PLO, 8, "PLO Double compare and swap (32 bi=
t in general registers)")
+DEF_FEAT(PLO_DCSG, "plo-dcsg", PLO, 9, "PLO Double compare and swap (64 =
bit in parameter list)")
+DEF_FEAT(PLO_DCSGR, "plo-dcsgr", PLO, 10, "PLO Double compare and swap (=
32 bit in general registers)")
+DEF_FEAT(PLO_DCSX, "plo-dcsx", PLO, 11, "PLO Double compare and swap (12=
8 bit in parameter list)")
+DEF_FEAT(PLO_CSST, "plo-csst", PLO, 12, "PLO Compare and swap and store =
(32 bit in general registers)")
+DEF_FEAT(PLO_CSSTG, "plo-csstg", PLO, 13, "PLO Compare and swap and stor=
e (64 bit in parameter list)")
+DEF_FEAT(PLO_CSSTGR, "plo-csstgr", PLO, 14, "PLO Compare and swap and st=
ore (32 bit in general registers)")
+DEF_FEAT(PLO_CSSTX, "plo-csstx", PLO, 15, "PLO Compare and swap and stor=
e (128 bit in parameter list)")
+DEF_FEAT(PLO_CSDST, "plo-csdst", PLO, 16, "PLO Compare and swap and doub=
le store (32 bit in general registers)")
+DEF_FEAT(PLO_CSDSTG, "plo-csdstg", PLO, 17, "PLO Compare and swap and do=
uble store (64 bit in parameter list)")
+DEF_FEAT(PLO_CSDSTGR, "plo-csdstgr", PLO, 18, "PLO Compare and swap and =
double store (32 bit in general registers)")
+DEF_FEAT(PLO_CSDSTX, "plo-csdstx", PLO, 19, "PLO Compare and swap and do=
uble store (128 bit in parameter list)")
+DEF_FEAT(PLO_CSTST, "plo-cstst", PLO, 20, "PLO Compare and swap and trip=
le store (32 bit in general registers)")
+DEF_FEAT(PLO_CSTSTG, "plo-cststg", PLO, 21, "PLO Compare and swap and tr=
iple store (64 bit in parameter list)")
+DEF_FEAT(PLO_CSTSTGR, "plo-cststgr", PLO, 22, "PLO Compare and swap and =
triple store (32 bit in general registers)")
+DEF_FEAT(PLO_CSTSTX, "plo-cststx", PLO, 23, "PLO Compare and swap and tr=
iple store (128 bit in parameter list)")
+
+/* Features exposed via the PTFF instruction. */
+DEF_FEAT(PTFF_QTO, "ptff-qto", PTFF, 1, "PTFF Query TOD Offset")
+DEF_FEAT(PTFF_QSI, "ptff-qsi", PTFF, 2, "PTFF Query Steering Information=
")
+DEF_FEAT(PTFF_QPT, "ptff-qpc", PTFF, 3, "PTFF Query Physical Clock")
+DEF_FEAT(PTFF_QUI, "ptff-qui", PTFF, 4, "PTFF Query UTC Information")
+DEF_FEAT(PTFF_QTOU, "ptff-qtou", PTFF, 5, "PTFF Query TOD Offset User")
+DEF_FEAT(PTFF_QSIE, "ptff-qsie", PTFF, 10, "PTFF Query Steering Informat=
ion Extended")
+DEF_FEAT(PTFF_QTOUE, "ptff-qtoue", PTFF, 13, "PTFF Query TOD Offset User=
 Extended")
+DEF_FEAT(PTFF_STO, "ptff-sto", PTFF, 65, "PTFF Set TOD Offset")
+DEF_FEAT(PTFF_STOU, "ptff-stou", PTFF, 69, "PTFF Set TOD Offset User")
+DEF_FEAT(PTFF_STOE, "ptff-stoe", PTFF, 73, "PTFF Set TOD Offset Extended=
")
+DEF_FEAT(PTFF_STOUE, "ptff-stoue", PTFF, 77, "PTFF Set TOD Offset User E=
xtended")
+
+/* Features exposed via the KMAC instruction. */
+DEF_FEAT(KMAC_DEA, "kmac-dea", KMAC, 1, "KMAC DEA")
+DEF_FEAT(KMAC_TDEA_128, "kmac-tdea-128", KMAC, 2, "KMAC TDEA-128")
+DEF_FEAT(KMAC_TDEA_192, "kmac-tdea-192", KMAC, 3, "KMAC TDEA-192")
+DEF_FEAT(KMAC_EDEA, "kmac-edea", KMAC, 9, "KMAC Encrypted-DEA")
+DEF_FEAT(KMAC_ETDEA_128, "kmac-etdea-128", KMAC, 10, "KMAC Encrypted-TDE=
A-128")
+DEF_FEAT(KMAC_ETDEA_192, "kmac-etdea-192", KMAC, 11, "KMAC Encrypted-TDE=
A-192")
+DEF_FEAT(KMAC_AES_128, "kmac-aes-128", KMAC, 18, "KMAC AES-128")
+DEF_FEAT(KMAC_AES_192, "kmac-aes-192", KMAC, 19, "KMAC AES-192")
+DEF_FEAT(KMAC_AES_256, "kmac-aes-256", KMAC, 20, "KMAC AES-256")
+DEF_FEAT(KMAC_EAES_128, "kmac-eaes-128", KMAC, 26, "KMAC Encrypted-AES-1=
28")
+DEF_FEAT(KMAC_EAES_192, "kmac-eaes-192", KMAC, 27, "KMAC Encrypted-AES-1=
92")
+DEF_FEAT(KMAC_EAES_256, "kmac-eaes-256", KMAC, 28, "KMAC Encrypted-AES-2=
56")
+
+/* Features exposed via the KMC instruction. */
+DEF_FEAT(KMC_DEA, "kmc-dea", KMC, 1, "KMC DEA")
+DEF_FEAT(KMC_TDEA_128, "kmc-tdea-128", KMC, 2, "KMC TDEA-128")
+DEF_FEAT(KMC_TDEA_192, "kmc-tdea-192", KMC, 3, "KMC TDEA-192")
+DEF_FEAT(KMC_EDEA, "kmc-edea", KMC, 9, "KMC Encrypted-DEA")
+DEF_FEAT(KMC_ETDEA_128, "kmc-etdea-128", KMC, 10, "KMC Encrypted-TDEA-12=
8")
+DEF_FEAT(KMC_ETDEA_192, "kmc-etdea-192", KMC, 11, "KMC Encrypted-TDEA-19=
2")
+DEF_FEAT(KMC_AES_128, "kmc-aes-128", KMC, 18, "KMC AES-128")
+DEF_FEAT(KMC_AES_192, "kmc-aes-192", KMC, 19, "KMC AES-192")
+DEF_FEAT(KMC_AES_256, "kmc-aes-256", KMC, 20, "KMC AES-256")
+DEF_FEAT(KMC_EAES_128, "kmc-eaes-128", KMC, 26, "KMC Encrypted-AES-128")
+DEF_FEAT(KMC_EAES_192, "kmc-eaes-192", KMC, 27, "KMC Encrypted-AES-192")
+DEF_FEAT(KMC_EAES_256, "kmc-eaes-256", KMC, 28, "KMC Encrypted-AES-256")
+DEF_FEAT(KMC_PRNG, "kmc-prng", KMC, 67, "KMC PRNG")
+
+/* Features exposed via the KM instruction. */
+DEF_FEAT(KM_DEA, "km-dea", KM, 1, "KM DEA")
+DEF_FEAT(KM_TDEA_128, "km-tdea-128", KM, 2, "KM TDEA-128")
+DEF_FEAT(KM_TDEA_192, "km-tdea-192", KM, 3, "KM TDEA-192")
+DEF_FEAT(KM_EDEA, "km-edea", KM, 9, "KM Encrypted-DEA")
+DEF_FEAT(KM_ETDEA_128, "km-etdea-128", KM, 10, "KM Encrypted-TDEA-128")
+DEF_FEAT(KM_ETDEA_192, "km-etdea-192", KM, 11, "KM Encrypted-TDEA-192")
+DEF_FEAT(KM_AES_128, "km-aes-128", KM, 18, "KM AES-128")
+DEF_FEAT(KM_AES_192, "km-aes-192", KM, 19, "KM AES-192")
+DEF_FEAT(KM_AES_256, "km-aes-256", KM, 20, "KM AES-256")
+DEF_FEAT(KM_EAES_128, "km-eaes-128", KM, 26, "KM Encrypted-AES-128")
+DEF_FEAT(KM_EAES_192, "km-eaes-192", KM, 27, "KM Encrypted-AES-192")
+DEF_FEAT(KM_EAES_256, "km-eaes-256", KM, 28, "KM Encrypted-AES-256")
+DEF_FEAT(KM_XTS_AES_128, "km-xts-aes-128", KM, 50, "KM XTS-AES-128")
+DEF_FEAT(KM_XTS_AES_256, "km-xts-aes-256", KM, 52, "KM XTS-AES-256")
+DEF_FEAT(KM_XTS_EAES_128, "km-xts-eaes-128", KM, 58, "KM XTS-Encrypted-A=
ES-128")
+DEF_FEAT(KM_XTS_EAES_256, "km-xts-eaes-256", KM, 60, "KM XTS-Encrypted-A=
ES-256")
+
+/* Features exposed via the KIMD instruction. */
+DEF_FEAT(KIMD_SHA_1, "kimd-sha-1", KIMD, 1, "KIMD SHA-1")
+DEF_FEAT(KIMD_SHA_256, "kimd-sha-256", KIMD, 2, "KIMD SHA-256")
+DEF_FEAT(KIMD_SHA_512, "kimd-sha-512", KIMD, 3, "KIMD SHA-512")
+DEF_FEAT(KIMD_SHA3_224, "kimd-sha3-224", KIMD, 32, "KIMD SHA3-224")
+DEF_FEAT(KIMD_SHA3_256, "kimd-sha3-256", KIMD, 33, "KIMD SHA3-256")
+DEF_FEAT(KIMD_SHA3_384, "kimd-sha3-384", KIMD, 34, "KIMD SHA3-384")
+DEF_FEAT(KIMD_SHA3_512, "kimd-sha3-512", KIMD, 35, "KIMD SHA3-512")
+DEF_FEAT(KIMD_SHAKE_128, "kimd-shake-128", KIMD, 36, "KIMD SHAKE-128")
+DEF_FEAT(KIMD_SHAKE_256, "kimd-shake-256", KIMD, 37, "KIMD SHAKE-256")
+DEF_FEAT(KIMD_GHASH, "kimd-ghash", KIMD, 65, "KIMD GHASH")
+
+/* Features exposed via the KLMD instruction. */
+DEF_FEAT(KLMD_SHA_1, "klmd-sha-1", KLMD, 1, "KLMD SHA-1")
+DEF_FEAT(KLMD_SHA_256, "klmd-sha-256", KLMD, 2, "KLMD SHA-256")
+DEF_FEAT(KLMD_SHA_512, "klmd-sha-512", KLMD, 3, "KLMD SHA-512")
+DEF_FEAT(KLMD_SHA3_224, "klmd-sha3-224", KLMD, 32, "KLMD SHA3-224")
+DEF_FEAT(KLMD_SHA3_256, "klmd-sha3-256", KLMD, 33, "KLMD SHA3-256")
+DEF_FEAT(KLMD_SHA3_384, "klmd-sha3-384", KLMD, 34, "KLMD SHA3-384")
+DEF_FEAT(KLMD_SHA3_512, "klmd-sha3-512", KLMD, 35, "KLMD SHA3-512")
+DEF_FEAT(KLMD_SHAKE_128, "klmd-shake-128", KLMD, 36, "KLMD SHAKE-128")
+DEF_FEAT(KLMD_SHAKE_256, "klmd-shake-256", KLMD, 37, "KLMD SHAKE-256")
+
+/* Features exposed via the PCKMO instruction. */
+DEF_FEAT(PCKMO_EDEA, "pckmo-edea", PCKMO, 1, "PCKMO Encrypted-DEA-Key")
+DEF_FEAT(PCKMO_ETDEA_128, "pckmo-etdea-128", PCKMO, 2, "PCKMO Encrypted-=
TDEA-128-Key")
+DEF_FEAT(PCKMO_ETDEA_256, "pckmo-etdea-192", PCKMO, 3, "PCKMO Encrypted-=
TDEA-192-Key")
+DEF_FEAT(PCKMO_AES_128, "pckmo-aes-128", PCKMO, 18, "PCKMO Encrypted-AES=
-128-Key")
+DEF_FEAT(PCKMO_AES_192, "pckmo-aes-192", PCKMO, 19, "PCKMO Encrypted-AES=
-192-Key")
+DEF_FEAT(PCKMO_AES_256, "pckmo-aes-256", PCKMO, 20, "PCKMO Encrypted-AES=
-256-Key")
+DEF_FEAT(PCKMO_ECC_P256, "pckmo-ecc-p256", PCKMO, 32, "PCKMO Encrypt-ECC=
-P256-Key")
+DEF_FEAT(PCKMO_ECC_P384, "pckmo-ecc-p384", PCKMO, 33, "PCKMO Encrypt-ECC=
-P384-Key")
+DEF_FEAT(PCKMO_ECC_P521, "pckmo-ecc-p521", PCKMO, 34, "PCKMO Encrypt-ECC=
-P521-Key")
+DEF_FEAT(PCKMO_ECC_ED25519, "pckmo-ecc-ed25519", PCKMO, 40 , "PCKMO Encr=
ypt-ECC-Ed25519-Key")
+DEF_FEAT(PCKMO_ECC_ED448, "pckmo-ecc-ed448", PCKMO, 41 , "PCKMO Encrypt-=
ECC-Ed448-Key")
+
+/* Features exposed via the KMCTR instruction. */
+DEF_FEAT(KMCTR_DEA, "kmctr-dea", KMCTR, 1, "KMCTR DEA")
+DEF_FEAT(KMCTR_TDEA_128, "kmctr-tdea-128", KMCTR, 2, "KMCTR TDEA-128")
+DEF_FEAT(KMCTR_TDEA_192, "kmctr-tdea-192", KMCTR, 3, "KMCTR TDEA-192")
+DEF_FEAT(KMCTR_EDEA, "kmctr-edea", KMCTR, 9, "KMCTR Encrypted-DEA")
+DEF_FEAT(KMCTR_ETDEA_128, "kmctr-etdea-128", KMCTR, 10, "KMCTR Encrypted=
-TDEA-128")
+DEF_FEAT(KMCTR_ETDEA_192, "kmctr-etdea-192", KMCTR, 11, "KMCTR Encrypted=
-TDEA-192")
+DEF_FEAT(KMCTR_AES_128, "kmctr-aes-128", KMCTR, 18, "KMCTR AES-128")
+DEF_FEAT(KMCTR_AES_192, "kmctr-aes-192", KMCTR, 19, "KMCTR AES-192")
+DEF_FEAT(KMCTR_AES_256, "kmctr-aes-256", KMCTR, 20, "KMCTR AES-256")
+DEF_FEAT(KMCTR_EAES_128, "kmctr-eaes-128", KMCTR, 26, "KMCTR Encrypted-A=
ES-128")
+DEF_FEAT(KMCTR_EAES_192, "kmctr-eaes-192", KMCTR, 27, "KMCTR Encrypted-A=
ES-192")
+DEF_FEAT(KMCTR_EAES_256, "kmctr-eaes-256", KMCTR, 28, "KMCTR Encrypted-A=
ES-256")
+
+/* Features exposed via the KMF instruction. */
+DEF_FEAT(KMF_DEA, "kmf-dea", KMF, 1, "KMF DEA")
+DEF_FEAT(KMF_TDEA_128, "kmf-tdea-128", KMF, 2, "KMF TDEA-128")
+DEF_FEAT(KMF_TDEA_192, "kmf-tdea-192", KMF, 3, "KMF TDEA-192")
+DEF_FEAT(KMF_EDEA, "kmf-edea", KMF, 9, "KMF Encrypted-DEA")
+DEF_FEAT(KMF_ETDEA_128, "kmf-etdea-128", KMF, 10, "KMF Encrypted-TDEA-12=
8")
+DEF_FEAT(KMF_ETDEA_192, "kmf-etdea-192", KMF, 11, "KMF Encrypted-TDEA-19=
2")
+DEF_FEAT(KMF_AES_128, "kmf-aes-128", KMF, 18, "KMF AES-128")
+DEF_FEAT(KMF_AES_192, "kmf-aes-192", KMF, 19, "KMF AES-192")
+DEF_FEAT(KMF_AES_256, "kmf-aes-256", KMF, 20, "KMF AES-256")
+DEF_FEAT(KMF_EAES_128, "kmf-eaes-128", KMF, 26, "KMF Encrypted-AES-128")
+DEF_FEAT(KMF_EAES_192, "kmf-eaes-192", KMF, 27, "KMF Encrypted-AES-192")
+DEF_FEAT(KMF_EAES_256, "kmf-eaes-256", KMF, 28, "KMF Encrypted-AES-256")
+
+/* Features exposed via the KMO instruction. */
+DEF_FEAT(KMO_DEA, "kmo-dea", KMO, 1, "KMO DEA")
+DEF_FEAT(KMO_TDEA_128, "kmo-tdea-128", KMO, 2, "KMO TDEA-128")
+DEF_FEAT(KMO_TDEA_192, "kmo-tdea-192", KMO, 3, "KMO TDEA-192")
+DEF_FEAT(KMO_EDEA, "kmo-edea", KMO, 9, "KMO Encrypted-DEA")
+DEF_FEAT(KMO_ETDEA_128, "kmo-etdea-128", KMO, 10, "KMO Encrypted-TDEA-12=
8")
+DEF_FEAT(KMO_ETDEA_192, "kmo-etdea-192", KMO, 11, "KMO Encrypted-TDEA-19=
2")
+DEF_FEAT(KMO_AES_128, "kmo-aes-128", KMO, 18, "KMO AES-128")
+DEF_FEAT(KMO_AES_192, "kmo-aes-192", KMO, 19, "KMO AES-192")
+DEF_FEAT(KMO_AES_256, "kmo-aes-256", KMO, 20, "KMO AES-256")
+DEF_FEAT(KMO_EAES_128, "kmo-eaes-128", KMO, 26, "KMO Encrypted-AES-128")
+DEF_FEAT(KMO_EAES_192, "kmo-eaes-192", KMO, 27, "KMO Encrypted-AES-192")
+DEF_FEAT(KMO_EAES_256, "kmo-eaes-256", KMO, 28, "KMO Encrypted-AES-256")
+
+/* Features exposed via the PCC instruction. */
+DEF_FEAT(PCC_CMAC_DEA, "pcc-cmac-dea", PCC, 1, "PCC Compute-Last-Block-C=
MAC-Using-DEA")
+DEF_FEAT(PCC_CMAC_TDEA_128, "pcc-cmac-tdea-128", PCC, 2, "PCC Compute-La=
st-Block-CMAC-Using-TDEA-128")
+DEF_FEAT(PCC_CMAC_TDEA_192, "pcc-cmac-tdea-192", PCC, 3, "PCC Compute-La=
st-Block-CMAC-Using-TDEA-192")
+DEF_FEAT(PCC_CMAC_ETDEA_128, "pcc-cmac-edea", PCC, 9, "PCC Compute-Last-=
Block-CMAC-Using-Encrypted-DEA")
+DEF_FEAT(PCC_CMAC_ETDEA_192, "pcc-cmac-etdea-128", PCC, 10, "PCC Compute=
-Last-Block-CMAC-Using-Encrypted-TDEA-128")
+DEF_FEAT(PCC_CMAC_TDEA, "pcc-cmac-etdea-192", PCC, 11, "PCC Compute-Last=
-Block-CMAC-Using-EncryptedTDEA-192")
+DEF_FEAT(PCC_CMAC_AES_128, "pcc-cmac-aes-128", PCC, 18, "PCC Compute-Las=
t-Block-CMAC-Using-AES-128")
+DEF_FEAT(PCC_CMAC_AES_192, "pcc-cmac-aes-192", PCC, 19, "PCC Compute-Las=
t-Block-CMAC-Using-AES-192")
+DEF_FEAT(PCC_CMAC_AES_256, "pcc-cmac-eaes-256", PCC, 20, "PCC Compute-La=
st-Block-CMAC-Using-AES-256")
+DEF_FEAT(PCC_CMAC_EAES_128, "pcc-cmac-eaes-128", PCC, 26, "PCC Compute-L=
ast-Block-CMAC-Using-Encrypted-AES-128")
+DEF_FEAT(PCC_CMAC_EAES_192, "pcc-cmac-eaes-192", PCC, 27, "PCC Compute-L=
ast-Block-CMAC-Using-Encrypted-AES-192")
+DEF_FEAT(PCC_CMAC_EAES_256, "pcc-cmac-eaes-256", PCC, 28, "PCC Compute-L=
ast-Block-CMAC-Using-Encrypted-AES-256")
+DEF_FEAT(PCC_XTS_AES_128, "pcc-xts-aes-128", PCC, 50, "PCC Compute-XTS-P=
arameter-Using-AES-128")
+DEF_FEAT(PCC_XTS_AES_256, "pcc-xts-aes-256", PCC, 52, "PCC Compute-XTS-P=
arameter-Using-AES-256")
+DEF_FEAT(PCC_XTS_EAES_128, "pcc-xts-eaes-128", PCC, 58, "PCC Compute-XTS=
-Parameter-Using-Encrypted-AES-128")
+DEF_FEAT(PCC_XTS_EAES_256, "pcc-xts-eaes-256", PCC, 60, "PCC Compute-XTS=
-Parameter-Using-Encrypted-AES-256")
+DEF_FEAT(PCC_SCALAR_MULT_P256, "pcc-scalar-mult-p256", PCC, 64, "PCC Sca=
lar-Multiply-P256")
+DEF_FEAT(PCC_SCALAR_MULT_P384, "pcc-scalar-mult-p384", PCC, 65, "PCC Sca=
lar-Multiply-P384")
+DEF_FEAT(PCC_SCALAR_MULT_P512, "pcc-scalar-mult-p521", PCC, 66, "PCC Sca=
lar-Multiply-P521")
+DEF_FEAT(PCC_SCALAR_MULT_ED25519, "pcc-scalar-mult-ed25519", PCC, 72, "P=
CC Scalar-Multiply-Ed25519")
+DEF_FEAT(PCC_SCALAR_MULT_ED448, "pcc-scalar-mult-ed448", PCC, 73, "PCC S=
calar-Multiply-Ed448")
+DEF_FEAT(PCC_SCALAR_MULT_X25519, "pcc-scalar-mult-x25519", PCC, 80, "PCC=
 Scalar-Multiply-X25519")
+DEF_FEAT(PCC_SCALAR_MULT_X448, "pcc-scalar-mult-x448", PCC, 81, "PCC Sca=
lar-Multiply-X448")
+
+/* Features exposed via the PPNO/PRNO instruction. */
+DEF_FEAT(PPNO_SHA_512_DRNG, "ppno-sha-512-drng", PPNO, 3, "PPNO SHA-512-=
DRNG")
+DEF_FEAT(PRNO_TRNG_QRTCR, "prno-trng-qrtcr", PPNO, 112, "PRNO TRNG-Query=
-Raw-to-Conditioned-Ratio")
+DEF_FEAT(PRNO_TRNG, "prno-trng", PPNO, 114, "PRNO TRNG")
+
+/* Features exposed via the KMA instruction. */
+DEF_FEAT(KMA_GCM_AES_128, "kma-gcm-aes-128", KMA, 18, "KMA GCM-AES-128")
+DEF_FEAT(KMA_GCM_AES_192, "kma-gcm-aes-192", KMA, 19, "KMA GCM-AES-192")
+DEF_FEAT(KMA_GCM_AES_256, "kma-gcm-aes-256", KMA, 20, "KMA GCM-AES-256")
+DEF_FEAT(KMA_GCM_EAES_128, "kma-gcm-eaes-128", KMA, 26, "KMA GCM-Encrypt=
ed-AES-128")
+DEF_FEAT(KMA_GCM_EAES_192, "kma-gcm-eaes-192", KMA, 27, "KMA GCM-Encrypt=
ed-AES-192")
+DEF_FEAT(KMA_GCM_EAES_256, "kma-gcm-eaes-256", KMA, 28, "KMA GCM-Encrypt=
ed-AES-256")
+
+/* Features exposed via the KDSA instruction. */
+DEF_FEAT(ECDSA_VERIFY_P256, "kdsa-ecdsa-verify-p256", KDSA, 1, "KDSA ECD=
SA-Verify-P256")
+DEF_FEAT(ECDSA_VERIFY_P384, "kdsa-ecdsa-verify-p384", KDSA, 2, "KDSA ECD=
SA-Verify-P384")
+DEF_FEAT(ECDSA_VERIFY_P512, "kdsa-ecdsa-verify-p521", KDSA, 3, "KDSA ECD=
SA-Verify-P521")
+DEF_FEAT(ECDSA_SIGN_P256, "kdsa-ecdsa-sign-p256", KDSA, 9, "KDSA ECDSA-S=
ign-P256")
+DEF_FEAT(ECDSA_SIGN_P384, "kdsa-ecdsa-sign-p384", KDSA, 10, "KDSA ECDSA-=
Sign-P384")
+DEF_FEAT(ECDSA_SIGN_P512, "kdsa-ecdsa-sign-p521", KDSA, 11, "KDSA ECDSA-=
Sign-P521")
+DEF_FEAT(EECDSA_SIGN_P256, "kdsa-eecdsa-sign-p256", KDSA, 17, "KDSA Encr=
ypted-ECDSA-Sign-P256")
+DEF_FEAT(EECDSA_SIGN_P384, "kdsa-eecdsa-sign-p384", KDSA, 18, "KDSA Encr=
ypted-ECDSA-Sign-P384")
+DEF_FEAT(EECDSA_SIGN_P512, "kdsa-eecdsa-sign-p521", KDSA, 19, "KDSA Encr=
ypted-ECDSA-Sign-P521")
+DEF_FEAT(EDDSA_VERIFY_ED25519, "kdsa-eddsa-verify-ed25519", KDSA, 32, "K=
DSA EdDSA-Verify-Ed25519")
+DEF_FEAT(EDDSA_VERIFY_ED448, "kdsa-eddsa-verify-ed448", KDSA, 36, "KDSA =
EdDSA-Verify-Ed448")
+DEF_FEAT(EDDSA_SIGN_ED25519, "kdsa-eddsa-sign-ed25519", KDSA, 40, "KDSA =
EdDSA-Sign-Ed25519")
+DEF_FEAT(EDDSA_SIGN_ED448, "kdsa-eddsa-sign-ed448", KDSA, 44, "KDSA EdDS=
A-Sign-Ed448")
+DEF_FEAT(EEDDSA_SIGN_ED25519, "kdsa-eeddsa-sign-ed25519", KDSA, 48, "KDS=
A Encrypted-EdDSA-Sign-Ed25519")
+DEF_FEAT(EEDDSA_SIGN_ED448, "kdsa-eeddsa-sign-ed448", KDSA, 52, "KDSA En=
crypted-EdDSA-Sign-Ed448")
+
+/* Features exposed via the SORTL instruction. */
+DEF_FEAT(SORTL_SFLR, "sortl-sflr", SORTL, 1, "SORTL SFLR")
+DEF_FEAT(SORTL_SVLR, "sortl-svlr", SORTL, 2, "SORTL SVLR")
+DEF_FEAT(SORTL_32, "sortl-32", SORTL, 130, "SORTL 32 input lists")
+DEF_FEAT(SORTL_128, "sortl-128", SORTL, 132, "SORTL 128 input lists")
+DEF_FEAT(SORTL_F0, "sortl-f0", SORTL, 192, "SORTL format 0 parameter-blo=
ck")
+
+/* Features exposed via the DEFLATE instruction. */
+DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
+DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
+DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
+DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 paramete=
r-block")
--=20
2.20.1


