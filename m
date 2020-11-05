Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B021FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0840A20719
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 22:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="StgBQOuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0840A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kand6-00008W-Vg
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 17:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbK-0006x1-FC; Thu, 05 Nov 2020 17:19:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kanbI-00040a-NZ; Thu, 05 Nov 2020 17:19:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A5M329H049101; Thu, 5 Nov 2020 17:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f6D21Gd3sWqQXZmuk8zlfTHG3FzoNxQSDYZK3fctaUU=;
 b=StgBQOuDHB3VsBMRsNMNmyjs6BlWGvRqwGQoDwOUPeUeDrk/IHd5OV8MUKgUPjGj/9rg
 1sp26ZUoNyNbI5Xwo9MILOemSkK0uVhmVOc+Sq1vGBImm1iSvVhop8kLa6yO71MY8ZFX
 QANUO/x/Rtg9RecwgMllLJsI+rW5JLXG0bsQPX7z+qRS2myX8Dj7MhLPPUHSyM4EpXVk
 vz5jkKs7q7oTuu36x6LrEZK5UhxtWucD+MgIW5M8S+jmdZPVplaHMBw0eVfcf1R4el8V
 4YOJB1QWxeEsI8blp2dtc5N2WAvh2920Pnp19cJyVC6dM4Ll5oFC/bOQWG1p6EPUBgRB 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34m8wwb1wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:23 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A5M36hv049462;
 Thu, 5 Nov 2020 17:19:22 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34m8wwb1w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 17:19:22 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A5MCkou007790;
 Thu, 5 Nov 2020 22:19:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma05wdc.us.ibm.com with ESMTP id 34h09nke70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2020 22:19:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A5MJEbX15335972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2020 22:19:15 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74F986A047;
 Thu,  5 Nov 2020 22:19:20 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B81E6A04D;
 Thu,  5 Nov 2020 22:19:19 +0000 (GMT)
Received: from Buonos-Thinkpad-X1.ibm.com (unknown [9.65.222.173])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2020 22:19:19 +0000 (GMT)
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
To: dbuono@linux.vnet.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] s390x: Avoid variable size warning in ipl.h
Date: Thu,  5 Nov 2020 17:19:00 -0500
Message-Id: <20201105221905.1350-5-dbuono@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-05_15:2020-11-05,
 2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050141
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 17:19:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

S390IPLState contains two IplParameterBlock, which may in turn have
either a IPLBlockPV or a IplBlockFcp, both ending with a variable
sized field (an array).

This causes a warning with clang 11 or greater, which checks that
variable sized type are only allocated at the end of the struct:

In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
    IplParameterBlock iplb;
                      ^
../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
    IplParameterBlock iplb_pv;

In this case, however, the warning is a false positive, because
IPLBlockPV and IplBlockFcp are allocated in a union wrapped at 4K,
making the union non-variable sized.

Fix the warning by turning the two variable sized arrays into arrays
of size 0. This avoids the compiler error and should produce the
same code.

Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
---
There is the possibility of removing  IplBlockFcp from
IplParameterBlock, since it is not actually used.
This would also allow to entirely remove the definition of
IplBlockFcp, but we may want to keep it for completeness.

 hw/s390x/ipl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 9e90169695..dfc6dfd89c 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -32,7 +32,7 @@ struct IPLBlockPV {
     uint32_t num_comp;          /* 0x74 */
     uint64_t pv_header_addr;    /* 0x78 */
     uint64_t pv_header_len;     /* 0x80 */
-    struct IPLBlockPVComp components[];
+    struct IPLBlockPVComp components[0];
 } QEMU_PACKED;
 typedef struct IPLBlockPV IPLBlockPV;
 
@@ -63,7 +63,7 @@ struct IplBlockFcp {
     uint64_t br_lba;
     uint32_t scp_data_len;
     uint8_t  reserved6[260];
-    uint8_t  scp_data[];
+    uint8_t  scp_data[0];
 } QEMU_PACKED;
 typedef struct IplBlockFcp IplBlockFcp;
 
-- 
2.17.1


