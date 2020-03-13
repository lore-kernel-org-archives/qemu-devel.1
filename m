Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF9C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0E1206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9bjRW9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0E1206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClcM-000423-KA
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jClbf-0003Lo-Ly
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jClbd-0004aY-Df
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jClbb-0004Wg-JS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEcigO049392;
 Fri, 13 Mar 2020 14:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=/InK+MOXRPTanep5gLM0Mh5zt+g2IAGF7PYJfuNGg/A=;
 b=O9bjRW9BO3rKxMMgq/b139w9N1PQI+4Ts5LkwHtDZjAK03Pe8BJnsOthVepYRv0SD01r
 yJxiiOK4dv0c5EkzmFuY9EYa+pP7mxq91D3qASx7H+XzSv2QnRN5JVTZQ2PpoS31m5QO
 eZNeXkdYi5yCcSTuw6dsdrlWkp23ntuiaMqodJODnLI2JLZaH2U6fsry5ds9VGe0D4pn
 teKewaXgTWKmV/4+cYz/RA/zWnGuKlFLcpV3ztw6rqGp7m1xX7TWgut5bvYoLlytmr8y
 R2tJDSGDZBroqvA2PjGQU9ZNNqr0Xo4OY04A8P5a8YyX69GPaREME7xDUM/GmtZ5fyBc Vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2yqtagc8v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:48:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02DEcKUG065807;
 Fri, 13 Mar 2020 14:48:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yqtadaf5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 14:48:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02DEm16F020823;
 Fri, 13 Mar 2020 14:48:01 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 13 Mar 2020 07:48:00 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3]: acpi: Add Windows ACPI Emulated Device Table (WAET)
Date: Fri, 13 Mar 2020 16:50:06 +0200
Message-Id: <20200313145009.144820-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=695 spamscore=0 suspectscore=1
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=757 phishscore=0
 suspectscore=1 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This patch-series aims to expose WAET ACPI table to guest. Which
improves performance of Windows guests (since Vista) and ignored by
other guests. This ACPI table is exposed by default by other common
hypervisors such as VMware, Xen (HVM), GCP and AWS.

Regards,
-Liran

v1->v2:
- Update bios-tables-test qtest by the process described at ./tests/qtest/bios-tables-test.c [MST]
- Add to commit message and code better description of the effect of enabling the ACPI PM timer good bit. [MST]
- Remove WAET flags macros and instead use them directly in WAET code generation together with a proper comment. [MST]
- Remove WaetAcpiTable structure and generate table by new coding convention (E.g. Use build_append_int_noprefix()) [Igor]
- Add documentation to build_waet() on specification, spec version and purpose of table. [MST]
- Removed flag that controls if WAET is exposed or not. [Igor]


