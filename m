Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C20DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7DE2247A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7DE2247A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGICc-0007Ky-Cj
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 03:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iGIBA-0006RS-2o
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iGIB8-0000eJ-JC
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:39:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iGIB8-0000cp-BV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:39:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x947b8KY117484
 for <qemu-devel@nongnu.org>; Fri, 4 Oct 2019 03:39:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ve1ea1161-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 03:39:03 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 4 Oct 2019 08:39:01 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 4 Oct 2019 08:38:58 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x947cvGj46268872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Oct 2019 07:38:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA162A405C;
 Fri,  4 Oct 2019 07:38:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05CDAA405B;
 Fri,  4 Oct 2019 07:38:57 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.67.254])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  4 Oct 2019 07:38:56 +0000 (GMT)
Subject: [PATCH] xive: Make some device types not user creatable
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 04 Oct 2019 09:38:50 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100407-0012-0000-0000-00000353ED1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100407-0013-0000-0000-0000218EF6F9
Message-Id: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-04_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040070
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some device types of the XIVE model are exposed to the QEMU command
line:

$ ppc64-softmmu/qemu-system-ppc64 -device help | grep xive
name "xive-end-source", desc "XIVE END Source"
name "xive-source", desc "XIVE Interrupt Source"
name "xive-tctx", desc "XIVE Interrupt Thread Context"

These are internal devices that shouldn't be instantiable by the
user. By the way, they can't be because their respective realize
functions expect link properties that can't be set from the command
line:

qemu-system-ppc64: -device xive-source: required link 'xive' not found:
 Property '.xive' not found
qemu-system-ppc64: -device xive-end-source: required link 'xive' not found:
 Property '.xive' not found
qemu-system-ppc64: -device xive-tctx: required link 'cpu' not found:
 Property '.cpu' not found

Hide them by setting dc->user_creatable to false in their respective
class init functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xive.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 29df06df1136..6c54a35fd4bb 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -670,6 +670,7 @@ static void xive_tctx_class_init(ObjectClass *klass, void *data)
     dc->realize = xive_tctx_realize;
     dc->unrealize = xive_tctx_unrealize;
     dc->vmsd = &vmstate_xive_tctx;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo xive_tctx_info = {
@@ -1118,6 +1119,7 @@ static void xive_source_class_init(ObjectClass *klass, void *data)
     dc->props   = xive_source_properties;
     dc->realize = xive_source_realize;
     dc->vmsd    = &vmstate_xive_source;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo xive_source_info = {
@@ -1853,6 +1855,7 @@ static void xive_end_source_class_init(ObjectClass *klass, void *data)
     dc->desc    = "XIVE END Source";
     dc->props   = xive_end_source_properties;
     dc->realize = xive_end_source_realize;
+    dc->user_creatable = false;
 }
 
 static const TypeInfo xive_end_source_info = {


