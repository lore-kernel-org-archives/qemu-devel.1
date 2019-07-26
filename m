Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22BAC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6AD218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6AD218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqu1n-0005T0-RJ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 02:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hqu13-00035n-A4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hqu11-0005Dq-Ee
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:47:45 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:41124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hqu0m-0004Ed-Qq; Fri, 26 Jul 2019 02:47:29 -0400
Received: from tpw09926dag18g.domain1.systemhost.net (10.9.212.34) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 26 Jul 2019 07:43:28 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18g.domain1.systemhost.net (10.9.212.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 26 Jul 2019 07:47:24 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 26 Jul
 2019 07:47:24 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v5 10/15] memory: Access MemoryRegion with
 MemOp semantics
Thread-Index: AQHVQ337z2ux/Jk5eUK0KMuToV5GXA==
Date: Fri, 26 Jul 2019 06:47:24 +0000
Message-ID: <1564123643791.27023@bt.com>
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.42]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.236
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v5 10/15] memory: Access MemoryRegion with
 MemOp semantics
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 laurent@vivier.eu, Alistair.Francis@wdc.com, edgar.iglesias@gmail.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To convert interfaces of MemoryRegion access, MEMOP_SIZE and
SIZE_MEMOP no-op stubs were introduced to change syntax while keeping
the existing semantics.

Now with interfaces converted, we fill the stubs and use MemOp
semantics.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 include/exec/memop.h  | 5 ++---
 include/exec/memory.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 09c8d20..f2847e8 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -106,8 +106,7 @@ typedef enum MemOp {
     MO_SSIZE =3D MO_SIZE | MO_SIGN,
 } MemOp;

-/* No-op while memory_region_dispatch_[read|write] is converted to MemOp *=
/
-#define MEMOP_SIZE(op)  (op)    /* MemOp to size.  */
-#define SIZE_MEMOP(ul)  (ul)    /* Size to MemOp.  */
+#define MEMOP_SIZE(op)  (1 << ((op) & MO_SIZE)) /* MemOp to size.  */
+#define SIZE_MEMOP(ul)  (ctzl(ul))              /* Size to MemOp.  */

 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 0ea4843..975b86a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1732,7 +1732,7 @@ void mtree_info(bool flatview, bool dispatch_tree, bo=
ol owner);
  * @mr: #MemoryRegion to access
  * @addr: address within that region
  * @pval: pointer to uint64_t which the data is written to
- * @op: size of the access in bytes
+ * @op: size, sign, and endianness of the memory operation
  * @attrs: memory transaction attributes to use for the access
  */
 MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
@@ -1747,7 +1747,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion =
*mr,
  * @mr: #MemoryRegion to access
  * @addr: address within that region
  * @data: data to write
- * @op: size of the access in bytes
+ * @op: size, sign, and endianness of the memory operation
  * @attrs: memory transaction attributes to use for the access
  */
 MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
--
1.8.3.1



